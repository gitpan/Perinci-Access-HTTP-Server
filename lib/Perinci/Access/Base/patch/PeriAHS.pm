package Perinci::Access::Base::patch::PeriAHS;

use 5.010;
use strict;
use warnings;

use Module::Patch 0.10 qw();
use base qw(Module::Patch);
use Perinci::Result::Format;

our $VERSION = '0.20'; # VERSION

sub patch_data {
    return {
        v => 3,
        patches => [
            {
                action => 'add',
                mod_version => ':all',
                sub_name => 'actionmeta_srvinfo',
                code => sub { +{
                    applies_to => ['*'],
                    summary    => "Get information about server",
                } }
            },

            {
                action => 'add',
                mod_version => ':all',
                sub_name => 'action_srvinfo',
                code => sub {
                    my ($self, $uri, $extra) = @_;

                    [200, "OK", {
                        srvurl => "TODO",
                        fmt    => [keys %Perinci::Result::Format::Formats],
                    }];
                }
            },
        ],
    };
}

1;
# ABSTRACT: Patch for Perinci::Access::Base


__END__
=pod

=head1 NAME

Perinci::Access::Base::patch::PeriAHS - Patch for Perinci::Access::Base

=head1 VERSION

version 0.20

=head1 DESCRIPTION

This patch adds several extra PeriAHS-related actions into
L<Perinci::Access::Base>. Currently: C<srvinfo>.

=head1 SEE ALSO

L<Perinci::Access::HTTP::Server>

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

