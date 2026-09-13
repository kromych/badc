/* A local copy of a structure larger than the scaled load offsets reach,
 * read through inlined accessors. Scalar replacement reads each field of
 * the copy straight from the source object, so every far access below
 * lands on one base address with a displacement past the scaled 12-bit
 * offset of its width: a byte at 8192, a 16-bit field past 8190, a 32-bit
 * field past 16380 and a 64-bit field past 32760. The near byte beside each
 * far field differs from the byte at offset 0, so a far access that loses
 * its displacement changes the sum. */

struct big {
    unsigned char data[40000];
    unsigned short half;
    unsigned int word;
    long long wide;
};

static struct big src;

static inline int far_byte(struct big *b) { return b->data[8192] + b->data[1]; }
static inline int far_half(struct big *b) { return b->data[3] + b->half; }
static inline long long far_word(struct big *b) { return b->data[5] + b->word; }
static inline long long far_wide(struct big *b) { return b->data[7] + b->wide; }

int from_big(struct big *s) {
    struct big t = *s;
    return far_byte(&t);
}

int half_from_big(struct big *s) {
    struct big t = *s;
    return far_half(&t);
}

long long word_from_big(struct big *s) {
    struct big t = *s;
    return far_word(&t);
}

long long wide_from_big(struct big *s) {
    struct big t = *s;
    return far_wide(&t);
}

int main(void) {
    src.data[0] = 9;
    src.data[1] = 2;
    src.data[3] = 3;
    src.data[5] = 5;
    src.data[7] = 7;
    src.data[8192] = 40;
    src.half = 0x1234;
    src.word = 0x12345678;
    src.wide = 0x123456789aLL;
    if (from_big(&src) != 42) {
        return 1;
    }
    if (half_from_big(&src) != 0x1237) {
        return 2;
    }
    if (word_from_big(&src) != 0x1234567dLL) {
        return 3;
    }
    if (wide_from_big(&src) != 0x12345678a1LL) {
        return 4;
    }
    return 42;
}
