// C99 6.7.2.2p4 leaves the enum compatible type to the implementation.
// gcc and clang widen an enum whose values need 64 bits to `long` or
// `unsigned long` where `long` has 64 bits, and give its constants that
// type; a packed enum of that range takes it too. `long long` is a
// distinct type of the same width, so `_Generic` tells the two apart.
// The PE targets take MSVC's rule instead: every enum is `int`.

enum wide { TOP = 0x100000000 };
enum swide { LOW = -1, HIGH = 0x100000000 };
enum __attribute__((packed)) pwide { PTOP = 0x100000000 };

#define KIND(x)                                                              \
    _Generic((x), int: 1, unsigned int: 2, long: 3, unsigned long: 4,        \
             long long: 5, unsigned long long: 6, default: 0)

int main(void) {
#if !defined(_WIN32)
    if (KIND((enum wide)0) != 4) return 1;
    if (KIND(TOP) != 4) return 2;
    if (KIND((enum swide)0) != 3) return 3;
    if (KIND(HIGH) != 3) return 4;
    if (KIND((enum pwide)0) != 4 || KIND(PTOP) != 4) return 5;
    if (sizeof(enum wide) != 8 || TOP != 0x100000000) return 6;
    if (LOW >= 0 || HIGH <= 0) return 7;
#endif
    return 0;
}
