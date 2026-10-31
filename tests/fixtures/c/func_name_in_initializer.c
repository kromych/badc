// C99 6.4.2.2: __func__ names the enclosing function as an implicit
// `static const char[]`. It must resolve to those bytes wherever the
// identifier appears -- including inside an initializer, where the array
// decays to a pointer -- not only in a bare expression. A scalar initializer
// element that is an undeclared identifier is otherwise taken as a
// forward-referenced function, which would bind __func__ to a code address.
struct nm { const char *f; int k; };

static int streq(const char *a, const char *b) {
    while (*a && *a == *b) { a++; b++; }
    return *a == *b;
}

static const char *direct(void)    { return __func__; }
static struct nm   compound(void)   { return (struct nm){ .f = __func__, .k = 1 }; }
static const char *local_aggr(void) { struct nm s = { .f = __func__ }; return s.f; }

// A static initializer takes it inside a constant expression too, as the
// address constant the array decays to (C99 6.6p9): a `?:` arm, an offset,
// an element's address.
struct pi { const char *fmt, *rest, *third; };
static const struct pi *in_const(void) {
    static const struct pi e = { .fmt = 1 ? __func__ : (void *)0,
                                 .rest = __func__ + 1, .third = &__func__[2] };
    return &e;
}

int main(void) {
    if (!streq(direct(), "direct"))         return 1;
    if (!streq(compound().f, "compound"))   return 2;
    if (!streq(local_aggr(), "local_aggr")) return 3;
    const struct pi *p = in_const();
    if (!streq(p->fmt, "in_const") || p->rest != p->fmt + 1 || !streq(p->third, "_const")) return 4;
    return 0;
}
