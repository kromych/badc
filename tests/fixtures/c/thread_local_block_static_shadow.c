/* C99 6.2.1p4: a block-scope static thread-local hides the file-scope object
   of the same name and is an object of its own, which every reference in its
   block names across calls. */

_Thread_local int x = 7;
static _Thread_local int y;

static int bump_x(void) {
    static _Thread_local int x = 3;
    return x++;
}

static int bump_y(void) {
    static _Thread_local int y = 40;
    y += 2;
    return y;
}

int main(void) {
    if (bump_x() != 3) return 1;
    if (bump_x() != 4) return 2;
    if (x != 7) return 3;
    if (bump_y() != 42) return 4;
    if (y != 0) return 5;
    x = 9;
    if (bump_x() != 5) return 6;
    return 0;
}
