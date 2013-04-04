
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "JSON" => 0,
    "Module::Build" => "0.3601",
    "Test::More" => "0.96"
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "PSGI application to implement Riap::HTTP",
  "dist_author" => [
    "Steven Haryanto <stevenharyanto\@gmail.com>"
  ],
  "dist_name" => "Perinci-Access-HTTP-Server",
  "dist_version" => "0.27",
  "license" => "perl",
  "module_name" => "Perinci::Access::HTTP::Server",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Data::Clean::JSON" => 0,
    "File::HomeDir" => 0,
    "File::Write::Rotate" => 0,
    "Gepok" => 0,
    "Log::Any" => 0,
    "Log::Any::Adapter" => 0,
    "Log::Any::Adapter::Callback" => "0.03",
    "Module::List" => 0,
    "Module::Patch" => "0.12",
    "Perinci::Access" => "0.10",
    "Perinci::Access::HTTP::Client" => "0.07",
    "Perinci::Access::InProcess" => "0.19",
    "Perinci::CmdLine" => 0,
    "Perinci::Examples" => 0,
    "Perinci::Gen::ForModule" => 0,
    "Perinci::Result::Format" => "0.30",
    "Perinci::Sub::GetArgs::Array" => 0,
    "Plack::Runner" => 0,
    "Riap" => "v1.1.10",
    "SHARYANTO::Array::Util" => 0,
    "Starman" => 0,
    "URI" => 0,
    "URI::Escape" => 0,
    "YAML::Syck" => 0,
    "perl" => "5.010001"
  },
  "script_files" => [
    "bin/peri-htserve"
  ]
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
