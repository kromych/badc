/* C99 6.7.8p6 `[N] =` array designators interleaved with positional entries
   in a runtime (non-constant) array initializer. Before the array walkers
   were brought to parity the runtime path was positional-only and rejected
   `[N]=`. Values come from parameters to force the runtime store path. */

static int check(int a, int b, int c) {
    int arr[6] = { [3] = a, [1] = b, c };   /* { 0, b, c, a, 0, 0 } */
    return (arr[0] == 0 && arr[1] == b && arr[2] == c
            && arr[3] == a && arr[4] == 0 && arr[5] == 0)
        ? 0
        : 1;
}

static int check_override(int a, int b) {
    /* A later designator overrides an earlier position (6.7.8p19). */
    int arr[3] = { a, [0] = b };            /* { b, 0, 0 } */
    return (arr[0] == b && arr[1] == 0 && arr[2] == 0) ? 0 : 2;
}

int main(void) {
    int r;
    if ((r = check(7, 3, 5))) return r;
    if ((r = check_override(4, 9))) return r;
    return 0;
}
