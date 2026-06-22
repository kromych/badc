// Locks C99 6.5.2.2: a variadic call through a function pointer whose
// prototype is not recoverable from a bare identifier symbol -- a
// struct/union field, an array element, or a dereferenced pointer --
// must still split the argument list at the fixed (pre-ellipsis)
// parameter count so the host variadic ABI places the variadic tail
// where the callee's va_arg walks it. The macOS/AAPCS64 Darwin variant
// passes the tail on the stack, so a mis-recovered prototype routed the
// tail through registers and the callee read garbage.
//
// Each invocation shape carries a distinct integer per slot and returns
// a distinct nonzero code on mismatch so the fixture runs under the VM
// without a libc shim.
#include <stdarg.h>

static int vsum(int n, ...) {
    va_list ap;
    va_start(ap, n);
    long s = 0;
    for (int k = 0; k < n; k++) {
        s += va_arg(ap, int);
    }
    va_end(ap);
    return (int)s;
}

typedef int (*vfp)(int, ...);

struct holder {
    vfp cb;
};

// struct field (Expr::Member callee)
static int via_field(struct holder *h) {
    return h->cb(4, 100, 200, 300, 400);
}

// array element (Expr::Index callee)
static int via_array(vfp *a) {
    return a[0](3, 11, 22, 33);
}

// inline (non-typedef) function-pointer field
struct inline_holder {
    int (*cb)(int, ...);
};
static int via_inline_field(struct inline_holder *h) {
    return h->cb(2, 40, 60);
}

int main(void) {
    struct holder h;
    h.cb = vsum;
    vfp arr[1];
    arr[0] = vsum;
    struct inline_holder ih;
    ih.cb = vsum;

    if (via_field(&h) != 1000) return 1;
    if (via_array(arr) != 66) return 2;
    if (via_inline_field(&ih) != 100) return 3;
    return 0;
}
