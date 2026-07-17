// GCC vector extension: `v[i]` indexes lane `i` of a vector as an
// element-typed lvalue (read and write, constant or runtime index). The vector
// value carries its address like a decayed array, so the subscript reuses the
// pointer-subscript path against the element type. Sizes stay data-model
// portable (int is 32-bit on every target).

typedef __attribute__((vector_size(16))) unsigned char u8x16;
typedef __attribute__((vector_size(16))) unsigned int u32x4;

// Subscript over a by-value vector parameter.
static unsigned int sum4(u32x4 v) {
    unsigned int s = 0;
    for (int i = 0; i < 4; i++) {
        s += v[i];
    }
    return s;
}

int main(void) {
    u8x16 a = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};

    // Constant-index read.
    if (a[0] != 0 || a[7] != 7 || a[15] != 15) return 1;

    // The element access has the element type's size.
    if (sizeof(a[0]) != sizeof(unsigned char)) return 2;

    // Runtime-index read.
    for (unsigned i = 0; i < 16; i++) {
        if (a[i] != (unsigned char)i) return 3;
    }

    // Write through the subscript (lvalue), constant and runtime index.
    a[3] = 99;
    unsigned j = 10;
    a[j] = 200;
    if (a[3] != 99 || a[10] != 200) return 4;

    // Wider lanes: a u32 vector.
    u32x4 b = {1000, 2000, 3000, 4000};
    if (b[1] != 2000) return 5;
    if (sizeof(b[0]) != sizeof(unsigned int)) return 6;
    if (sum4(b) != 10000) return 7;
    b[2] = 30000;
    if (b[2] != 30000 || sum4(b) != 37000) return 8;

    return 0;
}
