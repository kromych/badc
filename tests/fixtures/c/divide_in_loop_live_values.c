/* A loop whose values stay live across its divisions: x86-64 divides in
   rdx:rax, so a dividend read again and a quotient read after the next
   division keep out of those registers, in a callee-saved register when
   the caller-saved ones are taken, rather than being saved and restored
   around each division. */

__attribute__((noinline)) static int sum_div_mod(const int *a, int n, int d) {
    int s = 0;
    for (int i = 0; i < n; i++) {
        s += a[i] / d + a[i] % d;
    }
    return s;
}

__attribute__((noinline)) static unsigned long mix(const unsigned long *a, int n,
                                                   unsigned long d) {
    unsigned long s = 1;
    for (int i = 0; i < n; i++) {
        unsigned long q = a[i] / d, r = a[i] % d;
        s = s * 31 + q / (r + 1);
    }
    return s;
}

int main(void) {
    volatile int seven = 7;
    volatile unsigned long thirteen = 13;
    int a[64];
    unsigned long b[64];
    int i, want = 0;
    unsigned long wantu = 1;
    for (i = 0; i < 64; i++) {
        a[i] = i * 37 - 900;
        b[i] = (unsigned long)i * 0x9e3779b9u + 5;
    }
    for (i = 0; i < 64; i++) {
        want += a[i] / 7 + a[i] % 7;
        wantu = wantu * 31 + (b[i] / 13) / (b[i] % 13 + 1);
    }
    return (sum_div_mod(a, 64, seven) != want) + (mix(b, 64, thirteen) != wantu) * 2;
}
