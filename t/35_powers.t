# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 35_powers.t,v 1.1 2005/01/20 15:46:25 jettero Exp $

use strict;
use Test;

plan tests => 1;

use Math::Units::PhysicalValue "PV";

TEST1: {
    my $time = PV "32 s";

    $time = $time ** 2;

    ok( "$time", "1,024 s^2" );
}
