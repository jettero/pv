# vi:fdm=marker fdl=0 syntax=perl:

use strict;
use Test;

plan tests => 1;

use Math::Units::PhysicalValue "PV";

TEST1: {
    my $v1 = PV "2.718281828459045e20 g";
    my $s1 = "$v1";

    ok( $s1, "271828182845904500000 g" );
}
