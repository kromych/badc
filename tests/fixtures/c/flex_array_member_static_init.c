// A flexible array member (C99 6.7.2.1) carries no storage in the
// struct size, but a file-scope object may still be initialized with
// trailing elements for it. C99 6.7.2.1p18 forbids initializing a FAM;
// GCC and clang accept it for a top-level object and lay the object out
// as if the member were a fixed array sized to the initializer. badc
// reserves only the fixed struct size up front, so the trailing element
// bytes must extend the data segment without overwriting the next
// file-scope object.

struct keys {
    long refcnt;
    unsigned char log2_size;
    int version;
    long nentries;
    char indices[];
};

static struct keys empty = {
    9,                                /* refcnt */
    0,                                /* log2_size */
    1,                                /* version */
    0,                                /* nentries */
    { -1, -1, -2, -2, 5, 6, 7, 8 },   /* indices: flexible array member */
};

struct msg {
    int len;
    char text[];
};

static struct msg greeting = { 5, "hello" };

// A global laid out after the FAM objects must keep its own value; the
// FAM tail growth must not spill into it.
int sentinel = 0x12345678;

// A pointer field before the FAM is the harder case: the string literal
// it points at is appended right where the member's data lands unless
// the reservation accounts for the member up front. Also exercises a
// self-referential initializer and a member of structs with their own
// string fields.
struct desc {
    const char *n;
    int t;
    const char *help;
};
struct list {
    const char *name;
    const char *implied;
    int merge;
    struct {
        void *first;
        void **last;
    } head;
    struct desc items[];
};
static struct list cfg = {
    .name = "cfg",
    .implied = "type",
    .merge = 1,
    .head = { 0, &cfg.head.first },
    .items = {
        { .n = "id",   .t = 1, .help = "identifier" },
        { .n = "path", .t = 2, .help = "file path" },
        { /* end */ },
    },
};

// The same collision reached positionally rather than through a
// designator: the member initializer is the last brace-enclosed item,
// and the pointer field before it must still read back its own literal.
struct pos {
    const char *tag;
    int k;
    struct desc items[];
};
static struct pos p2 = {
    "pos",
    7,
    { { "a", 1, "aye" }, { "b", 2, "bee" } },
};

static int streq(const char *a, const char *b) {
    while (*a && *a == *b) { a++; b++; }
    return *a == *b;
}

int main(void) {
    if (empty.refcnt != 9) return 1;
    if (empty.version != 1) return 2;
    char expect[8] = { -1, -1, -2, -2, 5, 6, 7, 8 };
    for (int i = 0; i < 8; i++) {
        if (empty.indices[i] != expect[i]) return 10 + i;
    }
    if (greeting.len != 5) return 20;
    const char *want = "hello";
    for (int i = 0; i < 6; i++) {
        if (greeting.text[i] != want[i]) return 30 + i;
    }
    if (sentinel != 0x12345678) return 40;

    if (cfg.name == 0 || !streq(cfg.name, "cfg")) return 50;
    if (cfg.implied == 0 || !streq(cfg.implied, "type")) return 51;
    if (cfg.merge != 1) return 52;
    if (cfg.head.last != &cfg.head.first) return 53;
    if (cfg.items[0].n == 0 || !streq(cfg.items[0].n, "id") || cfg.items[0].t != 1) return 54;
    if (cfg.items[0].help == 0 || !streq(cfg.items[0].help, "identifier")) return 55;
    if (cfg.items[1].n == 0 || !streq(cfg.items[1].n, "path") || cfg.items[1].t != 2) return 56;
    if (cfg.items[1].help == 0 || !streq(cfg.items[1].help, "file path")) return 57;
    if (cfg.items[2].n != 0) return 58;

    if (p2.tag == 0 || !streq(p2.tag, "pos")) return 60;
    if (p2.k != 7) return 61;
    if (p2.items[0].n == 0 || !streq(p2.items[0].n, "a") || p2.items[0].t != 1) return 62;
    if (p2.items[0].help == 0 || !streq(p2.items[0].help, "aye")) return 63;
    if (p2.items[1].n == 0 || !streq(p2.items[1].n, "b") || p2.items[1].t != 2) return 64;
    if (p2.items[1].help == 0 || !streq(p2.items[1].help, "bee")) return 65;
    return 0;
}
