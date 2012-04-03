
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.3601"
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "PSGI application to implement Riap::HTTP",
  "dist_author" => [
    "Steven Haryanto <stevenharyanto\@gmail.com>"
  ],
  "dist_name" => "Perinci-Access-HTTP-Server",
  "dist_version" => "0.14",
  "license" => "perl",
  "module_name" => "Perinci::Access::HTTP::Server",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Gepok" => 0,
    "JSON" => 0,
    "Log::Any::Adapter" => 0,
    "Log::Any::Adapter::Callback" => "0.03",
    "Log::Any::App" => 0,
    "Module::List" => 0,
    "Perinci::Access" => "0.10",
    "Perinci::CmdLine" => 0,
    "Perinci::Examples" => 0,
    "Perinci::Gen::ForModule" => 0,
    "Perinci::Result::Format" => "0.12",
    "Perinci::Sub::GetArgs::Array" => 0,
    "Perinci::Sub::property::result_postfilter" => 0,
    "Perinci::Sub::property::timeout" => 0,
    "Plack" => 0,
    "Riap" => "1.1.8",
    "SHARYANTO::Array::Util" => 0,
    "Starman" => 0,
    "Test::More" => "0.96",
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
