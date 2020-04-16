package X3::WithLim;

use strict;
use warnings;

use MooX qw/late/;

use X3::Number ();

has [ 'n', 't_n' ] => ( is => 'rw' );

use overload '""' => sub {
    my $self = shift;
    return "n = " . $self->n() . "\nT^i(n) = " . $self->t_n() . "\n";
};

sub transform
{
    my $self = shift;

    my $n   = $self->n;
    my $t_n = $self->t_n;

    my $ret;

    while ( ( $t_n >= $n ) )
    {
        $ret = $t_n->transform();

        if ( $t_n < $n )
        {
            return 0;
        }

        if ($ret)
        {
            my (@results);
            for my $parity ( 0 .. 1 )
            {
                my $next_t_n = $t_n->increase($parity);
                $next_t_n->multi_transform();
                push @results,
                    X3::WithLim->new(
                    {
                        n   => $n->increase($parity),
                        t_n => $next_t_n,
                    }
                    );
            }
            return \@results;
        }
    }

    return 0;
}

1;
