// A packed object, and its members, sit off their types' alignment. Read
// and written through a plain pointer to a member, the access takes the
// member's whole address rather than folding the object's address into a
// scaled offset, which only holds a multiple of the access width. Returns
// 0 when every value matches.

#pragma pack(push, 1)
struct packed {
    char tag;
    int word;
    long long wide;
    short half;
};

struct packed p = {1, 0x12345678, 0x1122334455667788LL, 0x4321};

// Three bytes ahead of `q` leave a one-aligned object at an odd offset.
char lead[3] = {1, 2, 3};
struct first {
    int word;
} q = {0x0badcafe};
#pragma pack(pop)

__attribute__((noinline)) static int read_word(void) {
    int *w = &p.word;
    return *w;
}

__attribute__((noinline)) static void write_wide(long long v) {
    long long *w = &p.wide;
    *w = v;
}

__attribute__((noinline)) static int read_first(void) {
    int *w = &q.word;
    return *w;
}

int main(void) {
    if (read_word() != 0x12345678)
        return 1;
    if (read_first() != 0x0badcafe || lead[2] != 3)
        return 3;
    write_wide(0x0102030405060708LL);
    short *h = &p.half;
    if (p.wide != 0x0102030405060708LL || *h != 0x4321 || p.tag != 1)
        return 2;
    return 0;
}
