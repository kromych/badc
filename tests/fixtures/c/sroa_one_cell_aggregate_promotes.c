/* Address-taken automatic aggregates that fit one 8-byte frame cell.
 * `passes::sroa` splits them into per-member slots like any larger
 * aggregate; before one-cell objects joined the candidate set they
 * stayed memory-resident whatever their access pattern. Shapes:
 *
 *   `pair` -- two unsigned int members, a loop-carried state machine
 *             stepped through an always_inline helper's pointer, so
 *             the promoted members need header phis;
 *   `tiny` -- short / char members inside one cell at offsets that are
 *             not slot multiples;
 *   `q`    -- a four-element short array read back at constant indices.
 *
 * `spin` is read through a volatile global so no value here is a
 * translation-time constant. The final sum is the runtime check; a
 * promotion that dropped or aliased a member changes it. */

volatile long spin = 3;

struct pair {
    unsigned int state;
    unsigned int data;
};

static __attribute__((always_inline)) void pair_step(struct pair *p, long n) {
    switch (p->state) {
    case 0:
        return;
    case 1:
        p->data += (unsigned int)n;
        p->state = 2;
        return;
    case 2:
        p->state = 0;
        return;
    }
}

static long t_loop(long n) {
    long acc = 0;
    for (struct pair p = { 1, 5 }; p.state != 0; pair_step(&p, n))
        acc += (long)p.data;
    return acc;
}

struct tiny {
    short a;
    char b;
    char c;
};

static __attribute__((always_inline)) long tiny_mix(struct tiny *t, long k) {
    t->a = (short)(t->a + k);
    t->b = (char)(t->b ^ (char)k);
    return t->a * 2 + t->b + t->c;
}

static long t_tiny(long k) {
    struct tiny t = { 7, 'a', 3 };
    long r = tiny_mix(&t, k);
    return r + t.a;
}

static __attribute__((always_inline)) long arr_pick(short *q) {
    return q[0] + q[1] * 2 + q[2] * 3 + q[3];
}

static long t_arr(long k) {
    short q[4];
    q[0] = (short)k;
    q[1] = (short)(k + 1);
    q[2] = (short)(k * 2);
    q[3] = (short)(k - 3);
    return arr_pick(q);
}

int main(void) {
    long k = spin;
    long s = t_loop(k) + t_tiny(k) * 2 + t_arr(k) * 3;
    /* k == 3 */
    if (t_loop(k) != 13) return 1;
    if (t_tiny(k) != 131) return 2;
    if (t_arr(k) != 29) return 3;
    if (s != 362) return 4;
    return 0;
}
