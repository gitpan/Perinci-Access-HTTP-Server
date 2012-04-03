package Perinci::Access::Patch::PeriAHS;

use 5.010;
use strict;
use warnings;

our $VERSION = '0.14'; # VERSION

use Perinci::Access::Base;
package Perinci::Access::Base;

sub actionmeta_srvinfo { +{
    applies_to => ['*'],
    summary    => "Get information about server",
} }

sub action_srvinfo {
    my ($self, $uri, $extra) = @_;

    my @fmt = sort map {s/::$//; $_} grep {/::$/} keys %Perinci::Formatter::;

    [200, "OK", {
        srvurl => "TODO",
        fmt    => \@fmt,
    }];
}

1;
# ABSTRACT: Add extra actions to Perinci::Access::Base



__END__
=pod

=head1 NAME

Perinci::Access::Patch::PeriAHS - Add extra actions to Perinci::Access::Base

=head1 VERSION

version 0.14

=head1 DESCRIPTION

This module injects several extra PeriAHS-related actions into
L<Perinci::Access::Base>, including: C<srvinfo>.

=head1 SEE ALSO

L<Perinci::Access::HTTP::Server>

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

