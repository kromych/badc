// An unsigned 64-bit integer constant converts to a floating type from
// the value it holds (C99 6.3.1.4p2), not from the sign-extended bits a
// literal or an object read carries: 0xffffffffffffffff is 2^64 once
// rounded, never -1.0. Covers a literal, a cast, a const scalar and a
// const array element, at file and block scope.

static const unsigned long long top = 0xffffffffffffffffull;
static const unsigned long long big[] = {0x8000000000000001ull, 0xfffffffffffff800ull};

float f_lit = 0xffffffffffffffffull;
double d_lit = 0xffffffffffffffffull;
double d_high = 0x8000000000000000ull;
float f_cast = (float)0xfffffffffffffff0ull;
double d_scalar = top;
float f_elem = big[0];
double d_elem = big[1];

int main(void)
{
    static double d_block = big[1];
    if (f_lit != 18446744073709551616.0f) return 1;
    if (d_lit != 18446744073709551616.0) return 2;
    if (d_high != 9223372036854775808.0) return 3;
    if (f_cast != 18446744073709551616.0f) return 4;
    if (d_scalar != 18446744073709551616.0) return 5;
    if (f_elem != 9223372036854775808.0f) return 6;
    if (d_elem != 18446744073709549568.0) return 7;
    if (d_block != 18446744073709549568.0) return 8;
    return 0;
}
