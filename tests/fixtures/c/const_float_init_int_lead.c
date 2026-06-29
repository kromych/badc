// A floating initializer whose constant expression begins with an
// integer literal still folds in floating arithmetic: `3 * 0.5` is
// 1.5, not the integer-truncated 1. C99 6.5.5 / 6.3.1.8 make the
// multiplication floating once a float operand appears; the result
// converts to the object's type per 6.3.1.4.
double mul = 3 * 0.5;
double divd = 7 / 2.0;
float mixed = 1 + 0.5f;

int main(void) {
    if (!(mul == 1.5)) return 1;
    if (!(divd == 3.5)) return 2;
    if (!(mixed == 1.5f)) return 3;
    return 0;
}
