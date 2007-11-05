# vi:set syntax=perl:
# $Id: Makefile.PL 15.353.2EFvkwaFwns6Ik/ezhN1F8h08v0 2007-11-05 07:33:24 -0500 $

use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'         => 'Math::Units::PhysicalValue',
    'VERSION_FROM' => 'PhysicalValue.pm',
    'PREREQ_PM'     => { 
        'Number::Format'         => 0,
        'Math::Units'            => 0,
        'Math::Algebra::Symbols' => 0,
        'Math::BigFloat'         => 0,
    },
);
