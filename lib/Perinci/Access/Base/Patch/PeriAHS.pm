package Perinci::Access::Base::Patch::PeriAHS;

use 5.010;
use strict;
use warnings;

use Module::Patch 0.12 qw();
use base qw(Module::Patch);
use Perinci::Result::Format;

our $VERSION = '0.34'; # VERSION

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

=encoding UTF-8

=head1 NAME

Perinci::Access::Base::Patch::PeriAHS - Patch for Perinci::Access::Base

=head1 VERSION

version 0.34

=head1 DESCRIPTION

This patch adds several extra PeriAHS-related actions into
L<Perinci::Access::Base>. Currently: C<srvinfo>.

=head1 SEE ALSO

L<Perinci::Access::HTTP::Server>

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

This software is copyright (c) 2013 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
