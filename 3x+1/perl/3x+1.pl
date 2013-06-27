#!/usr/bin/perl

use strict;
use warnings;

use X3::Number;
use X3::WithLim;

my $n = X3::Number->new({var => 4, rem => 3, });
my $t_n = X3::Number->new({var => 4, rem => 3, });
my $init_lim = X3::WithLim->new({ n => $n, t_n => $t_n, });

my $max_num_iters = shift(@ARGV) || 10;

my $i = 3;
my $lims = [ $init_lim ];

while(@$lims && ($i < $max_num_iters))
{
    my $new_lims = [];
    foreach my $l (@$lims)
    {
        if (my $result = $l->transform())
        {
            push @$new_lims, @$result;
        }
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

