#!/usr/bin/perl -w

use strict;

use X3::Number;
use X3::WithLim;

my $n = X3::Number->new(4,3);
my $t_n = X3::Number->new(4,3);
my $init_lim = X3::WithLim->new($n,$t_n);

my ($result, $lims, $new_lims);

$lims = [ $init_lim ];

my $max_num_iters = shift(@ARGV) || 10;

my $i = 3;
while(@$lims && ($i < $max_num_iters))
{
    $new_lims = [];
    foreach my $l (@$lims)
    {
        $result = $l->transform();
        if (! $result)
        {
            next;
        }
        push @$new_lims, @$result;
    }
    $lims = $new_lims;
}
continue
{
    print "Iter $i\n---------------\n";
    my $num_lims = scalar(@$lims);
    my $total = (2**$i);
    my $ratio = $num_lims/$total;

    print "num_lims=$num_lims\ntotal=$total\nratio=$ratio\n";
    print "\n";
    $i++;
}

