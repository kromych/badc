// An object carrying both `__attribute__((section("name")))` and an
// alignment request -- an explicit `aligned(N)`, an aligned typedef, or
// a type whose members raise its natural alignment -- must land on that
// boundary at runtime, in every output mode. A layout-only check cannot
// see an under-placed object, so the checks read the runtime address.
// Matches GCC and clang on x86-64 and aarch64; returns 0, distinct
// non-zero per failure.

__attribute__((section(".t.pages"), aligned(4096))) char page_buf[8192];
__attribute__((section(".t.cache"), aligned(64))) int c64;
__attribute__((section(".t.cache"), aligned(64))) int c64i = 11;

struct nat16 {
    long long a, b;
} __attribute__((aligned(16)));
__attribute__((section(".t.nat"))) struct nat16 n16 = {1, 2};

typedef struct {
    char page[4096];
} __attribute__((aligned(4096))) page_t;
__attribute__((section(".t.pages2"))) page_t typed_page;

// Multiple members in one section keep declaration order and each
// member's own alignment.
__attribute__((section(".t.mix"))) char mix_a[10];
__attribute__((section(".t.mix"))) int mix_b = 7;
__attribute__((section(".t.mix"), aligned(32))) long long mix_c;

int plain = 5;

static int misaligned(const void *p, unsigned long want) {
    return ((unsigned long)p & (want - 1)) != 0;
}

char *page_buf_end(void) { return page_buf + sizeof(page_buf); }

int main(void) {
    static __attribute__((section(".t.stat"), aligned(128))) int s128 = 3;

    if (misaligned(page_buf, 4096)) return 1;
    if (misaligned(&c64, 64)) return 2;
    if (misaligned(&c64i, 64)) return 3;
    if (misaligned(&n16, 16)) return 4;
    if (misaligned(&typed_page, 4096)) return 5;
    if (misaligned(&mix_c, 32)) return 6;
    if (misaligned(&s128, 128)) return 7;

    // Values round-trip through the placed slots.
    page_buf[0] = 1;
    page_buf[8191] = 2;
    c64 = 21;
    typed_page.page[4095] = 3;
    mix_a[9] = 4;
    if (page_buf[0] + page_buf[8191] != 3) return 8;
    if (c64 + c64i != 32) return 9;
    if (n16.a + n16.b != 3) return 10;
    if (typed_page.page[4095] != 3) return 11;
    if (mix_a[9] + mix_b != 11) return 12;
    if (s128 != 3) return 13;
    if (plain != 5) return 14;

    // One-past-the-end stays adjacent to its own object (C99 6.5.6p8).
    if (page_buf_end() != page_buf + 8192) return 15;
    return 0;
}
