# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 15_exponents.t,v 1.2 2005/01/14 16:05:00 jettero Exp $

use Test;

plan tests => 1;

use Math::Units::PhysicalValue "PV";

my $v1 = (PV "9e3 m");

ok( $v1 == "9 km" );
