# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 01_load.t,v 1.3 2005/01/16 15:23:07 jettero Exp $

use strict;
use Test;

plan tests => 2;

use Math::Units::PhysicalValue qw(PV); ok 1;

my $v = PV("8 miles");

$v = deunit $v;

ok( $v, 8 );
