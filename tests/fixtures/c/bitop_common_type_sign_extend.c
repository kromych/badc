// C99 6.5.10-12 + 6.3.1.8: the result of `&` / `^` / `|` has the
// common type of the usual arithmetic conversions, independent of
// operand order. `unsigned | int` is `unsigned int`; casting that to
// signed `int` and widening to a 64-bit type must sign-extend from
// bit 31. The result type tag carried on the bitop must be the common
// type, not the right operand's pre-conversion type, or the widening
// cast zero-extends a negative value (the shape TCL's bytecode jump
// `pc += (cond ? 5 : TclGetInt4AtPtr(pc+1))` relies on, where a
// backward jump offset has the high bit set).

static long mix_ui(unsigned a, int c) { return (int)(a | c); }
static long mix_iu(int a, unsigned c) { return (int)(a | c); }
static long xor_ui(unsigned a, int c) { return (int)(a ^ c); }
static long and_ui(unsigned a, int c) { return (int)(a & c); }

// The TclGetInt4AtPtr shape: build a 32-bit value from four bytes with
// the high bit set, cast to int, use it as a (negative) pointer offset.
static long pc_advance(unsigned char *pc, unsigned char *base) {
    int off = (int)(((unsigned)pc[0] << 24) | (pc[1] << 16)
                    | (pc[2] << 8) | pc[3]);
    unsigned char *q = base;
    q += off;
    return (long)(q - base);
}

int main(void) {
    if (mix_ui(0xFFFFFDC2u, 0) != -574) {
        return 1;
    }
    if (mix_iu(0, 0xFFFFFDC2u) != -574) {
        return 2;
    }
    if (xor_ui(0xFFFFFDC2u, 0) != -574) {
        return 3;
    }
    if (and_ui(0xFFFFFFFFu, (int)0xFFFFFDC2) != -574) {
        return 4;
    }

    // -574 encoded big-endian: 0xFFFFFDC2.
    unsigned char enc[4] = {0xFF, 0xFF, 0xFD, 0xC2};
    unsigned char base[16];
    if (pc_advance(enc, base + 8) != -574) {
        return 5;
    }

    return 0;
}
