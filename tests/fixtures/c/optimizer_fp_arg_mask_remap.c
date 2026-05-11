// The optimizer rewrites the bytecode in-place; any side
// channel keyed on the bytecode PC has to ride along through
// the new-PC table. `call_fp_arg_masks` -- the per-call-site
// bitmap that tells the codegen "this libc call's k-th arg is
// FP, route it through xmm0/d0 instead of the int reg" -- used
// to be passed through unchanged, so at -O the new JsrExt PCs
// found no entry and every FP arg landed in an int register
// instead. Effect: `sin(0.5)` got handed the integer
// 4602678819172646912 (the bit pattern of 0.5), libm's `sin`
// read it as a vast double and either returned 0 or junk.
//
// Pinning a -O round-trip on
// `sin` / `cos` / `sqrt` here so a regression on the remap
// fails loudly on every native lane.
#include <math.h>
#include <stdio.h>

int main(void) {
    double a = 0.5;
    double s = sin(a);
    double c = cos(a);
    double r = sqrt(4.0);
    double e = exp(0.0);
    if (s < 0.479 || s > 0.480) return 1;
    if (c < 0.877 || c > 0.878) return 1;
    if (r != 2.0) return 1;
    if (e < 0.999 || e > 1.001) return 1;
    return 19;
}
