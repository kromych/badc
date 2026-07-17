/* C99 6.6: a parenthesized conditional with a constant condition is a
   constant expression, and it may be an operand of further arithmetic
   (`(cond ? a : b) * N`). In an aggregate initializer the constant-init
   evaluator selected the arm but returned before absorbing the trailing
   operators, so the brace list misread `* N` as extra elements ("too many
   initializers"). OpenSSL's cipher tables use exactly this form, e.g.
   `(0x6==0x10001||0x6==0x10004 ? 2 : 1) * 128 / 8`. The evaluator now
   continues the const-expr chain after a pure-integer conditional. */

struct Cipher {
    int block_size;
    int scaled;
    int mixed;
    int leading;
};

static const struct Cipher c = {
    (0x6 == 0x10001 || 0x6 == 0x10004 ? 2 : 1) * 128 / 8, /* 1*16 = 16 */
    (1 ? 3 : 4) * 10,                                     /* 30 */
    5 + (0 ? 1 : 2) * 3,                                  /* 11 */
    (1 ? 1 : 0),                                          /* no trailing op */
};

/* Nested / array forms exercised the same path. */
static const int arr[3] = { (1 ? 2 : 9) * 4, (0 ? 9 : 3) + 1, 7 };

int main(void) {
    if (c.block_size != 16 || c.scaled != 30 || c.mixed != 11 || c.leading != 1)
        return 1;
    if (arr[0] != 8 || arr[1] != 4 || arr[2] != 7)
        return 2;
    return 0;
}
