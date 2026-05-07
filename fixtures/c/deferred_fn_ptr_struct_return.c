// DEFERRED (#60): `(**fp)(args)` where `fp` is a function-pointer
// variable whose declared return type is a struct pointer ends
// up with the wrong type-tracking state on the postfix `(`
// indirect-call site. C's function-pointer-decay rule says the
// second `*` is a no-op, so the chain should bottom out with the
// function pointer in `a`; the dialect emits an extra load
// through the function code, leaving garbage as the call target
// and SIGBUSing on Jsri.
//
// The companion `fn_ptr_explicit_deref.c` covers the same
// `(**fp)(args)` shape against a function pointer whose return
// type is `int`. Only the struct-pointer return form crashes:
// the difference is c5 collapses the function-pointer level into
// the return type's pointer level, and a struct base type lets
// `is_pointer_ty` still report "true" after the over-deref --
// which short-circuits the conservative pop in the postfix `(`
// handler that otherwise rescues the int-return case. Fixing
// this properly requires an explicit "this is a function
// pointer" tag in the type encoding (or a function-typed `Ty`
// variant), which is bigger than this iteration.
//
// sqlite's `(**(finder_type*)pVfs->pAppData)(zFilename, pNew)`
// inside `unixOpen` is the in-the-wild user; it's currently
// patched in the local sqlite3.c with a temp-variable workaround
// (see comment around line 46270). Once this lands, restore the
// original sqlite3 source and the smoke test stays green
// without the workaround.
#include <stdlib.h>

struct iom { int x; };

typedef const struct iom *(*fn_t)(int);

static const struct iom g = { 42 };

static const struct iom *finder_impl(int x) { return &g; }

static fn_t the_fn = finder_impl;

int main(void) {
    // Direct call works.
    if (the_fn(0) == 0) return 1;

    // Single-deref-via-ptr-to-fp also works.
    fn_t *pp = &the_fn;
    if ((*pp)(0) == 0) return 2;

    // The double-deref form is the one that crashes today.
    if ((**pp)(0) == 0) return 3;
    return 0;
}
