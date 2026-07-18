// x86-64 non-temporal store (movnti) plus a store fence (sfence) via inline
// asm, reached through the catalogue passthrough. Store a value to memory
// non-temporally, order it, and read it back. Returns 42. Native x86-64 only.

static int store_nt(int v) {
    int x = 0;
    __asm__ volatile("movnti %1, %0\n\tsfence" : "=m"(x) : "r"(v) : "memory");
    return x;
}

int main(void) {
    return store_nt(42);
}
