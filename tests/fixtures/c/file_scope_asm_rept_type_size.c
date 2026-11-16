/* GNU as directive forms a file-scope asm section admits: `.rept` inside a
 * `.macro` body and at section scope, the space-separated `.type` spelling,
 * and a `.set` naming a location difference that `.size` and a `.long` then
 * consume. The section holds data only, so one form serves both
 * architectures. */

#include <stdio.h>

#if defined(__APPLE__)
#define CSYM(name) "_" name
#else
#define CSYM(name) name
#endif

extern const unsigned char rept_run[];
extern const int rept_run_len[];

asm(".pushsection .text.reptrun,\"ax\"\n"
    ".balign 8\n"
    ".globl " CSYM("rept_run") "\n"
    ".type " CSYM("rept_run") " STT_OBJECT\n"
    CSYM("rept_run") ":\n"
    ".macro fill_bytes cnt, val\n"
    ".rept \\cnt\n"
    ".byte \\val\n"
    ".endr\n"
    ".endm\n"
    "fill_bytes 3, 4\n"
    ".rept 5\n"
    ".byte 7\n"
    ".endr\n"
    ".set rept_run_size, . - " CSYM("rept_run") "\n"
    ".size " CSYM("rept_run") ", rept_run_size\n"
    ".balign 8\n"
    ".globl " CSYM("rept_run_len") "\n"
    CSYM("rept_run_len") ":\n"
    ".long rept_run_size\n"
    ".popsection\n");

int main(void) {
    int i;
    for (i = 0; i < 3; i++)
        if (rept_run[i] != 4)
            return 1;
    for (i = 3; i < 8; i++)
        if (rept_run[i] != 7)
            return 2;
    /* The assembler's own count of the bytes it emitted. */
    if (rept_run_len[0] != 8)
        return 3;
    printf("asm rept/type/size ok\n");
    return 42;
}
