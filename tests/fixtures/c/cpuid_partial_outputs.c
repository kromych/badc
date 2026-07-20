/* x86-64 `cpuid` inline-asm with a partial output set: registers not
   captured as outputs are listed as clobbers, and no subleaf input is
   given. Lowers to Intrinsic::Cpuid like the full four-output form; the
   uncaptured registers store to synthesized scratch slots and the
   missing subleaf defaults to 0. The VM zeroes every output, so both
   forms agree on 0 there; native x86-64 executes the instruction and
   both forms read the same leaf. Other native targets gate it out. */

static unsigned leaf_max_partial(void) {
    unsigned m;
    __asm__ volatile("cpuid" : "=a"(m) : "a"(0) : "rbx", "rcx", "rdx");
    return m;
}

static unsigned leaf_max_full(void) {
    unsigned a, b, c, d;
    __asm__ volatile("cpuid"
                     : "=a"(a), "=b"(b), "=c"(c), "=d"(d)
                     : "a"(0), "c"(0));
    return a + (b & 0) + (c & 0) + (d & 0);
}

int main(void) {
    return leaf_max_partial() == leaf_max_full() ? 0 : 1;
}
