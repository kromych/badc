// A dylib-bound (Token::Sys) function returning a struct by value. The C
// library's div returns div_t { int quot; int rem; } -- an 8-byte
// aggregate the platform ABI delivers in a return register. The walker
// tags the CallExt with ret_agg and the emitter gathers the result into
// the caller's temp; the slot-coalescing pass remaps ret_slot_local in
// lockstep with the matching LocalAddr. Exercises the external
// struct-return path end to end against the system C library.
#if defined(__APPLE__)
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::c_div, "_div")
#elif defined(_WIN32)
#pragma dylib(libc, "msvcrt.dll")
#pragma binding(libc::c_div, "div")
#else
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::c_div, "div")
#endif

typedef struct {
    int quot;
    int rem;
} cdiv_t;
cdiv_t c_div(int numer, int denom);

int main(void) {
    cdiv_t r = c_div(17, 5);
    // 17 / 5 = 3 remainder 2. Check order-independently so the result is
    // validated even where div_t's member order differs (C99 7.20.6.2
    // leaves it implementation-defined).
    if (r.quot + r.rem != 5) return 1;
    if (r.quot * r.rem != 6) return 2;
    cdiv_t r2 = c_div(100, 7);
    if (r2.quot + r2.rem != 16) return 3; // 14 + 2
    return 0;
}
