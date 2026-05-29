// A function-pointer local assigned once and called indirectly inside
// a loop, with another call between iterations. mem2reg promotes the
// pointer (single definition, address never taken); its value is then
// live across the loop back edge and across the intervening call, so
// the allocator must keep it in a register preserved across calls.
// The result is identical at -O and without it.
typedef long (*cmp_t)(long);
static long cb(long x) { return x + 7; }
static long noise(long x) { return x * 2 + 1; }
static long g(long n) {
    cmp_t fp = cb;
    long acc = 0;
    long i = 0;
    while (i < n) {
        acc = acc + noise(i);
        acc = acc + fp(i);
        i = i + 1;
    }
    return acc;
}
int main(void) {
    return (int)(g(3) & 0x7f);
}
