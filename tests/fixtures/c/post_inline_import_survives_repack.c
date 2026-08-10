// A library import whose only source reference sits in a static helper
// that dies once inlined: the inlined body still names the import, so it
// must stay resolved after the helper is gone. The orphaned ops table
// forces the post-inline `.data` recompaction, which is the path that
// rebuilds the import table -- without the reference the emit has no
// import to point the address-of at.
#include <stdio.h>
#include <string.h>

struct dev;
struct dev_ops {
    long long (*read)(struct dev *);
};

static long long ops_read(struct dev *d) {
    (void)d;
    return (long long)sizeof("only the dead table's literal");
}
static const struct dev_ops dead_ops = { ops_read };

// `measure` takes the import's address; `span` is its only caller and
// inlines it, so `measure` itself is dropped.
static unsigned long apply(const char *s, unsigned long (*fn)(const char *)) {
    return fn(s);
}
static unsigned long measure(const char *s) { return apply(s, strlen); }

static struct dev *alloc_dev(void *priv, const struct dev_ops *ops) {
    (void)ops;
    return (struct dev *)priv;
}

static const char text[] = "kept";

int main(void) {
    char marker;
    if (measure(text) != 4) return 1;
    if (measure("") != 0) return 2;
    if (alloc_dev(&marker, &dead_ops) != (struct dev *)&marker) return 3;
    if (text[0] != 'k' || text[4] != '\0') return 4;
    printf("ok len=%lu text=%s\n", measure(text), text);
    return 0;
}
