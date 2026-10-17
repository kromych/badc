// Tail calls from System V functions that keep values across Microsoft x64
// calls: the callee's first arguments go in rdi and rsi, its seventh and
// eighth floating ones in xmm6 and xmm7 (AMD64 psABI 3.2.3), registers the
// Microsoft x64 convention preserves and System V does not.
// snapshot-budget: exempt
typedef long long ll;
#define MSF __attribute__((ms_abi))
#define SVF __attribute__((sysv_abi))
#define NOINLINE __attribute__((noinline))

MSF NOINLINE ll ms_id(ll x) { return x; }
MSF NOINLINE double ms_idd(double x) { return x; }
SVF NOINLINE ll sv_sum(ll a, ll b, ll c) { return a * 100 + b * 10 + c; }
SVF NOINLINE double sv8(double a, double b, double c, double d, double e, double f, double g,
                        double h) {
    return a + b * 2 + c * 3 + d * 4 + e * 5 + f * 6 + g * 7 + h * 8;
}

static volatile ll v1 = 1, v2 = 2, v3 = 3, v4 = 4, v5 = 5, v6 = 6, v7 = 7;
static volatile double w[8] = {1, 2, 3, 4, 5, 6, 7, 8};

SVF NOINLINE ll tail_int(ll a, ll b) {
    ll x1 = v1, x2 = v2, x3 = v3, x4 = v4, x5 = v5, x6 = v6, x7 = v7;
    ll t = ms_id(a) + ms_id(b);
    return sv_sum(x1 + x2 + x3 + t, x4 + x5, x6 + x7);
}

SVF NOINLINE double tail_fp(double a, double b) {
    double y0 = w[0], y1 = w[1], y2 = w[2], y3 = w[3], y4 = w[4], y5 = w[5], y6 = w[6], y7 = w[7];
    double t = ms_idd(a) + ms_idd(b);
    return sv8(y0 + t, y1, y2, y3, y4, y5, y6, y7);
}

int main(void) {
    int bad = 0;
    if (tail_int(10, 20) != 3600 + 90 + 13) bad |= 1;
    if (tail_fp(0.5, 0.25) != 204.75) bad |= 2;
    return bad;
}
