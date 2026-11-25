// snapshot-flags: -mno-red-zone
/* Under -mno-red-zone a frame with no pointer keeps a register its
   lowering borrows within one instruction -- rdx:rax around a division
   with values live in both, cl around a shift by a variable count -- and
   the eight bytes an x87 conversion passes a value through, in slots of
   its own inside the frame; nothing is stored below rsp. The exit code
   names the first mismatch. */

#define NOINLINE __attribute__((noinline))

typedef long long ll;
typedef unsigned long long ull;

volatile ll in[8] = {3, 7, 11, 13, 17, 19, 23, 29};

NOINLINE ll divs(ll a, ll b, ll c, ll d, ll e, ll f)
{
    ll s = a * 3 + b, t = c * 5 + d, u = e * 7 + f, v = a ^ c, w = b ^ d, x = e ^ f;
    ll q = (s + t) / (u | 1), r = (s * t) % (u | 1);
    ull h = (ull)(s * t * 977) / (ull)(w | 1);
    return q + r + (ll)h + s + t + u + v + w + x;
}

NOINLINE ull shifts(ull a, ull b, int n, int m)
{
    ull x = a * 5, y = b * 9, z = a ^ b, w = a + b;
    ull p = x << (n & 63), q = y >> (m & 63), r = z << ((n + m) & 63);
    return p + q + r + x + y + z + w;
}

NOINLINE double widen(long double *p) { return (double)*p; }

NOINLINE void narrow(long double *p, double d) { *p = d; }

int main(void)
{
    if (divs(in[0], in[1], in[2], in[3], in[4], in[5]) != 96991)
        return 1;
    if (shifts((ull)in[6], (ull)in[7], (int)in[0], (int)in[1]) != 11600)
        return 2;
    long double x = 0;
    narrow(&x, (double)in[2] + 0.5);
    if (widen(&x) != 11.5)
        return 3;
    return 0;
}
