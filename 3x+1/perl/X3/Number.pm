package X3::Number;

use strict;
use warnings;

use MooX qw/late/;

has [ 'var', 'rem' ] => ( is => 'rw' );

use X3::Error::NotTrans ();

use overload
    '""' =>
    sub { my $self = shift; return ( $self->var() . "*x + " . $self->rem() ); },
    '<=>' => \&compare;

sub compare
{
    my ( $a, $b ) = @_;
    return ( ( $a->var() <=> $b->var() ) || ( $a->rem() <=> $b->rem() ) );
}

sub increase
{
    my $self   = shift;
    my $parity = shift;

    my $var = $self->var();
    return X3::Number->new(
        {
            var => ( $var << 1 ),
            rem => ( $self->rem() + ( $parity ? $var : 0 ) ),
        }
    );
}

sub transform
{
    my $self    = shift;
    my $deny_3x = shift || 0;

    my $var = $self->var();
    my $rem = $self->rem();

    if ( $var & 0x1 )
    {
        # If var is not even we don't know anything - so throw an exception
        return 1;    # throw X3::Error::NotTrans;
    }

    if ( $rem & 0x1 )
    {
        if ($deny_3x)
        {
            return 2;
        }
        $var *= 3;
        $rem *= 3;
        $rem++;
    }
    else
    {
        $var >>= 1;
        $rem >>= 1;
    }
    $self->var($var);
    $self->rem($rem);

    return 0;
}

sub multi_transform
{
    my $self = shift;
    my $ret;
    while ( !( $ret = $self->transform(1) ) )
    {
        if ( $self->var() == 0 )
        {
            return 0;
        }
    }
    return $ret;
}

1;
