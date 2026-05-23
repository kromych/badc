// C99 6.5.16.2: a compound assignment (`+=`, `-=`) on an
// integer lvalue adds the right-hand side verbatim; only
// pointer arithmetic (6.5.6) scales by the pointed-to type's
// size. The compound-assign lowering used `lhs_ty > Ty::Ptr`
// to decide "is this a pointer that needs index scaling"; an
// unsigned tag's high-bit flag tripped that check, and the
// constant was silently multiplied by the default pointee
// size on every `unsigned short += K` line.
#include <stdio.h>

int main() {
    // unsigned int += int constant. Must add the constant
    // verbatim, not constant * sizeof(int).
    unsigned int a = 100;
    a += 5;
    if (a != 105) { printf("FAIL: u32 += 5 -> %u\n", a); return 1; }
    a -= 3;
    if (a != 102) { printf("FAIL: u32 -= 3 -> %u\n", a); return 1; }

    // unsigned long += int constant. Wider slot.
    unsigned long b = 1000;
    b += 415;
    if (b != 1415) { printf("FAIL: u64 += 415 -> %lu\n", b); return 1; }

    // Mirror of the LEMON shape: u32 += (constA - constB).
    unsigned int yyNewState = 1052;
    int delta = 1282 - 867;     // YY_MIN_REDUCE - YY_MIN_SHIFTREDUCE
    yyNewState += delta;
    if (yyNewState != 1467) {
        printf("FAIL: yyNewState=1052+415 -> %u\n", yyNewState);
        return 1;
    }

    // unsigned char += int. The store-back is 1 byte, so a wide
    // RHS must wrap correctly into the byte slot.
    unsigned char c = 200;
    c += 60;        // wraps to 260 % 256 = 4
    if (c != 4)  { printf("FAIL: u8 200+60 wrap -> %d\n", c); return 1; }

    // Sanity: pointer compound assignment still scales by pointee
    // size. (`p += 3` advances by 3 ints, not 3 bytes.)
    int arr[5];
    arr[0] = 0; arr[1] = 10; arr[2] = 20; arr[3] = 30; arr[4] = 40;
    int *p = arr;
    p += 3;
    if (*p != 30) { printf("FAIL: int* p+=3 -> %d\n", *p); return 1; }

    return 0;
}
