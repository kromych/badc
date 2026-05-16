// Locks C99 6.6 -- a constant arithmetic expression is a valid
// initializer in every position, including individual elements
// of an array (or struct field) initializer list. The c5
// initializer parser previously returned an enum / macro
// constant immediately and left a trailing operator dangling.
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code.

enum { F_A = 0x10, F_B = 0x80, F_C = 0x04 };

static int singles[3] = { F_A, F_B, F_C };
static int composed[3] = { F_A | F_B, F_A | F_B | F_C, F_A };
static int shifted[2] = { F_A << 4, F_B >> 1 };
static int mixed[3] = { F_A + 1, F_B - F_A, F_A * 3 };

struct Bundle {
    int op_type[2];
};

static struct Bundle table[] = {
    { { F_A | F_B, F_A } },
    { { F_C, F_A | F_C } },
};

int main(void) {
    if (singles[0] != 0x10) return 11;
    if (singles[1] != 0x80) return 12;
    if (singles[2] != 0x04) return 13;
    if (composed[0] != 0x90) return 14;
    if (composed[1] != 0x94) return 15;
    if (composed[2] != 0x10) return 16;
    if (shifted[0] != 0x100) return 17;
    if (shifted[1] != 0x40) return 18;
    if (mixed[0] != 0x11) return 19;
    if (mixed[1] != 0x70) return 20;
    if (mixed[2] != 0x30) return 21;
    if (table[0].op_type[0] != 0x90) return 22;
    if (table[0].op_type[1] != 0x10) return 23;
    if (table[1].op_type[0] != 0x04) return 24;
    if (table[1].op_type[1] != 0x14) return 25;
    return 0;
}
