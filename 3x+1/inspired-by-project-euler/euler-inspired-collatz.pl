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

        # print "N=$n Seq=$seq\n";

        my $l = min(length($seq), length($wanted_seq));

        my $has_l = sub {
            for my $i (0 .. $l-1)
            {
                if (substr($seq, $i, 1) ne substr($wanted_seq, $i, 1))
                {
                    return $i;
                }
            }
            return $l;
        }->();

        if ($has_l > length($has_seq))
        {
            my $d = ($n - $last_n);
            # printf "Diff = 0b%s ; 0t%s\n", base($d, 2), base($d, 3);
            $last_n = $n;
            $has_seq = substr($seq, 0, $has_l);

            if ($has_seq =~ /\A\Q$wanted_seq\E/)
            {
                return $n;
            }
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

    my $exact_n = find_exact_seq($sub_seq);
    my $u_n = find_wanted_seq($last_n, $sub_seq.'u');
    my $d_n = find_wanted_seq($last_n, $sub_seq.'d');

    print "{ l=$l }\n";
    if (defined $exact_n)
    {
        print "D[exact] = " . as_bin($exact_n-$last_n) . "\n";
    }
    else
    {
        print "D[exact] = NONE\n";
    }
    print "D[d] = " . as_bin($d_n-$last_n) . "\n";
    print "D[u] = " . as_bin($u_n-$last_n) . "\n";

    if (substr($input_seq, $l, 1) eq 'u')
    {
        $last_n = $u_n;
    }
    else
    {
        $last_n = $d_n;
    }
}
