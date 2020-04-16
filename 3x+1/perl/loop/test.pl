#!/usr/bin/env perl

use strict;
use warnings;
use autodie;
use bytes;
use integer;

# use Math::GMP;

STDOUT->autoflush(1);
my $i;
my $STEP      = 1000000;
my $milestone = $STEP;
for ( $i = 2 ; $i < 1000000000 ; ++$i )
{
    #my $r = $i;Math::GMP->new($i);
    my $r = $i;
    while ( $r >= $i )
    {
        if ( $r & 1 )
        {
            $r *= 3;
            ++$r;
        }
        $r >>= 1;
    }
    if ( $i == $milestone )
    {
        print "$i\n";
        $milestone += $STEP;
    }
}
