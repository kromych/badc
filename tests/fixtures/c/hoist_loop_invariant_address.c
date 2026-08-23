/* Loop-invariant materializations hoisted out of loop bodies.

   Every loop below rebuilds something inside its body that is constant
   for the whole loop: a file-scope object's address, a divisor and its
   reciprocal, a comparison bound wider than one instruction can carry.
   Hoisting each into a block outside the loop must not change what the
   program computes, so the result is checked rather than the placement.

   `chase` is the counter-example: its address comes from the previous
   iteration, so nothing about it is loop-invariant. `bump` and
   `sample` cover the volatile cases -- the address of a volatile
   object is still a link-time constant and may be hoisted, while the
   accesses themselves must stay inside the loop and keep their count
   (C99 6.7.3p6, 5.1.2.3p2). */

#include <stdio.h>

static int digits[10];
static long long wide[8];
static volatile int counter;
static volatile int gate;

struct node {
    int value;
    struct node *next;
};

static struct node chain[24];

static void setup(void)
{
    int i;
    for (i = 0; i < 10; ++i) {
        digits[i] = i * i;
    }
    for (i = 0; i < 8; ++i) {
        wide[i] = (long long)i * 1000000007LL;
    }
    for (i = 0; i < 24; ++i) {
        chain[i].value = i + 1;
        chain[i].next = (i + 1 < 24) ? &chain[i + 1] : (struct node *)0;
    }
}

/* The issue's shape: a table indexed by a digit inside a digit loop,
   with the divisor and the reciprocal-multiply constant rebuilt every
   iteration alongside the table's address. */
static int digit_sum(int n)
{
    int total = 0;
    while (n > 0) {
        total += digits[n % 10];
        n = n / 10;
    }
    return total;
}

/* Nested loops: the inner body's invariants belong outside both, and
   the inner trip count is a bound wider than one immediate field. */
static long long nested(int rows)
{
    long long total = 0;
    int r;
    for (r = 0; r < rows; ++r) {
        long long i;
        for (i = 0; i < 3000000LL; ++i) {
            if (i > 4) {
                break;
            }
            total += wide[(int)(i & 7)] / 1000000007LL;
        }
    }
    return total;
}

/* Loop-varying address: each iteration's pointer comes from the last,
   so there is nothing to lift. */
static long long chase(void)
{
    long long total = 0;
    struct node *p = &chain[0];
    while (p) {
        total += p->value;
        p = p->next;
    }
    return total;
}

/* A float constant is a materialization like any other, and the copy
   has to carry the single-precision marker of the site it serves: the
   store of a `float` lvalue reads that marker to choose between storing
   the value and narrowing a double first (C99 6.3.1.5). 1 + 2^-9 has a
   non-zero low half, so it costs more than one instruction to build,
   and every partial sum below is exact. */
static float scale[16];

static float scaled(int n)
{
    float sum = 0.0f;
    int i;
    for (i = 0; i < n; ++i) {
        scale[i] = 1.001953125f;
        sum += scale[i];
    }
    return sum;
}

/* A volatile read-modify-write per iteration; the count is observable
   through the object itself. */
static int bump(int n)
{
    int i;
    for (i = 0; i < n; ++i) {
        counter += 1;
    }
    return counter;
}

/* A volatile read whose value the loop cannot cache: `gate` is written
   between the reads, so a loop that read it once would sum the wrong
   total. */
static long long sample(int n)
{
    long long total = 0;
    int i;
    for (i = 0; i < n; ++i) {
        total += gate;
        gate = gate + 2;
    }
    return total;
}

int main(void)
{
    long long total = 0;
    int i;

    setup();
    for (i = 0; i < 500; ++i) {
        total += digit_sum(i);
    }
    if (total != 31500) {
        printf("digit_sum: %lld\n", total);
        return 1;
    }

    if (nested(3) != 30LL) {
        printf("nested: %lld\n", nested(3));
        return 2;
    }

    if (chase() != 300LL) {
        printf("chase: %lld\n", chase());
        return 3;
    }

    if (bump(1000) != 1000 || counter != 1000) {
        printf("bump: %d\n", counter);
        return 4;
    }

    gate = 0;
    if (sample(100) != 9900L || gate != 200) {
        printf("sample: %d\n", gate);
        return 5;
    }

    if (scaled(16) != 16.03125f || scale[15] != 1.001953125f) {
        printf("scaled: %.6f %.6f\n", (double)scaled(16), (double)scale[15]);
        return 6;
    }

    return 42;
}
