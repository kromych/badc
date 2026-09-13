/* A narrow integer result feeding a multiply-accumulate read at 64 bits.
 * The product a*b + c is computed in a full register, so a narrow signed
 * operand must reach it sign-extended (C99 6.3.1.3): its high bits are
 * observed through the accumulate whatever its own width. A target that
 * fuses the multiply and the add must keep that extension. */

__attribute__((noinline)) long long macc(int a, int b, long long y, long long c)
{
    int s = (int)((unsigned)a + (unsigned)b);
    return (long long)s * y + c;
}

__attribute__((noinline)) long long macc_sub(int a, long long y, long long c)
{
    return c - (long long)a * y;
}

int main(void)
{
    /* s = INT_MIN, so the sign bit above bit 31 decides the product. */
    if (macc(0x7fffffff, 1, 3, 100) != -6442450844LL)
        return 1;
    if (macc(-4, 0, 1000000000, 0) != -4000000000LL)
        return 2;
    if (macc(2, 3, 7, -1) != 34)
        return 3;
    if (macc_sub(-5, 1000000000, 0) != 5000000000LL)
        return 4;
    if (macc_sub(1000000, 1000000, 0) != -1000000000000LL)
        return 5;
    return 42;
}
