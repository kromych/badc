/* Textual macro expansion must not paste adjacent tokens into new ones
 * (C99 6.10.3.3 reserves pasting for `##`): `-x` with `x` = `-22`
 * yields `- -22`, not the pre-decrement `--22`. */
#define E 22
#define NEG(x) (-x)
#define MINUS22 -22
#define APPLY(m, v) m(v)

int main(void) {
    int a = NEG(-E);
    if (a != 22)
        return 1;

    int b = 30 - MINUS22; /* expansion head seam: `- -22` */
    if (b != 52)
        return 2;

    int c = APPLY(NEG, MINUS22);
    if (c != 22)
        return 3;

    /* `##` still pastes. */
#define CAT(x, y) x##y
    int CAT(v, 1) = 9;
    if (v1 != 9)
        return 4;
    return 0;
}
