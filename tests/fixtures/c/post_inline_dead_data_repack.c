// C99 6.2.2: a static object no reachable code references is
// unobservable. Inlining a stub that ignores its `ops` argument removes
// the last reference to the table passed to it, so the table -- and the
// functions its initializer names, and the literal only they used --
// drop out and `.data` is packed again. Every surviving object must land
// where its references say it does, so the checks below read through a
// pointer initializer, an interior array element, a string literal, an
// over-aligned object, and a zero-initialized (`.bss`) global.
#include <stdio.h>

struct dev;
struct dev_ops {
    long long (*read)(struct dev *);
    long long (*write)(struct dev *);
};

static long long ops_read(struct dev *d) {
    (void)d;
    return (long long)sizeof("only the dead table's literal");
}
static long long ops_write(struct dev *d) {
    (void)d;
    return (long long)sizeof("nor is this one reachable");
}

// Referenced only by the argument the stub below ignores.
static const struct dev_ops dead_ops = { ops_read, ops_write };

static const long long table[4] = { 10, 20, 30, 40 };
static const long long *const tail = &table[3];
static const char text[] = "kept";
static _Alignas(64) long long wide[2] = { 7, 9 };
static long long zeroed[4];

static struct dev *alloc_dev(void *priv, const struct dev_ops *ops) {
    (void)ops;
    return (struct dev *)priv;
}

int main(void) {
    void *marker = (void *)&table[0];
    if (alloc_dev(marker, &dead_ops) != (struct dev *)marker) return 1;
    if (tail != &table[3] || *tail != 40) return 2;
    if (table[0] != 10 || table[2] != 30) return 3;
    if (text[0] != 'k' || text[3] != 't' || text[4] != '\0') return 4;
    if (((unsigned long long)(void *)wide & 63u) != 0u) return 5;
    if (wide[0] != 7 || wide[1] != 9) return 6;
    zeroed[2] = table[1] + 5;
    if (zeroed[0] != 0 || zeroed[2] != 25 || zeroed[3] != 0) return 7;
    if ((const void *)text == (const void *)table) return 8;
    printf("ok tail=%lld text=%s wide=%lld zeroed=%lld\n",
           *tail, text, wide[1], zeroed[2]);
    return 0;
}
