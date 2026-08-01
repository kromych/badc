// A segment override written as a leading mnemonic (`ds clflush %0`), and
// the operandless protection-key write `wrpkru`.
//
// A segment override prefixes the instruction it applies to, the same
// statement shape as `lock` / `rep`. Only `cs`, `ds`, `fs` and `gs` are
// spellable: 64-bit mode ignores `es` and `ss`, and GNU as rejects both.
//
// `wrpkru` faults unless the OS enabled protection keys, so it is only
// compiled here, never executed. Everything the fixture runs is a
// prefixed no-op or a prefixed access through the default data segment,
// which the prefix does not change.
//
// Returns 42 on success, a scenario id on the first mismatch.

static unsigned int cell = 0xA5A5A5A5u;

/* Compiled, never called: wrpkru takes its operands in eax/ecx/edx. */
void write_pkru(unsigned int v) {
    asm volatile("wrpkru" : : "a"(v), "c"(0), "d"(0));
}

static unsigned int ds_load(const unsigned int *p) {
    unsigned int v;
    asm volatile("ds movl %1, %0" : "=r"(v) : "m"(*p));
    return v;
}

static void ds_clflush(volatile void *p) {
    asm volatile("ds clflush %0" : "+m"(*(volatile char *)p));
}

static void cs_nop(void) { asm volatile("cs nop"); }
static void fs_nop(void) { asm volatile("fs nop"); }
static void gs_nop(void) { asm volatile("gs nop"); }

int main(void) {
    if (ds_load(&cell) != 0xA5A5A5A5u) return 1;

    ds_clflush(&cell);
    if (cell != 0xA5A5A5A5u) return 2;

    cs_nop();
    fs_nop();
    gs_nop();

    cell = 0x12345678u;
    if (ds_load(&cell) != 0x12345678u) return 3;

    return 42;
}
