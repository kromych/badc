// A GCC `vector_size(N)` type is aligned to its width up to the target's
// ceiling: the x86-64 psABI gives `__m128` 16 and `__m256` 32, and AAPCS64
// 5.1 defines the 8- and 16-byte short vectors, a wider vector keeping the
// 16-byte boundary as gcc and clang lay it out. The alignment decides
// `_Alignof`, the padding before a member that follows a `char`, the
// struct's size and alignment, an array's stride, and the placement of
// every object of the type: file-scope, static local, automatic, a compound
// literal and the body's copy of a by-value parameter. The single-byte
// neighbours keep the running data offset and the frame cursor off every
// wide boundary. Returns 0, distinct non-zero per failure.

typedef short v4hi __attribute__((vector_size(8)));
typedef int v4si __attribute__((vector_size(16)));
typedef int v8si __attribute__((vector_size(32)));

#if defined(__x86_64__)
#define WIDE_ALIGN 32
#elif defined(__aarch64__)
#define WIDE_ALIGN 16
#else
#error "no vector alignment ceiling for this target"
#endif

struct s8 {
    char c;
    v4hi v;
};
struct s16 {
    char c;
    v4si v;
};
struct s32 {
    char c;
    v8si v;
};
struct nested {
    char c;
    struct s16 s;
};

char pad0 = 1;
v4hi g8;
char pad1 = 2;
v4si g16;
char pad2 = 3;
v8si g32;
char pad3 = 4;
struct s16 gs16;
char pad4 = 5;
v4si garr[3];

static int misaligned(const void *p, unsigned long want) {
    return ((unsigned long)p & (want - 1)) != 0;
}

static long sink(const void *p) {
    return (long)p;
}

static int type_layout(void) {
    if (_Alignof(v4hi) != 8 || sizeof(v4hi) != 8) return 1;
    if (_Alignof(v4si) != 16 || sizeof(v4si) != 16) return 2;
    if (_Alignof(v8si) != WIDE_ALIGN || sizeof(v8si) != 32) return 3;
    if (__builtin_offsetof(struct s8, v) != 8 || sizeof(struct s8) != 16) return 4;
    if (_Alignof(struct s8) != 8) return 5;
    if (__builtin_offsetof(struct s16, v) != 16 || sizeof(struct s16) != 32) return 6;
    if (_Alignof(struct s16) != 16) return 7;
    if (__builtin_offsetof(struct s32, v) != WIDE_ALIGN) return 8;
    if (sizeof(struct s32) != WIDE_ALIGN + 32 || _Alignof(struct s32) != WIDE_ALIGN) return 9;
    if (__builtin_offsetof(struct nested, s) != 16 || sizeof(struct nested) != 48) return 10;
    if (_Alignof(struct nested) != 16) return 11;
    if (sizeof(v8si[3]) != 96 || _Alignof(v8si[3]) != WIDE_ALIGN) return 12;
    if (sizeof(v4si[3]) != 48 || _Alignof(v4si[3]) != 16) return 13;
    return 0;
}

static int file_scope_objects(void) {
    if (misaligned(&g8, 8)) return 14;
    if (misaligned(&g16, 16)) return 15;
    if (misaligned(&g32, WIDE_ALIGN)) return 16;
    if (misaligned(&gs16, 16) || misaligned(&gs16.v, 16)) return 17;
    if (misaligned(garr, 16) || misaligned(&garr[1], 16)) return 18;
    if ((char *)&gs16.v - (char *)&gs16 != 16) return 19;
    if ((char *)&garr[2] - (char *)&garr[0] != 32) return 20;
    g8[1] = 3;
    g16[3] = 5;
    g32[7] = 7;
    gs16.v[0] = 11;
    garr[2][1] = 13;
    sink(&pad0);
    sink(&pad1);
    sink(&pad2);
    sink(&pad3);
    sink(&pad4);
    if (g8[1] + g16[3] + g32[7] + gs16.v[0] + garr[2][1] != 39) return 21;
    if (pad0 + pad1 + pad2 + pad3 + pad4 != 15) return 22;
    return 0;
}

static int static_local_objects(void) {
    static char s_pad0 = 1;
    static v4si s16;
    static char s_pad1 = 2;
    static v8si s32;
    static char s_pad2 = 3;
    static struct s32 s_holder;
    static char s_pad3 = 4;
    static v4si s_arr[2];

    if (misaligned(&s16, 16)) return 23;
    if (misaligned(&s32, WIDE_ALIGN)) return 24;
    if (misaligned(&s_holder, WIDE_ALIGN) || misaligned(&s_holder.v, WIDE_ALIGN)) return 25;
    if (misaligned(s_arr, 16) || misaligned(&s_arr[1], 16)) return 26;
    s16[0] = 1;
    s32[0] = 2;
    s_holder.v[0] = 3;
    s_arr[1][0] = 4;
    sink(&s_pad0);
    sink(&s_pad1);
    sink(&s_pad2);
    sink(&s_pad3);
    if (s16[0] + s32[0] + s_holder.v[0] + s_arr[1][0] != 10) return 27;
    if (s_pad0 + s_pad1 + s_pad2 + s_pad3 != 10) return 28;
    return 0;
}

static int automatic_objects(void) {
    char a_pad0 = 1;
    v4hi a8 = {1, 2, 3, 4};
    char a_pad1 = 2;
    v4si a16 = {1, 2, 3, 4};
    char a_pad2 = 3;
    v8si a32 = {1, 2, 3, 4, 5, 6, 7, 8};
    char a_pad3 = 4;
    struct s16 a_holder = {5, {6, 7, 8, 9}};
    char a_pad4 = 5;
    v4si a_arr[3] = {{1}, {2}, {3}};
    v4si *lit = &(v4si){10, 11, 12, 13};

    if (misaligned(&a8, 8)) return 29;
    if (misaligned(&a16, 16)) return 30;
    if (misaligned(&a32, WIDE_ALIGN)) return 31;
    if (misaligned(&a_holder, 16) || misaligned(&a_holder.v, 16)) return 32;
    if (misaligned(a_arr, 16) || misaligned(&a_arr[1], 16)) return 33;
    if (misaligned(lit, 16)) return 34;
    sink(&a_pad0);
    sink(&a_pad1);
    sink(&a_pad2);
    sink(&a_pad3);
    sink(&a_pad4);
    // The objects survive a call between the writes and the reads.
    sink(&a8);
    sink(&a16);
    sink(&a32);
    sink(&a_holder);
    sink(a_arr);
    if (a8[3] + a16[3] + a32[7] + a_holder.v[3] + a_arr[2][0] + (*lit)[3] != 41) return 35;
    if (a_pad0 + a_pad1 + a_pad2 + a_pad3 + a_pad4 != 15) return 36;
    return 0;
}

static int by_value(char c, v4si v, v8si w, struct s16 s) {
    if (misaligned(&v, 16)) return 37;
    if (misaligned(&w, WIDE_ALIGN)) return 38;
    if (misaligned(&s, 16) || misaligned(&s.v, 16)) return 39;
    sink(&c);
    if (c + v[1] + w[5] + s.v[2] != 17) return 40;
    return 0;
}

static int parameters(void) {
    v4si v = {1, 2, 3, 4};
    v8si w = {1, 2, 3, 4, 5, 6, 7, 8};
    struct s16 s = {9, {6, 7, 8, 9}};
    return by_value(1, v, w, s);
}

int main(void) {
    int rc = type_layout();
    if (rc) return rc;
    rc = file_scope_objects();
    if (rc) return rc;
    rc = static_local_objects();
    if (rc) return rc;
    rc = automatic_objects();
    if (rc) return rc;
    return parameters();
}
