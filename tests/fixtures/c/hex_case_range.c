// A GCC case range whose bounds are hex integers written without spaces
// around `...` (`case 0x10...0x20:`) must lex as `0x10`, `...`, `0x20` --
// the `.` beginning the ellipsis is not a hex-float fractional part.
// Register-decode switches hit this after macro expansion
// (`case LO...HI:` where LO and HI expand to hex constants). A real hex
// float (`0x1.8p3`) must still lex as a float. Returns 0 on success.

#define LO 0x10
#define HI 0x20

int classify(int addr) {
    switch (addr) {
    case LO...HI:
        return 1;
    case 0x30 ... 0x40:
        return 2;
    default:
        return 0;
    }
}

int main(void) {
    double d = 0x1.8p3; // 1.5 * 2^3 = 12.0
    if (classify(0x10) != 1 || classify(0x18) != 1 || classify(0x20) != 1) {
        return 1;
    }
    if (classify(0x30) != 2 || classify(0x40) != 2) {
        return 2;
    }
    if (classify(0x00) != 0 || classify(0x21) != 0) {
        return 3;
    }
    if (d != 12.0) {
        return 4;
    }
    return 0;
}
