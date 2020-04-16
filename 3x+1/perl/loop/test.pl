#!/usr/bin/env perl

use strict;
use warnings;
use autodie;
use bytes;
use integer;

# use Math::GMP;

my $i;
for ( $i = 2 ; $i < 1e9 ; ++$i )
{
    #my $r = $i;Math::GMP->new($i);
    my $r = $i;
    while ( $r >= $i )
    {
        if ( $r % 2 == 0 )
        {
            $r /= 2;
        }
        else
        {
            $r *= 3;
            ++$r;
        }
    }
    if ( $i % 100000 == 0 )
    {
        print "$i\n";
    }
}
