// GCC `__attribute__((mode(M)))` replaces the declared type with the
// integer or floating type of machine mode `M`. On an enumerated type it
// fixes the underlying width, which moves every member declared after it
// inside a struct; the kernel's `__mode(byte)` macro expands to the
// `__mode__(__byte__)` spelling. Values below come from gcc 16 on
// linux/x86_64 and linux/aarch64, which agree on all of them.

#include <stddef.h>

enum byte_enum { BE_A, BE_B } __attribute__((mode(byte)));
struct after_enum {
    enum byte_enum x;
    char y;
    int z;
};

// The spelling the kernel's `__mode()` macro produces.
enum kernel_spelling { KS_A } __attribute__((__mode__(__byte__)));

// The attribute also binds between `enum` and the tag, and through a
// typedef alias of the enum.
enum __attribute__((mode(byte))) before_tag { BT_A };
typedef enum { TA_A } __attribute__((mode(byte))) tagless_alias;

enum hi_enum { HE_A } __attribute__((mode(HI)));
enum di_enum { DE_A } __attribute__((mode(DI)));
enum word_enum { WE_A } __attribute__((mode(word)));
enum ptr_enum { PE_A } __attribute__((mode(pointer)));

// An all-non-negative enum keeps the unsigned underlying type, so the
// full 8-bit range round-trips; one with a negative enumerator stays
// signed.
enum u8_enum { U8_MAX = 255 } __attribute__((mode(byte)));
enum s8_enum { S8_MIN = -128, S8_MAX = 127 } __attribute__((mode(byte)));

// On a typedef and on an object the mode names the type directly.
typedef int qi_t __attribute__((mode(QI)));
typedef int hi_t __attribute__((mode(HI)));
typedef int si_t __attribute__((mode(SI)));
typedef int di_t __attribute__((mode(DI)));
typedef float sf_t __attribute__((mode(SF)));
typedef float df_t __attribute__((mode(DF)));
static int obj_qi __attribute__((mode(QI)));

// And on a member declarator, where it shrinks that member alone.
struct member_mode {
    int a __attribute__((mode(QI)));
    char b;
};

int main(void) {
    if (sizeof(enum byte_enum) != 1) return 1;
    if (_Alignof(enum byte_enum) != 1) return 2;

    // The enum's width places `y` right after it and `z` at the next
    // 4-byte boundary, so the struct is 8 rather than 12 bytes.
    if (sizeof(struct after_enum) != 8) return 3;
    if (offsetof(struct after_enum, x) != 0) return 4;
    if (offsetof(struct after_enum, y) != 1) return 5;
    if (offsetof(struct after_enum, z) != 4) return 6;

    if (sizeof(enum kernel_spelling) != 1) return 7;
    if (sizeof(enum before_tag) != 1) return 8;
    if (sizeof(tagless_alias) != 1) return 9;

    if (sizeof(enum hi_enum) != 2) return 10;
    if (sizeof(enum di_enum) != 8) return 11;
    if (_Alignof(enum di_enum) != 8) return 12;
    if (sizeof(enum word_enum) != 8) return 13;
    if (sizeof(enum ptr_enum) != 8) return 14;

    // An array of the narrowed enum strides by its own width.
    enum byte_enum arr[3];
    if (sizeof(arr) != 3) return 15;

    {
        enum u8_enum u = U8_MAX;
        if ((long) u != 255) return 16;
        if (sizeof(enum u8_enum) != 1) return 17;
    }
    {
        enum s8_enum s = S8_MIN;
        if ((long) s != -128) return 18;
        if (sizeof(enum s8_enum) != 1) return 19;
    }

    if (sizeof(qi_t) != 1) return 20;
    if (sizeof(hi_t) != 2) return 21;
    if (sizeof(si_t) != 4) return 22;
    if (sizeof(di_t) != 8) return 23;
    if (sizeof(sf_t) != 4) return 24;
    if (sizeof(df_t) != 8) return 25;
    if (sizeof(obj_qi) != 1) return 26;

    // A mode-narrowed typedef still holds and returns its value.
    {
        di_t d = 0x1122334455667788L;
        qi_t q = -3;
        df_t f = 0.5;
        if (d != 0x1122334455667788L) return 27;
        if (q != -3) return 28;
        if (f != 0.5) return 29;
    }

    if (sizeof(struct member_mode) != 2) return 30;
    if (offsetof(struct member_mode, b) != 1) return 31;
    return 0;
}
