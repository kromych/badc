// `__attribute__((aligned(N)))` on a struct member (or before its
// declarator, or on the member's type) raises the member's alignment and
// the aggregate's own alignment up to 16. QEMU's exec/ headers use this
// (Int128Aligned, CPUTLBDescFast, cpu-defs.h neg_align). Layout, size, and
// alignment match GCC/clang. Returns 0 on success; distinct non-zero per fail.

// Interleaved 16-aligned member (the cpu-defs.h neg_align shape).
struct A {
    int a;
    char b __attribute__((aligned(16)));
    int c;
};

// A 16-byte struct member forced to 16-byte alignment (Int128Aligned shape).
struct Int128 {
    unsigned long lo;
    long hi;
};
struct B {
    char pad;
    struct Int128 v __attribute__((aligned(16)));
};

// aligned attribute before the declarator applies to the field.
struct C {
    long x;
    __attribute__((aligned(16))) long y;
};

// Byte offset of a member, via runtime pointer arithmetic (avoids the
// offsetof-with-struct-keyword const-expr path).
#define OFF(p, m) ((unsigned long)((char *)&(p).m - (char *)&(p)))

int main(void) {
    struct A a;
    struct B s;
    struct C c;

    if (sizeof(struct A) != 32 || _Alignof(struct A) != 16) {
        return 1;
    }
    if (OFF(a, b) != 16 || OFF(a, c) != 20) {
        return 2;
    }
    if (sizeof(struct B) != 32 || _Alignof(struct B) != 16 || OFF(s, v) != 16) {
        return 3;
    }
    if (sizeof(struct C) != 32 || _Alignof(struct C) != 16 || OFF(c, y) != 16) {
        return 4;
    }
    // Values through a 16-aligned member round-trip.
    s.v.lo = 0x1122334455667788UL;
    s.v.hi = -3;
    if (s.v.lo != 0x1122334455667788UL || s.v.hi != -3) {
        return 5;
    }
    return 0;
}
