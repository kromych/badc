// __builtin_object_size and __builtin_constant_p of a parameter answer
// once inlining reaches the object: the bytes left in a defined object
// under -O, the type's fallback otherwise. Type 3 answers the subobject
// the argument addresses, as gcc -O2 does. A load operand of
// __builtin_constant_p is not performed.
#include <string.h>

#define FI static inline __attribute__((__always_inline__))

FI size_t size0(const void *p) { return __builtin_object_size(p, 0); }
FI size_t size2(const void *p) { return __builtin_object_size(p, 2); }
FI size_t size3(const void *p) { return __builtin_object_size(p, 3); }
FI int loads_constant(const char *p) {
    return __builtin_constant_p(*p) + __builtin_constant_p(p[1]);
}
FI size_t len(const char *p) { return strlen(p); }

char buf[10];
const char msg[] = "hello";

int main(void) {
    size_t a = size0(buf + 3), b = size2(buf + 3);
    if (a != 7 && a != (size_t)-1)
        return 1;
    if (b != 7 && b != 0)
        return 2;
    size_t c = size3(buf);
    if (c != 10 && c != 0)
        return 4;
    int k = loads_constant(msg);
    if (k != 0 && k != 2)
        return 5;
    const char *volatile none = 0;
    if (loads_constant(none) != 0)
        return 6;
    if (len(msg + 1) != 4)
        return 7;
    return 0;
}
