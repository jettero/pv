# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 05_skydiving.t,v 1.1 2005/01/12 20:21:46 jettero Exp $

use Test;

plan tests => 3;

use Math::Units::PhysicalValue; ok 1;

my $exit  = new Math::Units::PhysicalValue "10,000 ft";
my $open  = "3500 ft";
my $delay = "43 s";

my $dist  = $exit - $open;
my $rate  = $dist / $delay;

my $weight = "180 lbs";
my $momentum = ($weight * ( ($exit - $open) / $delay )) + "0 kg*m/s";

# dist: 6,500 ft                                       
# rate: 151.16 ft/s
# momentum: 3,761.82 kg*m/s

ok( $dist,     "6,500 ft"        );
ok( $rate,     "151.16 ft/s"     );
ok( $momentum, "3,761.82 kg*m/s" );
