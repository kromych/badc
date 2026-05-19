// SSA-emit regression for a function-call return whose result the
// register allocator placed in a spill slot. The x86_64 SSA emit
// used to test `int_reg(dst)` after the call, which returns None
// for `Place::Spill`, so the call's return value in rax was
// silently dropped and later reads of the spilled value pulled
// stack residue. Mirrors aarch64's `move_call_result`, which
// already handled the Spill case.
//
// The fixture compiles cleanly under both the pool path and the
// SSA emit path. Run with BADC_USE_SSA_EMIT=1 BADC_SSA_MAX_CALLEE_GPRS=2
// BADC_SSA_MAX_CALLER_GPRS=1 to force every call return through a
// spill slot.

typedef unsigned long u64;

static u64 rot(u64 x, int c) { return (x >> c) | (x << (64 - c)); }
static u64 ch(u64 x, u64 y, u64 z) { return (x & y) ^ (~x & z); }
static u64 bs1(u64 x) { return rot(x, 14) ^ rot(x, 18) ^ rot(x, 41); }

int main(void) {
    // Eight live u64 locals plus a loop counter exceeds every
    // target's caller-saved pool. Helpers are non-inlined static
    // functions so each invocation goes through a Call instruction.
    u64 a = 0x100, b = 0x200, c = 0x400, d = 0x800;
    u64 e = 0x1000, f = 0x2000, g = 0x4000, h = 0x8000;
    int j;
    for (j = 0; j < 4; j++) {
        u64 t1 = bs1(e) + ch(e, f, g) + h;
        u64 t2 = bs1(a);
        h = g; g = f; f = e; e = d + t1;
        d = c; c = b; b = a; a = t1 + t2;
    }
    // Computed by the pool-path build; locks in the exact arithmetic
    // result so a Call-result truncation or addition skip would
    // surface as a non-zero exit code.
    if (a != 0x30a55d88de61bb19UL) return 1;
    if (h != 0x440000080000c800UL) return 2;
    return 0;
}
