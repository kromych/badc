// A complete but empty `struct {}` (a GCC extension) is accepted as a
// member and contributes zero storage and no alignment, so a following
// member shares its offset. This is the `__DECLARE_FLEX_ARRAY` idiom the
// Linux uapi headers use to place a flexible array inside a union. Each
// check returns a distinct non-zero code on failure; success returns 0.
// The MS layout of the PE targets (MSVC, clang's windows-msvc triples)
// gives the empty member 4 bytes instead, so what follows it moves by its
// size and alignment.

#if defined(_WIN32)
#define EMPTY 4
#define ENTRIES_AT 8
#else
#define EMPTY 0
#define ENTRIES_AT 0
#endif

#define __DECLARE_FLEX_ARRAY(T, N)                                             \
    struct {                                                                   \
        struct {                                                               \
        } __empty_##N;                                                         \
        T N[];                                                                 \
    }

struct with_pad {
    int n;
    struct {
    } pad;
    int m;
};

struct msg {
    int count;
    union {
        unsigned long long first;
        __DECLARE_FLEX_ARRAY(unsigned long long, entries);
    };
};

int main(void) {
    // The empty member contributes its size only: gcc places `m` right
    // after `n`.
    if (sizeof(struct with_pad) != 8 + EMPTY) {
        return 1;
    }
    struct with_pad w;
    w.n = 3;
    w.m = 7;
    if (w.n != 3 || w.m != 7) {
        return 2;
    }

    // gcc lays the flexible array over the union's first member.
    struct {
        struct msg m;
        unsigned long long tail[4];
    } buf;
    buf.m.entries[0] = 0x1111;
#if !defined(_WIN32)
    if (buf.m.first != 0x1111) {
        return 3;
    }
#endif
    if ((char *)&buf.m.entries[0] - (char *)&buf.m.first != ENTRIES_AT) {
        return 4;
    }
    buf.m.entries[1] = 0x2222;
    if (buf.m.entries[0] != 0x1111 || buf.m.entries[1] != 0x2222) {
        return 5;
    }
    return 0;
}
