// A function-pointer initializer naming a function a file-scope asm block
// defines holds that function's address, on every path that folds the
// block into the image. Returns 0.

#if defined(__x86_64__)
__asm__(".text\n.globl fsa_fn\nfsa_fn:\n\tmovl $5, %eax\n\tret\n");
#else
__asm__(".text\n.globl fsa_fn\nfsa_fn:\n\tmov w0, #5\n\tret\n");
#endif

int fsa_fn(void);
int (*p)(void) = fsa_fn;

int main(void) { return p() == 5 ? 0 : 1; }
