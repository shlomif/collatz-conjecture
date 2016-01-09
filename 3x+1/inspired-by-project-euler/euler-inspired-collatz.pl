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
    if ($n < 0)
    {
        return '-' . base(-$n , $b);
    }

    return base(int($n / $b), $b) . ($n % $b);
}

sub find_wanted_seq
{
    my ($n, $wanted_seq) = @_;

    my $has_seq = '';
    my $last_n = 0;
    N:
    while (1)
    {
        my $seq = seq(Math::GMP->new($n));

        if ($seq =~ /\A\Q$wanted_seq\E/)
        {
            return $n;
        }
    }
    continue
    {
        $n++;
    }
}

sub find_exact_seq
{
    my ($exact_seq) = @_;

    my $cb;

    $cb = sub {
        my ($so_far, $ops) = @_;

        if (! @$ops)
        {
            return $so_far;
        }
        elsif (shift(@$ops) eq 'd')
        {
            return $cb->(($so_far << 1), $ops);
        }
        else
        {
            my $x = ($so_far << 1)-1;
            if ($x % 3 != 0)
            {
                die "None";
            }
            return $cb->(($x / 3), $ops);
        }
    };

    my $ret;
    eval {
        $ret = $cb->(Math::GMP->new(1), [reverse split //, $exact_seq]);
    };

    if ($@)
    {
        return undef();
    }
    else
    {
        return $ret;
    }
}

sub base_wrapper
{
    my $ret = base(@_);
    return length($ret) ? $ret : 0;
}

sub as_bin
{
    my ($n) = @_;
    return '0b' . base_wrapper($n, 2);
}

my $input_seq = shift(@ARGV);

my $last_n = 1;
for my $l (1 .. length($input_seq)-1)
{
    my $sub_seq = substr($input_seq, 0, $l);

    print "{ l=$l seq=< $sub_seq > }\n";
    my $exact_n = find_exact_seq($sub_seq);
    if (defined $exact_n)
    {
        print "D[exact] = " . as_bin($exact_n-$last_n) . "\n";
    }
    else
    {
        print "D[exact] = NONE\n";
    }
    my $next_n;
    foreach my $step ('d', 'u')
    {
        my $step_n = find_wanted_seq($last_n, $sub_seq . $step);
        printf ("D[%s] = %s\n", $step, as_bin($step_n - $last_n));
        if (substr($input_seq, $l, 1) eq $step)
        {
            $next_n = $step_n;
        }
    }
    $last_n = $next_n;
}
