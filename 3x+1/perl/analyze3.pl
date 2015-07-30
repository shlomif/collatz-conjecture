#!/usr/bin/perl
open I, "<dump.txt";
while(<I>)
{
	if (/^n = (\d+)\*x/)
    {
        $n = $1;
        $_ = <I>;
        / = (\d+)\*x/;
        $t = $1;
        if ($t == $n)
        {
            print $_;
        }
    }
}
close(I);

