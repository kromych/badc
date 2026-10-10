/* `(t << k) >> k` with k in {32, 48, 56} is a sign extension, but only
   while the right shift is read: here it is discarded and the left
   shift's other reader still needs the shifted value. */

static volatile long long in[3] = {3, 5, 7};

__attribute__((noinline)) static long long narrow32(long long x, long long a)
{
    long long t = x << 32;
    long long u = t >> 32;
    (void)u;
    return a + t;
}

__attribute__((noinline)) static long long narrow48(long long x, long long a)
{
    long long t = x << 48;
    long long u = t >> 48;
    (void)u;
    return a ^ t;
}

__attribute__((noinline)) static long long narrow56(long long x, long long a)
{
    long long t = x << 56;
    long long u = t >> 56;
    (void)u;
    return a | t;
}

int main(void)
{
    if (narrow32(in[0], 1) != 0x300000001LL)
        return 1;
    if (narrow48(in[1], 1) != 0x5000000000001LL)
        return 2;
    if (narrow56(in[2], 1) != 0x700000000000001LL)
        return 3;
    return 0;
}
