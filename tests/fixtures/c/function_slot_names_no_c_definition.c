// A function-pointer initializer naming a function with no C definition in
// the unit holds what a link gives it: a weak reference no unit defines is
// null, displaced by its offset, and a function an asm statement defines is
// its label's address. Returns 0.

__attribute__((weak)) int absent_fn(void);
int asm_fn(void);

int (*p_absent)(void) = absent_fn;
char *p_absent_4 = (char *)absent_fn + 4;
int (*p_asm)(void) = asm_fn;

void holder(void) {
#if defined(__x86_64__)
    __asm__(".globl asm_fn\nasm_fn:\n\tmovl $5, %eax\n\tret\n");
#else
    __asm__(".globl asm_fn\nasm_fn:\n\tmov w0, #5\n\tret\n");
#endif
}

int main(void) {
    if (p_absent != 0) {
        return 1;
    }
    if (p_absent_4 != (char *)0 + 4) {
        return 2;
    }
    return p_asm() == 5 ? 0 : 3;
}
