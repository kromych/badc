// GCC / POSIX __builtin_ffs / ffsl / ffsll: one plus the index of the
// least-significant set bit, and 0 for a zero argument. Unlike ctz, the
// zero case is defined. Compiler builtins (no header), lowered to a
// portable (ctz + 1) * (x != 0) sequence. Asserted against hand-computed
// values so the fixture runs on the interpreter without formatted output.

static int eq(int a, int b) { return a == b; }

int main(void) {
    // ffs: 32-bit int. The zero case is defined as 0.
    if (!eq(__builtin_ffs(0), 0)) return 1;
    if (!eq(__builtin_ffs(1), 1)) return 2;
    if (!eq(__builtin_ffs(0x10000), 17)) return 3;      /* bit 16 */
    if (!eq(__builtin_ffs(0x40000000), 31)) return 4;   /* bit 30 */
    if (!eq(__builtin_ffs(0x18), 4)) return 5;          /* lowest set bit is 3 */
    if (!eq(__builtin_ffs((int)0x80000000), 32)) return 6; /* sign bit */

    // ffsll: 64-bit.
    if (!eq(__builtin_ffsll(0ull), 0)) return 7;
    if (!eq(__builtin_ffsll(1ull), 1)) return 8;
    if (!eq(__builtin_ffsll(0x100000000ull), 33)) return 9;         /* bit 32 */
    if (!eq(__builtin_ffsll(0x8000000000000000ull), 64)) return 10; /* bit 63 */

    // ffsl: long-width. Use low-bit values so the result is the same on
    // LP64 (64-bit long) and LLP64 (32-bit long).
    if (!eq(__builtin_ffsl(0L), 0)) return 11;
    if (!eq(__builtin_ffsl(1L), 1)) return 12;
    if (!eq(__builtin_ffsl(0x100L), 9)) return 13;      /* bit 8 */

    // Non-constant operands exercise the runtime path (the constants
    // above may fold at compile time).
    volatile int r = 0x00ff0000;
    if (!eq(__builtin_ffs(r), 17)) return 14;           /* bit 16 */
    volatile int z = 0;
    if (!eq(__builtin_ffs(z), 0)) return 15;
    return 0;
}
