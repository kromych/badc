/* File-scope declaration forms composed the way an export macro uses
 * them: a definition, an `extern typeof` redeclaration with an added
 * attribute, a file-scope asm block emitting the name into a custom
 * section (checked at the object level in the linker tests; executables
 * drop the unreferenced section), and a stack- / frame-pointer register
 * variable read from functions. */

int export_me(int v) { return v + 2; }
extern typeof(export_me) export_me __attribute__((used));
__asm__(".pushsection .export_tab,\"a\"\n"
        ".balign 8\n"
        ".quad export_me\n"
        ".asciz \"export_me\"\n"
        ".popsection");

asm(".section .modinfo,\"a\"\n"
    ".asciz \"name=file_scope_asm_decls\"\n"
    ".previous");

#if defined(__x86_64__)
register unsigned long stack_ptr asm("rsp");
register unsigned long frame_ptr asm("rbp");
#elif defined(__aarch64__)
register unsigned long stack_ptr asm("sp");
register unsigned long frame_ptr asm("x29");
#endif
/* Header re-inclusion shape: the declaration repeats. */
#if defined(__x86_64__)
register unsigned long stack_ptr asm("rsp");
#elif defined(__aarch64__)
register unsigned long stack_ptr asm("sp");
#endif

int arr[3] = {1, 2, 3};
extern typeof(arr) arr;

static unsigned long read_sp(void) { return stack_ptr; }

int main(void) {
    if (sizeof(arr) != 3 * sizeof(int) || arr[2] != 3)
        return 1;
    unsigned long a = stack_ptr;
    unsigned long b = read_sp();
    unsigned long f = frame_ptr;
    if (a == 0 || b == 0 || f == 0)
        return 2;
    /* Both reads see the same stack region. */
    unsigned long d = a > b ? a - b : b - a;
    if (d > 65536)
        return 3;
    return export_me(-2);
}
