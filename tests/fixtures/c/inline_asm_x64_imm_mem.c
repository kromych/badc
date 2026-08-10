/* Byte / word immediate-to-memory forms through `m` operands: the ALU
   80 / 66 81 / 66 83 /digit family, mov C6 / 66 C7, and test F6 / 66 F7.
   The AT&T size suffix (or a register operand) sets the access width, so a
   byte operation on a wider C object touches only its low lane. */

typedef unsigned long long u64;

int main(void) {
    volatile u64 w = 0x1122334455667788ULL;

    asm("xorb $0x80, %0" : "+m"(w));
    if (w != 0x1122334455667708ULL) return 1;
    asm("addb $0x08, %0" : "+m"(w));
    if (w != 0x1122334455667710ULL) return 2;
    asm("orb $0x0f, %0" : "+m"(w));
    if (w != 0x112233445566771FULL) return 3;
    asm("andb $0xf0, %0" : "+m"(w));
    if (w != 0x1122334455667710ULL) return 4;
    asm("subb $0x10, %0" : "+m"(w));
    if (w != 0x1122334455667700ULL) return 5;
    asm("stc\n\tadcb $0x00, %0" : "+m"(w));
    if (w != 0x1122334455667701ULL) return 6;
    asm("stc\n\tsbbb $0x00, %0" : "+m"(w));
    if (w != 0x1122334455667700ULL) return 7;
    asm("movb $0x2a, %0" : "+m"(w));
    if (w != 0x112233445566772AULL) return 8;

    /* Word forms take the 66 prefix; 66 83 for an immediate fitting imm8. */
    asm("xorw $0x8000, %0" : "+m"(w));
    if (w != 0x112233445566F72AULL) return 9;
    asm("addw $2, %0" : "+m"(w));
    if (w != 0x112233445566F72CULL) return 10;
    asm("movw $0x2a2a, %0" : "+m"(w));
    if (w != 0x1122334455662A2AULL) return 11;

    /* test / cmp read the byte lane and set flags. */
    unsigned char z;
    asm("testb $0x01, %1\n\tsete %0" : "=r"(z) : "m"(w));
    if (z != 1) return 12;
    asm("cmpb $0x2a, %1\n\tsete %0" : "=r"(z) : "m"(w));
    if (z != 1) return 13;

    /* No size suffix: the register operand fixes the byte access width. */
    unsigned char b = 0x80;
    asm("xor %1, %0" : "+m"(w) : "q"(b));
    if (w != 0x1122334455662AAAULL) return 14;

    return 42;
}
