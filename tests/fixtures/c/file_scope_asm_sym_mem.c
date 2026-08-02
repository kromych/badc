/* File-scope asm function in a pushed section with symbol-displacement
 * memory operands: the no-base scaled-index `sym(,%index,scale)` form
 * and the based `const+sym(%base)` form (an absolute R_X86_64_32S
 * displacement each), plus an immediate operand on the same
 * instruction. */

unsigned long per_slot_base[8];
struct slot_state {
    char pad[16];
    unsigned char busy;
} slot_state[2];

__asm__(".pushsection .text, \"ax\"\n"
        ".globl slot_is_busy\n\t"
        ".type slot_is_busy, @function\n\t"
        "slot_is_busy:\n\t"
        "movq per_slot_base(,%rdi,8), %rax\n\t"
        "cmpb $0, 16+slot_state(%rax)\n\t"
        "setne %al\n\t"
        "movzbq %al, %rax\n\t"
        "ret\n\t"
        ".size slot_is_busy, . - slot_is_busy\n\t"
        ".popsection");

extern unsigned long slot_is_busy(long slot);

int main(void) {
    /* The table holds byte offsets from `slot_state`, so the asm's
     * `16+slot_state(%rax)` reads element 1's `busy`. */
    per_slot_base[3] = sizeof(struct slot_state);
    slot_state[1].busy = 0;
    if (slot_is_busy(3) != 0)
        return 1;
    slot_state[1].busy = 1;
    if (slot_is_busy(3) != 1)
        return 2;
    return 42;
}
