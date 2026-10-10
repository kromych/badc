/* Calls with arguments past the AAPCS64 register window: the caller
   reserves one outgoing argument area in the prologue and stores every
   call's overflow at fixed offsets from sp, instead of adjusting sp
   around each call site. Two calls with different overflow widths share
   the area. Returns the sum of the two calls. */

static long sum10(long a, long b, long c, long d, long e, long f, long g, long h, long i,
                  long j) {
    return a + b + c + d + e + f + g + h + i + j;
}

static long sum11(long a, long b, long c, long d, long e, long f, long g, long h, long i,
                  long j, long k) {
    return a + b + c + d + e + f + g + h + i + j + k;
}

static long (*volatile p_sum10)(long, long, long, long, long, long, long, long, long,
                                long) = sum10;
static long (*volatile p_sum11)(long, long, long, long, long, long, long, long, long,
                                long, long) = sum11;

int main(void) {
    return (int)(p_sum10(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
                 + p_sum11(10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
                 - 110);
}
