// The `__builtin_` spelling of a library function is the function, as in
// gcc and clang: each call below binds to it with its declaration although
// no header is included, so arguments convert to the parameter types and a
// pointer result keeps its width. A macro of the library name does not
// capture the builtin. The builtins gcc provides and clang does not are
// guarded by `__has_builtin`. Returns 0, distinct non-zero per failure.

#define strdup(s) 0

static int format(char *out, __SIZE_TYPE__ n, const char *f, ...) {
    __builtin_va_list ap;
    int r;
    __builtin_va_start(ap, f);
    r = __builtin_vsnprintf(out, n, f, ap);
    __builtin_va_end(ap);
    return r;
}

int main(void) {
    char buf[32];
    char *d;
    if (__builtin_snprintf(buf, sizeof buf, "%d-%s", 42, "x") != 4) return 1;
    if (__builtin_strcmp(buf, "42-x") != 0) return 2;
    if (__builtin_sprintf(buf, "%.1f", __builtin_sqrt(16)) != 3) return 3;
    if (__builtin_strcmp(buf, "4.0") != 0) return 4;
    if (__builtin_fabs(-2.5) != 2.5 || __builtin_floor(2.5) != 2.0) return 5;
    if (__builtin_pow(2, 10) != 1024.0 || __builtin_fmax(1, 3) != 3.0) return 6;
    if (__builtin_copysign(2, -1.0) != -2.0 || __builtin_fdim(5, 3) != 2.0) return 7;
    d = __builtin_strdup("dup");
    if (!d || __builtin_strlen(d) != 3 || __builtin_strcasecmp(d, "DUP") != 0) return 8;
    __builtin_free(d);
    if (format(buf, sizeof buf, "%s%d", "v", 7) != 2 || __builtin_strcmp(buf, "v7") != 0) return 9;
#if __has_builtin(__builtin_toupper)
    if (__builtin_toupper('a') != 'A' || !__builtin_isdigit('7')) return 10;
#endif
#if __has_builtin(__builtin_puts)
    if (__builtin_puts("puts") < 0) return 11;
#endif
#if __has_builtin(__builtin_isdigit)
    if (__builtin_isdigit(-1) || __builtin_isdigit('a') || __builtin_isdigit('0') != 1) return 12;
#endif
    if (__builtin_printf("%s\n", "printf") != 7) return 13;
    return 0;
}
