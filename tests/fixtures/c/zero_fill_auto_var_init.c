// snapshot-flags: -ftrivial-auto-var-init=zero
// `-ftrivial-auto-var-init=zero` over locals declared without an initializer
// at 64, 256 and 264 bytes, 4 KiB and 64 KiB, and over a variable-length
// array, whose size is known only at run time. Each object takes a store at
// a run-time index and is read elsewhere, so the fill stays observable at -O.

long long uninit_64(unsigned long i)
{
    long long a[8];
    a[i % 8] = (long long)i;
    return a[0] + a[7];
}

long long uninit_256(unsigned long i)
{
    long long a[32];
    a[i % 32] = (long long)i;
    return a[0] + a[31];
}

long long uninit_264(unsigned long i)
{
    long long a[33];
    a[i % 33] = (long long)i;
    return a[0] + a[32];
}

long long uninit_4k(unsigned long i)
{
    long long a[512];
    a[i % 512] = (long long)i;
    return a[0] + a[511];
}

long long uninit_64k(unsigned long i)
{
    long long a[8192];
    a[i % 8192] = (long long)i;
    return a[0] + a[8191];
}

long long uninit_vla(unsigned long n, unsigned long i)
{
    long long a[n];
    a[i % n] = (long long)i;
    return a[0] + a[n - 1];
}

int main(void)
{
    long long r = uninit_64(3) + uninit_256(3) + uninit_264(3) + uninit_4k(3);
    return (int)(r + uninit_64k(3) + uninit_vla(100, 3));
}
