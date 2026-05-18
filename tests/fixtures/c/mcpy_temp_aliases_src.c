// Locks the SSA emit's `Op::Mcpy` lowering against a regression
// where the scratch register chosen for the per-iteration word
// copy aliased the source pointer. The pool path keeps src in
// x19 and the SSA emit materialises src into whatever register
// the allocator picked; if `pick_distinct_temp` only avoided the
// destination, an allocator placing src in x10 (or wherever the
// temp lands) corrupted the base on the first `ldr` and the rest
// of the struct was read from a garbage address.
//
// Repros the sqlite3 demo's `*pItem = zeroItem;` shape:
// LocalAddr (dst) -> Psh; ImmData (global src) -> Mcpy. With
// enough surrounding live values the allocator parks src in the
// caller-saved scratch range, exposing the aliasing.

#include <string.h>

struct slot {
    long a;
    long b;
    long c;
    long d;
};

static const struct slot zero_slot = { 0x1111, 0x2222, 0x3333, 0x4444 };

int main(void) {
    struct slot s;
    int a = 1, b = 2, c = 3, d = 4, e = 5;
    int f = 6, g = 7, h = 8, i = 9, j = 10;
    int sum = a + b + c + d + e + f + g + h + i + j;
    s = zero_slot;
    if (sum != 55) return 1;
    if (s.a != 0x1111) return 2;
    if (s.b != 0x2222) return 3;
    if (s.c != 0x3333) return 4;
    if (s.d != 0x4444) return 5;
    return 0;
}
