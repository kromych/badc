// Arguments with 16-byte alignment. AAPCS64 C.10 starts one at an even
// general register and C.14 aligns its stack slot to 16; the Apple arm64
// convention drops the register rule. System V AMD64 3.2.3 aligns an
// `__int128` in memory to 16 and 3.5.7 its `va_arg` overflow read. Each
// callee reads every argument, so a misplaced one changes the result.
// Every check returns a distinct nonzero code.

#include <stdarg.h>

typedef __int128 i128;
typedef long long ll;

struct wrap128 { i128 v; };
struct member16 { ll lo __attribute__((aligned(16))); ll hi; };
struct whole16 { ll lo; ll hi; } __attribute__((aligned(16)));

static i128 mk(ll hi, ll lo) { return (i128)hi * ((i128)1 << 64) + (i128)(unsigned long long)lo; }
static ll fold(i128 a) { return (ll)(a >> 64) * 1000 + (ll)a; }

__attribute__((noinline)) ll after_one(void *ctx, i128 a, ll c)
{ return fold(a) + c * 7 + (ctx != 0); }

__attribute__((noinline)) ll after_five(ll r0, ll r1, ll r2, ll r3, ll r4, i128 a, ll c)
{ return fold(a) + c * 7 + r0 + r1 * 2 + r2 * 3 + r3 * 4 + r4 * 5; }

__attribute__((noinline)) ll after_seven(ll r0, ll r1, ll r2, ll r3, ll r4, ll r5, ll r6,
                                         i128 a, ll c)
{ return fold(a) + c * 7 + r0 + r1 * 2 + r2 * 3 + r3 * 4 + r4 * 5 + r5 * 6 + r6 * 8; }

__attribute__((noinline)) ll after_double(double d, ll x, i128 a, ll c)
{ return fold(a) + c * 7 + x * 3 + (ll)d; }

__attribute__((noinline)) i128 twice(ll x, i128 a, ll c)
{ return a * 2 + x + c; }

__attribute__((noinline)) ll wrapped(ll x, struct wrap128 w, ll c)
{ return fold(w.v) + c * 7 + x * 3; }

__attribute__((noinline)) ll member_aligned(ll x, struct member16 m, ll c)
{ return m.hi * 1000 + m.lo + c * 7 + x * 3; }

__attribute__((noinline)) ll whole_aligned(ll x, struct whole16 s, ll c)
{ return s.hi * 1000 + s.lo + c * 7 + x * 3; }

__attribute__((noinline)) ll whole_on_stack(ll r0, ll r1, ll r2, ll r3, ll r4, ll r5, ll r6,
                                            ll r7, ll x, struct whole16 s, ll c)
{ return s.hi * 1000 + s.lo + c * 7 + x * 3 + r0 + r1 + r2 + r3 + r4 + r5 + r6 + r7; }

// `n` general slots precede the `__int128`; odd counts need the pairing.
__attribute__((noinline)) ll va_after(int n, ...)
{
	va_list ap;
	ll s = 0;
	va_start(ap, n);
	for (int i = 0; i < n; i++)
		s += va_arg(ap, ll) * (i + 1);
	i128 a = va_arg(ap, i128);
	ll c = va_arg(ap, ll);
	va_end(ap);
	return s + fold(a) + c * 7;
}

int main(void)
{
	static int ctx;
	const ll FA = 5011, FB = -1960;
	i128 a = mk(5, 11), b = mk(-2, 40);
	if (fold(a) != FA || fold(b) != FB) return 1;
	if (after_one(&ctx, a, 3) != FA + 21 + 1) return 2;
	if (after_one(0, b, 4) != FB + 28) return 3;
	if (after_five(1, 2, 3, 4, 5, a, 3) != FA + 21 + 55) return 4;
	if (after_five(5, 4, 3, 2, 1, b, 6) != FB + 42 + 35) return 5;
	if (after_seven(1, 2, 3, 4, 5, 6, 7, a, 3) != FA + 21 + 147) return 6;
	if (after_seven(0, 0, 0, 0, 0, 0, 1, b, 9) != FB + 63 + 8) return 7;
	if (after_double(2.0, 1, a, 3) != FA + 21 + 3 + 2) return 8;
	if (after_double(-1.0, 4, b, 5) != FB + 35 + 12 - 1) return 9;
	if (twice(1, a, 2) != mk(10, 25)) return 10;
	if (twice(-3, b, 4) != mk(-4, 81)) return 11;
	if (wrapped(1, (struct wrap128){ a }, 3) != FA + 21 + 3) return 12;
	if (wrapped(2, (struct wrap128){ b }, 4) != FB + 28 + 6) return 13;
	if (member_aligned(1, (struct member16){ 11, 5 }, 3) != FA + 21 + 3) return 14;
	if (member_aligned(2, (struct member16){ 40, -2 }, 4) != FB + 28 + 6) return 15;
	if (whole_aligned(1, (struct whole16){ 11, 5 }, 3) != FA + 21 + 3) return 16;
	if (whole_aligned(2, (struct whole16){ 40, -2 }, 4) != FB + 28 + 6) return 17;
	if (whole_on_stack(1, 2, 3, 4, 5, 6, 7, 8, 1, (struct whole16){ 11, 5 }, 3) != FA + 21 + 3 + 36)
		return 18;
	if (whole_on_stack(0, 0, 0, 0, 0, 0, 0, 1, 2, (struct whole16){ 40, -2 }, 4) != FB + 28 + 6 + 1)
		return 19;
	if (va_after(0, a, 3LL) != FA + 21) return 20;
	if (va_after(1, 2LL, b, 4LL) != 2 + FB + 28) return 21;
	if (va_after(2, 2LL, 3LL, a, 3LL) != 8 + FA + 21) return 22;
	if (va_after(7, 1LL, 1LL, 1LL, 1LL, 1LL, 1LL, 1LL, b, 5LL) != 28 + FB + 35) return 23;
	if (va_after(8, 1LL, 1LL, 1LL, 1LL, 1LL, 1LL, 1LL, 1LL, a, 3LL) != 36 + FA + 21) return 24;
	return 0;
}
