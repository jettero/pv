# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 15_exponents.t,v 1.1 2005/01/14 16:02:03 jettero Exp $

use Test;

plan tests => 1;

use Math::Units::PhysicalValue "PV";

my $v1 = 9 * PV "10e3 m";

ok( $v1 == "9 kg" );
