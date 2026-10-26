// <intsafe.h>'s conversions store the value and return S_OK when it fits the
// result type, and store the error value (0 for UCHAR, all bits set
// otherwise) and return INTSAFE_E_ARITHMETIC_OVERFLOW when it does not; its
// arithmetic does the same for a sum, difference or product. Its limits are
// those of the Windows integer types.

#ifdef _WIN32
#include <windows.h>
#include <intsafe.h>

#define FITS(call, out, want) ((call) == S_OK && (out) == (want))
#define OVERFLOWS(call, out, error) ((call) == INTSAFE_E_ARITHMETIC_OVERFLOW && (out) == (error))

int main(void)
{
    UCHAR uc;
    CHAR c;
    SHORT s;
    USHORT us;
    INT i;
    UINT u;
    LONG l;
    ULONG ul;
    LONGLONG ll;
    ULONGLONG ull;
    SIZE_T sz;
    if (ULONG_MAX != 0xffffffffUL || LONG_MAX != 0x7fffffffL || DWORD_MAX != 0xffffffffUL ||
        SIZE_T_MAX != 0xffffffffffffffffULL || BYTE_MAX != 255 || SHORT_MIN != -32768 ||
        LONGLONG_MIN != -0x7fffffffffffffffLL - 1 || INT_PTR_MAX != 0x7fffffffffffffffLL)
        return 1;
    if (!FITS(IntToUChar(255, &uc), uc, 255) || !OVERFLOWS(IntToUChar(256, &uc), uc, 0) ||
        !OVERFLOWS(IntToUChar(-1, &uc), uc, 0))
        return 2;
    if (!FITS(IntToChar(-128, &c), c, -128) || !OVERFLOWS(IntToChar(128, &c), c, -1))
        return 3;
    if (!FITS(IntToShort(-32768, &s), s, -32768) || !OVERFLOWS(IntToShort(32768, &s), s, -1) ||
        !OVERFLOWS(UIntToUShort(65536, &us), us, 0xffff))
        return 4;
    if (!FITS(UIntToInt(0x7fffffff, &i), i, 0x7fffffff) ||
        !OVERFLOWS(UIntToInt(0x80000000u, &i), i, -1) || !OVERFLOWS(IntToUInt(-1, &u), u, ~0u))
        return 5;
    if (!FITS(LongLongToULongLong(5, &ull), ull, 5) ||
        !OVERFLOWS(LongLongToULongLong(-1, &ull), ull, ~0ull) ||
        !OVERFLOWS(ULongLongToLongLong(0x8000000000000000ull, &ll), ll, -1) ||
        !FITS(ULongLongToLongLong(0x7fffffffffffffffull, &ll), ll, 0x7fffffffffffffffLL))
        return 6;
    if (!FITS(SizeTToULong(0xffffffffu, &ul), ul, 0xffffffffUL) ||
        !OVERFLOWS(SizeTToULong((SIZE_T)1 << 32, &ul), ul, 0xffffffffUL) ||
        !OVERFLOWS(ULongLongToLong(0x80000000ull, &l), l, -1) ||
        !OVERFLOWS(LongLongToSizeT(-1, &sz), sz, (SIZE_T)-1))
        return 7;
    if (!FITS(ULongAdd(0xfffffffeUL, 1, &ul), ul, 0xffffffffUL) ||
        !OVERFLOWS(ULongAdd(0xffffffffUL, 1, &ul), ul, 0xffffffffUL) ||
        !OVERFLOWS(ULongSub(0, 1, &ul), ul, 0xffffffffUL) ||
        !FITS(ULongMult(0x10000, 0xffff, &ul), ul, 0xffff0000UL) ||
        !OVERFLOWS(ULongMult(0x10000, 0x10000, &ul), ul, 0xffffffffUL))
        return 8;
    if (!OVERFLOWS(UShortAdd(0xffff, 1, &us), us, 0xffff) ||
        !OVERFLOWS(IntAdd(0x7fffffff, 1, &i), i, -1) ||
        !FITS(IntSub(-1, 0x7fffffff, &i), i, -0x7fffffff - 1) ||
        !OVERFLOWS(LongLongMult(0x100000000LL, 0x80000000LL, &ll), ll, -1) ||
        !FITS(ULongLongMult(0x100000000ull, 0xffffffffull, &ull), ull, 0xffffffff00000000ull) ||
        !OVERFLOWS(SizeTAdd((SIZE_T)-1, 1, &sz), sz, (SIZE_T)-1))
        return 9;
    if (!FITS(DWordAdd(1, 2, (DWORD *)&ul), ul, 3) || !FITS(UInt32Mult(3, 4, &u), u, 12))
        return 10;
    return 0;
}
#else
int main(void) { return 0; }
#endif
