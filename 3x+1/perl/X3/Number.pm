package X3::Number;

our(@ISA);

use Shlomif::Gamla::Object;

@ISA=qw(Shlomif::Gamla::Object);

use Error qw(:try);
use X3::Error::NotTrans;

use overload
    '""' => sub { my $self = shift; return ($self->get_var() . "*x + " .$self->get_rem()); },
    '<=>' => \&compare;

sub compare
{
    my ($a,$b) = @_;
    return (($a->get_var() <=> $b->get_var()) ||
            ($a->get_rem() <=> $b->get_rem())
           );
}

sub initialize
{
    my $self = shift;

    my $arg = shift;
    my $arg2 = shift;
    $self->set($arg,$arg2);

    return 0;
}

sub increase
{
    my $self = shift;
    my $parity = shift;

    my $var = $self->get_var();
    return X3::Number->new(
        ($var << 1),
        ($self->get_rem() + ($parity ? $var : 0))
    );
}

sub get_var
{
    my $self = shift;

    return $self->{'var'};
}

sub get_rem
{
    my $self = shift;

    return $self->{'rem'};
}

sub set
{
    my $self = shift;
    @{$self}{qw(var rem)} = @_;
    return 0;
}

sub transform
{
    my $self = shift;
    my $deny_3x = shift || 0;

    my $var = $self->get_var();
    my $rem = $self->get_rem();

    if ($var & 0x1)
    {
        # If var is not even we don't know anything - so throw an exception
        return 1; # throw X3::Error::NotTrans;
    }

    if ($rem & 0x1)
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
    $self->set($var,$rem);

    return 0;
}

sub multi_transform
{
    my $self = shift;
    my $ret;
    while (!($ret = $self->transform(1)))
    {
        if ($self->get_var() == 0)
        {
            return 0;
        }
    }
    return $ret;
}

1;


