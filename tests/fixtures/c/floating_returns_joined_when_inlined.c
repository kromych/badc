/* A function returning `double` or `float` from several `return`
   statements -- a field read, a conversion, a call's result, constants --
   gives each its own value where the call is replaced by its body. The
   exit code names the first mismatch. */

#include <stdint.h>
#include <string.h>

#define NOINLINE __attribute__((noinline))

struct cell {
    int tag;
    long i;
    double r;
    float f;
};

NOINLINE double slow(const struct cell *c) { return c->i * 0.5; }

static double real_value(const struct cell *c) {
    if (c->tag == 1)
        return c->r;
    if (c->tag == 2)
        return (double)c->i;
    if (c->tag == 3)
        return slow(c);
    if (c->tag == 4)
        return -0.0;
    return 0.0;
}

static float single_value(const struct cell *c) {
    if (c->tag == 1)
        return c->f;
    if (c->tag == 2)
        return (float)c->i;
    if (c->tag == 5)
        return __builtin_nanf("");
    return 2.5f;
}

static uint64_t bits(double d) {
    uint64_t u;
    memcpy(&u, &d, sizeof u);
    return u;
}

NOINLINE double sum(const struct cell *cs, int n) {
    double s = 0;
    for (int i = 0; i < n; i++)
        s += real_value(&cs[i]);
    return s;
}

NOINLINE float fsum(const struct cell *cs, int n) {
    float s = 0;
    for (int i = 0; i < n; i++)
        if (cs[i].tag != 5)
            s += single_value(&cs[i]);
    return s;
}

int main(void) {
    struct cell cs[] = {
        {1, 0, 1.25, 0.75f}, {2, 7, 0, 0}, {3, 9, 0, 0}, {4, 0, 0, 0}, {6, 0, 0, 0},
    };
    if (sum(cs, 5) != 1.25 + 7 + 4.5)
        return 1;
    if (bits(real_value(&cs[3])) != bits(-0.0))
        return 2;
    if (bits(real_value(&cs[4])) != bits(0.0))
        return 3;
    if (fsum(cs, 5) != 0.75f + 7.0f + 2.5f + 2.5f + 2.5f)
        return 4;
    struct cell nan = {5, 0, 0, 0};
    float q = single_value(&nan);
    if (q == q)
        return 5;
    return 0;
}
