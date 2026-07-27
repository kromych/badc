// C99 6.7.2.1p16: a flexible array member is not counted by `sizeof`,
// but a definition that initializes it occupies those element bytes, so
// the next object in the same storage starts past them. This must hold
// for objects placed in a named section by `section("name")` exactly as
// it does in the default section, at file scope and for a block-scope
// static. The second descriptor is reached only through a table in the
// same section, so a short carve puts the table over its elements.
// Matches GCC and clang on x86-64 and aarch64; returns 0, distinct
// non-zero per failure.

#define SEC __attribute__((section(".t.prel"), aligned(8)))

struct target {
    unsigned long v;
};

struct desc {
    char name[20];
    union {
        struct target *ptr;
        signed int off;
    } over;
    struct {
        char field[10];
        unsigned char shift;
    } regs[];
};

static struct target t1 = {11};
static struct target t2 = {22};

static const struct desc head SEC = {.name = "head", .over = {&t1}};
static const struct desc tail SEC = {.name = "tail",
                                     .over = {&t2},
                                     .regs = {{"aa", 1}, {"bb", 2}, {"cc", 3}}};
static const struct desc *const table[] SEC = {&head, &tail};

static int streq(const char *a, const char *b) {
    while (*a && *a == *b) {
        a++;
        b++;
    }
    return *a == *b;
}

const struct desc *pick(int i) { return table[i]; }

int main(void) {
    const struct desc *h = pick(0);
    const struct desc *t = pick(1);

    if (!streq(h->name, "head")) return 1;
    if (h->over.ptr != &t1 || h->over.ptr->v != 11) return 2;
    if (!streq(t->name, "tail")) return 3;
    if (t->over.ptr != &t2 || t->over.ptr->v != 22) return 4;

    // Every initialized element of the tail object's member reads back.
    if (!streq(t->regs[0].field, "aa") || t->regs[0].shift != 1) return 5;
    if (!streq(t->regs[1].field, "bb") || t->regs[1].shift != 2) return 6;
    if (!streq(t->regs[2].field, "cc") || t->regs[2].shift != 3) return 7;

    // The table follows the elements rather than overlapping them.
    {
        const char *end = (const char *)t + sizeof *t + 3 * sizeof t->regs[0];
        if ((const char *)table < end && (const char *)table >= (const char *)t)
            return 8;
    }
    if (sizeof *t != sizeof(struct desc)) return 9;

    // A block-scope static takes the same tail reservation: without it
    // the member's fill overwrites whatever follows in the data image.
    {
        static const struct desc local SEC = {
            .name = "local", .over = {&t1}, .regs = {{"xx", 7}, {"yy", 8}}};
        static const char after[] SEC = "after";
        if (!streq(local.name, "local")) return 10;
        if (local.over.ptr != &t1) return 11;
        if (!streq(local.regs[0].field, "xx") || local.regs[0].shift != 7)
            return 12;
        if (!streq(local.regs[1].field, "yy") || local.regs[1].shift != 8)
            return 13;
        if (!streq(after, "after")) return 14;
    }

    // The same shape in the default section keeps its spacing too.
    {
        static const struct desc plain_tail = {
            .name = "plain", .regs = {{"zz", 9}, {"ww", 4}}};
        static const char plain_after[] = "past";
        if (!streq(plain_tail.regs[0].field, "zz")) return 15;
        if (plain_tail.regs[1].shift != 4) return 16;
        if (!streq(plain_after, "past")) return 17;
    }
    return 0;
}
