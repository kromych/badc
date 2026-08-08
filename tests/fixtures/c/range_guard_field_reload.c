// A dominating unsigned guard on a struct field bounds what every later
// reload of the field produces while nothing writes memory in between.
// The build-time assert's operand -- the kernel's min(unsigned, signed)
// type check spelled the way fs/fuse/dev.c reaches it -- has a
// translation-time answer only through that bound: the record is filled
// through a call the compiler cannot see through, so no constant ever
// reaches the guard. `compiletime_assert_675` is declared and never
// defined, so linking is the assertion. gcc 16 links this at -O2
// (value-range propagation) and fails to at -O0.

typedef long long loff_t;
typedef unsigned long long u64;
typedef unsigned int u32;

#define MAX_LFS_FILESIZE 0x7fffffffffffffffLL

struct notify_out {
    u64 nodeid;
    u64 offset;
    u32 size;
    u32 padding;
};

extern void compiletime_assert_675(void);

volatile u64 in_off;
volatile u32 in_size;

static void fill(struct notify_out *o) {
    o->nodeid = 1;
    o->offset = in_off;
    o->size = in_size;
    o->padding = 0;
}

// Reached only through a volatile pointer, so the store side stays out
// of sight of the caller the way a copy_from_user-style filler does.
static void (*volatile fill_p)(struct notify_out *) = fill;

static int notify_store(void) {
    struct notify_out outarg;
    loff_t pos;
    u32 num;

    fill_p(&outarg);
    if (outarg.offset >= (u64)MAX_LFS_FILESIZE)
        return -22;
    pos = outarg.offset;
    {
        // min(u32, s64) as the kernel's minmax.h checks it: the mixed
        // signedness is accepted only when the signed side is provably
        // non-negative at translation time.
        u32 ux = outarg.size;
        loff_t uy = MAX_LFS_FILESIZE - pos;
        if (!(__builtin_constant_p(uy >= 0) && (uy >= 0)))
            compiletime_assert_675();
        num = (u64)ux < (u64)uy ? ux : (u32)uy;
    }
    return (int)num;
}

int main(void) {
    in_off = 100;
    in_size = 7;
    if (notify_store() != 7)
        return 1;
    in_off = (u64)MAX_LFS_FILESIZE - 3;
    in_size = 9;
    if (notify_store() != 3)
        return 2;
    in_off = (u64)MAX_LFS_FILESIZE + 5;
    if (notify_store() != -22)
        return 3;
    return 0;
}
