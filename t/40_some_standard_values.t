# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 40_some_standard_values.t,v 1.1 2005/01/20 16:51:05 jettero Exp $

use strict;
use Test;

plan tests => 1;

use Math::Units::PhysicalValue qw(PV G);

# So far, there is only one standard value: G.
# The constants interface is still under consideration
# and is probably a bad idea in this form.

TEST1: {
    my $earth_mass    = PV "5.98e24 kg";
    my $earth_radius  = PV "6.37e6 m";

    my $g = &G * ( $earth_mass / $earth_radius**2 );

    ok( $g eq "9.83 m/s^2" );
}
