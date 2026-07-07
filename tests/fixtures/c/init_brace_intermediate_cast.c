// C99 6.5.4: a cast converts the operand to the named type, so an
// intermediate cast narrows before any outer widening. 6.7.8p11: an
// initializer is converted to the object's type as by assignment
// after the expression's own conversions. Brace-enclosed elements
// must apply every cast in the chain, in static and automatic
// storage, for array and struct members alike.

struct box {
    long long l;
    unsigned long long ul;
    int i;
};

long long sa[4] = {
    (long long)(int)0x92492493,
    (long long)(unsigned)0x1FFFFFFFFLL,
    (long long)(short)0xFFFF,
    (long long)(signed char)0x1FF,
};
unsigned long long sua[2] = { (unsigned long long)(short)0xFFFF, (unsigned long long)(int)0x92492493 };
int sia[2] = { (int)(signed char)200, (int)(short)0x18000 };
struct box sb = { (long long)(int)0x92492493, (unsigned long long)(short)0xFFFF, (int)(signed char)200 };

// Scalar wrapped in the optional brace pair (6.7.8p11).
long long sscal = { (long long)(int)0x92492493 };

// The cast binds tighter than a following binary operator (6.5.4).
long long sprec[2] = { (int)0x100000000LL / 2, (int)0xFFFFFFFF >> 4 };

// Casts converting between integer and floating values (6.3.1.4).
int sfi[1] = { (int)2.75 };
double sfd[1] = { (long long)3.9 };

int main(void) {
    long long aa[4] = {
        (long long)(int)0x92492493,
        (long long)(unsigned)0x1FFFFFFFFLL,
        (long long)(short)0xFFFF,
        (long long)(signed char)0x1FF,
    };
    unsigned long long aua[2] = { (unsigned long long)(short)0xFFFF, (unsigned long long)(int)0x92492493 };
    int aia[2] = { (int)(signed char)200, (int)(short)0x18000 };
    struct box ab = { (long long)(int)0x92492493, (unsigned long long)(short)0xFFFF, (int)(signed char)200 };
    long long ascal = { (long long)(int)0x92492493 };

    if (sa[0] != -1840700269LL) return 1;
    if (sa[1] != 4294967295LL) return 2;
    if (sa[2] != -1LL) return 3;
    if (sa[3] != -1LL) return 4;
    if (sua[0] != 0xFFFFFFFFFFFFFFFFULL) return 5;
    if (sua[1] != 0xFFFFFFFF92492493ULL) return 6;
    if (sia[0] != -56) return 7;
    if (sia[1] != -32768) return 8;
    if (sb.l != -1840700269LL) return 9;
    if (sb.ul != 0xFFFFFFFFFFFFFFFFULL) return 10;
    if (sb.i != -56) return 11;
    if (sscal != -1840700269LL) return 12;
    if (sprec[0] != 0LL) return 13;
    if (sprec[1] != -1LL) return 14;
    if (sfi[0] != 2) return 15;
    if (sfd[0] != 3.0) return 16;

    if (aa[0] != -1840700269LL) return 17;
    if (aa[1] != 4294967295LL) return 18;
    if (aa[2] != -1LL) return 19;
    if (aa[3] != -1LL) return 20;
    if (aua[0] != 0xFFFFFFFFFFFFFFFFULL) return 21;
    if (aua[1] != 0xFFFFFFFF92492493ULL) return 22;
    if (aia[0] != -56) return 23;
    if (aia[1] != -32768) return 24;
    if (ab.l != -1840700269LL) return 25;
    if (ab.ul != 0xFFFFFFFFFFFFFFFFULL) return 26;
    if (ab.i != -56) return 27;
    if (ascal != -1840700269LL) return 28;

    return 0;
}
