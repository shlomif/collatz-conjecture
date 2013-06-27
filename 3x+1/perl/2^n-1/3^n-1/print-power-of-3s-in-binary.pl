#!/usr/bin/perl -w

use strict;

use Math::GMP qw(:constant);

sub binary_rep
{
    my $n = shift;
    $n = $n + 0;
    my $s = "";
    my $i = 0;
    while ($n)
    {
        $s = ($n % 2) . $s;
        if ($i % 4 == 3)
        {
            $s = "|".$s;
        }
        $n = ($n - ($n%2)) / 2;
    }
    continue 
    {
        $i++;
    }
    return $s;
}

my $i;
for($i=0;$i<20;$i++)
{
    printf("%070s\n", binary_rep(3**$i));
}
