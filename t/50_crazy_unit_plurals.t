# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 50_crazy_unit_plurals.t,v 1.2 2005/08/22 16:04:38 jettero Exp $

use strict;
use Test;

plan tests => 6;

use Math::Units::PhysicalValue qw(PV);

TEST1: {
    my $ships = PV "1 spaceship(s)";  # PV handles very generic ones automatically
    my $boxes = PV "1 box(es)";       # however, it may not be very accurate and
    my $virii = PV "1 virus(ii)";     # Math::Units::PhysicalValue::new() will not handle them at all.

    ok("$ships", "1 spaceship");
    ok("$boxes", "1 box");
    ok("$virii", "1 virus");

    $_ ++ for ($ships, $boxes, $virii);

    ok("$ships", "2 spaceships");
    ok("$boxes", "2 boxes");
    ok("$virii", "2 virii");


    # FIXME: make 1.0 parts/ship and 1.0 ships/hanger work
}
