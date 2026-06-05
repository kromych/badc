// Regression for the Win64 tail-call shadow-space bug. The fixed-up
// emit path is `emit_tail_call` in ssa_emit_x86_64.rs: a tail-call
// must clear `plan.scratch_bytes` before `marshal_args`, because
// regular calls do `sub rsp, scratch_bytes` ahead of the marshal but
// tail calls do not (the callee re-uses the caller's argument area).
// Without the clear, the marshal's spill-slot loads add a phantom
// 32-byte shift and pull from past the caller's saved registers.
//
// On Windows x64 (the only target with a non-zero shadow-space
// requirement under Win64 ABI) the unfixed emit returned garbage
// from `forward` and the program exited non-zero. Linux x86_64 and
// the AArch64 lanes never carried a non-zero `scratch_bytes` on the
// tail path, so the fixture is a no-op assertion there; the value
// is to lock the Win64 behaviour against regression.

#include <stdio.h>

static int sink(int a, int b, int c, int d) {
    return a * 1 + b * 2 + c * 3 + d * 4;
}

static int forward(int seed) {
    // Sixteen locals force the allocator to spill at least some
    // candidates into stack slots; the tail call below then has to
    // source its argument values from those spill slots, exercising
    // the `materialize_int_shifted` spill-load arm inside marshal_args.
    int v0  = seed + 0;
    int v1  = seed + 1;
    int v2  = seed + 2;
    int v3  = seed + 3;
    int v4  = seed + 4;
    int v5  = seed + 5;
    int v6  = seed + 6;
    int v7  = seed + 7;
    int v8  = seed + 8;
    int v9  = seed + 9;
    int v10 = seed + 10;
    int v11 = seed + 11;
    int v12 = seed + 12;
    int v13 = seed + 13;
    int v14 = seed + 14;
    int v15 = seed + 15;

    // Keep v0..v14 live up to the call site so the live-range pressure
    // is real; the allocator cannot fold any of them away.
    int touch = v0 + v1 + v3 + v4 + v6 + v7 + v8 + v9 + v10 + v11
                + v12 + v14 + v15;
    if (touch == 0) return -1;

    return sink(v2, v5, v9, v13);
}

int main(void) {
    int r = forward(10);
    // v2=12, v5=15, v9=19, v13=23 -> 12*1 + 15*2 + 19*3 + 23*4 = 12+30+57+92 = 191
    printf("%d\n", r);
    return r == 191 ? 0 : 1;
}
