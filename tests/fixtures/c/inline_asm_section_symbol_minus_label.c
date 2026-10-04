// A data directive in a pushed section subtracting a label of that
// section from a symbol, `.long sym - 2b`, is what GNU as makes it: a
// PC-relative field whose addend is the field's distance from the label,
// so the stored value is `sym - 2b` wherever the field sits. A table entry
// may spell a pointer field `.long %c0 - 2b` four bytes past its label,
// after `.long 1b - 2b`; the entry here sits in a read-only
// section. Each form is gated on the architecture with a portable
// fallback. Returns 42 when every field reads back.

#include <string.h>

struct entry {
    int addr_disp;
    int file_disp;
    unsigned short line;
    unsigned short flags;
};

#if defined(__x86_64__) || defined(__aarch64__)
extern const struct entry sml_entry;

__attribute__((noinline)) static const char *record(void) {
    const char *site;
#if defined(__x86_64__)
    __asm__ volatile("1:\tlea 1b(%%rip), %0\n"
#else
    __asm__ volatile("1:\tadr %0, 1b\n"
#endif
                     ".pushsection .rodata.sml, \"a\"\n"
                     ".balign 4\n"
                     ".globl sml_entry\n"
                     "sml_entry:\n"
                     "2:\t.long 1b - 2b\n"
                     "\t.long %c1 - 2b\n"
                     "\t.short %c2\n"
                     "\t.short %c3\n"
                     ".popsection"
                     : "=r"(site)
                     : "i"("fixture file"), "i"(1234), "i"(7));
    return site;
}
#endif

int main(void) {
#if defined(__x86_64__) || defined(__aarch64__)
    const char *site = record();
    const struct entry *e = &sml_entry;
    if (e->line != 1234 || e->flags != 7)
        return 1;
    if ((const char *)e + e->addr_disp != site)
        return 2;
    if (strcmp((const char *)e + e->file_disp, "fixture file") != 0)
        return 3;
#endif
    return 42;
}
