// Plain `char` signedness is implementation-defined (C99 6.2.5p15).
// c5 follows the host C ABI: signed on x86_64 (all OSes), Apple
// AArch64, and Windows AArch64; unsigned on AArch64 ELF. The chosen
// signedness must agree with the `__CHAR_UNSIGNED__` predefine and
// must drive the extension when an 8-bit `char` lvalue widens to a
// larger integer (the load-extension half of the same decision).
//
// This pins both halves against the one source of truth, so the
// fixture's expectation is correct on every target. A widened
// negative byte that comes back as 227 instead of -29 is the
// regression that broke TCL's bytecode source-offset decode
// (`(int) *((char *) p)` with a -29 delta).

#ifdef __CHAR_UNSIGNED__
#define EXPECT_NEG_BYTE 227
#else
#define EXPECT_NEG_BYTE (-29)
#endif

struct S {
    char field;
};

int main(void) {
    // Scalar local.
    char c = -29;
    if ((int)c != EXPECT_NEG_BYTE) {
        return 1;
    }

    // Array element.
    char arr[1];
    arr[0] = -29;
    if ((int)arr[0] != EXPECT_NEG_BYTE) {
        return 2;
    }

    // Struct field.
    struct S s;
    s.field = -29;
    if ((int)s.field != EXPECT_NEG_BYTE) {
        return 3;
    }

    // Load through a `char *` of a byte with the high bit set, the
    // exact shape of TclGetInt1AtPtr's `(int) *((char *) p)`.
    unsigned char raw = 0xE3;
    char *p = (char *)&raw;
    if ((int)*p != EXPECT_NEG_BYTE) {
        return 4;
    }

    // `signed char` is always signed and `unsigned char` always
    // unsigned, independent of the plain-`char` choice.
    signed char sc = -29;
    if ((int)sc != -29) {
        return 5;
    }
    unsigned char uc = 0xE3;
    if ((int)uc != 227) {
        return 6;
    }

    return 0;
}
