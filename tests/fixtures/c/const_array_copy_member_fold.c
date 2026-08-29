/* Member loads at constant offsets from copies of a const-initialized
   static array fold to the initializer bytes at -O; copies from a
   mutable array, a written-through copy, and a variable index must keep
   loading. Exit code is the count of value mismatches. */
struct pf {
    unsigned char startbit;
    unsigned char endbit;
    unsigned char offset;
    unsigned char size;
};

static const struct pf fields[] = {
    { 63, 61, 0, 1 },
    { 60, 52, 1, 2 },
    { 51, 28, 3, 4 },
};

static struct pf mut_fields[] = {
    { 7, 5, 0, 1 },
    { 4, 0, 1, 2 },
};

static int fail;

static void check(int cond)
{
    if (!cond)
        ++fail;
}

static void check_field(const struct pf *arr, int idx, int sb, int eb, int off, int sz)
{
    typeof(arr[0]) f = arr[idx];
    check(f.startbit == sb);
    check(f.endbit == eb);
    check(f.offset == off);
    check(f.size == sz);
}

int main(void)
{
    struct pf a = fields[0];
    check(a.startbit == 63 && a.endbit == 61 && a.size == 1);

    /* Two successive do-while blocks: the tracked copy must survive the
       join after the first one's branch. */
    do {
        struct pf b = fields[1];
        check(b.startbit == 60 && b.endbit == 52);
    } while (0);
    do {
        struct pf c = fields[1];
        check(c.size == 2 && c.offset == 1);
    } while (0);

    /* A pointer that provably holds the array's address, per-index. */
    do {
        typeof(&(fields)[0]) _f = (fields);
        typeof(_f[0]) __f = _f[0];
        check(__f.startbit == 63 && __f.size == 1);
    } while (0);
    do {
        typeof(&(fields)[0]) _f = (fields);
        typeof(_f[0]) __f = _f[2];
        check(__f.startbit == 51 && __f.endbit == 28 && __f.offset == 3 && __f.size == 4);
    } while (0);

    /* A mutable array: the store must be visible in the copy. */
    mut_fields[1].size = 8;
    do {
        struct pf m = mut_fields[1];
        check(m.startbit == 4 && m.endbit == 0 && m.offset == 1 && m.size == 8);
    } while (0);

    /* A written-through copy: the write wins over the template. */
    do {
        struct pf w = fields[2];
        w.size = 16;
        check(w.startbit == 51 && w.size == 16);
    } while (0);

    /* A variable index keeps loading. */
    do {
        volatile int i = 1;
        struct pf v = fields[i];
        check(v.startbit == 60 && v.offset == 1);
    } while (0);

    /* An inlined helper covers the runtime path for both arrays. */
    check_field(fields, 1, 60, 52, 1, 2);
    check_field(mut_fields, 0, 7, 5, 0, 1);

    return fail;
}
