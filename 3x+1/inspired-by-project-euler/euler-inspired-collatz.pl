#!/usr/bin/perl

use strict;
use warnings;

no warnings 'recursion';

use List::Util qw(min);

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

sub base
{
    my ($n  , $b) = @_;

    if (!$n)
    {
        return '';
    }

    return base(int($n / $b), $b) . ($n % $b);
}

my $wanted_seq = shift(@ARGV);

my $has_seq = '';
my $last_n = 0;
N:
for my $n (1 .. 1_000_000_000_000)
{
    my $seq = seq(Math::GMP->new($n));

    my $l = min(length($seq), length($wanted_seq));

    my $has_l = sub {
        for my $i (1 .. $l)
        {
            if (substr($seq, $i, 1) ne substr($wanted_seq, $i, 1))
            {
                return $i-1;
            }
        }
        return $l;
    }->();

    if ($has_l > length($has_seq))
    {
        my $d = ($n - $last_n);
        printf "Diff = 0b%s ; 0t%s\n", base($d, 2), base($d, 3);
        $last_n = $n;
        $has_seq = $seq;

        if ($has_seq =~ /\A\Q$wanted_seq\E/)
        {
            last N;
        }
    }
}
