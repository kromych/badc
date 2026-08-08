/* `.ascii` / `.asciz` / `.string` operand lists: operands are separated by
 * commas, adjacent literals within one operand concatenate, and `.asciz` /
 * `.string` terminate each operand while `.ascii` terminates none. The
 * expected bytes are GNU as output for the same directives. */

#include <string.h>

extern const unsigned char str_probe[];

asm(".pushsection .rodata.strprobe,\"a\"\n"
    ".globl str_probe\n"
    "str_probe:\n"
    ".ascii \"A\"\n"
    ".asciz \"B\"\n"
    ".ascii \"C\", \"D\"\n"
    ".asciz \"E\", \"F\"\n"
    ".ascii \"G\" \"H\"\n"
    ".string \"I\", \"J\"\n"
    ".ascii \"\" \"\\0\"\n"
    ".popsection\n");

int main(void) {
    static const unsigned char want[] = {
        'A', 'B', 0, 'C', 'D', 'E', 0, 'F', 0, 'G', 'H', 'I', 0, 'J', 0, 0,
    };
    if (memcmp(str_probe, want, sizeof(want)) != 0)
        return 1;
    return 42;
}
