// Zero images on both sides of the inline fill bound: locals initialized
// with `{0}` at 64, 256 and 264 bytes, 4 KiB and 64 KiB, zero literals
// assigned through a pointer at 264 bytes and 4 KiB, and a 4-byte-aligned
// aggregate whose size leaves a tail short of a whole word. Each local
// takes a store at a run-time index, so the fill stays observable at -O.

struct S264 { long long w[33]; };
struct S4k { long long w[512]; };
struct Odd { int i[1021]; };

long long local_64(unsigned long i)
{
    long long a[8] = {0};
    a[i % 8] = (long long)i;
    return a[0] + a[7];
}

long long local_256(unsigned long i)
{
    long long a[32] = {0};
    a[i % 32] = (long long)i;
    return a[0] + a[31];
}

long long local_264(unsigned long i)
{
    long long a[33] = {0};
    a[i % 33] = (long long)i;
    return a[0] + a[32];
}

long long local_4k(unsigned long i)
{
    long long a[512] = {0};
    a[i % 512] = (long long)i;
    return a[0] + a[511];
}

long long local_64k(unsigned long i)
{
    long long a[8192] = {0};
    a[i % 8192] = (long long)i;
    return a[0] + a[8191];
}

int local_odd(unsigned long i)
{
    struct Odd x = {0};
    x.i[i % 1021] = (int)i;
    return x.i[0] + x.i[1020];
}

void zero_264(struct S264 *p) { *p = (struct S264){}; }
void zero_4k(struct S4k *p) { *p = (struct S4k){0}; }
void zero_odd(struct Odd *p) { *p = (struct Odd){}; }

int main(void)
{
    static struct S264 s264;
    static struct S4k s4k;
    static struct Odd odd;
    s264.w[32] = 1;
    s4k.w[511] = 1;
    odd.i[1020] = 1;
    zero_264(&s264);
    zero_4k(&s4k);
    zero_odd(&odd);
    long long r = local_64(3) + local_256(3) + local_264(3) + local_4k(3) + local_64k(3);
    return (int)(r + local_odd(3) + s264.w[32] + s4k.w[511] + odd.i[1020]);
}
