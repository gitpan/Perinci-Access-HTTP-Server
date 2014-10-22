package Plack::Middleware::PeriAHS::CheckAccess;

use 5.010;
use strict;
use warnings;
use Log::Any '$log';

use parent qw(Plack::Middleware);
use Plack::Util::Accessor qw(
                                allow_log
                                allow_uri_scheme
                                deny_uri_scheme
                                allow_uri
                                deny_uri
                                allow_action
                                deny_action
                        );
use Plack::Util::PeriAHS qw(errpage);
use SHARYANTO::Array::Util qw(match_array_or_regex);
use URI::Split qw(uri_split);

our $VERSION = '0.50'; # VERSION

sub prepare_app {
    my $self = shift;

    $self->{allow_log}         //= 0;
    $self->{allow_uri_scheme}  //= ['pl'];
}

sub call {
    $log->tracef("=> PeriAHS::CheckAccess middleware");

    my ($self, $env) = @_;

    my $rreq = $env->{"riap.request"};
    my $uri  = $rreq->{uri};

    if (!$self->{allow_log}) {
        return errpage($env, [403, "Setting loglevel is forbidden"])
            if $rreq->{loglevel};
    }

    my ($sch, $auth, $path) = uri_split($uri);
    $sch //= "pl";
    if ($self->{allow_uri_scheme}) {
        return errpage($env, [403, "Riap URI scheme not allowed (not in list)"])
            unless match_array_or_regex($sch, $self->{allow_uri_scheme});
    }
    if ($self->{deny_uri_scheme}) {
        return errpage($env, [403, "Riap URI scheme not allowed (deny list)"])
            if match_array_or_regex($sch, $self->{deny_uri_scheme});
    }

    if ($self->{allow_uri}) {
        return errpage($env, [403, "Riap URI not allowed (not in list)"])
            unless match_array_or_regex($uri, $self->{allow_uri});
    }
    if ($self->{deny_uri}) {
        return errpage($env, [403, "Riap URI not allowed (deny list)"])
            if match_array_or_regex($uri, $self->{deny_uri});
    }

    if ($self->{allow_action}) {
        return errpage($env, [403, "Riap action not allowed (not in list)"])
            unless match_array_or_regex($rreq->{action}, $self->{allow_action});
    }
    if ($self->{deny_action}) {
        return errpage($env, [403, "Riap action '$rreq->{action}' not allowed ".
                                  "(deny list)"])
            if match_array_or_regex($rreq->{action}, $self->{deny_action});
    }

    # continue to app
    $self->app->($env);
}

1;
# ABSTRACT: Deny access based on some criteria

__END__

=pod

=encoding UTF-8

=head1 NAME

Plack::Middleware::PeriAHS::CheckAccess - Deny access based on some criteria

=head1 VERSION

This document describes version 0.50 of Plack::Middleware::PeriAHS::CheckAccess (from Perl distribution Perinci-Access-HTTP-Server), released on 2014-07-22.

=head1 DESCRIPTION

This middleware denies access according to some criterias in
C<$env->{"riap.request"}>. It should be put after ParseRequest.

For a more sophisticated access control, try the PeriAHS::ACL middleware.

=for Pod::Coverage .*

=head1 CONFIGURATIONS

=over 4

=item * allow_log => BOOL (default 1)

Whether to allow request for returning log messages (request key C<loglevel>
with values larger than 0). You might want to turn this off on production
servers.

=item * allow_uri_scheme => ARRAY|REGEX (default ['pl'])

Which URI schemes are allowed. By default only local schemes are allowed. Add
'http' or 'https' if you want proxying capability.

=item * deny_uri_scheme => ARRAY|REGEX

Which URI schemes are forbidden.

=item * allow_uri => ARRAY|REGEX (default ['pl'])

Allowed URIs. Note that URIs are normalized with scheme C<pl> if unschemed.
Example:

=item * deny_uri => ARRAY|REGEX (default ['pl'])

Forbidden URIs.

=item * allow_action => ARRAY|REGEX

Which actions are allowed.

=item * deny_action => ARRAY|REGEX

Which actions are forbidden.

=back

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Perinci-Access-HTTP-Server>.

=head1 SOURCE

Source repository is at L<https://github.com/sharyanto/perl-Perinci-Access-HTTP-Server>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Perinci-Access-HTTP-Server>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
