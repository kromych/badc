// C99 6.5.2.2 + AAPCS64 6.8.2: two two-eightbyte integer aggregates
// passed by value in the same call. Each occupies two general-purpose
// argument registers, so the caller loads four eightbytes. The second
// aggregate's base address sits in an argument register that is also
// the first aggregate's second eightbyte target; loading the first
// aggregate must not clobber the second's pending base. A scalar
// pointer argument ahead of the aggregates shifts the register
// assignment, matching a common library shape (a parser handle
// followed by two token structs).

struct token { char *z; unsigned int n; };
struct parse { int calls; };

static unsigned long r_z0, r_z1;
static unsigned r_n0, r_n1;
static int r_calls;

static void add(struct parse *p, struct token a, struct token b) {
    r_calls = p->calls;
    r_z0 = (unsigned long)a.z;
    r_n0 = a.n;
    r_z1 = (unsigned long)b.z;
    r_n1 = b.n;
}

// No leading scalar: the two aggregates take x0..x3 directly.
static unsigned long s_z0, s_z1;
static unsigned s_n0, s_n1;

static void pair(struct token a, struct token b) {
    s_z0 = (unsigned long)a.z;
    s_n0 = a.n;
    s_z1 = (unsigned long)b.z;
    s_n1 = b.n;
}

int main(void) {
    struct parse pp;
    pp.calls = 9;
    struct token a;
    a.z = (char *)0x1111;
    a.n = 4;
    struct token b;
    b.z = (char *)0x2222;
    b.n = 6;

    add(&pp, a, b);
    if (r_calls != 9) return 1;
    if (r_z0 != 0x1111 || r_n0 != 4) return 2;
    if (r_z1 != 0x2222 || r_n1 != 6) return 3;

    pair(a, b);
    if (s_z0 != 0x1111 || s_n0 != 4) return 4;
    if (s_z1 != 0x2222 || s_n1 != 6) return 5;

    return 0;
}
