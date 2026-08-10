/* A register-asm declarator's register-name operand joins adjacent
   string literals (C99 5.1.1.2 phase 6) before resolving the register,
   so `asm("%" "rdx")` binds the same register as `asm("%rdx")`. The
   binding pins an inline-asm operand naming the variable to that
   register (x86-64 extended asm). */

/* Split-literal, `%`-prefixed binding used as a plain `"r"` operand. */
long through_rdx(long x) {
    register long v asm("%" "rdx") = x;
    long out;
    __asm__("mov %1, %0" : "=r"(out) : "r"(v));
    return out;
}

/* Split-literal, unprefixed binding verified by reading the named
   register: if the join resolved to rdx, %rdx holds x when the asm
   runs. A binding to any other register would read an unrelated value. */
long via_named_rdx(long x) {
    register long v asm("r" "dx") = x;
    long out;
    __asm__ volatile("movq %%rdx, %0" : "=r"(out) : "r"(v));
    return out;
}

int main(void) {
    if (through_rdx(42) != 42) {
        return 1;
    }
    if (through_rdx(-7) != -7) {
        return 2;
    }
    if (via_named_rdx(123) != 123) {
        return 3;
    }
    if (via_named_rdx(-5) != -5) {
        return 4;
    }
    return 0;
}
