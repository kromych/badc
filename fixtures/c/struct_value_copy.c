// Struct-to-struct copy via Op::Mcpy. The compiler lowers `a = b`
// (both struct values) to:
//   Lea val_a    ; address of a in `acc`
//   Psh          ; push dst
//   Lea val_b    ; address of b in `acc`
//   Mcpy size    ; pop dst, copy `size` bytes from acc to dst,
//                 ; leave dst in `acc` (mirrors libc memcpy)
//
// VM, aarch64, and x86_64 all unroll the copy at compile time.
// The copy goes word-by-word for whole 8-byte slots and byte-by-
// byte for any sub-8 tail; struct fields land on 8-byte alignment
// so the byte tail is empty in practice but the lowering covers
// it for forward-compat.

struct Pair { int a; int b; };
struct Triple { int x; int y; int z; };

int main() {
    struct Pair p;
    struct Pair q;
    struct Triple t;
    struct Triple u;

    p.a = 1;
    p.b = 2;
    q.a = 99;
    q.b = 99;

    // Whole-struct copy.
    q = p;
    if (q.a != 1) return 1;
    if (q.b != 2) return 2;

    // Mutating the source after the copy must leave the
    // destination untouched -- verifies the copy was real, not a
    // shared reference.
    p.a = 1000;
    p.b = 2000;
    if (q.a != 1) return 3;
    if (q.b != 2) return 4;

    // Three-field struct (24 bytes, 3 slots).
    t.x = 7;
    t.y = 14;
    t.z = 21;
    u = t;
    if (u.x != 7) return 5;
    if (u.y != 14) return 6;
    if (u.z != 21) return 7;

    // Self-copy: should be a no-op (memcpy is undefined for
    // overlapping regions in C, but identical regions trivially
    // round-trip the bytes).
    p.a = 50;
    p.b = 60;
    p = p;
    if (p.a != 50) return 8;
    if (p.b != 60) return 9;

    return 0;
}
