// C99 6.7p1: a function may be declared inside a block. 6.2.2p5: with
// no storage-class specifier (or `extern`) the name has external
// linkage, so the declaration refers to the file-scope definition and
// a call to it resolves. Both a plain return type and a pointer return
// type are covered, at the top of a function body and inside a nested
// block. A block-scope declaration must not override an existing libc
// binding (`strlen` below stays resolvable).

#include <string.h>

int add(int a, int b);
const char *label(void);

static int streq(const char *a, const char *b) {
    while (*a && *a == *b) {
        a++;
        b++;
    }
    return *a == *b;
}

int main(void) {
    // Block-scope declarations referring to the file-scope
    // definitions below.
    int add(int a, int b);
    const char *label(void);

    if (add(40, 2) != 42) {
        return 1;
    }
    if (!streq(label(), "ok")) {
        return 2;
    }

    // Nested block, declared with `extern`, including a pointer
    // return type.
    {
        extern int add(int, int);
        extern const char *label(void);
        if (add(1, 2) != 3 || !streq(label(), "ok")) {
            return 3;
        }
    }

    // A block-scope declaration of a libc function must keep its
    // binding -- the call still resolves through libc, not as an
    // undefined user reference.
    {
        extern unsigned long strlen(const char *s);
        if (strlen("abcd") != 4) {
            return 4;
        }
    }

    // A prototype parameter name may match an enclosing local; the
    // local must survive (no spurious "duplicate" in a later block).
    {
        int cnt = 5;
        int sum3(int cnt, int b, int c);
        if (sum3(1, 2, 3) != 6 || cnt != 5) {
            return 5;
        }
    }
    {
        int cnt = 7;
        if (cnt != 7) {
            return 6;
        }
    }

    return 0;
}

int sum3(int a, int b, int c) {
    return a + b + c;
}

int add(int a, int b) {
    return a + b;
}

const char *label(void) {
    return "ok";
}
