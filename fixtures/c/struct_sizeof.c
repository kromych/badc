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

    // Three int fields, 8-byte aligned each → 24 bytes.
    if (sizeof(struct Three) != 24) return 1;

    // Mixed: char takes a full slot (8), int takes 8, ptr takes 8 → 24.
    if (sizeof(struct Mixed) != 24) return 2;

    // sizeof on a struct pointer is just 8.
    if (sizeof(struct Three *) != 8) return 3;

    // sizeof on a struct-pointer expression too.
    if (sizeof(p) != 8) return 4;

    return 0;
}
