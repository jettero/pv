package Math::Units::PhysicalValue;

use strict;
use Carp;
use Math::Units qw(convert);
use Number::Format;
use overload 
    '+'  => \&pv_add,
    '*'  => \&pv_mul,
    '-'  => \&pv_sub,
    '/'  => \&pv_div,
    '++' => \&pv_inc,
    '--' => \&pv_dec,
    '""' => \&pv_print;

our $VERSION        = "0.31";
our $StrictTypes    = 0; # throws errors on unknown units
our $PrintPrecision = 2; 
our $fmt;
    $fmt = new Number::Format if not defined $fmt;

1;

# new {{{
sub new {
    my $class = shift;
    my $value = shift;
    my $this  = bless [], $class;

    if( $value =~ m/^([\-\,\.\d]+)\s*(\S*)$/ ) {
        my ($v, $u) = ($1, $2);

        $v =~ s/\,//g;

        if ( $StrictTypes ) {
            eval { convert(3.1415926, $u, '') };
            if( $@ =~ /unknown unit/ ) {
                my $e = $@;
                $@ =~ s/ at PhysicalValue.*//s;
                croak $@;
            }
        }

        $this->[0] = $v;
        $this->[1] = new AutoUnit $u;

    } else {
        croak "value passed to PhysicalValue->new(\"$value\") was not understood";
    }

    return $this;
}
# }}}

# pv_add {{{
sub pv_add {
    my ($lhs, $rhs) = @_; 
    
    $rhs = ref($lhs)->new($rhs) unless ref $rhs eq ref $lhs;

    my $v; 
    eval {
        $v = convert(@$lhs, $rhs->[1]);
    };

    if( $@ ) {
        my $e = $@;
        $@ =~ s/'1'/''/;
        $@ =~ s/ at PhysicalValue.*//s;
        croak $@;
    }

    $v += $rhs->[0];

    return bless [ $v, $rhs->[1] ], ref $lhs;
}
# }}}
# pv_mul {{{
sub pv_mul {
    my ($lhs, $rhs) = @_; 

    $rhs = ref($lhs)->new($rhs) unless ref $rhs eq ref $lhs;

    my ($v, $u) = (@$lhs);

    $v *= $rhs->[0];
    $u *= $rhs->[1];

    return bless [ $v, $u ], ref $lhs;
}
# }}}
# pv_div {{{
sub pv_div {
    my ($lhs, $rhs) = @_;

    $rhs = ref($lhs)->new($rhs) unless ref $rhs eq ref $lhs;

    my ($v, $u) = (@$lhs);

    $v /= $rhs->[0];
    $u /= $rhs->[1];

    return bless [ $v, $u ], ref $lhs;
}
# }}}

# pv_sub {{{
sub pv_sub {
    my ($lhs, $rhs) = @_;

    $rhs = ref($lhs)->new($rhs) unless ref $rhs eq ref $lhs;

    return $lhs->pv_add( $rhs->pv_mul(-1) );
}
# }}}

# pv_inc {{{
sub pv_inc {
    my $this = shift;

    $this->[0] ++;
    
    return $this;
}
# }}}
# pv_dec {{{
sub pv_dec {
    my $this = shift;

    $this->[0] --;
    
    return $this;
}
# }}}

# pv_print {{{
sub pv_print {
    my $this = shift;
    my ($v, $u) = @$this;

    # $v = bstr $v;

    return "$v $u" unless $PrintPrecision;
    return join(" ", $fmt->format_number( $v, $PrintPrecision ), $u);
}
# }}}

package AutoUnit;

use strict;
use Carp;
use Math::Algebra::Symbols;
use overload
    '+'  => \&au_add,
    '-'  => \&au_sub,
    '/'  => \&au_div,
    '*'  => \&au_mul,
    'eq' => \&au_eq,
    '""' => \&au_print;

# new {{{
sub new {
    my $class = shift;
    my $unit  = shift;
    my $this  = bless {unit=>1}, $class;

    if( $unit =~ m/[^a-z]/ ) {
        my %unities = ();

        while( $unit =~ m/([a-z]+)/g ) {
            my $xxu = "xx$1";
            unless( $unities{$xxu} ) {
                $unities{$xxu} = symbols($xxu);
            }
        }

        my $obj;

        $unit =~ s/([a-z]+)/\$unities{"xx$1"}/g;
        $unit = "\$obj = $unit";

        eval $unit;
        die $@ if $@;

        # use Data::Dumper;
        # warn "$obj";
        # die Dumper( \%unities, $unit, $obj );

        $this->{unit} = $obj;

    } elsif( $unit =~ m/[a-z]/ ) {
        $this->{unit} = symbols("xx$unit");

    }

    return $this;
}
# }}}
# au_mul {{{
sub au_mul {
    my ($lhs, $rhs) = @_;

    return bless { unit=>($lhs->{unit} * $rhs->{unit}) }, ref $lhs;
}
# }}}
# au_div {{{
sub au_div {
    my ($lhs, $rhs) = @_;

    return bless { unit=>($lhs->{unit} / $rhs->{unit}) }, ref $lhs;
}
# }}}
# au_print {{{
sub au_print {
    my $this = shift;
    my $a = $this->{unit};
       $a =~ s/\$xx//g;
       $a =~ s/\*\*/\^/g;

    return $a;
}
# }}}
# au_eq {{{
sub au_eq {
    my ($lhs, $rhs) = @_;

    return $lhs->au_print eq $rhs->au_print;
}
# }}}
