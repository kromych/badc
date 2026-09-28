// Objects whose blocks are left by return, goto, break, continue and a
// switch fall-through, in the shape of the kernel's `crc_t10dif_arch`: a
// 528-byte state aligned 16, filled and checked through pointers passed to
// callees, while another object must keep its contents. Storage may be
// shared only between objects whose lifetimes do not overlap (C99 6.2.4p2).
// VLA blocks left early, or first entered by a goto ahead of the VLA, free
// their storage as their own exit does. Exits 0 when every object keeps its
// contents, a distinct code per failure.

struct state {
    _Alignas(16) unsigned char v[512];
    unsigned fpsr, fpcr;
};

static volatile unsigned calls;

__attribute__((noinline)) static void fill(struct state *s, unsigned tag) {
    for (int i = 0; i < 512; i++)
        s->v[i] = (unsigned char)(tag * 31 + i);
    s->fpsr = tag;
    s->fpcr = ~tag;
    calls++;
}

__attribute__((noinline)) static int intact(const struct state *s, unsigned tag) {
    for (int i = 0; i < 512; i++)
        if (s->v[i] != (unsigned char)(tag * 31 + i))
            return 0;
    return s->fpsr == tag && s->fpcr == ~tag;
}

// The kernel's `scoped_ksimd()`: a for-scope declaring the state, whose
// cleanup checks it as the scope is left.
static unsigned released;

__attribute__((noinline)) static void release(struct state **pp) {
    if (*pp && intact(*pp, (*pp)->fpsr))
        released++;
}

#define scoped_state(st, tag)                                                            \
    for (struct state st, *st##_p __attribute__((cleanup(release))) = (fill(&st, tag), &st); \
         st##_p; st##_p = 0)

// Returns from inside each of two scoped states, as `crc_t10dif_arch` does.
static int crc_shape(int path, unsigned tag) {
    if (path == 0) {
        scoped_state(a, tag) return intact(&a, tag) ? 0 : 1;
    } else if (path == 1) {
        scoped_state(b, tag + 1) return intact(&b, tag + 1) ? 0 : 2;
    }
    struct state c;
    fill(&c, tag + 2);
    return intact(&c, tag + 2) ? 0 : 3;
}

// An outer object lives across inner blocks left by continue and break.
static int loop_exits(int n) {
    struct state outer;
    fill(&outer, 100);
    for (int i = 0; i < n; i++) {
        struct state inner;
        fill(&inner, 101 + i);
        if (!intact(&inner, 101 + i))
            return 10;
        if (i == 1)
            continue;
        if (i == 3)
            break;
    }
    {
        struct state after;
        fill(&after, 120);
        if (!intact(&after, 120))
            return 11;
    }
    return intact(&outer, 100) ? 0 : 12;
}

// A goto leaves one block forward and another backward.
static int goto_exits(int k) {
    struct state keep;
    fill(&keep, 130);
    int round = 0;
again: {
    struct state t;
    fill(&t, 131 + round);
    if (!intact(&t, 131 + round))
        return 20;
    if (++round < 3)
        goto again;
    if (k)
        goto skip;
    if (!intact(&t, 131 + round - 1))
        return 21;
}
skip: {
    struct state u;
    fill(&u, 140);
    if (!intact(&u, 140))
        return 22;
}
    return intact(&keep, 130) ? 0 : 23;
}

// A switch falls from one case block into the next, and the dispatch jumps
// past the first.
static int switch_exits(int k) {
    struct state keep;
    fill(&keep, 150);
    switch (k) {
    case 0: {
        struct state a;
        fill(&a, 151);
        if (!intact(&a, 151))
            return 30;
    }
    case 1: {
        struct state b;
        fill(&b, 152);
        if (!intact(&b, 152))
            return 31;
        break;
    }
    default:
        break;
    }
    return intact(&keep, 150) ? 0 : 32;
}

// A VLA block left by continue, break and goto frees its storage: 8192
// rounds of 2 KiB would otherwise take 16 MiB of stack.
static volatile int sink;

static int vla_exits(int n, int rounds) {
    int total = 0;
    for (int i = 0; i < rounds; i++) {
        char v[n];
        v[0] = (char)i;
        sink = v[0];
        if (i & 1)
            continue;
        total++;
    }
    for (int i = 0; i < rounds; i++) {
        for (;;) {
            char v[n];
            v[n - 1] = (char)i;
            sink = v[n - 1];
            total++;
            break;
        }
    }
    for (int i = 0; i < rounds; i++) {
        {
            char v[n];
            v[0] = (char)i;
            sink = v[0];
            if (i & 1)
                goto next;
            total++;
        }
    next:;
    }
    return total;
}

// The VLA block is first entered by a goto ahead of the declaration.
__attribute__((noinline)) static int touch(int x) {
    volatile char pad[64];
    pad[0] = (char)x;
    return pad[0] - (char)x;
}

static int vla_entered_by_goto(int n, int rounds) {
    int r = 0;
    for (int i = 0; i < rounds; i++) {
        if (i == 0 || (i & 1))
            goto inside;
        r += 1;
        {
        inside:
            r += 2;
            char v[n];
            v[0] = 5;
            sink = v[0];
        }
        r += touch(i);
    }
    return r;
}

int main(void) {
    for (int p = 0; p < 3; p++) {
        int rc = crc_shape(p, 7);
        if (rc)
            return rc;
    }
    if (released != 2)
        return 4;
    int rc = loop_exits(6);
    if (rc)
        return rc;
    for (int k = 0; k < 2; k++) {
        rc = goto_exits(k);
        if (rc)
            return rc;
    }
    for (int k = 0; k < 3; k++) {
        rc = switch_exits(k);
        if (rc)
            return rc;
    }
    if (vla_exits(2048, 8192) != 4096 + 8192 + 4096)
        return 40;
    if (vla_entered_by_goto(2048, 1000) != 1000 * 2 + 499)
        return 41;
    return 0;
}
