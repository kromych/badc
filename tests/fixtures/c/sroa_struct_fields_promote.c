/* Address-taken automatic aggregates that `passes::sroa` splits into
 * per-field slots for the mem2reg re-run to promote. Each shape here is
 * one the whole-cell array split could not express:
 *
 *   `mixed`  -- sub-8-byte members (int / short / char) at offsets that
 *               are not slot multiples, reached through an
 *               always_inline helper's pointer parameter;
 *   `deep`   -- a member past the first four cells at byte 36, so the
 *               field's slot cannot be the object's own cell;
 *   `tmpl`   -- a partially designated initializer, which the walker
 *               emits as a block copy from a staged template plus a
 *               store, so the copy has to decompose per field;
 *   `loop`   -- a for-init aggregate whose members are carried across
 *               the loop back edge, so the promoted fields need header
 *               phis.
 *
 * `spin` is read through a volatile global so no value here is a
 * translation-time constant. The final sum is the runtime check; a
 * promotion that dropped or aliased a field changes it. */

volatile long spin = 3;

struct mixed {
    int a;
    long b;
    short c;
    char d;
};

static __attribute__((always_inline)) void mixed_bump(struct mixed *m, long k) {
    m->a += (int)k;
    m->b += k * 2;
    m->c = (short)(m->c + k);
    m->d = (char)(m->d ^ (char)k);
}

static long t_mixed(long k) {
    struct mixed m = { .a = 1, .b = k * 5, .c = 7, .d = 'z' };
    mixed_bump(&m, k);
    mixed_bump(&m, k + 1);
    return m.a + m.b + m.c + m.d;
}

struct deep {
    long pad[4];
    int index;
    int level;
};

static __attribute__((always_inline)) int deep_pick(struct deep *d) {
    return d->index + d->level * 16;
}

static long t_deep(long k) {
    struct deep d;
    d.pad[0] = 0;
    d.pad[1] = 0;
    d.pad[2] = 0;
    d.pad[3] = k;
    d.index = (int)k;
    d.level = (int)(k >> 1);
    return deep_pick(&d) + d.pad[3];
}

struct tmpl {
    int x;
    int y;
    long z;
};

static __attribute__((always_inline)) long tmpl_sum(struct tmpl *t) {
    return t->x + t->y + t->z;
}

static long t_tmpl(long k) {
    struct tmpl t = { .y = 9 };
    t.z = k * 7;
    return tmpl_sum(&t);
}

enum st { st_done = 0, st_run, st_wait };

struct walk {
    enum st state;
    unsigned long data;
    long *back;
};

static __attribute__((always_inline)) void walk_step(struct walk *w, long n) {
    switch (w->state) {
    case st_done:
        return;
    case st_run:
        w->data += (unsigned long)n;
        w->state = st_wait;
        return;
    case st_wait:
        w->state = st_done;
        return;
    }
}

static long t_loop(long n) {
    long acc = 0;
    for (struct walk w = { .state = st_run, .data = 5 }; w.state != st_done;
         walk_step(&w, n))
        acc += (long)w.data;
    return acc;
}

int main(void) {
    long k = spin;
    long s = t_mixed(k) + t_deep(k) * 2 + t_tmpl(k) * 3 + t_loop(k) * 5;
    /* k == 3 */
    if (t_mixed(k) != 176) return 1;
    if (t_deep(k) != 22) return 2;
    if (t_tmpl(k) != 30) return 3;
    if (t_loop(k) != 13) return 4;
    if (s != 375) return 5;
    return 0;
}
