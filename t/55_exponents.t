# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 55_exponents.t,v 1.4 2005/12/07 21:18:27 jettero Exp $

use strict;
use Test;

plan tests => 2;

use Math::Units::PhysicalValue qw(PV);

my $earth_orbit = PV "149,597,870.691 km";

my $Ts  = PV "5780 K"; # temp of sun
my $Rs  = PV "432,469 miles"; # radius of sun
my $Te4 = (($Ts**4 * $Rs**2) / (4*$earth_orbit**2));

my $Te; # temp of earth (radiant-ally anyway)
eval q( $Te = $Te4 ** (1/4); ); 

ok($@, "");
ok($Te, "something...");
