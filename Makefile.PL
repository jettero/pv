# vi:set syntax=perl:
# $Id: Makefile.PL 14.314.jMM6gc8lCSBxgHTQbBpcBUOOo94 2007-03-05 13:17:37 -0500 $

use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'         => 'Math::Units::PhysicalValue',
    'VERSION_FROM' => 'PhysicalValue.pm',
    'PREREQ_PM'     => { 
        'Number::Format'         => 0,
        'Math::Units'            => 0,
        'Math::Algebra::Symbols' => 0,
    },
);
