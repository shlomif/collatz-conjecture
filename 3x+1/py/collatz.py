# The Expat License
#
# Copyright (c) 2017, Shlomi Fish
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# import sys


def main():
    STEP = 10 ** 7
    k = 276900 * 10 ** 6
    k = 100
    while ((k & 0b11) != 3):
        k -= 1
    # k = STEP
    max_k = k + STEP
    max_k += (STEP - max_k % STEP)
    max_c = 0
    while True:
        k += 4
        r = k
        c = 0
        while r >= k:
            if r & 1:
                r += ((r << 1) | 1)
            r >>= 1
            c += 1
        if c > max_c:
            max_c = c
            print('max_c =', max_c)
        if k >= max_k:
            max_k += STEP
            print("Reached {}".format(max_k), flush=True)


if __name__ == "__main__":
    main()
