# vi:fdm=marker fdl=0 syntax=perl:
# $Id: 15_exponents.t,v 1.3 2005/01/14 18:50:45 jettero Exp $

use Test;

plan tests => 6;

use Math::Units::PhysicalValue "PV";

TEST1: {
    my $v1 = PV "9e3 m";

    ok( $v1 == "9 km" );
}

TEST2: {
    my $v2 = PV "19e27 Mg";
    my $v3 = PV "1.9e34 g";

    $v2 += "0 g";
    $v3 += "0 g";
    ok( $v2 == $v3 );
}

TEST3: {
    my $v2 = PV "19e27 Mg";
    my $v3 = PV "1.9e34 g";

    $v2 += "0 kg";
    $v3 += "0 kg";
    ok( $v2 == $v3 );
}

TEST4: {
    my $v2 = PV "19e27 Mg";
    my $v3 = PV "1.9e34 g";

    ok( $v2 == $v3 );
}

TEST5: {
    my $v2 = PV "19e27 Mg";
    my $v3 = PV "1.9e35 g";

    ok( $v2 < $v3 );
}

TEST6: {
    my $v2 = PV "19e27 Mg";
    my $v3 = PV "1.9e32 g";

    ok( $v2 > $v3 );
}
