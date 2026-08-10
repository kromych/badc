// C99 6.8.6.4p3: a `return` operand converts to the return type as if by
// assignment. The GCC 128-bit integer shares the aggregate carrier but is
// an integer type, so a scalar operand widens into it -- sign-extended
// from a signed source, zero-extended from an unsigned one -- exactly as
// the assignment and argument paths already convert one. lib/ubsan.c
// returns an `s64` load from an `s_max`-returning function this way.
typedef __int128 s_max;
typedef unsigned __int128 u_max;

static long long neg = -3;
static unsigned long long big = 0xffffffffffffffffULL;

static s_max ret_signed(void) { return neg; }
static u_max ret_unsigned(void) { return big; }
static s_max ret_deref(const long long *p) { return *p; }
static s_max ret_int(void) { return -1; }

static int take(int a, s_max b) { return (int)(b + a); }

int main(void) {
	if (sizeof(s_max) != 16) return 1;
	if (ret_signed() != (s_max)-3) return 2;
	if ((ret_signed() >> 64) != (s_max)-1) return 3;
	if (ret_unsigned() != (u_max)0xffffffffffffffffULL) return 4;
	if ((ret_unsigned() >> 64) != 0) return 5;
	if (ret_deref(&neg) != (s_max)-3) return 6;
	if (ret_int() != (s_max)-1) return 7;
	if (take(4, ret_signed()) != 1) return 8;
	return 0;
}
