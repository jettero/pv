# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 45_boolean.t,v 1.1 2005/02/10 16:06:10 jettero Exp $

use strict;
use Test;

plan tests => 2;

use Math::Units::PhysicalValue qw(PV);

TEST1: {
    my $mass_0  = PV "0 g";
    my $mass_10 = PV "10 g";

    if( $mass_0 ) {
        ok( 0 );

    } else {
        ok( 1 );

    }

    if( $mass_10 ) {
        ok( 1 );

    } else {
        ok( 0 );

    }
}
