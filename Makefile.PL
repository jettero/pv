# vi:set syntax=perl:

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
