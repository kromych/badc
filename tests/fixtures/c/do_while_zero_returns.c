// A `do { ...; return; } while (0)` body runs before the condition and
// always returns, so it never reaches the exit test: the function does
// not fall off its end (C99 6.8.5). This is the common single-evaluation
// macro idiom; the fall-through diagnostic must not fire on it.

int from_value(int x) {
    do {
        if (x < 0) {
            return -x;
        }
        return x + 1;
    } while (0);
}

int classify(int x) {
    do {
        if (x == 0) return 0;
        else return x > 0 ? 1 : -1;
    } while (0);
}

int main(void) {
    if (from_value(41) != 42) return 1;
    if (from_value(-5) != 5) return 2;
    if (classify(0) != 0) return 3;
    if (classify(9) != 1) return 4;
    if (classify(-9) != -1) return 5;
    return 0;
}
