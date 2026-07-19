/* `alloca(n)` carves `n` bytes off the stack and returns a pointer.
 * The memory is reclaimed when the function returns; no per-call
 * free. c5 lowers it via `Op::Intrinsic(Alloca)` to a runtime
 * stack-pointer move; the frame's own slots stay reachable through
 * the frame pointer.
 *
 * Exercise:
 *   - single small alloca with write/read round-trip
 *   - dynamic size driven by a function arg
 *   - multiple allocas in one frame land at distinct addresses
 *   - alloca inside a loop (each iteration allocates more,
 *     freed only at function return)
 *   - nested alloca-using calls don't leak memory across frames
 */

#include <stdio.h>
#include <string.h>
#include <alloca.h>

static int single(void) {
    char *p = (char *)alloca(32);
    memset(p, 0x55, 32);
    int i;
    for (i = 0; i < 32; i++) {
        if (p[i] != 0x55) return 1;
    }
    return 0;
}

static int dynamic(int n) {
    int *buf = (int *)alloca(n * sizeof(int));
    int i, sum = 0;
    for (i = 0; i < n; i++) buf[i] = i * 7 - 3;
    for (i = 0; i < n; i++) sum += buf[i];
    return sum;
}

static int distinct(void) {
    /* Two allocas in the same frame must return non-overlapping
     * memory. Writing the marker through one pointer mustn't
     * disturb the other. */
    char *a = (char *)alloca(16);
    char *b = (char *)alloca(16);
    if (a == b) return 1;
    memset(a, 'A', 16);
    memset(b, 'B', 16);
    /* Check both ends of each block for accidental overlap. */
    if (a[0] != 'A' || a[15] != 'A') return 2;
    if (b[0] != 'B' || b[15] != 'B') return 3;
    return 0;
}

static int looped(int rounds) {
    /* Each iteration moves the stack pointer another 16 bytes
     * down; the storage is freed only at function return. */
    int sum = 0;
    int i;
    for (i = 0; i < rounds; i++) {
        long long *p = (long long *)alloca(sizeof(long long));
        *p = (long long)i;
        sum += (int)*p;
    }
    return sum;
}

/* Nested alloca: inner's allocations are freed when inner returns,
 * so outer's alloca'd memory is unaffected. */
static int inner_alloca_disturbs_outer(int marker) {
    char *outer = (char *)alloca(64);
    memset(outer, marker, 64);
    int inner_sum = looped(20);
    /* outer must still contain the marker. inner's frame teardown
     * mustn't have clobbered outer's data. */
    int i;
    for (i = 0; i < 64; i++) {
        if (outer[i] != (char)marker) return -1;
    }
    /* looped(20) sums 0..19 = 190 */
    if (inner_sum != 190) return -2;
    return 0;
}

int main(void) {
    if (single() != 0) {
        printf("FAIL single\n");
        return 1;
    }
    /* sum_{i=0}^{n-1} (7*i - 3) for n=10: 7*(0+1+...+9) - 30 = 315 - 30 = 285 */
    if (dynamic(10) != 285) {
        printf("FAIL dynamic: %d\n", dynamic(10));
        return 2;
    }
    if (distinct() != 0) {
        printf("FAIL distinct\n");
        return 3;
    }
    if (looped(50) != 1225) { /* sum 0..49 */
        printf("FAIL looped: %d\n", looped(50));
        return 4;
    }
    if (inner_alloca_disturbs_outer(0x33) != 0) {
        printf("FAIL nested\n");
        return 5;
    }
    return 0;
}
