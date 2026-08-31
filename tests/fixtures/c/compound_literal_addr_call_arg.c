// An `&(compound literal)` argument is a pointer value (C99 6.5.2.2,
// 6.5.3.2p3): the callee receives the literal object's address, never
// the object's bytes marshalled as a by-value aggregate. An array
// compound literal argument decays the same way (6.3.2.1p3). Covers
// direct calls and calls through a plain and a struct-member function
// pointer, with a by-value literal argument and an `&named` /
// `&global` argument as controls.

typedef struct {
    unsigned long long a;
} s8;
typedef struct {
    unsigned long long a, b;
} s16;
typedef struct {
    unsigned long long a, b, c;
} s24;

static void *want_h;
static void **want_out;

static int take8(void *h, const s8 *p, void **out) {
    if (h != want_h) return 1;
    if (out != want_out) return 2;
    // A by-value lowering puts the member bytes where the address
    // belongs; detect that without dereferencing a garbage pointer.
    if ((unsigned long long)p == 0x1111111111111111ULL) return 3;
    if (p->a != 0x1111111111111111ULL) return 4;
    *out = (void *)p;
    return 0;
}

static int take16(void *h, const s16 *p, void **out) {
    if (h != want_h) return 1;
    if (out != want_out) return 2;
    if ((unsigned long long)p == 0x2222222222222222ULL) return 3;
    if (p->a != 0x2222222222222222ULL || p->b != 0x3333333333333333ULL) return 4;
    *out = (void *)p;
    return 0;
}

static int take24(void *h, const s24 *p, void **out) {
    if (h != want_h) return 1;
    if (out != want_out) return 2;
    if ((unsigned long long)p == 0x4444444444444444ULL) return 3;
    if (p->a != 0x4444444444444444ULL || p->b != 0x5555555555555555ULL ||
        p->c != 0x6666666666666666ULL)
        return 4;
    *out = (void *)p;
    return 0;
}

// A by-value aggregate parameter still rides by value.
static int byval16(void *h, s16 v, void **out) {
    if (h != want_h) return 1;
    if (out != want_out) return 2;
    if (v.a != 0x7777777777777777ULL || v.b != 0x8888888888888888ULL) return 3;
    *out = h;
    return 0;
}

// An array compound literal of `double` decays to `double *`, so it
// takes an integer argument register, not an FP one.
static int takefp(const double *p, int k, void **out) {
    if (k != 7) return 1;
    if (out != want_out) return 2;
    if (p[0] != 1.5 || p[1] != 2.5) return 3;
    *out = (void *)p;
    return 0;
}

struct ops {
    int (*handle16)(void *, const s16 *, void **);
};

static s16 global16 = { 0x2222222222222222ULL, 0x3333333333333333ULL };

int main(void) {
    int marker;
    void *out = 0;
    int (*fp8)(void *, const s8 *, void **) = take8;
    int (*fp16)(void *, const s16 *, void **) = take16;
    int (*fp24)(void *, const s24 *, void **) = take24;
    int (*fv16)(void *, s16, void **) = byval16;
    int (*ffp)(const double *, int, void **) = takefp;
    struct ops ops = { take16 };
    struct ops *bs = &ops;
    s16 local16 = { 0x2222222222222222ULL, 0x3333333333333333ULL };

    want_h = &marker;
    want_out = &out;

    if (fp8(&marker, &(s8){ 0x1111111111111111ULL }, &out)) return 10;
    if (!out) return 11;

    out = 0;
    if (fp16(&marker, &(s16){ 0x2222222222222222ULL, 0x3333333333333333ULL },
             &out))
        return 12;
    if (!out) return 13;

    out = 0;
    if (fp24(&marker,
             &(s24){ 0x4444444444444444ULL, 0x5555555555555555ULL,
                     0x6666666666666666ULL },
             &out))
        return 14;
    if (!out) return 15;

    // Struct-member function pointer.
    out = 0;
    if (bs->handle16(&marker,
                     &(s16){ 0x2222222222222222ULL, 0x3333333333333333ULL },
                     &out))
        return 16;
    if (!out) return 17;

    // Direct call with the same argument shape.
    out = 0;
    if (take16(&marker, &(s16){ 0x2222222222222222ULL, 0x3333333333333333ULL },
               &out))
        return 18;
    if (!out) return 19;

    // An array compound literal yields its first element's address.
    out = 0;
    if (fp8(&marker, (const s8[]){ { 0x1111111111111111ULL } }, &out))
        return 20;
    if (!out) return 21;

    out = 0;
    if (ffp((const double[]){ 1.5, 2.5 }, 7, &out)) return 22;
    if (!out) return 23;

    // A by-value literal argument still rides by value.
    out = 0;
    if (fv16(&marker, (s16){ 0x7777777777777777ULL, 0x8888888888888888ULL },
             &out))
        return 24;
    if (out != (void *)&marker) return 25;

    // `&named_local` and `&global` through the same function pointer.
    out = 0;
    if (fp16(&marker, &local16, &out)) return 26;
    if (out != (void *)&local16) return 27;

    out = 0;
    if (fp16(&marker, &global16, &out)) return 28;
    if (out != (void *)&global16) return 29;

    return 0;
}
