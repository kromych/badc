// x86-64 accumulator sign-extend (cdqe) via inline asm, reached through the
// catalogue passthrough: eax is sign-extended into rax. Returns 42 only when
// both the negative and positive extensions are correct. Native x86-64 only.

static long sext_asm(int x) {
    long r;
    __asm__("cdqe" : "=a"(r) : "a"(x));
    return r;
}

int main(void) {
    long a = sext_asm(-5); // sign-extends to -5
    long b = sext_asm(47); // stays 47
    if (a == -5 && b == 47) {
        return 42;
    }
    return 1;
}
