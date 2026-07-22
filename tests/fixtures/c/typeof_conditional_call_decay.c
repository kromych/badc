// A value-producing operator -- a function call or a conditional -- yields a
// fresh rvalue whose type is its own, never an array-decayed operand. An
// array or string operand must not leak its array shape into the enclosing
// `typeof` / `sizeof` (C99 6.3.2.1p3, 6.5.2.2, 6.5.15). Before the fix a
// string-literal call argument (`f("s")`) or a string / array conditional arm
// made `typeof` recover a spurious array type, so the common
// `typeof(1 ? (a) : (b))` MIN / MAX shape and the container-of style
// `typeof(f(x))` macro failed to compile. Returns 0 on success.

// A size-returning call whose argument is a string literal (strlen shape).
static unsigned long slen(const char *s) {
    unsigned long n = 0;
    while (s[n]) {
        n++;
    }
    return n;
}

// A pointer-returning call, taken with a string-literal argument.
static const char *pick(const char *s) {
    return s;
}

#define MAX(a, b)                                                              \
    ({                                                                         \
        typeof(1 ? (a) : (b)) _a = (a), _b = (b);                              \
        _a > _b ? _a : _b;                                                     \
    })

int main(void) {
    // typeof of a call whose argument is a string literal is the return type
    // (a pointer), not the argument's char[]; it is assignable as a pointer.
    typeof(pick("")) rp = pick("hello");
    if (sizeof(typeof(pick(""))) != sizeof(char *)) {
        return 1;
    }
    if (rp[0] != 'h') {
        return 2;
    }

    // MAX with a call arm whose argument is a string literal: the string's
    // width must not leak into the conditional's type. strlen("Call site")
    // is 9, so MAX(3, 9) is 9.
    unsigned long ml = 3;
    if (MAX(ml, slen("Call site")) != 9) {
        return 3;
    }

    // A conditional over two string literals has type char *: its size is a
    // pointer's and it is assignable to a char *.
    if (sizeof(1 ? "x" : "yy") != sizeof(char *)) {
        return 4;
    }
    typeof(1 ? "x" : "yy") sp = "hello";
    if (sp[1] != 'e') {
        return 5;
    }

    // A conditional over two char arrays decays to char *, not the array.
    char a10[10] = {0}, b20[20] = {0};
    if (sizeof(1 ? a10 : b20) != sizeof(char *)) {
        return 6;
    }
    (void)a10;
    (void)b20;

    return 0;
}
