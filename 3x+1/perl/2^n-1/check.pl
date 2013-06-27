#!/usr/bin/perl -w

use strict;
use Math::GMP qw(:constant);

sub is_power_of
{
    my $n = shift;
    my $power = shift;
    while ($n > 1)
    {
        if ($n % $power != 0)
        {
            return 0;
        }
        $n /= $power;
    }
    return 1;
}

sub f
{
    my $r = shift;
    if ($r & 0x1)
    {
        $r = $r * 3 + 1;
    }
    else
    {
        $r /= 2;
    }
    return $r;
}

my $i;
for($i=3;$i<20;$i++)
{
    my $num = 2**$i-1;
    my $r = $num;
    while (!is_power_of($r+1, 3))
    {
        if ($r == 1)
        {
            die "Not true (1) for $num!\n";
        }
        $r = f($r);
    }
    print "True (1) for $num! (\$r=$r)\n";
    while (!is_power_of($r*8+1, 9))
    {
        if ($r == 1)
        {
            die "Not true (2) for $num!\n";
        }
        $r = f($r);
    }
    print "True (2) for $num! (\$r=$r)\n";
}

