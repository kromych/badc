// AArch64 cache maintenance + barriers recognized as fixed-encoding
// intrinsics: `mrs %0, ctr_el0`, `dc cvau, %0`, `ic ivau, %0`, `dsb ish`,
// `isb`. Runs under the interpreter -- the native aarch64 backend emits the
// real instructions (which need EL0 cache-op permission; x86-64 gates them
// out), and the interpreter returns a fixed CTR_EL0 (64-byte lines) and
// treats the cache ops / barriers as no-ops.

static int flush_idcache_range(char *start, char *end) {
    unsigned long ctr;
    __asm__ volatile("mrs\t%0, ctr_el0" : "=r"(ctr));
    int dline = 4 << (ctr & 0xf);
    int iline = 4 << ((ctr >> 16) & 0xf);
    int dcount = 0;
    int icount = 0;
    for (char *p = start; p < end; p += dline) {
        __asm__ volatile("dc\tcvau, %0" : : "r"(p) : "memory");
        dcount++;
    }
    __asm__ volatile("dsb\tish" : : : "memory");
    for (char *p = start; p < end; p += iline) {
        __asm__ volatile("ic\tivau, %0" : : "r"(p) : "memory");
        icount++;
    }
    __asm__ volatile("dsb\tish" : : : "memory");
    __asm__ volatile("isb" : : : "memory");
    // The interpreter's CTR_EL0 gives 64-byte lines; a 256-byte range is
    // four lines of each cache.
    if (dline != 64 || iline != 64) return 1;
    if (dcount != 4 || icount != 4) return 2;
    return 0;
}

int main(void) {
    char buf[256];
    return flush_idcache_range(buf, buf + sizeof(buf));
}
