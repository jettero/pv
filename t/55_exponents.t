# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 55_exponents.t,v 1.1 2005/12/07 21:05:22 jettero Exp $

use strict;
use Test;

plan tests => 5;

use Math::Units::PhysicalValue qw(PV);

$earth_orbit  = PV "149,597,870.691 km";

my $Ts  = PV "5780 K"; # temp of sun
my $Rs  = PV "432,469 miles"; # radius of sun
my $Te4 = (($Ts**4 * $Rs**2) / (4*$earth_orbit**2));

my $Te = $Te4 ** (1/4);
