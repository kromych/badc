/* A general-purpose explicit-register variable keeps normal storage;
   its documented guarantee is that an inline-asm operand naming it is
   pinned to the declared register (x86-64 extended asm here). */
long through_r12(long x) {
    register long v asm("r12") = x;
    long out;
    __asm__("mov %1, %0" : "=r"(out) : "r"(v));
    return out;
}

int main(void) {
    if (through_r12(42) != 42) {
        return 1;
    }
    if (through_r12(-7) != -7) {
        return 2;
    }
    return 0;
}
