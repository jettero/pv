# vi:fdm=marker fdl=0 syntax=perl:

use strict;
use Test;

plan tests => 2;

use Math::Units::PhysicalValue qw(PV); ok 1;

my $v = PV("8 miles");

$v = deunit $v;

ok( $v, 8 );
