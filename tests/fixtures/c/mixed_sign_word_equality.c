// C99 6.5.9p4 / 6.3.1.8: `==` and `!=` between `unsigned int` and `int`
// compare in `unsigned int`, so only the low 32 bits decide. At -O the
// comparison takes one 32-bit compare, as a same-signedness one does.
// Asserted by return code.

__attribute__((noinline)) static unsigned u(unsigned v) { return v; }
__attribute__((noinline)) static int s(int v) { return v; }

int main(void) {
    static const unsigned vals[] = {0u, 81u, 0xFFFFFFFFu, 0x80000000u, 0x7FFFFFFFu, 0x100u};
    for (int i = 0; i < 6; i++) {
        unsigned a = u(vals[i]);
        int b = s((int)vals[i]);
        if ((a == 81) != (vals[i] == 81u)) return 1;
        if ((a == -1) != (vals[i] == 0xFFFFFFFFu)) return 2;
        if ((b == 0xFFFFFFFFu) != (vals[i] == 0xFFFFFFFFu)) return 3;
        if (a != b) return 4;
        if ((b == 0x80000000u) != (vals[i] == 0x80000000u)) return 5;
        if ((a == (int)0x80000000) != (vals[i] == 0x80000000u)) return 6;
    }
    return 0;
}
