// GCC inline asm with a memory operand for the two x87 FPU control-word
// forms used on x86: `fnstcw %0` stores the control word to a 16-bit
// memory operand and `fldcw %0` loads it. The reserved high bits of the
// word are runtime-defined, so the test only requires that the store/load
// round-trips and that the default word is read.
//
// The x87 control word is an x86 register; the asm has no meaning on
// other ISAs, so it is gated to x86 and the fixture is a trivial success
// elsewhere (the standalone-compile suite builds every fixture for each
// linux target, including aarch64).

#include <stdio.h>

#if defined(__x86_64__) || defined(__i386__)

static unsigned short get_cw(void) {
    unsigned short cw;
    __asm__ __volatile__("fnstcw %0" : "=m"(cw));
    return cw;
}

static void set_cw(unsigned short cw) {
    __asm__ __volatile__("fldcw %0" : : "m"(cw));
}

int main(void) {
    unsigned short cw = get_cw();
    set_cw(cw);
    unsigned short cw2 = get_cw();
    if (cw2 != cw) {
        printf("FAIL cw=0x%x cw2=0x%x\n", cw, cw2);
        return 1;
    }
    // The low 6 bits select the rounding/precision/exception mask; the
    // power-on default is 0x037f.
    if ((cw & 0x0fff) != 0x037f) {
        printf("FAIL default cw=0x%x\n", cw);
        return 2;
    }
    printf("ok cw=0x%x\n", cw);
    return 0;
}

#else

int main(void) {
    return 0;
}

#endif
