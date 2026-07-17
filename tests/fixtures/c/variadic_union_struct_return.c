// A variadic function returning a 16-byte struct whose first eightbyte is
// a union overlapping a double with an int/pointer returns in the integer
// result registers (the eightbyte classifies as INTEGER) while the
// variadic tail rides the host stack. The register-return recovery and the
// stack-placed variadic arguments must both be correct: a prior version
// placed the variadic arguments in registers, so the callee's va_start read
// past them. The shape mirrors a printf-style helper returning a tagged
// value (a union plus a tag), a common real-world shape.

#include <stdarg.h>
#include <string.h>

struct Val {
    union {
        int i;
        double d;
        void *p;
    } u;
    long tag;
};

static struct Val format_first(int ignored, const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    const char *s = va_arg(ap, const char *);
    int n = va_arg(ap, int);
    va_end(ap);
    struct Val v;
    // Record the first character of the string argument and the int, to
    // prove both variadic arguments reached the callee intact.
    v.u.i = (s != 0 ? s[0] : 0) + n;
    v.tag = 7;
    return v;
}

int main(void) {
    const char *s = "Kxyz";
    struct Val r = format_first(0, "fmt", s, 100);
    // 'K' is 0x4B = 75; plus 100 = 175.
    if (r.u.i != 175) return 1;
    if (r.tag != 7) return 2;

    // A second call with different arguments, to catch a stale-register
    // dependence in the variadic placement.
    struct Val r2 = format_first(0, "fmt", "Az", 1);
    if (r2.u.i != 'A' + 1) return 3; // 0x41 + 1 = 66
    if (r2.tag != 7) return 4;

    return 0;
}
