use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'TorontoPerlMongers',
    AUTHOR              => q{YOUR NAME <youremail@example.com>},
    VERSION_FROM        => 'lib/TorontoPerlMongers.pm',
    ABSTRACT            => 'YOUR APPLICATION ABSTRACT',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' 			        => 0,
        'YAML'       			        => 0,
        'Dancer'     			        => 1.3080,
        'Dancer::Plugin::Feed'          => 0,
        'common::sense' 		        => 0,
        'Dancer::Template::Alloy'       => 0,
        'Moose'                         => 0,
        'XML::Simple'                   => 0,
        'DateTime::Format::ISO8601'     => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'TorontoPerlMongers-*' },
);
