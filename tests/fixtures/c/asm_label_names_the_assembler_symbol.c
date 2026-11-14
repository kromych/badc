// An asm label is the symbol's assembler name, as written. Mach-O spells a C
// name with a leading underscore: there `__asm__("_asm_label_two")` names
// the symbol file-scope asm defines as `_asm_label_two:`, and
// `__asm__("asm_label_raw")` the symbol `asm_label_raw`, which spells no C
// name. A function C defines under such a label is reached by it from asm.
#if defined(__APPLE__)
#define C_SYM(name) "_" #name
#else
#define C_SYM(name) #name
#endif
#define TWO C_SYM(asm_label_two)
#define THREE "asm_label_raw"
#define FIVE "asm_label_raw_def"

int two(void) __asm__(TWO);
int three(void) __asm__(THREE);
int five(void) __asm__(FIVE);
int five(void) { return 5; }
int call_five(void);

#if defined(__aarch64__)
#define FN(sym, body) ".globl " sym "\n.p2align 2\n" sym ":\n" body
__asm__(".text\n" FN(TWO, "    mov w0, #2\n    ret\n") FN(THREE, "    mov w0, #3\n    ret\n")
            FN(C_SYM(call_five), "    b " FIVE "\n"));
#else
#define FN(sym, body) ".globl " sym "\n" sym ":\n" body
__asm__(".text\n" FN(TWO, "    movl $2, %eax\n    ret\n") FN(THREE, "    movl $3, %eax\n    ret\n")
            FN(C_SYM(call_five), "    jmp " FIVE "\n"));
#endif

int main(void) { return two() == 2 && three() == 3 && call_five() == 5 ? 0 : 1; }
