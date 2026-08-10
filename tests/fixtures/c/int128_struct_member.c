/* A 128-bit integer as a struct member: the type's 16-byte alignment
   decides the containing struct's member offsets and size, a brace
   initializer must spend one initializer on it rather than descending
   into its halves, and the member must survive a read / write through a
   pointer. Static, file-scope, and runtime initializer forms all carry
   the full 128 bits. Exit 0 on success; a distinct non-zero code per
   failing check. */

typedef unsigned long long u64;
typedef unsigned __int128 u128;

struct holder {
    int lead;
    u128 wide;
    int tail;
};

volatile u64 nine = 9;
volatile u64 four = 4;

/* File-scope and static initializers fold at compile time. */
struct holder g_holder = {1, ((u128)9 << 64) | 4, 2};
u128 g_scalar = ((u128)9 << 64) | 4;
u128 g_shifted = (u128)1 << 100;

static void bump(struct holder *p, u128 by) {
    p->wide = p->wide + by;
    p->lead++;
}

static u128 read_wide(const struct holder *p) { return p->wide; }

int main(void) {
    u128 expect = ((u128)nine << 64) | four;

    /* 16-byte alignment places the member at 16 and the trailing int at
       32, so the struct rounds up to 48. */
    if (sizeof(struct holder) != 48)
        return 1;
    if (__builtin_offsetof(struct holder, wide) != 16)
        return 2;
    if (__builtin_offsetof(struct holder, tail) != 32)
        return 3;
    if (sizeof(u128) != 16 || _Alignof(u128) != 16)
        return 4;

    /* File-scope initializers keep both halves and leave the siblings
       alone. */
    if (g_holder.lead != 1 || g_holder.tail != 2 || g_holder.wide != expect)
        return 5;
    if (g_scalar != expect)
        return 6;
    if (g_shifted != (u128)1 << 100 || (u64)(g_shifted >> 64) != (1ULL << 36))
        return 7;

    /* Block-scope initializer, constant and non-constant forms. */
    {
        struct holder s = {1, ((u128)9 << 64) | 4, 2};
        struct holder r = {1, expect, 2};
        if (s.lead != 1 || s.tail != 2 || s.wide != expect)
            return 8;
        if (r.lead != 1 || r.tail != 2 || r.wide != expect)
            return 9;
    }

    /* Member assignment, and read / write through a pointer. */
    {
        struct holder v = {1, expect, 2};
        bump(&v, ((u128)1 << 64) | 3);
        if (v.lead != 2 || v.tail != 2)
            return 10;
        if (read_wide(&v) != (((u128)10 << 64) | 7))
            return 11;
        v.wide = (u128)0;
        if (v.wide != 0 || v.lead != 2 || v.tail != 2)
            return 12;
        v.wide = expect;
        if (read_wide(&v) != expect)
            return 13;
    }

    /* An array of the type strides by 16 and initializes element-wise. */
    {
        u128 arr[3] = {1, expect, ((u128)1 << 127)};
        if (sizeof arr != 48)
            return 14;
        if (arr[0] != 1 || arr[1] != expect)
            return 15;
        if (arr[2] != ((u128)1 << 127) || (u64)arr[2] != 0)
            return 16;
    }
    return 0;
}
