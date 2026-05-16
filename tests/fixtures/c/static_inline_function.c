// C99 6.7.4: a function declared `static inline` at file scope has
// internal linkage; the inline specifier permits the implementation
// to inline the body at call sites. c5 treats `inline` as a no-op
// function-specifier modifier (per the C99 "as if" rule -- the
// observable behaviour matches a non-inlined call) and keeps the
// `static` internal-linkage attribute, so the function body is
// emitted as a private definition in each TU that includes the
// declaring header. Multi-TU builds therefore see one copy per TU,
// which is C99-conformant; cross-TU dedup is not required by the
// standard.
//
// This fixture locks in the single-TU case: a `static inline`
// helper defined at file scope must compile, link, and produce
// the expected result.

static inline int triple_plus_one(int x) {
    return x * 3 + 1;
}

static inline unsigned long long bit_count(unsigned long long v) {
    unsigned long long c = 0;
    while (v) {
        c += v & 1;
        v >>= 1;
    }
    return c;
}

int main(void) {
    if (triple_plus_one(2)  !=  7) return 1;
    if (triple_plus_one(-1) != -2) return 2;
    if (bit_count(0xDEADBEEFULL) != 24) return 3;
    if (bit_count(0)             !=  0) return 4;
    return 0;
}
