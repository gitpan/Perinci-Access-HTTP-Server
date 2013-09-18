
use strict;
use warnings;

use 5.010001;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "PSGI application to implement Riap::HTTP",
  "AUTHOR" => "Steven Haryanto <stevenharyanto\@gmail.com>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Perinci-Access-HTTP-Server",
  "EXE_FILES" => [
    "bin/peri-htserve"
  ],
  "LICENSE" => "perl",
  "NAME" => "Perinci::Access::HTTP::Server",
  "PREREQ_PM" => {
    "File::HomeDir" => 0,
    "File::Write::Rotate" => 0,
    "Gepok" => 0,
    "Log::Any" => 0,
    "Log::Any::Adapter" => 0,
    "Log::Any::Adapter::Callback" => "0.03",
    "Module::List" => 0,
    "Module::Patch" => "0.12",
    "Perinci::Access" => "0.36",
    "Perinci::Access::HTTP::Client" => "0.07",
    "Perinci::Access::Perl" => "0.19",
    "Perinci::Access::Schemeless" => "0.19",
    "Perinci::CmdLine" => 0,
    "Perinci::Examples" => 0,
    "Perinci::Gen::ForModule" => 0,
    "Perinci::Result::Format" => "0.31",
    "Perinci::Sub::GetArgs::Array" => 0,
    "Plack::Middleware::Auth::Basic" => 0,
    "Plack::Runner" => 0,
    "Riap" => "v1.1.10",
    "SHARYANTO::Array::Util" => 0,
    "Starman" => 0,
    "URI::Escape" => 0,
    "URI::Split" => 0,
    "YAML::Syck" => 0
  },
  "TEST_REQUIRES" => {
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "JSON" => 0,
    "Test::More" => "0.96"
  },
  "VERSION" => "0.31",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  my $tr = delete $WriteMakefileArgs{TEST_REQUIRES};
  my $br = $WriteMakefileArgs{BUILD_REQUIRES};
  for my $mod ( keys %$tr ) {
    if ( exists $br->{$mod} ) {
      $br->{$mod} = $tr->{$mod} if $tr->{$mod} > $br->{$mod};
    }
    else {
      $br->{$mod} = $tr->{$mod};
    }
  }
}

unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



