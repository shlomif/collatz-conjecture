#!/bin/bash
iter="$1"
shift
let next_iter=iter+1;
cat dump.txt |
    sed "/^Iter $iter\$/,/^Iter $next_iter\$/ ! { d; }" |
    grep "^T\\^i" | sort | uniq | wc -l
