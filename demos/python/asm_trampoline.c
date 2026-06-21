// badc replacement for CPython's hand-written Python/asm_trampoline.S.
//
// perf_trampoline.c copies the bytes between _Py_trampoline_func_start and
// _Py_trampoline_func_end into a per-code-object arena so the Linux perf
// profiler attributes each compiled Python frame to a distinct address.
// The template is therefore copied and run from a new location, so it must
// be position-independent. A plain C trampoline that forwards its first
// three arguments to the function pointer in the fourth compiles to exactly
// that under badc -- frame-pointer-relative addressing plus an indirect
// call, no RIP-relative or PLT reference -- on both x86_64 and aarch64.
//
// `_Py_trampoline_func_end` is an empty function placed immediately after
// the trampoline so `&_Py_trampoline_func_end - &_Py_trampoline_func_start`
// is the template's byte length.

typedef void *(*py_evaluator)(void *ts, void *frame, int throwflag);

void *_Py_trampoline_func_start(void *ts, void *frame, int throwflag,
                                py_evaluator evaluator) {
    return evaluator(ts, frame, throwflag);
}

void _Py_trampoline_func_end(void) {}
