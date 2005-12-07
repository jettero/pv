# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 50_zero.t,v 1.1 2005/12/07 21:03:38 jettero Exp $

use strict;
use Test;

plan tests => 5;

use Math::Units::PhysicalValue qw(PV);

my $mass_0  = 0;
my $mass_10 = PV "10 g";

my $t1 = $mass_0  + $mass_10;
my $t2 = $mass_10 + $mass_0;
