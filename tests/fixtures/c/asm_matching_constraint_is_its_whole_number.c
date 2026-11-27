// A matching constraint names an output by its decimal number, every digit
// of it: `"10"` ties the input to output 10, not to output 1.

int main(void) {
    long a0 = 0, a1 = 1, a2 = 2, a3 = 3, a4 = 4, a5 = 5, a6 = 6, a7 = 7, a8 = 8, a9 = 9, a10 = 10;
    long in = 42;
    __asm__ volatile(""
                     : "+r"(a0), "+r"(a1), "+r"(a2), "+r"(a3), "+r"(a4), "+r"(a5), "+r"(a6),
                       "+r"(a7), "+r"(a8), "+r"(a9), "=r"(a10)
                     : "10"(in));
    return a10 == 42 && a1 == 1 && a9 == 9 ? 0 : 1;
}
