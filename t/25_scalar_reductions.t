# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 25_scalar_reductions.t,v 1.2 2005/01/16 15:23:07 jettero Exp $

use strict;
use Test;

plan tests => 2;

use Math::Units::PhysicalValue "PV";

TEST1: {
    my $v1 = PV "1 miles";
    my $v2 = PV "4 miles";
    my $v3 = ($v1 / $v2);

    ok( $v3, 0.25 );
}

TEST2: {
    my $sun_radius  = PV("864,938 miles")/2;
       $sun_radius /= $sun_radius;

    ok( $sun_radius, 1 );
}
