// C99 6.7.2.2p4 leaves the enum compatible type to the implementation.
// gcc and clang widen an enum whose values need 64 bits to `long` or
// `unsigned long` where `long` has 64 bits, to `long long` or `unsigned
// long long` where it has 32 (the PE targets), and give its constants that
// type; a packed enum of that range takes it too. The two 64-bit types are
// distinct, so `_Generic` tells them apart.

enum wide { TOP = 0x100000000 };
enum swide { LOW = -1, HIGH = 0x100000000 };
enum __attribute__((packed)) pwide { PTOP = 0x100000000 };

#define KIND(x)                                                              \
    _Generic((x), int: 1, unsigned int: 2, long: 3, unsigned long: 4,        \
             long long: 5, unsigned long long: 6, default: 0)

#if defined(_WIN32)
#define UWIDE 6
#define SWIDE 5
#else
#define UWIDE 4
#define SWIDE 3
#endif

int main(void) {
    if (KIND((enum wide)0) != UWIDE) return 1;
    if (KIND(TOP) != UWIDE) return 2;
    if (KIND((enum swide)0) != SWIDE) return 3;
    if (KIND(HIGH) != SWIDE) return 4;
    if (KIND((enum pwide)0) != UWIDE || KIND(PTOP) != UWIDE) return 5;
    if (sizeof(enum wide) != 8 || TOP != 0x100000000) return 6;
    if (LOW >= 0 || HIGH <= 0) return 7;
    return 0;
}
