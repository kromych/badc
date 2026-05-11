// Regression for the C99 6.7.7 typedef of a function type:
//
//   typedef RET NAME(args);
//
// This is the *function*-type alias (vs. the more common
// function-pointer-type alias `typedef RET (*NAME)(args)`).
// Both spellings are legal C99 and resolve to the same callable
// at use sites: `NAME cb` declares cb with function type, which
// decays to a function pointer in expression position per
// C99 6.3.2.1p4; `NAME *cb` is already a function pointer.
// c5 used to stop at the identifier and treat the `(args)` as
// a syntax error on the next iteration -- so the whole typedef
// line rejected with "identifier expected in declaration".
//
// c5 models the typedef as a function-pointer alias (fpi=1)
// because every real use site reads it as a callable.

typedef int CB(int x, int y);

static int add(int a, int b) { return a + b; }
static int sub(int a, int b) { return a - b; }

// Function-pointer-style usage: `CB *cb` is "pointer to function
// returning int taking (int, int)".
static int call_via_ptr(CB *cb, int a, int b) {
    return cb(a, b);
}

// Bare-function-typedef parameter: `CB cb` declares cb as a
// function (which decays to a function pointer at the call site).
// Same effective shape as `CB *cb` from the caller's perspective.
static int call_via_decay(CB cb, int a, int b) {
    return cb(a, b);
}

int main(void) {
    if (call_via_ptr(add, 3, 4) != 7) return 1;
    if (call_via_ptr(sub, 10, 4) != 6) return 2;
    if (call_via_decay(add, 5, 6) != 11) return 3;
    if (call_via_decay(sub, 20, 8) != 12) return 4;
    return 0;
}
