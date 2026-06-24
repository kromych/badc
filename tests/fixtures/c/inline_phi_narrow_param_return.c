/* A single-block leaf that returns its narrow parameter directly is
   spliced to an Extend of the call argument, so the call result resolves
   to that Extend. The caller's accumulator is a loop-carried phi whose
   back-edge value is defined after the phi in block-array order, so the
   value-remap fixpoint must converge the Extend's operand across passes.
   The argument is a 64-bit expression narrowed to int by the parameter
   (the callee-narrows ABI), truncating every iteration. Checked against
   an off-line value. */

static int trunc_id(int x) { return x; }

static long phi_accumulate(int n) {
    long acc = 1;
    for (int i = 0; i < n; i++) {
        acc = (long)trunc_id(acc * 1000003 + i) + 1;
    }
    return acc;
}

int main(void) {
    return phi_accumulate(50) == -1193861050L ? 0 : 1;
}
