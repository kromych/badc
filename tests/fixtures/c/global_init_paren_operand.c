// A parenthesised operand followed by a binary operator in a static or
// file-scope constant initializer is a constant expression: `(1) << 5` folds
// with full operator precedence (C99 6.6 / 6.7.9), not stopping at the closing
// paren. A parenthesised whole value -- `(&x)`, `(123)` -- keeps its meaning.
// Asserted by return code.

static const int sh = (1) << 5;
static const int pr = ((2)) + 3 * 4;
static const unsigned mask = ((unsigned)1) << 28;
const int filescope = (7) % 4;
static const double fp = (1.5) * 2.0 + (3.0);
int gx = 5;
int *paddr = (&gx);

int main(void) {
    if (sh != 32) return 1;
    if (pr != 14) return 2;
    if (mask != 0x10000000u) return 3;
    if (filescope != 3) return 4;
    if (fp != 6.0) return 5;
    if (paddr != &gx) return 6;
    static const int local = (0xFF) & 0x0F;
    if (local != 15) return 7;
    static const int nested = (((1) + (2))) * ((3));
    if (nested != 9) return 8;
    return 0;
}
