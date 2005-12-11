# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 35_powers.t,v 1.2 2005/12/11 13:28:16 jettero Exp $

use strict;
use Test;

plan tests => 2;

use Math::Units::PhysicalValue "PV";

TEST1: {
    my $time = PV "32 s";

    $time = $time ** 2;

    ok( "$time", "1,024 s^2" );
}

TEST2: {
    my $time = PV "9 s^2";

    $time = sqrt( $time );

    ok( "$time", "3 s" );
}
