package Math::Units::PhysicalValue;

use strict;
use Carp;
use base qw(Exporter); our @EXPORT_OK = qw(PV);
use Math::Units qw(convert);
use Number::Format;
use overload 
    '+'  => \&pv_add,
    '*'  => \&pv_mul,
    '-'  => \&pv_sub,
    '/'  => \&pv_div,
    '++' => \&pv_inc,
    '--' => \&pv_dec,
    '==' => \&pv_num_eq,
    '<'  => \&pv_num_lt,
    '>'  => \&pv_num_gt,
    '<=' => \&pv_num_lte,
    '>=' => \&pv_num_gte,
    'eq' => \&pv_str_eq,
    '""' => \&pv_print;

our $VERSION        = "0.45";
our $StrictTypes    = 0; # throws errors on unknown units
our $PrintPrecision = 2; 
our $fmt;
    $fmt = new Number::Format if not defined $fmt;

1;

# PV {{{
sub PV {
    my $v = shift;

    return Math::Units::PhysicalValue->new( $v );
}
# }}}
# new {{{
sub new {
    my $class = shift;
    my $value = shift;
    my $this  = bless [], $class;

    if( $value =~ m/^([\-\,\.\de]+)\s*(\S*)$/ ) {
        my ($v, $u) = ($1, $2);

        $v =~ s/\,//g;
        $u =~ s/\^/**/g;

        if ( $StrictTypes ) {
            eval { convert(3.1415926, $u, '') };
            if( $@ =~ /unknown unit/ ) {
                my $e = $@;
                $e =~ s/ at .*PhysicalValue.*//s;
                croak $e;
            }
        }

        $this->[0] = $v;
        $this->[1] = new Math::Units::PhysicalValue::AutoUnit $u;

    } else {
        croak "value passed to PhysicalValue->new(\"$value\") was not understood";
    }

    return $this;
}
# }}}
# deunit {{{
sub deunit {
    my $this = shift;

    return $this->[0];
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
        $e =~ s/'1'/''/;
        $e =~ s/ at .*PhysicalValue.*//s;
        croak $e;
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

# pv_str_eq {{{
sub pv_str_eq {
    my ($lhs, $rhs) = @_;

    $rhs = ref($lhs)->new($rhs) unless ref $rhs eq ref $lhs;

    my $v;
    eval {
        $v = convert(@$rhs, $lhs->[1]);
    };

    $rhs->[0] = $v;
    $rhs->[1] = $lhs->[1];

    if( $@ ) {
        my $e = $@;
        $e =~ s/'1'/''/;
        $e =~ s/ at .*PhysicalValue.*//s;
        croak $e;
    }

    return "$lhs" eq "$rhs";
}
# }}}
# pv_num_eq {{{
sub pv_num_eq {
    my ($lhs, $rhs) = @_;

    $rhs = ref($lhs)->new($rhs) unless ref $rhs eq ref $lhs;

    my $v;
    eval {
        $v = convert(@$rhs, $lhs->[1]);
    };

    if( $@ ) {
        my $e = $@;
        $e =~ s/'1'/''/;
        $e =~ s/ at .*PhysicalValue.*//s;
        croak $e;
    }

    unless( $lhs->[0] == $v ) {
        $v = "$v";  # This is a really stupid hack... but it sometimes fixes things like 19e27 != 1.9e+28 ... dumb
                    # I'm afraid that it's throwing away a lot of precision... but then again, hopefully we aren't relying
                    # on == too much for floats...
    }

    return $lhs->[0] == $v;
}
# }}}
# pv_num_lt {{{
sub pv_num_lt {
    my ($lhs, $rhs) = @_;

    $rhs = ref($lhs)->new($rhs) unless ref $rhs eq ref $lhs;

    my $v;
    eval {
        $v = convert(@$rhs, $lhs->[1]);
    };

    if( $@ ) {
        my $e = $@;
        $e =~ s/'1'/''/;
        $e =~ s/ at .*PhysicalValue.*//s;
        croak $e;
    }

    return $lhs->[0] < $v;
}
# }}}
# pv_num_gt {{{
sub pv_num_gt {
    my ($lhs, $rhs) = @_;

    $rhs = ref($lhs)->new($rhs) unless ref $rhs eq ref $lhs;

    my $v;
    eval {
        $v = convert(@$rhs, $lhs->[1]);
    };

    if( $@ ) {
        my $e = $@;
        $e =~ s/'1'/''/;
        $e =~ s/ at .*PhysicalValue.*//s;
        croak $e;
    }

    return $lhs->[0] > $v;
}
# }}}
# pv_num_lte {{{
sub pv_num_lte {
    my ($lhs, $rhs) = @_;

    $rhs = ref($lhs)->new($rhs) unless ref $rhs eq ref $lhs;

    my $v;
    eval {
        $v = convert(@$rhs, $lhs->[1]);
    };

    if( $@ ) {
        my $e = $@;
        $e =~ s/'1'/''/;
        $e =~ s/ at .*PhysicalValue.*//s;
        croak $e;
    }

    return $lhs->[0] <= $v;
}
# }}}
# pv_num_gte {{{
sub pv_num_gte {
    my ($lhs, $rhs) = @_;

    $rhs = ref($lhs)->new($rhs) unless ref $rhs eq ref $lhs;

    my $v;
    eval {
        $v = convert(@$rhs, $lhs->[1]);
    };

    if( $@ ) {
        my $e = $@;
        $e =~ s/'1'/''/;
        $e =~ s/ at .*PhysicalValue.*//s;
        croak $e;
    }

    return $lhs->[0] >= $v;
}
# }}}

# pv_print {{{
sub pv_print {
    my $this = shift;
    my ($v, $u) = @$this;

    if( $u->{unit} == 1 ) {
        $u = "";
    } else {
        $u = " $u";
    }

    return $v . $u if $PrintPrecision < 0;

    # temprary fix until I hear back from the Number::Format guy

    my $f = join('', $fmt->format_number( $v, $PrintPrecision ), $u);
    if( $f =~ m/^\S*e/ ) {
        $f = $v . $u;
        $f =~ s/e\+(\d+)/e$1/g;
        $f =~ s/^([\.\-\d]+)(?=e)/$fmt->format_number( $1, $PrintPrecision )/e if $PrintPrecision >= 0;
    }
    return $f;

    # original numbers

=cut
    return "$v $u" if $PrintPrecision < 0;
    return join(" ", $fmt->format_number( $v, $PrintPrecision ), $u);
=cut

}
# }}}
# sci {{{
sub sci {
    my $this   = shift;
    my $digits = shift;
    my ($v, $u) = @$this;
    my $e = int( log($v) / log(10) );

    if( $u->{unit} == 1 ) {
        $u = "";
    } else {
        $u = " $u";
    }

    croak "please use 0 or more sigfigs..." if $digits < 0;

    $v = $fmt->format_number($v / (10 ** $e), $digits-1) . "e$e";

    return $v . $u;
}
# }}}

=cut

=head1 NAME

Math::Units::PhysicalValue - An object oriented interface for handling values with units.

=head1 SYNOPSIS

    use Math::Units::PhysicalValue;

    my $exit  = new Math::Units::PhysicalValue "10,000 ft";
    my $open  = "3500 ft";
    my $delay = "43 s";

    my $dist  = $exit - $open;
    my $rate  = $dist / $delay;

    my $weight = "180 lbs";
    my $momentum = ($weight * ( ($exit - $open) / $delay )) + "0 kg*m/s";

    print "$momentum\n";                     # prints 3,761.82 kg*m/s
    print ($rate + "0 miles/hour"), "\n"     # prints 103.07 miles/hour

=head1 DESCRIPTION

In more detail than the synopsis, Math::Units::PhysicalValue (aka PV) keeps
track of the units on values that might work in the real world.  It splits and
stores the value and units separately as an array.

Using operator overloading, you can use them how you'd normally use any numeric
value.  There are probably more gotchas than I can enumerate, but you should be
able to stay out of trouble if you keep string values on the right hand side of
operators.

    my $example1 = new Math::Units::PhysicalValue "10,000 ft";  
    my $example2 = "3500 ft";
    my $example3 = "1000 ft";

    print ($example1 + $example2 + $example3), "\n"; # prints: 13,500 ft
    print ($example3 + $example2 + $example1), "\n"; # generates an error...

Perl is smart enough to do $example1 and $example2 in any order, but $example3 +
$example2 is evaluated as the number 4500 (with no units) before it gets added
to $example1 -- where the units won't match!

=head2 WATCH OUT FOR PLURALS

Math::Units can handle them (mostly), but Math::Algebra::Symbols cannot.

    my $v1 = new Math::Units::PhysicalValue "1 hour";
    my $v2 = new Math::Units::PhysicalValue "2 hours";
    my $v3 = $v1 + $v2;
    my $v4 = $v1 / $v2;

    print "$v3\n"; # prints 3 hours
    print "$v4\n"; # prints 0.5 hour/hours  .. and that's probably not what you want.

=head2 Export PV

There is a shortcut.  You can use Math::Units::PhysicalValue "PV" to export the
magical shortcut function.  my $v = PV "10,000 ft" is the same as $example1
above.  Handy.

    my $handy = (PV "8miles") + (PV "72ft");
    my $time  = PV "90s";
    my $fast  = $handy / $time;  # neato

=head2 $StrictTypes

Presently, by default, you can create $wierd_units = PV "5 Saxons"; without any
real trouble.  When you try to convert it to something real, Math::Units will
have an opportunity to complain.  If your Saxon units cancel out before
Math::Units sees it, though, it's perfectly fine to make it up as you go.

WATCH OUT FOR PLURALS (again) though.

=head2 $PrintPrecision

There is a Number::Format object in the head of PV.  $PrintPrecision is the 
precision passed to format_number when PV is evaluated in a string context.

$Math::Units::PhysicalValue::PrintPrecision defaults to 2

You can set $Math::Units::PhysicalValue::PrintPrecision = -1 to disable it and
lastly, you can set all sorts of format settings like so:

    $Math::Units::PhysicalValue::fmt = 
        new Number::Format(-thousands_sep   => '.',
                                -decimal_point   => ',',
                                -int_curr_symbol => 'DEM');

Though, at this time, there's no way to change which format function it uses.

=head2 deunit()

If you want to get the numerical value back out, you can use deunit();

    my $v = deunit PV("8 miles"); # makes $v = 8;

=head1 AUTHOR

Jettero Heller <japh@voltar-confed.org>

Jet is using this software in his own projects...  If you find bugs, please
please please let him know. :) Actually, let him know if you find it handy at
all.  Half the fun of releasing this stuff is knowing that people use it.

Additionally, he is aware that the documentation sucks.  Should you email him
for help, he will most likely try to give it.

=head1 COPYRIGHT

GPL!  I included a gpl.txt for your reading enjoyment.

Though, additionally, I will say that I'll be tickled if you
were to include this package in any commercial endeavor.
Also, any thoughts to the effect that using this module will
somehow make your commercial package GPL should be washed
away.

I hereby release you from any such silly conditions.

This package and any modifications you make to it must
remain GPL.  Any programs you (or your company) write shall
remain yours (and under whatever copyright you choose) even
if you use this package's intended and/or exported
interfaces in them.

=head1 TODO

Here's a list of things I'd still like to do.  

If you'd like to add a couple, please float me an email.

1) Significant digit support (until it's done, there is $value->sci( $digits ))
2) Error interval support
*) Better handling of metric units (e.g, 3g == 0.003kg == 3000mg)

Concerning metric units, I expected them to work much worse than they do.  In
fact, they appear to function correctly.  If you can produce and examples of
failures, please let me know.  For now I'm going to assume they work.

=head1 SPECIAL THANKS

Math::Units and Math::Algebra::Symbols do all the real work here.

So really, say thanks to these guys:

Ken Fox <fox ta vulpes.com>

Philip R Brenan at <philiprbrenan ta yahoo.com>

And here's a nod to Number::Format.  I use the module constantly.

William R. Ward, <wrw ta bayview.com>

=head1 SEE ALSO

perl(1), Math::Units, Math::Algebra::Symbols, Number::Format

=cut

package Math::Units::PhysicalValue::AutoUnit;

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

    if( $unit =~ m/[^a-zA-Z]/i ) {
        my %unities = ();

        while( $unit =~ m/([a-zA-Z]+)/g ) {
            my $xxu = "xx$1";
            unless( $unities{$xxu} ) {
                $unities{$xxu} = symbols($xxu);
            }
        }

        my $obj;

        $unit =~ s/([a-zA-Z]+)/\$unities{"xx$1"}/g;
        $unit = "\$obj = $unit";

        eval $unit;
        die $@ if $@;

        # use Data::Dumper;
        # warn "$obj";
        # die Dumper( \%unities, $unit, $obj );

        $this->{unit} = $obj;

    } elsif( $unit =~ m/[a-zA-Z]/ ) {
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
