#!/bin/bash

a=8 
i=0
while true ; do 
    b=$(grep -F " = $a*x" dump.txt | 
        sort | uniq | wc -l
       )
    c=$(bash analyze2.sh $i)
    if ((b == 0)) ; then
        break
    fi
    printf "%10i %10i %10i   " $a $b $c
    (echo "scale = 20" ; echo "$b/$a" ) | bc
    # perl -e "print (($b/$a), \"\\n\")"; 
    let a*=2
    let i++
done

