/* The caller's only inlinable call is to a multi-block callee, so the
   multi-block splice runs even when no single-block inline preceded it.
   `pre` and `b` are defined before the call and read after it, in the
   postfix block the splice emits after the callee's blocks: their live
   ranges span the spliced callee. The splice must emit every block's
   instructions in block-index order so the contiguous-ascending
   inst_range the liveness analysis relies on holds; otherwise `pre`/`b`
   get the wrong live ranges and the result is corrupted. Value is
   identical at -O and without it. */
static int twice(int x) {
    int y;
    goto compute;
compute:
    y = x + x;
    return y;
}

int run(int a, int b) {
    int pre = a * 100 + b;
    int t = twice(a);
    return pre + t + b;
}

int main(void) {
    /* run(3, 4): pre = 304, t = 6, => 304 + 6 + 4 = 314 */
    return run(3, 4) - 272; /* 42 */
}
