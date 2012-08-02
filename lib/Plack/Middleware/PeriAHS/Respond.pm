package Plack::Middleware::PeriAHS::Respond;

use 5.010;
use strict;
use warnings;
use Log::Any '$log';

use parent qw(Plack::Middleware);
use Plack::Util::Accessor qw();

use Log::Any::Adapter;
use Perinci::Result::Format;
use Scalar::Util qw(blessed);
use Time::HiRes qw(gettimeofday);

our $VERSION = '0.16'; # VERSION

sub prepare_app {
    my $self = shift;
}

sub format_result {
    my ($self, $rres, $env) = @_;

    my $rreq = $env->{"riap.request"};
    my $fmt = $rreq->{fmt} // $env->{'periahs.default_fmt'} // 'json';

    my $formatter;
    for ($fmt, "json") { # fallback to json if unknown format
        $formatter = $Perinci::Result::Format::Formats{$_};
        if ($formatter) {
            $fmt = $_;
            last;
        }
    }
    my $ct = $formatter->[1];

    my $fres = Perinci::Result::Format::format($rres, $fmt);

    if ($fmt =~ /^json/ && defined($env->{"periahs.jsonp_callback"})) {
        $fres = $env->{"periahs.jsonp_callback"}."($fres)";
    }

    ($fres, $ct);
}
my %str_levels = qw(1 critical 2 error 3 warning 4 info 5 debug 6 trace);

sub call {
    $log->tracef("=> PeriAHS::Respond middleware");

    my ($self, $env) = @_;

    die "This middleware needs psgi.streaming support"
        unless $env->{'psgi.streaming'};

    my $rreq = $env->{"riap.request"};
    my $pa   = $env->{"periahs.riap_client"}
        or die "\$env->{'periahs.riap_client'} not defined, ".
            "perhaps ParseRequest middleware has not run?";

    return sub {
        my $respond = shift;

        my $writer;
        my $loglvl  = $rreq->{'loglevel'} // 0;
        my $marklog = $rreq->{'marklog'};
        my $rres; #  short for riap response
        $env->{'periahs.start_action_time'} = [gettimeofday];
        if ($loglvl > 0) {
            $writer = $respond->([200, ["Content-Type" => "text/plain"]]);
            Log::Any::Adapter->set(
                {lexically=>\my $lex},
                "Callback",
                min_level => $str_levels{$loglvl} // 'warning',
                logging_cb => sub {
                    my ($method, $self, $format, @params) = @_;
                    my $msg = join(
                        "",
                        $marklog ? "L" : "",
                        "[$method]",
                        "[", scalar(localtime), "] ",
                        $format, "\n");
                    $writer->write($msg);
                },
            );
            $rres = $pa->request($rreq->{action} => $rreq->{uri}, $rreq);
        } else {
            $rres = $pa->request($rreq->{action} => $rreq->{uri}, $rreq);
        }
        $env->{'periahs.finish_action_time'} = [gettimeofday];

        $env->{'riap.response'} = $rres;
        my ($fres, $ct) = $self->format_result($rres, $env);

        if ($writer) {
            $writer->write($marklog ? "R$fres" : $fres);
            $writer->close;
        } else {
            $respond->([200, ["Content-Type" => $ct], [$fres]]);
        }
    };
}

1;
# ABSTRACT: Send Riap request to Riap server and send the response to client


__END__
=pod

=head1 NAME

Plack::Middleware::PeriAHS::Respond - Send Riap request to Riap server and send the response to client

=head1 VERSION

version 0.16

=head1 SYNOPSIS

 # in your app.psgi
 use Plack::Builder;

 builder {
     enable "PeriAHS::Respond";
 };

=head1 DESCRIPTION

This middleware sends Riap request (C<$env->{"riap.request"}>) to Riap client
(L<Perinci::Access> object, stored in C<$env->{"periahs.riap_client"}> by
PeriAHS::ParseRequest middleware), format the result, and send it to client.
This middleware is the one that sends response to client and should be put as
the last middleware after all the parsing, authentication, and authorization
middlewares.

The result will also be put in C<$env->{"riap.response"}>.

=head1 CONFIGURATIONS

=over 4

=back

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

