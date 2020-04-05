/*
The Expat License

Copyright (c) 2017, Shlomi Fish

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
#include <gmp.h>
#include <stdbool.h>
#include <stdio.h>

int main()
{
    mpz_t STEP;
    mpz_init_set_str(STEP, "10000000", 0);
    mpz_t three;
    mpz_init_set_str(three, "3", 0);
    mpz_t one;
    mpz_init_set_str(one, "1", 0);
    mpz_t two;
    mpz_init_set_str(two, "2", 0);
    mpz_t k;
    mpz_init_set_str(k, "101", 0);
    mpz_t max_k;
    mpz_init(max_k);
    mpz_set(max_k, STEP);
    while (true)
    {
        mpz_add(k, k, two);
        mpz_t r;
        mpz_init_set(r, k);
        while (mpz_cmp(r, k) >= 0)
        {
            if (mpz_tstbit(r, 0))
            {
                mpz_mul(r, r, three);
                mpz_add(r, r, one);
            }
            mpz_fdiv_q_2exp(r, r, 1);
        }
        if (mpz_cmp(k, max_k) >= 0)
        {
            gmp_printf("Reached %Zd\n", max_k);
            fflush(stdout);
            mpz_add(max_k, max_k, STEP);
        }
    }
    return 0;
}
