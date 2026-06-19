/* Declared-local slot coalescing. heavy() spreads an accumulation across many
   function-top-level scalars whose live ranges are disjoint (lexically
   coexisting but never simultaneously live), so the no-debug pass reuses
   their cells. It is cross-checked against simple(), which computes the same
   sum with one accumulator, and against the storage a wrong reservation would
   corrupt: an address-taken local, a declared array, a struct-by-value
   parameter copy, and a > 16-byte (indirect-return) struct. long long keeps
   every value 64-bit on LP64 and LLP64 alike. Returns 0 on success. */
struct Q { long long a, b, c, d; };
static struct Q mkq(long long s){ struct Q q; q.a=s; q.b=s^0x5555; q.c=s+9; q.d=s*3; return q; }
static long long useq(struct Q q){ return q.a + q.b + q.c + q.d; }

static long long simple(long long n){
    long long r = 0;
    for (long long i = 0; i < n; i++) r += 3*i + 7;
    return r;
}
static long long heavy(long long n){
    long long r = 0;
    for (long long i = 0; i < n; i++){
        long long a0 = 3*i, a1 = 7;                      r += a0 + a1;   /* 3i+7 */
        long long b0 = i, b1 = i, b2 = i, z = b0+b1+b2 - 3*i;  r += z;   /* 0   */
        long long c0 = i*9, c1 = i*9, w = c0 - c1;       r += w;         /* 0   */
    }
    return r;
}
/* A > 16-byte-struct-returning function whose body has many disjoint-lifetime
   scalars and returns a compound literal. The literal is marshaled through an
   unnamed temporary -- a slot the parser allocates with no VariableInfo,
   reached only through its base address. A reservation that misses the
   temporary's interior cells lets a coalesced scalar or the out-pointer save
   reuse them and corrupt the returned struct (the live ranges of the three
   scalar phases are disjoint, so the coalescer packs them tightly). */
struct W { long long a, b, c, d, e, f, g, h; };
static long long sum8(struct W w){ return w.a+w.b+w.c+w.d+w.e+w.f+w.g+w.h; }
static struct W build(long long n){
    long long p0=n,  p1=n+1, p2=n+2, p3=n+3, p4=n+4, p5=n+5, p6=n+6, p7=n+7;
    long long u = p0+p1+p2+p3+p4+p5+p6+p7;
    long long q0=u,  q1=u+1, q2=u+2, q3=u+3, q4=u+4, q5=u+5, q6=u+6, q7=u+7;
    long long v = q0+q1+q2+q3+q4+q5+q6+q7;
    long long r0=v,  r1=v+1, r2=v+2, r3=v+3, r4=v+4, r5=v+5, r6=v+6, r7=v+7;
    long long w = r0+r1+r2+r3+r4+r5+r6+r7;
    return (struct W){ n, n+1, n+2, n+3, n+4, n+5, n+6, n + (u-u)+(v-v)+(w-w) };
}
#include <stdio.h>
int main(void){
    int ok = (heavy(50) == simple(50));

    long long t = 0x1234abcd, te = 0x1234abcd;          /* address-taken */
    long long *p = &t; *p ^= 0xfeed; te ^= 0xfeed;
    ok = ok && (t == te);

    long long arr[6], asum = 0, esum = 0;               /* multi-cell */
    for (int i = 0; i < 6; i++){ arr[i] = 1000 + i; esum += 1000 + i; }
    for (int i = 0; i < 6; i++) asum += arr[i];
    ok = ok && (asum == esum);

    struct Q q = mkq(123);                              /* indirect return + by-value param */
    long long qe = 123 + (123 ^ 0x5555) + (123 + 9) + (123 * 3);
    ok = ok && (useq(q) == qe) && (q.a == 123) && (q.d == 369);

    struct W bw = build(10);                            /* compound-literal return temp */
    ok = ok && (sum8(bw) == 10+11+12+13+14+15+16+10);

    if (!ok){ printf("FAIL\n"); return 1; }
    return 0;
}
