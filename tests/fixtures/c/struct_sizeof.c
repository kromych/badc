struct Three {
    int a;
    int b;
    int c;
};

struct Mixed {
    char ch;
    int  num;
    char *name;
};

int main() {
    struct Three *p;

    // Three int fields packed at natural alignment (4 each) -> 12,
    // padded up to the struct's own alignment (4) -> 12, then to
    // c5's per-aggregate floor of 8 (already past it) -> 12.
    if (sizeof(struct Three) != 12) return 1;

    // Mixed: char(1), pad(3), int(4), char*(8) -> 16 bytes. Tail
    // aligned to max(struct_align)=8 (already aligned, so no pad).
    if (sizeof(struct Mixed) != 16) return 2;

    // sizeof on a struct pointer is just 8.
    if (sizeof(struct Three *) != 8) return 3;

    // sizeof on a struct-pointer expression too.
    if (sizeof(p) != 8) return 4;

    return 0;
}
