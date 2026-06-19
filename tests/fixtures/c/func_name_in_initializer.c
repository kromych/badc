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

int main(void) {
    if (!streq(direct(), "direct"))         return 1;
    if (!streq(compound().f, "compound"))   return 2;
    if (!streq(local_aggr(), "local_aggr")) return 3;
    return 0;
}
