// Munchausen-number search for the perf table. A digit loop over a
// large counted range: the hot path is `n % 10` / `n / 10` by a
// constant, a small table load, an accumulate, and an early-exit
// compare -- so this fixture is mostly about how the division by a
// constant lowers and how tightly the inner loop schedules.
//
// Runtime grows linearly in MAX; pick MAX so wall-clock stays in the
// range the other fixtures use on the slowest compiler under test.

#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <time.h>

#define MAX 44000000

int cache[10];

bool is_munchausen(const int number)
{
    int n = number;
    int total = 0;

    while (n > 0)
    {
        int digit = n % 10;
        total += cache[digit];
        if (total > number) {
            return false;
        }
        n = n / 10;
    }

    return total == number;
}

void set_cache(void)
{
    cache[0] = 0;
    for (int i = 1; i <= 9; ++i) {
        cache[i] = pow(i, i);
    }
}

int main(void)
{
    struct timespec t0, t1;
    set_cache();

    clock_gettime(CLOCK_MONOTONIC, &t0);
    long found = 0;
    long sum = 0;
    for (int i = 0; i < MAX; ++i)
    {
        if (is_munchausen(i)) {
            found++;
            sum += i;
        }
    }
    clock_gettime(CLOCK_MONOTONIC, &t1);

    long secs = t1.tv_sec - t0.tv_sec;
    long nsecs = t1.tv_nsec - t0.tv_nsec;
    double ms = (double)secs * 1000.0 + (double)nsecs / 1000000.0;
    printf("munchausen(%d) = %ld in %.2f ms\n", MAX, found, ms);

    // 0, 1 and 3435 are the Munchausen numbers below MAX; the fourth
    // (438579088) sits above it. Sanity-check both the count and the
    // sum so a miscompilation surfaces as a non-zero exit rather than
    // a wrong timing.
    if (found != 3L || sum != 3436L) {
        printf("WRONG: expected 3 numbers summing to 3436\n");
        return 1;
    }
    return 0;
}
