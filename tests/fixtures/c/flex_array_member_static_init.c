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
    return 0;
}
