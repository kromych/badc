// A parenthesized aggregate-initializer element is first parsed
// speculatively as a conditional; that attempt emits the compound
// literal's bytes and rewinds the data segment when no `?` follows. The
// rewind must drop the alignment padding and boundaries recorded past
// the new end -- the re-parse fills those offsets with live bytes, and a
// stale range describes them as padding, which the named-section
// placement then drops. Values match GCC and clang on x86-64 and
// aarch64; returns 0, distinct non-zero per failure.

struct info {
    int type;
    const unsigned int *config;
};

// An odd size leaves the data cursor off the 8-byte boundary, so the
// literal that follows records real padding.
static const char lead[] = "ab";

static const struct info *const table[] = {
    (&(const struct info){.type = 1,
                          .config = (const unsigned int[]){10, 20, 0}}),
    (&(const struct info){.type = 2, .config = (const unsigned int[]){30, 0}}),
    ((void *)0)};

__attribute__((section(".t.info"), used)) static const char tag[] = "T";

int main(void) {
    if (lead[0] != 'a' || lead[1] != 'b' || lead[2] != 0) {
        return 1;
    }
    if (table[2] != (void *)0) {
        return 2;
    }
    if (table[0]->type != 1 || table[1]->type != 2) {
        return 3;
    }
    if (table[0]->config[0] != 10 || table[0]->config[1] != 20 ||
        table[0]->config[2] != 0) {
        return 4;
    }
    if (table[1]->config[0] != 30 || table[1]->config[1] != 0) {
        return 5;
    }
    if (tag[0] != 'T' || tag[1] != 0) {
        return 6;
    }
    return 0;
}
