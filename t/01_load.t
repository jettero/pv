# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 01_load.t,v 1.2 2005/01/14 20:49:40 jettero Exp $

use Test;

plan tests => 2;

use Math::Units::PhysicalValue qw(PV); ok 1;

my $v = PV("8 miles");

$v = deunit $v;

ok( $v, 8 );
