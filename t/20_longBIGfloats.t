# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 20_longBIGfloats.t,v 1.1 2005/01/14 20:34:27 jettero Exp $

use Test;

plan tests => 1;

use Math::Units::PhysicalValue "PV";

TEST1: {
    my $v1 = PV "2.718281828459045e20 g";
    my $s1 = "$v1";

    ok( $s1, "2.72e20" );
}
