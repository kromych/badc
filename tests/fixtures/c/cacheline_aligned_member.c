// `__attribute__((aligned(N)))` / `_Alignas(N)` on a struct member above
// 16 -- cache-line alignment (64, and 128 on some configurations), a
// real-world shape in low-level headers. Covers the member's offset and
// leading padding, the aggregate's own size and alignment, arrays,
// nesting, the `#pragma pack` and `packed` interactions, and the runtime
// alignment of objects badc places. Every number matches GCC and clang on
// x86-64 and aarch64. Returns 0 on success; distinct non-zero per fail.

#define A64 __attribute__((aligned(64)))
#define A128 __attribute__((aligned(128)))

// Over-aligned member alone: it alone sets the aggregate's size.
struct S1 {
    A64 int a;
};

// Leading member forces padding before the over-aligned one.
struct S2 {
    char c;
    A64 int a;
    int b;
};

// A group attribute covers every declarator in the comma list.
struct S3 {
    char c;
    A64 int a, b;
};

// 128-byte alignment.
struct S4 {
    char c;
    A128 long long q;
    int t;
};

// Nesting: an over-aligned aggregate as a member raises its container.
struct S5 {
    char c;
    struct S1 n;
    int t;
};

// `_Alignas(type-name)`, C11 6.7.5.
struct S6 {
    char c;
    _Alignas(struct S1) int a;
    int b;
};

// A struct-level attribute after the body raises the aggregate.
struct S7 {
    char c;
    int b;
} __attribute__((aligned(64)));

// `#pragma pack(N)` clamps a member's finished alignment, the explicit
// request included; a request above 16 packs nothing.
#pragma pack(1)
struct P1 {
    char c;
    A64 int a;
    int b;
};
#pragma pack()

#pragma pack(8)
struct P2 {
    char c;
    A64 int a;
};
#pragma pack()

#pragma pack(32)
struct P3 {
    char c;
    A64 int a;
};
#pragma pack()

// `__attribute__((packed))` drops only the NATURAL alignment: the
// explicit request on the member survives and still raises the aggregate.
struct P4 {
    char c;
    A64 int a;
} __attribute__((packed));

// Objects badc places. Uninitialised file-scope storage of an
// over-aligned type must land on its boundary.
static struct S1 g_one;
static struct S1 g_arr[4];
static struct S5 g_nest;
static A64 int g_scalar;
// Over-aligned automatics are diagnosed (frame slots are 8 bytes and the
// prologue does not realign), so the offset probes use static storage.
static struct S2 g_s2;
static struct S5 g_s5;

static int off(const void *base, const void *member) {
    return (int)((const char *)member - (const char *)base);
}

static int misaligned(const void *p, unsigned long want) {
    return ((unsigned long)p & (want - 1)) != 0;
}

int main(void) {
    int i;

    // Sizes and alignments.
    if (sizeof(struct S1) != 64 || _Alignof(struct S1) != 64) return 1;
    if (sizeof(struct S2) != 128 || _Alignof(struct S2) != 64) return 2;
    if (sizeof(struct S3) != 192 || _Alignof(struct S3) != 64) return 3;
    if (sizeof(struct S4) != 256 || _Alignof(struct S4) != 128) return 4;
    if (sizeof(struct S5) != 192 || _Alignof(struct S5) != 64) return 5;
    if (sizeof(struct S6) != 128 || _Alignof(struct S6) != 64) return 6;
    if (sizeof(struct S7) != 64 || _Alignof(struct S7) != 64) return 7;

    // Member offsets: padding is inserted before the over-aligned member.
    if (off(&g_s2, &g_s2.c) != 0 || off(&g_s2, &g_s2.a) != 64
        || off(&g_s2, &g_s2.b) != 68)
        return 8;
    if (off(&g_s5, &g_s5.c) != 0 || off(&g_s5, &g_s5.n) != 64
        || off(&g_s5, &g_s5.t) != 128)
        return 9;

    // An array of an over-aligned struct keeps every element on the
    // boundary, so the stride is the padded size.
    if (sizeof(struct S1[2]) != 128) return 10;
    if (off(&g_arr[0], &g_arr[1]) != 64) return 11;
    if (off(&g_arr[0], &g_arr[3]) != 192) return 12;

    // pack interactions.
    if (sizeof(struct P1) != 9 || _Alignof(struct P1) != 1) return 13;
    if (sizeof(struct P2) != 16 || _Alignof(struct P2) != 8) return 14;
    if (sizeof(struct P3) != 128 || _Alignof(struct P3) != 64) return 15;
    if (sizeof(struct P4) != 128 || _Alignof(struct P4) != 64) return 16;

    // Runtime alignment of placed objects: a layout-only check cannot
    // see an object whose address does not meet its type's alignment.
    if (misaligned(&g_one, 64)) return 17;
    if (misaligned(&g_one.a, 64)) return 18;
    if (misaligned(&g_scalar, 64)) return 19;
    if (misaligned(&g_nest.n.a, 64)) return 20;
    for (i = 0; i < 4; i++) {
        if (misaligned(&g_arr[i], 64)) return 21;
        if (misaligned(&g_arr[i].a, 64)) return 22;
    }

    // Stores through over-aligned members round-trip.
    g_one.a = 11;
    g_arr[3].a = 33;
    g_nest.n.a = 44;
    g_scalar = 55;
    if (g_one.a != 11 || g_arr[3].a != 33 || g_nest.n.a != 44 || g_scalar != 55)
        return 23;

    return 0;
}
