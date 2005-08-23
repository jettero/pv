# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 50_crazy_unit_plurals.t,v 1.3 2005/08/23 15:45:44 jettero Exp $

use strict;
use Test;

plan tests => 10;

use Math::Units::PhysicalValue qw(PV);

TEST1: {
    my $ships = PV "1 spaceship(s)";  # PV handles very generic ones automatically
    my $boxes = PV "1 box(es)";       # however, it may not be very accurate and
    my $virii = PV "1 virus(ii)";     # Math::Units::PhysicalValue::new() will not handle them at all.
    my $hulls = PV "1 hull(s)";

    ok("$ships", "1 spaceship");
    ok("$boxes", "1 box");
    ok("$virii", "1 virus");

    $_ ++ for ($ships, $boxes, $virii);

    ok("$ships", "2 spaceships");
    ok("$boxes", "2 boxes");
    ok("$virii", "2 virii");
}

TEST2: {
    my $ships = PV "1 ship(s)";
    my $hulls = PV "1 hull(s)";
    my $over  = $hulls / $ships;
    my $revo  = $ships / $hulls;

    ok("$over", "1 hull/ship");
    ok("$revo", "1 ship/hull");

    $over *= 2;
    $revo *= 2;

    ok("$over", "2 hulls/ship");
    ok("$revo", "2 ships/hull");
}
