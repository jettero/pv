# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 30_sigfigs.t,v 1.1 2005/01/16 15:23:07 jettero Exp $

use strict;
use Test;

plan tests => 1;

use Math::Units::PhysicalValue "PV";

# This is NOT the sigfig support that's on the todo list...
# It is a shitty undocumented makeshift solution until I get to it.

TEST1: {
    my $sun = PV "864,938 miles";

    ok( $sun->sci( 3 ), "8.65e5 miles" );
}
