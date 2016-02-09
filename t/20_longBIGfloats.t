# vi:fdm=marker fdl=0 syntax=perl:

BEGIN { $ENV{LC_ALL} = "C" }

use strict;
use Test;

plan tests => 1;

use Math::Units::PhysicalValue "PV";

TEST1: {
    my $v1 = PV "2.718281828459045e10 g";
    my $s1 = "$v1";

    ok( $s1, "27,182,818,284.59 g" );
}
