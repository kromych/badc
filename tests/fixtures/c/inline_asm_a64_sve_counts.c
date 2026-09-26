/* The SVE vector-length and element-count instructions assemble to the words
   llvm-mc 22.1.8 gives them (-mattr=+sve): rdvl, addvl / addpl, and the
   cnt / inc / dec and saturating sqinc / sqdec / uqinc / uqdec families with
   their predicate-constraint pattern and multiplier. The naked function is
   never called, so the host need not implement SVE; main compares its code
   with the expected words. gcc has no naked functions on AArch64, and other
   targets have no SVE, so there the comparison does not apply. The exit code
   names the first word that differs. */

#include <stdint.h>

#if defined(__aarch64__)
/* The kernel's spelling (Linux 7.2 arch/arm64/include/asm/fpsimd.h). */
unsigned sve_get_vl(void) {
    unsigned vl;
    __asm__ volatile(".arch_extension sve\n\trdvl %x[vl], #1\n" : [vl] "=r"(vl));
    return vl;
}
#endif

#if defined(__aarch64__) && (defined(__clang__) || !defined(__GNUC__))
#define SVE_WORDS 1
__attribute__((naked, noinline)) static void sve_words(void) {
    __asm__(".arch_extension sve\n"
            "rdvl x0, #1\n"
            "addvl sp, sp, #-2\n"
            "addpl x0, x1, #-32\n"
            "cntb x0\n"
            "cnth x1, vl256, mul #4\n"
            "cntd x3, mul4, mul #2\n"
            "incb x0, all, mul #16\n"
            "decw x6, vl64\n"
            "sqincb x0, w0, all, mul #3\n"
            "sqdecd x7, vl5\n"
            "uqincw w2, vl3\n"
            "uqdech x5\n"
            "cntb x0, #14\n"
            "cntb x0, ALL, MUL #2\n"
            "ret\n");
}
static const uint32_t expected[] = {
    0x04BF5020, 0x043F57DF, 0x04615400, 0x0420E3E0, 0x0463E1A1, 0x04E1E3A3, 0x043FE3E0,
    0x04B0E566, 0x0422F3E0, 0x04F0F8A7, 0x04A0F462, 0x0470FFE5, 0x0420E1C0, 0x0421E3E0,
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
