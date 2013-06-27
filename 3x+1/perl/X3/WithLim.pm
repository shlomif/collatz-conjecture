package X3::WithLim;

use X3::Number;

use Shlomif::Gamla::Object;

our(@ISA);

@ISA=qw(Shlomif::Gamla::Object);

use overload '""' => 
    sub { 
        my $self = shift;
        return "n = " . $self->{'n'} . "\nT^i(n) = " . $self->{'t_n'} . "\n";
    };

sub initialize
{
    my ($self,$n,$t_n) = @_;

    $self->{'n'} = $n;
    $self->{'t_n'} = $t_n;

    return 0;
}

sub transform
{
    my $self = shift;

    my ($n,$t_n) = (@$self{qw(n t_n)});

    my $ret;
       
    while (($t_n >= $n))
    {
        $ret = $t_n->transform();

        if ($t_n < $n)
        {
            return 0;
        }

        if ($ret)
        {
            my (@results);
            for my $parity (0 .. 1)
            {
                my $next_t_n = $t_n->increase($parity);
                $next_t_n->multi_transform();
                push @results, 
                    X3::WithLim->new(
                        $n->increase($parity),
                        $next_t_n
                    );
            }
            return \@results;        
        }
    }

    return 0;
}

1;

