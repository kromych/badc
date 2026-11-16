// Static data slots naming functions: on ELF an undefined weak function's
// slot is a null pointer, and everywhere a slot naming a function file-scope
// asm defines holds the function's address. Exits 0 when both hold and the
// asm function runs.

#define SPELL_(prefix, name) #prefix #name
#define SPELL(prefix, name) SPELL_(prefix, name)
#define SYM(name) SPELL(__USER_LABEL_PREFIX__, name)

#ifdef __ELF__
extern void absent(void) __attribute__((weak));
void (*const absent_slot)(void) = absent;
#else
void (*const absent_slot)(void) = 0;
#endif

int asm_fn(void);
#if defined(__x86_64__)
__asm__(".text\n.globl " SYM(asm_fn) "\n.p2align 4\n" SYM(asm_fn) ":\n"
        "\tmovl $7, %eax\n\tret\n");
#elif defined(__aarch64__)
__asm__(".text\n.globl " SYM(asm_fn) "\n.p2align 4\n" SYM(asm_fn) ":\n"
        "\tmov w0, #7\n\tret\n");
#endif
int (*const asm_slot)(void) = asm_fn;

int main(void) {
    if (absent_slot)
        return 1;
    if (asm_slot != asm_fn)
        return 2;
    return asm_slot() == 7 ? 0 : 3;
}
