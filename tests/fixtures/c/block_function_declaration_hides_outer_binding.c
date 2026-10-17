// A block-scope function declaration hides whatever binding its name has
// outside the block (C99 6.2.1p4) and declares the function the unit's
// other declarations of the name denote (6.2.2p4): a call in the block goes
// to the function, not through a hidden local, parameter, static, enumerator
// or typedef, and the hidden binding is back after the block. In the block
// the function has the composite type of the visible declarations
// (6.2.7p4), so a prototype there converts the arguments (6.5.2.2p7) though
// the file-scope declaration has none. A block may declare the function
// first, around the local the inner declaration hides; its result type
// holds then too.
#include <stdarg.h>
#include <stdlib.h>

int add100(int);
int unproto();

__attribute__((noinline)) static int hides_local(void) {
    int add100 = 7, r;
    {
        {
            int add100(int);
            r = add100(5);
        }
    }
    return r + add100;
}

__attribute__((noinline)) static int hides_parameter(int twice) {
    {
        int twice(int);
        return twice(4);
    }
}

__attribute__((noinline)) static int hides_static(void) {
    static int later = 3;
    {
        int later(int);
        return later(6) + 0;
    }
}

__attribute__((noinline)) static int hides_block_local(void) {
    {
        double later = 2;
        {
            int later(int);
            return later(7) + 0 * (int)later;
        }
    }
}

__attribute__((noinline)) static int hides_enumerator(void) {
    {
        enum { twice = 3 };
        {
            int twice(int);
            return twice(8);
        }
    }
}

__attribute__((noinline)) static int hides_typedef(void) {
    {
        typedef int later;
        later v = 2;
        {
            int later(int);
            return later(9) + 0 * v;
        }
    }
}

__attribute__((noinline)) static int hides_library(void) {
    int abs = 7;
    {
        int abs(int);
        return abs(-5);
    }
}

__attribute__((noinline)) static int composite_prototype(void) {
    int unproto(int, double);
    return unproto(1, 2);
}

__attribute__((noinline)) static double hides_with_variadic(void) {
    int vsum = 7;
    double r;
    {
        double vsum(int, ...);
        r = vsum(3, 1.5, 2.25, 4.0);
    }
    return r + vsum;
}

static volatile int five = 5;
static char buf[8] = "badc";

__attribute__((noinline)) static long declared_in_an_outer_block(void) {
    long r;
    {
        long big(int);
        {
            int big = 3;
            {
                long big(int);
                r = big(five);
            }
            r += big;
        }
    }
    return r;
}

__attribute__((noinline)) static double outer_block_double(void) {
    double r;
    {
        double half(int);
        {
            int half = 1;
            {
                double half(int);
                r = half(five);
            }
            r += half;
        }
    }
    return r;
}

__attribute__((noinline)) static char *outer_block_pointer(void) {
    char *r;
    {
        char *at(int);
        {
            int at = 0;
            {
                char *at(int);
                r = at(five - 4);
            }
        }
    }
    return r;
}

int add100(int x) { return x + 100; }
int twice(int x) { return 2 * x; }
int later(int x) { return x * 10; }
int unproto(int a, double b) { return a * 100 + (int)(b * 10); }
long big(int x) { return 1000L * x; }
double half(int x) { return x / 2.0; }
char *at(int i) { return &buf[i]; }
double vsum(int n, ...) {
    va_list ap;
    va_start(ap, n);
    double s = 0;
    for (int i = 0; i < n; i++) s += va_arg(ap, double);
    va_end(ap);
    return s;
}

int main(void) {
    int bad = 0;
    bad |= (hides_local() != 112) << 0;
    bad |= (hides_parameter(1) != 8) << 1;
    bad |= (hides_static() != 60) << 2;
    bad |= (hides_block_local() != 70) << 3;
    bad |= (hides_enumerator() != 16) << 4;
    bad |= (hides_typedef() != 90) << 5;
    bad |= (hides_library() != 5) << 6;
    bad |= (composite_prototype() != 120) << 7;
    bad |= (hides_with_variadic() != 14.75) << 8;
    bad |= (declared_in_an_outer_block() != 5003) << 9;
    bad |= (outer_block_double() != 3.5) << 10;
    bad |= (outer_block_pointer() != &buf[1]) << 11;
    return bad != 0;
}
