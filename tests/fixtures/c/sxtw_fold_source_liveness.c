/* The Shl/Shr sign-narrow fold reads the Shl source's register at the
   Shr; an intervening definition may reuse that register once the
   source's live range ends. The fold must verify the place survives. */
long long f(long long x, long long b) {
    long long t = x << 32;
    long long v = x + b;
    long long y = t >> 32;
    return y + v + b;
}

int main(void) { return (int)f(2, 7); }
