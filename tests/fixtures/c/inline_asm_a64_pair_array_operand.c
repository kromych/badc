// C99 6.5.3.2p4: the register-pair templates take an array lvalue's address
// as any template does; literal operands keep their bytes. The exit status
// is the number of the first check that fails.
struct pair {
    long long lo, hi;
} __attribute__((aligned(16)));

int main(void) {
    long long a[8] = {0, 1, 2, 3, 4, 5, 6, 7};
#if defined(__aarch64__)
    long long lo, hi, one;
    __asm__ volatile("ldp %0, %1, %2" : "=r"(lo), "=r"(hi) : "m"(*(long long(*)[2])&a[4]));
    if (lo != 4 || hi != 5)
        return 1;
    __asm__ volatile("stp %1, %2, %0" : "=m"(*(long long(*)[2])&a[6]) : "r"(60LL), "r"(70LL));
    if (a[6] != 60 || a[7] != 70)
        return 2;
    __asm__ volatile("ldp %[l], %[h], %[mem]"
                     : [l] "=r"(lo), [h] "=r"(hi)
                     : [mem] "m"(*(long long(*)[2])&a[2]));
    if (lo != 2 || hi != 3)
        return 3;
    __asm__ volatile("ldr %0, %1" : "=r"(one) : "m"(*(long long(*)[2])&a[1]));
    if (one != 1)
        return 4;
    __asm__ volatile("ldp %0, %1, %2" : "=r"(lo), "=r"(hi) : "m"((struct pair){7, 8}));
    if (lo != 7 || hi != 8)
        return 5;
    __asm__ volatile("ldp %0, %1, %2"
                     : "=r"(lo), "=r"(hi)
                     : "m"(*(const struct pair *)"ABCDEFGHIJKLMNOP"));
    if (lo != 0x4847464544434241 || hi != 0x504f4e4d4c4b4a49)
        return 6;
#endif
    return a[0];
}
