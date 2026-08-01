/* File-scope asm assembling RIP-relative references whose displacement is
 * a link-time symbol plus a constant, optionally parenthesized and
 * segment-prefixed: the assembler grammar `seg? disp-expr (%rip)`. The
 * template-in-rodata shape: instructions a runtime patcher copies,
 * addressing per-CPU data through %gs. Byte and relocation checks live in
 * the linker tests. */

long counter[2] = {42, 7};

__asm__(".pushsection .rodata\n"
        ".globl patch_template\n"
        "patch_template:\n"
        "sarq $5, %gs:(counter + 8)(%rip)\n"
        "movq counter(%rip), %rax\n"
        "incl %gs:counter(%rip)\n"
        "movq counter+8(%rip), %rcx\n"
        "leaq (counter - 8)(%rip), %rdx\n"
        ".globl patch_template_end\n"
        "patch_template_end:\n"
        ".popsection\n");

int main(void) { return 42; }
