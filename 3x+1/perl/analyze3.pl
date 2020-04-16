#!/usr/bin/env perl

use strict;
use warnings;
use autodie;

open my $in_fh, '<', 'dump.txt';
while ( my $l = <$in_fh> )
{
    if ( my ($n) = $l =~ /\An = ([0-9]+)\*x/ )
    {
        if ( my ($t) = ( ( my $l2 = <$in_fh> ) =~ / = ([0-9]+)\*x/ ) )
        {
            if ( $t == $n )
            {
                print $l2;
            }
        }
    }
}
close($in_fh);
