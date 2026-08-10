// C23 6.10.5.2 __VA_OPT__ in a static initializer: a variadic macro that
// terminates a pointer list, emitting the separating comma only when the
// caller supplied entries. gcc accepts the construct in every language mode.

#define ENTRY(_name, ...)                                                      \
    {                                                                          \
        .name = _name, .items = { __VA_ARGS__ __VA_OPT__(, ) 0 }                \
    }

struct table {
    const char *name;
    const char *items[4];
};

static const struct table empty = ENTRY("empty");
static const struct table one = ENTRY("one", "a");
static const struct table two = ENTRY("two", "a", "b");

static int count(const struct table *t) {
    int n = 0;
    while (t->items[n]) {
        n++;
    }
    return n;
}

static int slen(const char *s) {
    int n = 0;
    while (s[n]) {
        n++;
    }
    return n;
}

int main(void) {
    if (count(&empty) != 0 || count(&one) != 1 || count(&two) != 2) {
        return 1;
    }
    if (one.items[0][0] != 'a' || two.items[1][0] != 'b') {
        return 2;
    }
    // The name argument is a fixed parameter, so it is unaffected.
    return 39 + slen(empty.name) - 2; // 39 + 5 - 2 = 42
}
