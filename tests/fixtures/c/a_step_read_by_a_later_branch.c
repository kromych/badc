// A decremented counter `y = x - 1` whose flags close its own block's branch
// (`while (x--)`), read again by a branch in a later block (`y != 0`) after a
// test of another value. The later branch tests `y` itself; the step's flags
// no longer hold. The shape is a digit-grouping loop: a separator after
// every third digit counted from the right, none after the last. Returns 0
// when every count and string is right; each failure returns its own code.

__attribute__((noinline)) int separators(unsigned long digits) {
    unsigned long left = digits, until = (digits + 2) % 3;
    int count = 0;
    while (left--) {
        if (until-- == 0 && left != 0) {
            count++;
            until = 2;
        }
    }
    return count;
}

__attribute__((noinline)) void group(const char *in, char *out) {
    unsigned long n = 0, until;
    while (in[n] >= '0' && in[n] <= '9')
        n++;
    until = (n + 2) % 3;
    while (n--) {
        *out++ = *in++;
        if (until-- == 0 && n != 0) {
            *out++ = ',';
            until = 2;
        }
    }
    while ((*out++ = *in++))
        ;
}

static int same(const char *a, const char *b) {
    while (*a && *a == *b)
        a++, b++;
    return *a == *b;
}

int main(void) {
    static const int want[] = {0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3};
    char out[32];
    for (unsigned long n = 0; n <= 10; n++)
        if (separators(n) != want[n])
            return 1 + (int)n;
    group("1234", out);
    if (!same(out, "1,234"))
        return 20;
    group("1234567.25", out);
    if (!same(out, "1,234,567.25"))
        return 21;
    group("123", out);
    if (!same(out, "123"))
        return 22;
    return 0;
}
