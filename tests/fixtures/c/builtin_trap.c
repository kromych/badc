// __builtin_trap() lowers to an architecture trap instruction (ud2 on
// x86_64, brk #0 on AArch64) and does not return to its caller. A
// function whose only fall-through path ends in the trap therefore does
// not reach its end without a value, so the C99 6.9.1p12 diagnostic does
// not fire. The trap path is not taken at run time here, so the program
// exits normally.

#pragma intrinsic("__builtin_trap")

static int clamp_low(int x) {
    if (x >= 0) return x;
    __builtin_trap();
}

int main(void) {
    if (clamp_low(7) != 7) return 1;
    if (clamp_low(0) != 0) return 2;
    return 0;
}
