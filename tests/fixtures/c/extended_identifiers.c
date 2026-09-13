// C99 6.4.2.1: names declared under universal character names are used under
// their UTF-8 spellings and the reverse, and `__func__` holds the name in
// UTF-8. Returns 0, distinct non-zero per failure.

static int caf\u00e9 = 3;

int ma\u00F1ana(int x) { return x + 1; }

struct point {
    int \u03b1;
    int β;
};

#define TWICE(\u00e9) (é * 2)
#define CAT(a, b) a##b

static const char *se\u00f1al(void) { return __func__; }

static int same(const char *p, const char *q) {
    while (*p && *p == *q) {
        p++;
        q++;
    }
    return *p == *q;
}

int main(void) {
    if (café != 3) return 1;
    if (mañana(1) != 2 || ma\u00f1ana(2) != 3) return 2;
    {
        struct point p = {4, 5};
        if (p.α != 4 || p.\u03B2 != 5) return 3;
    }
    if (TWICE(21) != 42) return 4;
    if (CAT(caf, \u00e9) != 3 || CAT(caf, é) != 3) return 5;
    {
        int ω = 0;
        goto \u00e9tape;
        return 6;
    étape:
        \u03c9 += 7;
        if (ω != 7) return 7;
    }
    if (!same(señal(), "se\xc3\xb1" "al")) return 8;
    return 0;
}
