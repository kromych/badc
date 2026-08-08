/* File-scope aarch64 asm function: numeric-label branches (26-bit, 19-bit
 * conditional, 14-bit test-bit), an `adr` and a literal `ldr` to a
 * same-section constant, and a `bl` out to C -- all resolved through the
 * section relocation path GNU as would fold or emit. */

unsigned long bump_calls;

void bump(void) { bump_calls++; }

__asm__(".pushsection .probe.text, \"ax\"\n"
        ".globl sum_probe\n"
        ".type sum_probe, @function\n"
        "sum_probe:\n"
        "  stp x29, x30, [sp, #-16]!\n"
        "  stp x19, x20, [sp, #-16]!\n"
        "  mov x19, #0\n"
        "  mov x1, #3\n"
        "1:\n"
        "  add x19, x19, x1\n"
        "  subs x1, x1, #1\n"
        "  b.ne 1b\n"
        "  cbz x1, 2f\n"
        "  mov x19, #100\n"
        "2:\n"
        "  bl bump\n"
        "  tbz x19, #0, 3f\n"
        "  mov x19, #200\n"
        "3:\n"
        "  adr x1, 4f\n"
        "  ldr w2, 4f\n"
        "  ldr w3, [x1]\n"
        "  add x0, x2, x3\n"
        "  add x0, x0, x19\n"
        "  ldp x19, x20, [sp], #16\n"
        "  ldp x29, x30, [sp], #16\n"
        "  ret\n"
        "4:\n"
        "  .word 7\n"
        ".size sum_probe, . - sum_probe\n"
        ".popsection\n");

extern unsigned long sum_probe(void);

int main(void) {
    /* 3+2+1 = 6 (bit 0 clear, so the tbz skips the mov), plus 7 + 7. */
    if (sum_probe() != 20)
        return 1;
    if (bump_calls != 1)
        return 2;
    return 42;
}
