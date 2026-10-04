/* The SVE and SME register-state moves assemble to the words llvm-mc 21
   gives them (-mattr=+sve,+sme): LDR/STR of a vector and of a predicate
   register at a vector-length-scaled offset, rdffr, wrffr, pfalse, rdsvl,
   and LDR/STR of a ZA array vector, whose address repeats the vector offset.
   Save and restore sequences in these spellings compile. Nothing here
   is called, so the host need not implement SVE or SME; main compares the
   naked function's code with the expected words. gcc has no naked functions
   on AArch64, and other targets have no SVE, so there the comparison does
   not apply. The exit code names the first word that differs. */

#include <stdint.h>

#if defined(__aarch64__)
/* Register-state moves generated through `.irp` loops over the registers. */
#define FOR_EACH_Z_REG(idx_str, asm_str)                                                       \
    "	.irp " idx_str ",0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26," \
    "27,28,29,30,31\n" asm_str "\n"                                                            \
    "	.endr\n"
#define FOR_EACH_P_REG(idx_str, asm_str)                                                       \
    "	.irp " idx_str ",0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15\n" asm_str "\n"                    \
    "	.endr\n"

void sve_save_z(void *state) {
    __asm__ volatile(".arch_extension sve\n" FOR_EACH_Z_REG("n", "str	z\\n, [%[zregs], #\\n, MUL VL]")
                     :
                     : [zregs] "r"(state)
                     : "memory");
}

void sve_save_p(void *pregs, void *pffr) {
    __asm__ volatile(".arch_extension sve\n" FOR_EACH_P_REG("n", "str	p\\n, [%[pregs], #\\n, MUL VL]\n")
                     :
                     : [pregs] "r"(pregs)
                     : "memory");
    __asm__ volatile(".arch_extension sve\n"
                     "	rdffr	p0.b\n"
                     "	str	p0, [%[pffr]]\n"
                     "	ldr	p0, [%[pregs]]\n"
                     :
                     : [pregs] "r"(pregs), [pffr] "r"(pffr)
                     : "memory");
}

void sve_flush_p(void) {
    __asm__ volatile(".arch_extension sve\n" FOR_EACH_P_REG("n", "pfalse	p\\n\\().b") "	wrffr	p0.b\n");
}

unsigned sme_get_vl(void) {
    unsigned vl;
    __asm__ volatile(".arch_extension sme\n	rdsvl %x[vl], #1\n" : [vl] "=r"(vl));
    return vl;
}

void sme_save_za(void *state, unsigned long svl) {
    register unsigned int v __asm__("w12");
    for (v = 0; v < svl; v++) {
        void *pav = (char *)state + v * svl;
        __asm__ volatile(".arch_extension sme\n"
                         "	str	za[%w[v], #0], [%[pav]]\n"
                         :
                         : [v] "r"(v), [pav] "r"(pav)
                         : "memory");
    }
}
#endif

#if defined(__aarch64__) && (defined(__clang__) || !defined(__GNUC__))
#define SVE_WORDS 1
__attribute__((naked, noinline)) static void sve_words(void) {
    __asm__(".arch_extension sve\n"
            ".arch_extension sme\n"
            "ldr z0, [x0]\n"
            "ldr z31, [x1, #31, mul vl]\n"
            "ldr z5, [sp, #-256, mul vl]\n"
            "str z1, [x2, #255, MUL VL]\n"
            "ldr p15, [x1, #15, mul vl]\n"
            "str p3, [x2, #-256, mul vl]\n"
            "str p0, [x0]\n"
            "rdffr p15.b\n"
            "wrffr p15.b\n"
            "pfalse p0.b\n"
            "rdsvl x30, #-32\n"
            "ldr za[w15, 15], [x1, #15, mul vl]\n"
            "str za[w13, #3], [sp, #3, mul vl]\n"
            "ret\n");
}
static const uint32_t expected[] = {
    0x85804000, 0x85835C3F, 0x85A043E5, 0xE59F5C41, 0x85811C2F, 0xE5A00043, 0xE5800000,
    0x2519F00F, 0x252891E0, 0x2518E400, 0x04BF5C1E, 0xE100602F, 0xE12023E3,
};
#endif

int main(void) {
#ifdef SVE_WORDS
    const uint32_t *code = (const uint32_t *)(uintptr_t)sve_words;
    for (int i = 0; i < (int)(sizeof expected / sizeof expected[0]); i++)
        if (code[i] != expected[i]) return 1 + i;
#endif
    return 0;
}
