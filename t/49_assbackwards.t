# vi:fdm=marker fdl=0 syntax=perl:

use strict;
use Test;

plan tests => 8;

use Math::Units::PhysicalValue qw(PV);

my $a =    "12 g";
my $b = PV "15 g";

my $c = PV "12 g";
my $d =    "15 g";

ok( $a < $b => $c < $d );
ok( $a > $b => $c > $d );

ok( $a <= $b => $c <= $d );
ok( $a >= $b => $c >= $d );

ok( $a - $b => $c - $d );
ok( $a / $b => $c / $d );

ok( ($a cmp $b) => ($c cmp $d) );
ok( ($a <=> $b) => ($c <=> $d) );
