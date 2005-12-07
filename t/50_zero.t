# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 50_zero.t,v 1.3 2005/12/07 21:08:00 jettero Exp $

use strict;
use Test;

plan tests => 4;

use Math::Units::PhysicalValue qw(PV);

my $mass_0  = 0;
my $mass_10 = PV "10 g";

my ($t1, $t2);

eval q($t1 = $mass_0  + $mass_10;); ok( not $@ );
eval q($t2 = $mass_10 + $mass_0;);  ok( not $@ );

ok( "$t1", "10 g" );
ok( "$t2", "10 g" );
