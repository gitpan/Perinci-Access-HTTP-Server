package Plack::Util::PeriAHS;

use 5.010;
use strict;
use warnings;
use Log::Any '$log';

our @ISA = qw(Exporter);
our @EXPORT_OK = qw(errpage);

our $VERSION = '0.26'; # VERSION

use JSON;

my $json = JSON->new->allow_nonref;

sub errpage {
    my ($env, $rres) = @_;

    my $fmt = $env->{'riap.request'}{fmt} //
        $env->{"periahs.default_fmt"} // 'json';
    my $pres;

    if ($fmt =~ /^html$/i) {
        $pres = [
            200,
            ["Content-Type" => "text/html"],
            ["<h1>Error $rres->[0]</h1>\n\n$rres->[1]\n"],
        ];
    } elsif ($fmt =~ /text$/i) {
        $pres = [
            200,
            ["Content-Type" => "text/plain"],
            ["Error $rres->[0]: ".$rres->[1].($rres->[1] =~ /\n$/ ? "":"\n")],
        ];
    } else {
        $pres = [
            200,
            ["Content-Type" => "application/json"],
            [$json->encode($rres)]
        ];
    }

    $log->tracef("Returning error page: %s", $pres);
    $pres;
}

1;
#ABSTRACT: Utility routines


__END__
=pod

=head1 NAME

Plack::Util::PeriAHS - Utility routines

=head1 VERSION

version 0.26

=head1 FUNCTIONS

=head2 errpage($env, $resp)

Render enveloped response $resp (as specified in L<Rinci::function>) as an error
page PSGI response, either in HTML/JSON/plaintext (according to C<<
$env->{"riap.request"}{fmt} >>). Will default to JSON if C<fmt> is unsupported.

$env is PSGI environment.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

