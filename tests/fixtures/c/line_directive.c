// The `#line` directive retargets `__LINE__`, its operand is
// macro-expanded (C99 6.10.4), and `__LINE__` is available in a `#if`
// condition.

#define LN 4000
#line LN
#if __LINE__ != 4000
#error "#line with a macro operand did not set __LINE__"
#endif

int main(void) {
    if (__LINE__ != 4005) return 1;
#line 100
    if (__LINE__ != 100) return 2;
    if (__LINE__ != 101) return 3;
    return 0;
}
