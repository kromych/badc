// DEFERRED (#50): function-pointer call through a struct field on
// PE/x64 returns the wrong value. struct_initializers.c hits this
// at `if (fn(2, 3) != 5) return 2;` after copying the field to a
// local first; this minimised fixture exercises the same shape
// without the surrounding designated/positional initializer
// variants.
//
// Today on PE/x64: fixture exits 1 (wrong return). On macOS arm64,
// Linux aarch64/x86_64, and PE/aarch64 + wine, fixture exits 0.
// Suspected cause: the indirect-call path on PE/x64 doesn't quite
// shuffle args into the Microsoft x64 calling convention (RCX,
// RDX, R8, R9 + shadow space) the way a direct libc call does;
// could also be a stale-RAX issue similar to the wine-arm64 atoi
// shape (#48). Until investigated, the fixture is the JIT-side
// invariant -- if it ever fails on JIT we know the trigger has
// broadened beyond PE/x64.
#include <stdio.h>

typedef int (*BinOp)(int, int);

static int do_add(int a, int b) { return a + b; }
static int do_sub(int a, int b) { return a - b; }

struct Vtable {
    BinOp add;
    BinOp sub;
};

static struct Vtable v = { do_add, do_sub };

int main() {
    BinOp fn;

    // Copy struct field to a local and call -- the shape that
    // breaks struct_initializers.c on PE/x64.
    fn = v.add;
    if (fn(2, 3) != 5) return 1;
    fn = v.sub;
    if (fn(10, 4) != 6) return 2;

    return 0;
}
