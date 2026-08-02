/* GNU as directive forms a file-scope asm section admits: `.rept` inside a
 * `.macro` body and at section scope, the space-separated `.type` spelling,
 * and a `.set` naming a location difference that `.size` and a `.long` then
 * consume. The section holds data only, so one form serves both
 * architectures. */

#include <stdio.h>

extern const unsigned char rept_run[];
extern const int rept_run_len[];

asm(".pushsection .text.reptrun,\"ax\"\n"
    ".balign 8\n"
    ".globl rept_run\n"
    ".type rept_run STT_OBJECT\n"
    "rept_run:\n"
    ".macro fill_bytes cnt, val\n"
    ".rept \\cnt\n"
    ".byte \\val\n"
    ".endr\n"
    ".endm\n"
    "fill_bytes 3, 4\n"
    ".rept 5\n"
    ".byte 7\n"
    ".endr\n"
    ".set rept_run_size, . - rept_run\n"
    ".size rept_run, rept_run_size\n"
    ".balign 8\n"
    ".globl rept_run_len\n"
    "rept_run_len:\n"
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
