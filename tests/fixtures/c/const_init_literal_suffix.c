/* C99 6.4.4.1: an integer constant's type comes from its suffix and its base
   -- `LL`/`ULL` set the rank, `U` the signedness, and a hexadecimal constant
   may take an unsigned type where a decimal one of the same value takes a
   wider signed type. 6.4.4.2p4 gives an `f`-suffixed floating constant type
   float, and 6.4.4.4p11 gives `L'x'` type wchar_t.

   A static initializer's constant expression is parsed speculatively: the
   parser tries one interpretation, rewinds, and retries. The rewind restores
   the token, so it must restore the attributes that type the token too --
   otherwise a leading literal is retyped from whatever the abandoned parse
   lexed last and the arithmetic is done at the wrong width. Each initializer
   below leads with a suffixed or hexadecimal literal and continues with a
   binary operator, which is the shape that rewinds.

   Every form appears at file scope, inside an aggregate, and again at block
   scope with `static` storage: all three take the constant-expression path,
   so a divergence between them must fail here. Values are data-model
   portable -- `long long` is 64-bit under both LP64 and LLP64. */

static long long ll_chain = 719163LL * 24 * 60 * 60;
static unsigned long long ull_shift = 1ULL << 40;
static unsigned long long ull_mul = 3000000000ULL * 3;
static long long u_cmp = (0u - 1) > 0;
static long long hex_wrap = 0xFFFFFFFF + 1;
static long long dec_wide = 4294967295 + 1;
static long long ll_trailing = 24 * 60 * 60 * 719163LL;

struct vals {
    long long a;
    unsigned long long b;
};

static struct vals agg = {719163LL * 24 * 60 * 60, 1ULL << 40};
static unsigned long long arr[3] = {1ULL << 40, 1ULL << 33, 0xFFFFFFFF + 1};

static double f32_chain = 0.1f + 0.0f;
static double f64_chain = 0.1 + 0.0;
static long long wide_char = sizeof(L'x') + 0;
static long long wide_str = sizeof(L"ab") + 0;
static long long narrow_str = sizeof("ab") + 0;

static int check_block_scope(void) {
    static long long b_chain = 719163LL * 24 * 60 * 60;
    static unsigned long long b_shift = 1ULL << 40;
    static long long b_hex = 0xFFFFFFFF + 1;

    if (b_chain != 62135683200LL) return 30;
    if (b_shift != 1099511627776ULL) return 31;
    if (b_hex != 0) return 32;
    return 0;
}

int main(void) {
    float f = 0.1f + 0.0f;
    double d = 0.1 + 0.0;
    int rc;

    if (ll_chain != 62135683200LL) return 1;
    if (ull_shift != 1099511627776ULL) return 2;
    if (ull_mul != 9000000000ULL) return 3;
    if (u_cmp != 1) return 4;
    if (hex_wrap != 0) return 5;
    if (dec_wide != 4294967296LL) return 6;
    if (ll_trailing != 62135683200LL) return 7;

    if (agg.a != 62135683200LL) return 8;
    if (agg.b != 1099511627776ULL) return 9;
    if (arr[0] != 1099511627776ULL) return 10;
    if (arr[1] != 8589934592ULL) return 11;
    if (arr[2] != 0) return 12;

    if (f32_chain != (double)f) return 13;
    if (f64_chain != d) return 14;
    if (wide_char != (long long)sizeof(L'x')) return 15;
    if (wide_str != (long long)sizeof(L"ab")) return 16;
    if (narrow_str != 3) return 17;

    rc = check_block_scope();
    if (rc != 0) return rc;
    return 0;
}
