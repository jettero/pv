# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 10_metric.t,v 1.2 2005/01/16 15:23:07 jettero Exp $

use strict;
use Test;

plan tests => 6;

use Math::Units::PhysicalValue "PV";

# A typical jump
my $v1 = PV "9 m**2";
my $v2 = PV "9 m^2";
my $v3 = PV "3 m";
my $v4 = PV "0.003 km";

ok( $v1 == $v2 );
ok( $v3 == $v4 );

ok( ($v4 * $v3) == $v1 );
ok( ($v4 * $v3) == $v2 );

ok( $v3 / $v4, 1 );

ok( $v3 == "3000 mm" )
