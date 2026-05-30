// Exercises the VaStart + VaCopy emit shapes where the
// allocator places `&last` (VaStart) or `&src` / `&dst`
// (VaCopy) on r10. Prior to the SCRATCH_R10 -> r13 migration,
// the staging mov collapsed source and scratch into one
// register, lost the operand, and surfaced as either a
// SIGSEGV through a nulled cursor or a wrong-value walk
// through unrelated stack memory.
//
// The fixture is composed so the allocator is likely to place
// `&ap` and `&last` on register-pressured caller-saved regs
// (rcx / rdx / r10) by interleaving int arithmetic right after
// va_start / va_copy.
//
// Exit 0 on success. Any other exit code identifies the
// failing check.

#include <stdarg.h>
#include <stdio.h>

static long va_start_then_two_args(int n, ...) {
    va_list ap;
    va_start(ap, n);
    long a = va_arg(ap, long);
    long b = va_arg(ap, long);
    va_end(ap);
    return a + b * 1000;
}

static long copy_then_walk_twice(int n, ...) {
    va_list ap;
    va_list bp;
    va_start(ap, n);
    va_copy(bp, ap);
    long via_ap = va_arg(ap, long);
    long via_bp = va_arg(bp, long);
    va_end(ap);
    va_end(bp);
    return via_ap * 17 + via_bp;
}

int main(void) {
    long r1 = va_start_then_two_args(2, 11L, 22L);
    if (r1 != 11L + 22L * 1000) {
        printf("FAIL va_start_then_two_args: %ld\n", r1);
        return 1;
    }
    long r2 = copy_then_walk_twice(1, 7L);
    if (r2 != 7L * 17 + 7L) {
        printf("FAIL copy_then_walk_twice: %ld\n", r2);
        return 2;
    }
    return 0;
}
