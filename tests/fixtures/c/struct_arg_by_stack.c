// C99 6.5.2.2 + System V AMD64 3.2.3: an aggregate larger than two
// eightbytes is MEMORY class and passed by value inline on the caller's
// outgoing stack, not in argument registers. The callee copies it from
// the incoming stack into its own local. A leading scalar in argument
// registers and a trailing aggregate that does fit in registers verify
// the by-stack struct does not disturb the register-passed arguments.
//
// On AAPCS64 the same aggregate is passed by reference; both ends agree
// on reading the fields, so the fixture is target-independent.

struct big { long a, b, c, d; };
struct small { long x, y; };

static long r_tag, r_a, r_b, r_c, r_d, r_sx, r_sy;

static void take(int tag, struct big g, struct small s) {
    r_tag = tag;
    r_a = g.a;
    r_b = g.b;
    r_c = g.c;
    r_d = g.d;
    r_sx = s.x;
    r_sy = s.y;
}

// Mutating a by-value parameter must not be observable by the caller.
static long mutate(struct big g) {
    g.a += 1000;
    g.d -= 1;
    return g.a + g.b + g.c + g.d;
}

int main(void) {
    struct big g;
    g.a = 11;
    g.b = 22;
    g.c = 33;
    g.d = 44;
    struct small s;
    s.x = 5;
    s.y = 6;

    take(7, g, s);
    if (r_tag != 7) return 1;
    if (r_a != 11 || r_b != 22 || r_c != 33 || r_d != 44) return 2;
    if (r_sx != 5 || r_sy != 6) return 3;

    long m = mutate(g);
    if (m != (11 + 1000) + 22 + 33 + (44 - 1)) return 4;
    // Caller's copy is unchanged.
    if (g.a != 11 || g.d != 44) return 5;

    return 0;
}
