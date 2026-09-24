// Functions whose entry test returns on one arm and recurses or loops on
// the other. At -O the returning arm leaves without the frame, so each
// takes both exits. Exits 0 when every result matches, a distinct code per
// failure.

#include <stdint.h>

// The header test tail-recursion elimination leaves in the loop.
long long fib(int n) {
    if (n < 2)
        return n;
    return fib(n - 1) + fib(n - 2);
}

// A return with no value.
void qs(long long *a, int lo, int hi) {
    if (lo >= hi)
        return;
    long long pivot = a[(lo + hi) / 2];
    int i = lo, j = hi;
    while (i <= j) {
        while (a[i] < pivot)
            i++;
        while (a[j] > pivot)
            j--;
        if (i <= j) {
            long long t = a[i];
            a[i] = a[j];
            a[j] = t;
            i++;
            j--;
        }
    }
    qs(a, lo, j);
    qs(a, i, hi);
}

// A pointer tested for null, returning a constant.
struct node {
    struct node *left, *right;
    long long val;
};

long long tree_sum(const struct node *p) {
    if (!p)
        return 0;
    return p->val + tree_sum(p->left) + tree_sum(p->right);
}

// Narrow parameters: the test reads a signed char, the return a short.
short narrow(signed char c, short s) {
    if (c <= 0)
        return s;
    return (short)(narrow((signed char)(c - 1), (short)(s - c)) + 1);
}

// An unsigned compare whose returned value is computed in 32 bits.
uint64_t ucount(uint32_t n, uint32_t k) {
    if (n < k)
        return (n << 2) + k;
    return ucount(n - k, k) ^ 1;
}

// More arguments than registers: the test and the returned value read
// register arguments, and the stack arguments stay where the caller put them.
long long many(long long a, long long b, long long c, long long d, long long e,
               long long f, long long g, long long h, long long i, long long j) {
    if (a <= 0)
        return b ^ c;
    return many(a - 1, b + i, c + j, d, e, f, g, h, i, j) + d + e + f + g + h;
}

// A truth test of an int, recursing through a pointer.
int gcd(int a, int b);
int (*volatile gcd_ptr)(int, int) = gcd;

int gcd(int a, int b) {
    if (!b)
        return a;
    return gcd_ptr(b, a % b);
}

// The frame path runs into a loop whose test the entry's end repeats.
static int kind, yields;
static void count_yield(void) {
    yields++;
}
static void (*volatile yield_fn)(void) = count_yield;

void lex(const char *input) {
    if (input == 0)
        return;
    while (1) {
        switch (*input) {
        case '0': case '1': case '2': case '3': case '4':
        case '5': case '6': case '7': case '8': case '9':
            kind = 0;
            break;
        case '*': case '+': case '-':
            kind = 1;
            break;
        default:
            kind = 2;
            return;
        }
        input++;
        yield_fn();
    }
}

// Values live across calls that return early keep their registers.
static volatile long long vals[12] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};

static long long keep(void) {
    long long a = vals[0], b = vals[1], c = vals[2], d = vals[3], e = vals[4], f = vals[5];
    long long g = vals[6], h = vals[7], i = vals[8], j = vals[9], k = vals[10], l = vals[11];
    long long r = fib(1) + tree_sum(0) + narrow(0, 5) + gcd(7, 0) + many(0, 1, 2, 0, 0, 0, 0, 0, 0, 0);
    return r + a + 2 * b + 3 * c + 4 * d + 5 * e + 6 * f + 7 * g + 8 * h + 9 * i + 10 * j + 11 * k + 12 * l;
}

int main(void) {
    if (fib(20) != 6765)
        return 1;
    if (fib(-3) != -3)
        return 2;
    long long a[64];
    uint64_t seed = 12345;
    for (int i = 0; i < 64; i++) {
        seed = seed * 6364136223846793005ull + 1442695040888963407ull;
        a[i] = (long long)(seed >> 33) - (1ll << 30);
    }
    qs(a, 0, 63);
    for (int i = 1; i < 64; i++)
        if (a[i - 1] > a[i])
            return 3;
    qs(a, 5, 5);
    struct node n[7];
    for (int i = 0; i < 7; i++) {
        n[i].val = i + 1;
        n[i].left = 2 * i + 1 < 7 ? &n[2 * i + 1] : 0;
        n[i].right = 2 * i + 2 < 7 ? &n[2 * i + 2] : 0;
    }
    if (tree_sum(n) != 28)
        return 4;
    if (narrow(5, 100) != 90)
        return 5;
    if (narrow(-7, -300) != -300)
        return 6;
    if (ucount(100, 7) != 15 || ucount(10, 3) != 6)
        return 7;
    if (ucount(0xfffffff0u, 0x7ffffff0u) != 0x80000030u || ucount(0x7fffffffu, 0x80000000u) != 0x7ffffffcu)
        return 8;
    if (many(3, 1, 2, 10, 20, 30, 40, 50, 100, 1000) != ((1 + 300) ^ (2 + 3000)) + 3 * 150)
        return 9;
    if (many(0, 6, 3, 0, 0, 0, 0, 0, 0, 0) != 5)
        return 10;
    if (gcd(1071, 462) != 21)
        return 11;
    if (gcd(-4, 0) != -4)
        return 12;
    if (keep() != 16 + 650)
        return 13;
    lex(0);
    if (yields != 0)
        return 14;
    lex("1+2*3x");
    if (yields != 5 || kind != 2)
        return 15;
    return 0;
}
