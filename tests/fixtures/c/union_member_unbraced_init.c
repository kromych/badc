// C99 6.7.8p17: with its braces elided, a union member of a struct
// takes a single initializer for its first named member, converted as
// if by assignment. The integer 3 must land as the double 3.0, the
// following value goes to the next struct member, and a union wider
// than 8 bytes must not wrap the stored bytes at offset 8.
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code.

union U { double d; char pad[16]; };
struct S { union U u; int tag; };
struct S gs = { 3, 42 };

union U8 { double d; long l; };
struct S8 { union U8 u; int tag; } gs8 = { 5, 43 };

// The first member may itself be an aggregate; elision continues
// into it (6.7.8p20).
union V { struct { int a; int b; } s; double d; };
struct W { union V v; int t; } gw = { 1, 2, 9 };

struct S garr[2] = { 3, 42, 4, 43 };

int main(void) {
    if (gs.u.d != 3.0 || gs.tag != 42) return 1;
    // Bytes past offset 8 of the 16-byte union stay zero.
    for (int i = 8; i < 16; i++) {
        if (gs.u.pad[i] != 0) return 2;
    }
    if (gs8.u.d != 5.0 || gs8.tag != 43) return 3;
    if (gw.v.s.a != 1 || gw.v.s.b != 2 || gw.t != 9) return 4;
    if (garr[0].u.d != 3.0 || garr[0].tag != 42) return 5;
    if (garr[1].u.d != 4.0 || garr[1].tag != 43) return 6;

    // Automatic storage with constant values follows the same path.
    struct S l = { 3, 42 };
    if (l.u.d != 3.0 || l.tag != 42) return 7;

    // A braced union member is unaffected.
    struct S lb = { { 6 }, 44 };
    if (lb.u.d != 6.0 || lb.tag != 44) return 8;
    return 0;
}
