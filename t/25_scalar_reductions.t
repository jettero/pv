# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 25_scalar_reductions.t,v 1.1 2005/01/14 21:04:30 jettero Exp $

use Test;

plan tests => 1;

use Math::Units::PhysicalValue "PV";

TEST1: {
    my $v1 = PV "1 miles";
    my $v2 = PV "4 miles";

    ok( ($v1 / $v2), 0.25 );
}
