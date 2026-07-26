// A callee whose asm names the stack pointer keeps a distinct relocated
// frame region per inline site and its caller's frame is never
// compacted: a stack capture allows an activation to be parked and
// resumed while later code in the same frame runs, so lifetimes are not
// bounded by the CFG and no frame storage may be shared. x86-64 asm.

static long capture(long v) {
    long cell = v;
    void *sp;
    __asm__("mov %%rsp, %0" : "=r"(sp));
    return cell + ((long)sp != 0);
}

int main(void) {
    long a = capture(10);
    long b = capture(20);
    return (a == 11 && b == 21) ? 0 : 1;
}
