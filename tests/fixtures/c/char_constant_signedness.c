// Char-constant signedness (C99 6.4.4.4p10): a single-character
// constant has the value of its char interpreted as int, so on a
// signed-char target '\x80' is -128 -- the same value a `char` lvalue
// holding that byte loads. The constant and the read must agree
// regardless of the target's char signedness, including through a
// switch over char-valued enum case labels.
enum op { LO = '(', HI = '\x80', TOP = '\xff' };

static int pick(char *s) {
    switch ((enum op)s[0]) {
        case HI:  return 1;
        case TOP: return 2;
        case LO:  return 3;
        default:  return 0;
    }
}

// Opaque call target plus a volatile byte: the switch is emitted once
// and the char load really runs, instead of folding to the taken arm.
static int (*volatile pick_p)(char *) = pick;

int main(void) {
    volatile int byte = 0x80;
    char c = (char)byte;
    if ('\x80' != c) return 1;
    byte = 0xFF;
    char d = (char)byte;
    if ('\xff' != d) return 2;
    char b[1];
    byte = 0x80;
    b[0] = (char)byte;
    if (pick_p(b) != 1) return 3;
    byte = 0xFF;
    b[0] = (char)byte;
    if (pick_p(b) != 2) return 4;
    return 0;
}
