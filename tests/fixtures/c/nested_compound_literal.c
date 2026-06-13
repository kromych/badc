// C99 6.5.2.5 compound literals nested inside another aggregate
// initializer: `(Outer){ (Inner){ ... }, ... }`. The inner cast names
// the member's own type and is redundant there, so it is dropped and
// the brace list initializes the member like a nested `{ ... }`.
// Exercised in local, file-scope, and return-value contexts, including
// a union member standing in for a tagged-value representation.

typedef struct { int x, y; } P;
typedef struct { P origin; int z; } Q;

typedef union { void *ptr; int i32; double f64; unsigned long long u64; } VU;
typedef struct { VU u; long long tag; } V;

// File-scope: outer + nested compound literal initializer.
static Q g_struct = (Q){ (P){ 1, 2 }, 9 };
static V g_val = (V){ (VU){ .i32 = 5 }, 3 };

static V make(void) {
    // Return value built from a nested compound literal.
    return (V){ (VU){ .i32 = 11 }, 2 };
}

int main(void) {
    // Assignment-position compound literal with a nested one.
    Q a = (Q){ (P){ 3, 4 }, 5 };
    if (a.origin.x != 3 || a.origin.y != 4 || a.z != 5) return 1;

    // Plain declaration whose member is a compound literal.
    Q b = { (P){ 6, 7 }, 8 };
    if (b.origin.x != 6 || b.origin.y != 7 || b.z != 8) return 2;

    if (g_struct.origin.x != 1 || g_struct.origin.y != 2 || g_struct.z != 9) return 3;

    // Union member initialized through a nested compound literal.
    V v = (V){ (VU){ .i32 = 42 }, 7 };
    if (v.tag != 7 || v.u.i32 != 42) return 4;
    if (g_val.tag != 3 || g_val.u.i32 != 5) return 5;

    V r = make();
    if (r.tag != 2 || r.u.i32 != 11) return 6;
    return 0;
}
