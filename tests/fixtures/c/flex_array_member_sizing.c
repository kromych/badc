// C99 6.7.2.1p18 + the GCC zero-length-array extension: a flexible /
// zero-length array member (`T v[]` / `T v[0]`) contributes no storage.
// An aggregate built only from such members has size 0 (gcc / clang),
// so the empty-aggregate floor-to-1 must not apply -- otherwise the
// aggregate gains a spurious byte that mis-pads any enclosing struct.
// The aggregate's alignment still follows its members' declared types.

struct OnlyFlexU {
    union {
        unsigned char a8[0];
        unsigned short a16[0];
    } u;
};

struct WithLeading {
    unsigned int a;
    union {
        unsigned char a8[0];
        unsigned short a16[0];
    } u;
};

struct OnlyFlexArr {
    unsigned short s[0];
};

int main(void) {
    // A union of only flexible-array members has size 0, alignment from
    // its widest member (unsigned short -> 2).
    if (sizeof(struct OnlyFlexU) != 0) return 1;

    // Embedding it after an int must not add a tail byte: the int is
    // 4 bytes and the union contributes nothing, so the struct is 4.
    if (sizeof(struct WithLeading) != 4) return 2;

    // A struct whose only member is a zero-length array is size 0.
    if (sizeof(struct OnlyFlexArr) != 0) return 3;

    // The flexible member still addresses the bytes that follow the
    // header when backing storage is provided.
    struct WithLeading *p;
    unsigned char buf[8];
    p = (struct WithLeading *)buf;
    p->a = 0x11223344;
    p->u.a16[0] = 0xBEEF; // lands at offset 4 (right after `a`)
    if (p->a != 0x11223344) return 4;
    if (p->u.a16[0] != 0xBEEF) return 5;
    if (*(unsigned short *)(buf + 4) != 0xBEEF) return 6;

    return 0;
}
