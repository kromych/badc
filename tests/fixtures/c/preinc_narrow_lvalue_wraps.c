// C99 6.5.3.1p3 + 6.5.16.2: the value of a pre-increment
// expression is the post-update value of the lvalue in the
// lvalue's type. For a narrow (sub-int) lvalue the post-update
// value must be truncated to the lvalue's storage width so a
// surrounding test such as `(++p) == 0` observes the wraparound.
//
// A common multi-byte carry pattern relies on this exactly:
//   if ((++data[k]) == 0) data[k-1]++;
// where data is u8*; when the low byte rolls 0xFF -> 0x00 the
// expression must compare equal to zero so the high byte carries.
// Skipping the narrowing leaves the in-register sum at 0x100
// which never equals zero, so the carry into the high byte is
// lost and the stored multi-byte value is corrupted.
//
// The same defect affects all narrow-lvalue compound-assignment
// expressions (`+=`, `-=`, etc.) because they share the
// post-update value rule. The fixture covers both shapes.

#include <stdio.h>

static int preinc_u8_wrap(void) {
    unsigned char x = 0xFF;
    int high = 0;
    if ((++x) == 0) high = 1;
    return (high == 1 && x == 0) ? 0 : 1;
}

static int preinc_u16_wrap(void) {
    unsigned short x = 0xFFFF;
    int high = 0;
    if ((++x) == 0) high = 1;
    return (high == 1 && x == 0) ? 0 : 1;
}

static int preinc_u32_wrap(void) {
    unsigned int x = 0xFFFFFFFFu;
    int high = 0;
    if ((++x) == 0) high = 1;
    return (high == 1 && x == 0) ? 0 : 1;
}

static int compound_u8_wrap(void) {
    unsigned char x = 0xF0;
    int high = 0;
    if ((x += 0x10) == 0) high = 1;
    return (high == 1 && x == 0) ? 0 : 1;
}

static int compound_u16_wrap(void) {
    unsigned short x = 0xFFF0;
    int high = 0;
    if ((x += 0x10) == 0) high = 1;
    return (high == 1 && x == 0) ? 0 : 1;
}

static int preinc_u8_through_pointer(void) {
    unsigned char x = 0xFF;
    unsigned char *p = &x;
    int high = 0;
    if ((++(*p)) == 0) high = 1;
    return (high == 1 && x == 0) ? 0 : 1;
}

int main(void) {
    int r = 0;
    r |= preinc_u8_wrap();
    r |= preinc_u16_wrap();
    r |= preinc_u32_wrap();
    r |= compound_u8_wrap();
    r |= compound_u16_wrap();
    r |= preinc_u8_through_pointer();
    printf("%d\n", r);
    return r;
}
