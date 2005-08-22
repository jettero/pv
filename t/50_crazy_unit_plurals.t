# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 50_crazy_unit_plurals.t,v 1.1 2005/08/22 13:11:51 jettero Exp $

use strict;
use Test;

plan tests => 2;

use Math::Units::PhysicalValue qw(PV);

TEST1: {
    my $ships = PV "1 spaceship(s)";
    my $boxes = PV "1 box(es)";
    my $virii = PV "1 virus(ii)";

    ok("$ships", "1 spaceship");
    ok("$boxes", "1 box");
    ok("$virii", "1 virus");

    $_ ++ for ($ships, $boxes, $virii);

    ok("$ships", "2 spaceships");
    ok("$boxes", "2 boxes");
    ok("$virii", "2 virii");
}
