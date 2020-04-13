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
    mpz_t four;
    mpz_init_set_str(four, "4", 0);
    mpz_t k;
    mpz_init_set_str(k, "403", 0);
    mpz_t max_k;
    mpz_init(max_k);
    mpz_set(max_k, STEP);
    while (true)
    {
        mpz_add(k, k, four);
        mpz_t r;
        mpz_init_set(r, k);
        do
        {
            if (mpz_tstbit(r, 0))
            {
                mpz_t twice;
                mpz_init(twice);
                mpz_mul_2exp(twice, r, 1);
                mpz_setbit(twice, 0);
                mpz_add(r, r, twice);
                mpz_clear(twice);
            }
            mpz_fdiv_q_2exp(r, r, 1);
        } while (mpz_cmp(r, k) >= 0);
        mpz_clear(r);
        if (mpz_cmp(k, max_k) >= 0)
        {
            gmp_printf("Reached %Zd\n", max_k);
            fflush(stdout);
            mpz_add(max_k, max_k, STEP);
        }
    }
    return 0;
}
