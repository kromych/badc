// GCC/Clang builtin type macros: the underlying types of size_t, ptrdiff_t,
// intptr_t, and uintptr_t. Headers use these to typedef without knowing the
// data model. Verify width tracks the pointer size and the sign is correct.
typedef __SIZE_TYPE__ size_type;
typedef __PTRDIFF_TYPE__ diff_type;
typedef __INTPTR_TYPE__ iptr_type;
typedef __UINTPTR_TYPE__ uptr_type;

int main(void) {
    if (sizeof(size_type) != sizeof(void *)) return 1;
    if (sizeof(diff_type) != sizeof(void *)) return 2;
    if (sizeof(iptr_type) != sizeof(void *)) return 3;
    if (sizeof(uptr_type) != sizeof(void *)) return 4;

    // __SIZE_TYPE__ / __UINTPTR_TYPE__ are unsigned: 0 - 1 wraps high.
    size_type s = 0;
    s = s - 1;
    if (s <= 0) return 5;
    uptr_type u = 0;
    u = u - 1;
    if (u <= 0) return 6;

    // __PTRDIFF_TYPE__ / __INTPTR_TYPE__ are signed: 0 - 1 is negative.
    diff_type d = 0;
    d = d - 1;
    if (d >= 0) return 7;
    iptr_type p = 0;
    p = p - 1;
    if (p >= 0) return 8;

    // Each __SIZEOF_*__ equals the corresponding sizeof (a common macro
    // shape derives host word width as __SIZEOF_POINTER__ * 8).
    if (__SIZEOF_SHORT__ != (int)sizeof(short)) return 9;
    if (__SIZEOF_INT__ != (int)sizeof(int)) return 10;
    if (__SIZEOF_LONG__ != (int)sizeof(long)) return 11;
    if (__SIZEOF_LONG_LONG__ != (int)sizeof(long long)) return 12;
    if (__SIZEOF_POINTER__ != (int)sizeof(void *)) return 13;
    if (__SIZEOF_PTRDIFF_T__ != (int)sizeof(diff_type)) return 14;
    if (__SIZEOF_SIZE_T__ != (int)sizeof(size_type)) return 15;
    if (__SIZEOF_FLOAT__ != (int)sizeof(float)) return 16;
    if (__SIZEOF_DOUBLE__ != (int)sizeof(double)) return 17;

    return 0;
}
