// A page-multiple alignment (16 KiB here) requested via `aligned` or
// `_Alignas`, or inherited from an over-aligned struct member, is honored
// for struct layout and for the runtime placement of static / global
// objects. The value exceeds the x86-64 page size, so the self-contained
// ELF writer raises the read-write segment alignment for the PIE load bias
// and the JIT over-aligns its data mapping. Struct layout up to the static
// cap (64 KiB) is checked at compile time; the addresses are read at run
// time. Matches GCC and clang on x86-64 and aarch64.
//
// The `mis` helper returns the low alignment bits of a pointer, zero only
// on the boundary. A deliberately-offset pointer must come back non-zero
// (the negative control below), so a passing run cannot be a vacuous one.

#include <stddef.h>

struct Member16k {
    char c;
    int __attribute__((aligned(16384))) v;
    char tail;
};

struct Member64k {
    char c;
    long _Alignas(65536) v;
};

// Layout up to the 64 KiB static cap, resolved at compile time.
_Static_assert(_Alignof(struct Member16k) == 16384, "16k member raises align");
_Static_assert(sizeof(struct Member16k) == 32768, "16k struct tail padded");
_Static_assert(offsetof(struct Member16k, v) == 16384, "16k member offset");
_Static_assert(offsetof(struct Member16k, tail) == 16388, "field after 16k member");
_Static_assert(_Alignof(struct Member64k) == 65536, "64k member raises align");
_Static_assert(sizeof(struct Member64k) == 131072, "64k struct tail padded");
_Static_assert(offsetof(struct Member64k, v) == 65536, "64k member offset");

int __attribute__((aligned(16384))) g_bare;
int __attribute__((aligned(16384))) g_init = 1;
// Type-derived: no attribute on the declarator, the alignment comes from
// the struct's member.
struct Member16k g_type;
struct Member16k g_arr[3];

static int mis(const void *p, unsigned long a) {
    return (int)((unsigned long)p & (a - 1));
}

int main(void) {
    static int __attribute__((aligned(16384))) s_bare;
    static int __attribute__((aligned(16384))) s_init = 2;

    if (mis(&g_bare, 16384)) return 1;
    if (mis(&g_init, 16384)) return 2;
    if (mis(&s_bare, 16384)) return 3;
    if (mis(&s_init, 16384)) return 4;
    if (mis(&g_type, 16384)) return 5;
    if (mis(&g_type.v, 16384)) return 6;
    if (mis(&g_arr[1], 16384)) return 7;
    if (mis(&g_arr[1].v, 16384)) return 8;
    if (mis(&g_arr[2], 16384)) return 9;

    // Negative control: a pointer one byte and half a boundary past an
    // aligned object must register as misaligned, proving the checks run.
    if (!mis((const char *)&g_bare + 1, 16384)) return 20;
    if (!mis((const char *)&g_bare + 8192, 16384)) return 21;

    // The placed slots round-trip values.
    g_init = 11;
    s_init = 22;
    g_type.v = 33;
    g_arr[2].v = 44;
    if (g_init != 11 || s_init != 22 || g_type.v != 33 || g_arr[2].v != 44) return 30;
    return 0;
}
