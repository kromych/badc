// `(*fp)(args)` and `(**fp)(args)` shapes against a function
// pointer whose declared return type is itself a pointer (a
// struct pointer here). C 6.3.2.1 / 6.3.4 say any number of `*`s
// applied to a function pointer rvalue decay back to the same
// function pointer; the call site has to see the fn-ptr value
// in the accumulator regardless of how many `*`s the source
// stacked on top.
//
// Pre-fix the dialect collapsed the function-pointer level into
// the return-type's pointer level and emitted a real `Op::Li`
// for each `*`, so a function with a non-pointer return type
// (`int`-returning, covered by fn_ptr_explicit_deref.c) would
// drop to a non-pointer ty and the call-site fallback caught
// the over-deref, but a struct-pointer-returning function left
// the chain as "still a pointer" and the over-deref slipped
// through. The Symbol::fn_ptr_indirection / Compiler::
// fn_ptr_chain_depth side-channel now propagates the fn-ptr
// lineage through identifier loads, casts, and `*` / `&`, so
// the unary `*` handler suppresses the spurious load.
//
// In the wild this fires on an SQL engine's
// `(**(finder_type*)pVfs->pAppData)(zFilename, pNew)` inside
// unixOpen -- vfp's return type is `const sqlite3_io_methods *`,
// the same struct-pointer-return pattern the fixture pins.
#include <stdlib.h>

struct iom { int x; };

typedef const struct iom *(*fn_t)(int);

static const struct iom g = { 42 };

static const struct iom *finder_impl(int x) { return &g; }

static fn_t the_fn = finder_impl;

int main(void) {
    // Direct call.
    if (the_fn(0) == 0) return 1;

    // Single-deref through ptr-to-fn-ptr (`*pp` is a real load
    // through pp, not decay).
    fn_t *pp = &the_fn;
    if ((*pp)(0) == 0) return 2;

    // Double-deref through ptr-to-fn-ptr: the second `*` is C
    // function-pointer decay, a no-op.
    if ((**pp)(0) == 0) return 3;

    // Single-deref through a fn-ptr lvalue: also decay (because
    // `(*fp)` on a fn pointer is the fn pointer again).
    fn_t fp = finder_impl;
    if ((*fp)(0) == 0) return 4;

    // Double-deref through a fn-ptr lvalue: still the fn ptr.
    if ((**fp)(0) == 0) return 5;

    // Cast-through-finder-shape: an SQL engine's exact pattern. Take a
    // void pointer that *actually* points at a fn_t variable,
    // cast to `fn_t *`, then `**` to call.
    void *opaque = &the_fn;
    if ((**(fn_t *)opaque)(0) == 0) return 6;

    return 0;
}
