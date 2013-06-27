#!/usr/bin/perl -w

use strict;

my @prefix = ();

sub add
{
    my $add_to = shift;
    my $what_to_add = shift;
    my $place = 0;
    my $carry = 0;
    push @$what_to_add, (0,0,0,0);
    push @$add_to, ((0) x (@$what_to_add-@$add_to));
    for($place=0;$place<@$what_to_add;$place++)
    {
        my $sum = $add_to->[$place] + $what_to_add->[$place] + $carry;
        $add_to->[$place] = $sum & 0x1;
        $carry = ($sum >> 1);
    }
}

my $i = 0;
for($i=0;$i<10;$i++)
{
    print join("", reverse(@prefix)), "\n";
    my @new_prefix = @prefix;    
    add(\@new_prefix, [0, @prefix]);
    add(\@new_prefix, [0, 1]);
    while($new_prefix[-1] == 0)
    {
        pop(@new_prefix);
    }
    @prefix = @new_prefix;
}

