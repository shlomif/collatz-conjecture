#!/usr/bin/perl -w

use strict;

use Math::GMP;

my $i;
for($i=1;$i<1e9;$i++)
{
    #my $r = $i;Math::GMP->new($i);
    my $r = $i;
    while ($r != 1)
    {
        if ($r % 2 == 0)
        {
            $r /= 2;
        }
        else
        {
            $r *= 3;
            $r++;
        }
    }
    if ($i % 1000 == 0)
    {
        print "$i\n";
    }
}
