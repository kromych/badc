/* An inline candidate whose body calls through a function pointer is
 * opaque at that call, not recursive: the target is never spliced and
 * runs in a frame of its own, so the region backing the spliced body's
 * locals is shared across the caller's sites like any other off-cycle
 * callee's instead of appending one region per site. The callback takes
 * the address of a spliced local, so the block stays in the frame and
 * the sharing is visible in the frame size; the two sites' results
 * check that consecutive activations of the shared region stay
 * independent. Returns 42 on success. */

typedef void (*step_fn)(long *slot);

static void twice(long *p) { *p = 2 * *p; }
static void negate(long *p) { *p = -*p; }

static step_fn volatile hook = twice;

static __inline__ __attribute__((always_inline)) long helper(long x) {
    long acc[4];
    acc[0] = x;
    acc[1] = x + 1;
    acc[2] = x + 2;
    acc[3] = x + 3;
    hook(&acc[1]);
    hook(&acc[3]);
    return acc[0] + acc[1] + acc[2] + acc[3];
}

int main(void) {
    long a = helper(3);
    hook = negate;
    long b = helper(10);
    if (a != 28) return 1;
    if (b != -2) return 2;
    return 42;
}
