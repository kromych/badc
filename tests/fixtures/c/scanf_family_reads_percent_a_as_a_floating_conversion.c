// C99 7.19.6.2: in a scanf format `%as` is the floating conversion %a and
// then a literal `s`; sscanf, fscanf, vsscanf and vfscanf read it alike.
// glibc's pre-C99 scanners, which its <stdio.h> leaves to GNU C89, take
// `%as` as an allocating string conversion and store a pointer instead, so
// each target object has room for one.

#include <stdarg.h>
#include <stdio.h>

typedef union {
    float f;
    char *p;
} slot;

static int scan_string(const char *s, const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int r = vsscanf(s, fmt, ap);
    va_end(ap);
    return r;
}

static int scan_file(FILE *f, const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int r = vfscanf(f, fmt, ap);
    va_end(ap);
    return r;
}

int main(void) {
    slot a = {0}, b = {0}, c = {0}, d = {0};
    int n = 0;
    FILE *t = tmpfile();
    if (sscanf("1.5s 7", "%as %d", &a.f, &n) != 2 || a.f != 1.5f || n != 7)
        return 1;
    if (scan_string("0x1p-2s", "%as", &b.f) != 1 || b.f != 0.25f)
        return 2;
    if (!t || fputs("2.5s -8s", t) < 0)
        return 3;
    rewind(t);
    if (fscanf(t, "%as", &c.f) != 1 || c.f != 2.5f)
        return 4;
    if (scan_file(t, " %as", &d.f) != 1 || d.f != -8.0f)
        return 5;
    fclose(t);
    return 0;
}
