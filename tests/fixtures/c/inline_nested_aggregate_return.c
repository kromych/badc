// A function spliced into its caller may hold a call of its own that
// returns a struct by value. That call delivers into a frame slot of
// the spliced body, which the splice relocates with the rest of the
// body's locals; the values below pin what each relocated slot must
// hold. Sizes cross the register / memory return boundary on both
// ABIs, and one site reaches its callee through a function pointer the
// splice turns into a direct call.

struct pair { unsigned long a; unsigned long b; };
struct wide { unsigned long v[6]; };
struct mixed { double d; long i; };

#define ALWAYS static inline __attribute__((always_inline))

static int calls;

static struct pair make_pair(unsigned long k) {
    struct pair p;
    p.a = k;
    p.b = k * 3u + 1u;
    calls++;
    return p;
}

static struct wide make_wide(unsigned long k) {
    struct wide w;
    for (unsigned i = 0; i < 6; i++)
        w.v[i] = k + i;
    calls++;
    return w;
}

static struct mixed make_mixed(long k) {
    struct mixed m;
    m.d = (double)k / 2.0;
    m.i = k;
    return m;
}

// Two nested aggregate returns live at once, so the two relocated
// slots must not overlap.
ALWAYS unsigned long sum_pair_and_wide(unsigned long k) {
    struct pair p = make_pair(k);
    struct wide w = make_wide(k);
    unsigned long t = p.a + p.b;
    for (unsigned i = 0; i < 6; i++)
        t += w.v[i];
    return t;
}

// A nested aggregate return inside a branch the caller's argument
// decides, plus one after the join.
ALWAYS unsigned long branchy(unsigned long k, int take) {
    struct pair p;
    if (take)
        p = make_pair(k);
    else
        p = make_pair(k + 1u);
    struct wide w = make_wide(p.a);
    return p.b + w.v[5];
}

// The callee is reached through a function pointer; the splice
// substitutes the constant and the call becomes direct.
ALWAYS unsigned long via_pointer(unsigned long k, struct pair (*f)(unsigned long)) {
    struct pair p = f(k);
    return p.a * 2u + p.b;
}

ALWAYS double mixed_bank(long k) {
    struct mixed m = make_mixed(k);
    return m.d + (double)m.i;
}

// A body whose own local is an aggregate the nested call fills, taken
// by address afterwards.
ALWAYS unsigned long addressed(unsigned long k) {
    struct wide w = make_wide(k);
    unsigned long *p = &w.v[3];
    return *p;
}

int main(void) {
    int rc = 0;

    if (sum_pair_and_wide(4) != (4 + 13) + (4 + 5 + 6 + 7 + 8 + 9)) rc |= 1;
    if (sum_pair_and_wide(0) != (0 + 1) + (0 + 1 + 2 + 3 + 4 + 5)) rc |= 2;

    if (branchy(4, 1) != 13 + (4 + 5)) rc |= 4;
    if (branchy(4, 0) != 16 + (5 + 5)) rc |= 8;

    if (via_pointer(5, make_pair) != 10 + 16) rc |= 16;

    if (mixed_bank(6) != 3.0 + 6.0) rc |= 32;

    if (addressed(10) != 13) rc |= 64;

    // Each nested call ran exactly once per splice: 2 + 2 + 1 + 1 + 1
    // aggregate-returning calls, plus one per `addressed`.
    if (calls != 2 + 2 + 2 + 2 + 1 + 1) rc |= 128;

    return rc;
}
