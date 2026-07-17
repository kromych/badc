/* GCC 128-bit integer type, modeled as a 16-byte aggregate for parse /
   layout / sizeof / by-value copy (128-bit arithmetic is rejected as an
   aggregate operand, tested separately). Needed to parse Linux
   kernel-UAPI headers such as asm/sigcontext.h's `__uint128_t vregs[32]`.
   All three spellings and `unsigned __int128` denote the same type. */

__int128 g_signed;
__uint128_t g_unsigned;
typedef __int128_t alias128;

/* asm/sigcontext.h fpsimd_context shape: the aarch64 blocker. */
struct fpsimd { unsigned a, b, c, d; __uint128_t vregs[32]; };

static int check_copy(void) {
    __int128 a = g_signed;   /* load through the aggregate */
    g_signed = a;            /* store back */
    __uint128_t b = a;       /* same 16-byte type, cross-spelling copy */
    a = b;
    return 0;
}

int main(void) {
    if (sizeof(__int128) != 16 || sizeof(__uint128_t) != 16
        || sizeof(__int128_t) != 16 || sizeof(unsigned __int128) != 16)
        return 1;
    if (sizeof(alias128) != 16) return 2;
    if (sizeof(struct fpsimd) != 528) return 3;          /* 16 + 32*16 */
    __int128 arr[4];
    if (sizeof(arr) != 64) return 5;
    return check_copy();
}
