// Comparisons the range analysis must leave alone. Each returns a
// distinct code so a wrong fold names itself, and every operand is read
// through a volatile cell, which no pass may forward across, so nothing
// here is decided by constant propagation.
//
//   * a mask that is not the operand's identity: `(x & 0xff) == 0` says
//     nothing about `x`;
//   * an ordering through an exclusive-or, which does not preserve it;
//   * a slot whose address escaped, reloaded across a call that writes
//     through the escaped pointer;
//   * a sum that wraps, so the interval of the operands does not bound
//     the result;
//   * a shift count at the top of the register.

static volatile long opaque;
static volatile unsigned long uopaque;
static long *escaped;

static void writes_through(void) { *escaped = 0x100; }

static int mask_is_not_identity(void) {
    long x = opaque;
    if ((x & 0xff) == 0)
        // x is 0x100 here, so the masked test says nothing about x.
        return x == 0 ? 1 : 0;
    return 0;
}

static int xor_does_not_order(void) {
    unsigned long x = uopaque;
    if (((x ^ 2u) & 0xffffffffu) != 0) {
        // x != 2 holds; x <= 2 does not follow and x is 0x100.
        if (x <= 2)
            return 2;
    }
    return 0;
}

static int escaped_slot_reloaded(void) {
    long slot = 5;
    escaped = &slot;
    if (slot < 100) {
        writes_through();
        // The call wrote the slot through the pointer it was given, so
        // the guard's bound does not describe this read.
        if (slot < 100)
            return 3;
    }
    return 0;
}

static int sum_wraps(void) {
    unsigned long x = uopaque;      // 0x100
    unsigned long y = ~0ul - 0x10;
    if (x > 0 && y > 0) {
        // Both are positive; the sum wraps past the top of the register
        // and is below either of them.
        if (x + y > y)
            return 4;
    }
    return 0;
}

static int shift_to_the_top(void) {
    unsigned long x = uopaque;      // 0x100
    if (x != 0) {
        // Bit 8 shifted left by 55 lands on the sign bit, so the result
        // read as signed is negative.
        if ((long)(x << 55) >= 0)
            return 5;
    }
    return 0;
}

int main(void) {
    opaque = 0x100;
    uopaque = 0x100ul;
    escaped = 0;
    int r;
    if ((r = mask_is_not_identity()) != 0)
        return r;
    if ((r = xor_does_not_order()) != 0)
        return r;
    if ((r = escaped_slot_reloaded()) != 0)
        return r;
    if ((r = sum_wraps()) != 0)
        return r;
    if ((r = shift_to_the_top()) != 0)
        return r;
    return 0;
}
