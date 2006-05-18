# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 60_plurals.t,v 1.1 2006/05/18 00:54:12 jettero Exp $

use strict;
use Test;

plan tests => 6;

use Math::Units::PhysicalValue qw(PV);

TEST1: {
    my $unit_12 = PV "12 unit(s)";
    my $unit_1  = PV "1  unit(s)";
    my $unit_11 = PV "11 units";
    my $unit_5  = PV  "5 unit";

    my $u = $unit_12 - $unit_11;
    my $v = $unit_12 - $unit_5;
    my $w = $unit_1 + $unit_1;

    ok( $unit_12, "12 units" );
    ok( $unit_1,  "1 unit" );
    ok( $u,       "1 unit" );
    ok( $v,       "7 units" );
    ok( $w,       "2 units" );

    # NOTE: added later... why is there a difference?
    my $x = $unit_1 * 2;
    ok( $x, "2 units" );

}
