// A GCC zero-length array member (`T v[0]`) shares the flexible-array
// spelling but may sit anywhere in a struct, where it is a zero-storage
// position marker sharing its offset with the member after it. Only a
// trailing member is the aggregate's flexible array member (C99
// 6.7.2.1p16), so a leading marker must not be taken for one: the
// object's storage reservation would be sized from the marker's offset
// instead of the fixed part's size, and the member fill would then run
// past the object into whatever follows it in the data segment.

struct Marked {
    unsigned char head[0];
    int a;
    int b;
    unsigned char mid[0];
    int c;
};

static struct Marked g1 = { .a = 1, .b = 2, .c = 3 };
static struct Marked g2 = { .a = 4, .b = 5, .c = 6 };
static int guard = 0x5A5A5A;

// A trailing zero-length array is the flexible member, as is `T v[]`.
struct Header {
    int n;
    unsigned char tail[0];
};

static struct Header h = { .n = 7 };

struct Flex {
    int n;
    int v[];
};

static struct Flex f = { 2, { 40, 41 } };

int main(void)
{
    struct Marked local = { .a = 8, .b = 9, .c = 10 };

    // The markers contribute no storage and share the offset of the
    // member that follows them.
    if (sizeof(struct Marked) != 3 * sizeof(int)) return 1;
    if ((void *)g1.head != (void *)&g1.a) return 2;
    if ((void *)g1.mid != (void *)&g1.c) return 3;

    // Neither definition may overrun into the object after it.
    if (g1.a != 1 || g1.b != 2 || g1.c != 3) return 4;
    if (g2.a != 4 || g2.b != 5 || g2.c != 6) return 5;
    if (guard != 0x5A5A5A) return 6;
    if (local.a != 8 || local.b != 9 || local.c != 10) return 7;

    // A trailing zero-length member still contributes no storage.
    if (sizeof(struct Header) != sizeof(int)) return 8;
    if (h.n != 7) return 9;

    // A trailing flexible member still takes its initializer.
    if (sizeof(struct Flex) != sizeof(int)) return 10;
    if (f.n != 2 || f.v[0] != 40 || f.v[1] != 41) return 11;

    return 0;
}
