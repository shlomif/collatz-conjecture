#!/usr/bin/perl -w

use strict;
use Math::GMP qw(:constant);

sub base_rep
{
    my $n = shift;
    my $b = shift;
    $n = $n + 0;
    my $s = "";
    my $i = 0;
    while ($n)
    {
        $s = ($n % $b) . $s;
        $n = ($n - ($n%$b)) / $b;
    }
    continue 
    {
        $i++;
    }
    return $s;
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
    my $num = 3**$i-1;
    print "i=$i num=$num\n\n";
    while ($num != 1)
    {
        printf("%040s\n", base_rep($num, 2));
        $num = f($num);
    }
    print "\n";
}
