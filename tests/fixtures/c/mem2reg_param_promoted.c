// Parameter-slot promotion: a non-variadic, non-struct-returning
// function with an integer parameter whose body reads the param
// across recursive calls. C99 6.2.4p5 / 6.9.1p10 leave the
// implementation free to materialise parameters however it wants;
// keeping the value in a register and skipping the per-use spill /
// reload is the codegen choice mem2reg drives once the walker
// synthesises a single reaching `StoreLocal` for the c5 cdecl arg
// slot from a fresh `Inst::ParamRef`. The recursive `fib`-shape
// exercises the promotion at -O: `n` is read four times across two
// calls and at exit, and all four reads must agree without ever
// hitting the spill slot.
static long fib_lr(int n) {
    if (n < 2) return (long)n;
    return fib_lr(n - 1) + fib_lr(n - 2);
}

int main(void) {
    if (fib_lr(0) != 0) return 1;
    if (fib_lr(1) != 1) return 2;
    if (fib_lr(2) != 1) return 3;
    if (fib_lr(10) != 55) return 4;
    if (fib_lr(20) != 6765) return 5;
    return 0;
}
