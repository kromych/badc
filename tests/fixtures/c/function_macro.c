// Locks the C99 6.4.2.2 predeclared identifier `__func__` and
// its GCC aliases `__FUNCTION__` / `__PRETTY_FUNCTION__`.
//
// The standard declares `__func__` as one `static const char[]`
// per function, so every reference in a function designates the
// same object and the identifier evaluates to a pointer to its
// NUL-terminated bytes. Aliases must agree byte-for-byte with
// `__func__` so the GCC-compatible form is interchangeable.
//
// Returns 0 only when every check passes; each failure path
// returns a distinct nonzero code.

static int string_eq(const char *a, const char *b) {
    while (*a && *a == *b) { a++; b++; }
    return *a == 0 && *b == 0;
}

static int helper_one(void) {
    const char *a = __func__;
    const char *b = __FUNCTION__;
    const char *c = __PRETTY_FUNCTION__;
    if (!string_eq(a, "helper_one")) return 21;
    if (!string_eq(b, "helper_one")) return 22;
    if (!string_eq(c, "helper_one")) return 23;
    if (!string_eq(a, b)) return 24;
    if (!string_eq(a, c)) return 25;
    return 0;
}

static int helper_two(void) {
    if (!string_eq(__func__, "helper_two")) return 31;
    // C99 6.4.2.2 declares one object per function, so both
    // references designate it and sizeof is the array's.
    if (__func__ != __func__) return 32;
    if (sizeof(__func__) != 11) return 33;
    return 0;
}

int main(void) {
    int rc = helper_one();
    if (rc != 0) return rc;
    rc = helper_two();
    if (rc != 0) return rc;
    // The name in main() must differ from the helpers'; this
    // catches a regression that returned the same fixed string
    // for every call site.
    if (!string_eq(__func__, "main")) return 41;
    return 0;
}
