// C99 6.10.8: the predefined macros are macros, so `defined` and
// `#ifdef` report them even though their replacement comes from
// context rather than from the macro table. `__COUNTER__` in
// particular is probed this way before use.
//
// `__BASE_FILE__` names the main input file, which is this file at
// top level; it differs from `__FILE__` only inside an include, so
// the value comparison here is the equality case.

#ifndef __FILE__
#error "__FILE__ must be defined"
#endif
#ifndef __LINE__
#error "__LINE__ must be defined"
#endif
#ifndef __COUNTER__
#error "__COUNTER__ must be defined"
#endif
#ifndef __BASE_FILE__
#error "__BASE_FILE__ must be defined"
#endif

#if !defined(__FILE__) || !defined(__BASE_FILE__)
#error "the `defined` operator must agree with #ifdef"
#endif

// A name that is not a macro stays undefined, so the predicate above
// is not simply answering true.
#ifdef __surely_not_a_predefined_macro__
#error "an unknown name must not report as defined"
#endif

static int str_eq(const char *a, const char *b) {
    while (*a && *a == *b) {
        a++;
        b++;
    }
    return *a == *b;
}

int main(void) {
    // Both expand to string literals, equal at top level.
    if (!str_eq(__BASE_FILE__, __FILE__))
        return 1;
    if (__BASE_FILE__[0] == '\0')
        return 2;
    // Each use of the counter yields the next value.
    int first = __COUNTER__;
    int second = __COUNTER__;
    if (second != first + 1)
        return 3;
    if (__LINE__ <= 0)
        return 4;
    return 0;
}
