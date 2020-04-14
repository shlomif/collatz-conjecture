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
#include <assert.h>
#include <stdbool.h>
#include <stdio.h>

#define USE_128
#ifdef USE_128
typedef unsigned __int128 mpz_t;
#if 1
const mpz_t overflow = (((mpz_t)3) << ((mpz_t)(128 - 2)));
#else
const mpz_t overflow = ~((mpz_t)0);
#endif
#define mpz_init_set_ui(dest, src) dest = (src)
#define mpz_init(dest) dest = 0
#define mpz_fdiv_q_2exp(dest, dest2, count) dest >>= (count)
#define mpz_add_ui(dest, dest2, count) dest += (count)
#define cmp(r, k) (r >= k)
#define tstbit(r) ((r)&1)
#define mpz_set(dest, src) dest = (src)
#define mpz_add(dest, dest2, src) dest += (src)
#define mpz_mul_ui(dest, dest2, src) dest *= (src)

static inline void print(const mpz_t k)
{
    if (k == 0)
    {
        return;
    }
    print(k / 10);
    printf("%u", (unsigned)(k % 10));
}
static inline void gmp_printf(
    __attribute__((unused)) const char *const fmt, mpz_t k)
{
    printf("Reached ");
    print(k);
    printf("\n");
}
#else
#include <gmp.h>
#define cmp(r, k) (mpz_cmp((r), (k)) >= 0)
#define tstbit(r) mpz_tstbit(r, 0)
#endif
int main()
{
    mpz_t STEP;
    mpz_init_set_ui(STEP, 10000000);
    mpz_t four;
    mpz_init_set_ui(four, 4);
    mpz_t k;
    mpz_init_set_ui(k, 403);
    mpz_t max_k;
    mpz_init(max_k);
    mpz_set(max_k, STEP);
    mpz_t r;
    mpz_init(r);
#if 0
    unsigned long l = 0;
    while ((++l) < 100000000)
#else
    while (true)
#endif
    {
        mpz_add(k, k, four);
        mpz_set(r, k);
        do
        {
            if (tstbit(r))
            {
                mpz_mul_ui(r, r, 3);
                mpz_add_ui(r, r, 1);
#if 0
                print(r);
                printf("\n");
#endif
#ifdef USE_128
                assert((r & overflow) == 0);
#endif
            }
            mpz_fdiv_q_2exp(r, r, 1);
        } while (cmp(r, k));
        if (cmp(k, max_k))
        {
            gmp_printf("Reached %Zd\n", max_k);
            fflush(stdout);
            mpz_add(max_k, max_k, STEP);
        }
    }
    return 0;
}
