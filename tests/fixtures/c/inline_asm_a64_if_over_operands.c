/* A `.if` over symbols the same asm statement defines with `.irp` /
 * `.equ` and names through its operands: the register-number table and
 * distinctness test of Linux's arm64 per-CPU accessors. The condition is
 * valued once the operands are registers. Returns 42. */

#define GPR_NUMS                                                          \
    ".irp num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,"   \
    "22,23,24,25,26,27,28,29,30\n"                                       \
    ".equ .L__gpr_num_x\\num, \\num\n"                                   \
    ".equ .L__gpr_num_w\\num, \\num\n"                                   \
    ".endr\n"

static long distinct(long a, long b) {
    long r;
    asm(GPR_NUMS
        ".if (.L__gpr_num_%[a] == .L__gpr_num_%[b]) || (.L__gpr_num_%[a] == .L__gpr_num_%[r])\n"
        ".error \"operands overlap\"\n"
        ".endif\n"
        "add %[r], %[a], %[b]\n"
        : [r] "=&r"(r)
        : [a] "r"(a), [b] "r"(b));
    return r;
}

static long same(long a) {
    long r;
    asm(GPR_NUMS
        ".if .L__gpr_num_%[a] == .L__gpr_num_%[a]\n"
        "mov %[r], #20\n"
        ".else\n"
        "mov %[r], #0\n"
        ".endif\n"
        : [r] "=r"(r)
        : [a] "r"(a));
    return r;
}

int main(void) {
    return (int)(distinct(10, 12) + same(5));
}
