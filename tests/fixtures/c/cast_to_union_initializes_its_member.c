/* GNU C: a cast to a union from the type of one of its members is the
 * union with that member initialized, the compound literal `(union U){ .m
 * = v }`: as an initializer, an assigned value, an argument, a member read
 * and a loop temporary, from a scalar, a pointer, a qualified or
 * narrower-spelled operand and a structure. The member is the first of
 * the operand's own type, past an array or a bit-field. Returns 0. */
struct P {
    int a, b;
};
union U {
    int i;
    double d;
    char *p;
};
union W {
    struct P s;
    long l;
};
union X {
    unsigned char c;
    long l;
};
union A {
    int a[2];
    int b : 3;
    signed char s;
    char c;
    int i;
};

static int take(union U u) { return u.i; }
static double take_d(union U u) { return u.d; }

int main(void) {
    char ch = 'x';
    const int ci = 6;
    unsigned char uc = 7;
    struct P sp = {1, 2};
    long x = 41;
    union U a = (union U)3, b = (union U)2.5, c = (union U)&ch;
    if (a.i != 3 || b.d != 2.5 || *c.p != 'x' || ((union U)9).i != 9) {
        return 1;
    }
    if (take((union U)7) != 7 || take_d((union U)1.5) != 1.5) {
        return 2;
    }
    union U same = (union U)a, q = (union U)ci;
    union X n = (union X)uc;
    union W w = (union W)sp;
    if (same.i != 3 || q.i != 6 || n.c != 7 || w.s.a != 1 || w.s.b != 2) {
        return 3;
    }
    union W v;
    v = (union W)(x + 1);
    int sum = 0;
    for (int k = 0; k < 3; k++) {
        union U t = (union U)(k * 2);
        sum += t.i;
    }
    union A ai = (union A)sum, ac = (union A)ch;
    if (ai.i != 6 || ac.c != 'x') {
        return 4;
    }
    return v.l == 42 && sum == 6 && sizeof((union U)1) == sizeof(union U) ? 0 : 5;
}
