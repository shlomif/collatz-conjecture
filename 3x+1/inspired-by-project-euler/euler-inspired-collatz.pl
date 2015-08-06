#!/usr/bin/perl

use strict;
use warnings;

use Math::GMP;

sub seq
{
    my ($n) = @_;

    if ($n == 1)
    {
        return '';
    }
    elsif ($n & 0b1)
    {
        return "u" . seq(($n * 3 + 1) >> 1);
    }
    else
    {
        return "d" . seq($n >> 1);
    }
}

print seq(shift(@ARGV)), "\n";
