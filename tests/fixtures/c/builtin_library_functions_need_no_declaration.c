// gcc and clang give each `__builtin_` library function its prototype with
// no declaration in scope, so the unit includes no header. The absolute
// values and the functions a header binds to an instruction lower inline;
// the rest call the library function, the arguments converted to the
// prototype's parameters (C99 6.5.2.2p7): an `unsigned` count to `size_t`.

typedef __SIZE_TYPE__ size_t;
typedef __builtin_va_list va_list;

static int format(char *buf, size_t n, const char *fmt, ...) {
    va_list ap;
    __builtin_va_start(ap, fmt);
    int r = __builtin_vsnprintf(buf, n, fmt, ap);
    __builtin_va_end(ap);
    return r;
}

int main(void) {
    volatile int i = -7;
    volatile long l = -8;
    volatile long long q = -9;
    volatile double d = -2.5;
    volatile float f = -1.5f;
    volatile long double ld = -3.25L;
    if (__builtin_abs(i) != 7 || __builtin_labs(l) != 8 || __builtin_llabs(q) != 9)
        return 1;
    if (__builtin_imaxabs(q) != 9 || __builtin_abs(-i) != 7)
        return 2;
    if (__builtin_fabs(d) != 2.5 || __builtin_fabsf(f) != 1.5f || __builtin_fabsl(ld) != 3.25L)
        return 3;
    if (sizeof(__builtin_fabsl(ld)) != sizeof(long double) || sizeof(__builtin_fabsf(f)) != 4)
        return 4;
    if (__builtin_sqrt(d * d) != 2.5 || __builtin_floor(d) != -3.0 || __builtin_ceilf(f) != -1.0f)
        return 5;
    char buf[32];
    volatile size_t n = 6;
    volatile unsigned m = 3;
    __builtin_memset(buf, 'x', n);
    __builtin_memcpy(buf, "hello", n);
    if (__builtin_strlen(buf) != 5 || __builtin_strcmp(buf, "hello") != 0)
        return 6;
    if (__builtin_memcmp(buf, "help", m) != 0 || __builtin_strchr(buf, 'l') != buf + 2)
        return 7;
    if (__builtin_strncmp("abcx", "abcy", m) != 0 || __builtin_strncmp("abx", "aby", m) == 0)
        return 8;
    if (format(buf, sizeof buf, "%d-%s-%.1f", 42, "ab", 0.5) != 9)
        return 9;
    if (__builtin_strcmp(buf, "42-ab-0.5") != 0)
        return 10;
    char *p = __builtin_malloc(n);
    if (!p)
        return 11;
    __builtin_memmove(p, buf, n);
    int same = __builtin_memcmp(p, "42-ab-", n) == 0;
    __builtin_free(p);
    return same ? 0 : 12;
}
