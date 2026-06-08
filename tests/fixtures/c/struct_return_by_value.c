// C99 6.8.6.4 + AAPCS64 6.9: returning a struct by value. An integer
// aggregate of at most 16 bytes is returned in x0/x1; a larger one is
// returned through the caller-supplied x8 indirect-result register.
// Exercises a returned value consumed by field access, whole-struct
// assignment, as an argument to a further call, and a struct returned
// straight through from a parameter.

struct small {
    int x, y;
};

struct big {
    long a, b, c;
};

static struct small make_small(int s) {
    struct small r;
    r.x = s;
    r.y = s + 1;
    return r;
}

static struct big make_big(long s) {
    struct big r;
    r.a = s;
    r.b = s + 1;
    r.c = s + 2;
    return r;
}

static int sum_small(struct small s) {
    return s.x + s.y;
}

static long sum_big(struct big b) {
    return b.a + b.b + b.c;
}

// Returned struct fed straight into another by-value call.
static int small_round(int s) {
    return sum_small(make_small(s));
}

static long big_round(long s) {
    return sum_big(make_big(s));
}

// Return a struct received by value (pass-through copy).
static struct small echo_small(struct small s) {
    return s;
}

int main(void) {
    struct small s = make_small(7);
    if (s.x != 7 || s.y != 8) return 1;

    struct big b = make_big(10);
    if (b.a != 10 || b.b != 11 || b.c != 12) return 2;

    // Field access directly off the returned value.
    if (make_small(20).x != 20) return 3;
    if (make_big(30).c != 32) return 4;

    // Whole-struct assignment from a returned value.
    struct small t;
    t = make_small(40);
    if (t.x != 40 || t.y != 41) return 5;

    // Returned value consumed by a further by-value call.
    if (small_round(3) != 7) return 6;
    if (big_round(5) != 18) return 7;

    // Pass-through: return a by-value parameter.
    struct small e = echo_small(s);
    if (e.x != 7 || e.y != 8) return 8;

    return 0;
}
