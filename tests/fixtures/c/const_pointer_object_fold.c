// A const-qualified pointer object with static storage duration holds
// its initializer's address for the whole execution (C99 6.7.3p5), so
// at -O a load from it is the address constant itself and the object
// is not emitted; an object whose address is taken stays. Every value
// is checked at run time.

static const char *const file_scope = "file scope";
static const char *const escaped = "escaped";
// A writable pointer to `escaped`: its load is not folded, so the read
// through it goes to the object, which must therefore stay.
const char *const *through = &escaped;
static const int table[4] = {10, 20, 30, 40};
// Sits right after `table`, so `&table[4]` coincides with its start; it
// is unreferenced and the data compaction drops it.
static const char unreferenced[] = "dropped by the data compaction";
static const int *const table_mid = &table[2];
static const int *const table_end = &table[4];
static const struct {
    const char *name;
    int n;
} agg = {"aggregate", 7};

extern int later[4];
static int *const later_two = &later[2];
int later[4] = {1, 2, 3, 4};

static int twice(int v) { return v * 2; }
static int (*const op)(int) = twice;

static int streq(const char *a, const char *b) {
    while (*a && *a == *b) {
        a++;
        b++;
    }
    return *a == *b;
}

static const char *pick(int k) {
    static const char *const block_scope = "block scope";
    switch (k) {
    case 1:
        return file_scope;
    case 2:
        return block_scope;
    case 3:
        return file_scope + 5;
    case 4:
        return block_scope + 6;
    default:
        return block_scope;
    }
}

int main(void) {
    if (!streq(pick(1), "file scope"))
        return 1;
    if (!streq(pick(2), "block scope"))
        return 2;
    if (!streq(pick(3), "scope"))
        return 3;
    if (!streq(pick(4), "scope"))
        return 4;
    if (!streq(pick(9), "block scope"))
        return 5;
    if (!streq(*through, "escaped"))
        return 6;
    if (*table_mid != 30)
        return 7;
    if (table_end - table != 4 || table_end[-1] != 40)
        return 8;
    if (!streq(agg.name, "aggregate") || agg.n != 7)
        return 9;
    if (*later_two != 3)
        return 10;
    if (op(21) != 42)
        return 11;
    return 0;
}
