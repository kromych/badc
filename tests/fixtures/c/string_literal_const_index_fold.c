// C99 6.4.5p6: string-literal storage is immutable, so a load from a
// literal at a constant index may fold to the initializer's byte. The
// kernel guards compile-time assertions with such reads
// (fmt[sizeof(fmt) - 2] != '\n'). The folded value must equal what the
// unoptimized load reads: every position (interior, terminator),
// concatenated parts, escapes, and `__func__`.

static int opaque(int i) { return i; }

int main(void) {
    if ("abc\n"[0] != 'a') return 1;
    if ("abc\n"[sizeof("abc\n") - 2] != '\n') return 2;
    if ("abc\n"[sizeof("abc\n") - 1] != 0) return 3;
    // Adjacent parts are one literal (C99 5.1.1.2 translation phase 6).
    if ("ab" "cd\n"[sizeof("abcd\n") - 2] != '\n') return 4;
    if ("ab" "cd\n"[1] != 'b') return 5;
    // Escaped bytes keep their values through the fold.
    if ((unsigned char)"\x41\377"[1] != 0xFF) return 6;
    if ("\x41\377"[0] != 'A') return 7;
    // The folded read equals the runtime-indexed read.
    for (int i = 0; i < (int)sizeof("abc\n"); i++) {
        char r = "abc\n"[opaque(i)];
        char f;
        switch (i) {
        case 0: f = "abc\n"[0]; break;
        case 1: f = "abc\n"[1]; break;
        case 2: f = "abc\n"[2]; break;
        case 3: f = "abc\n"[3]; break;
        default: f = "abc\n"[4]; break;
        }
        if (r != f) return 8;
    }
    // `__func__` is a static const char[] (C99 6.4.2.2).
    if (__func__[0] != 'm' || __func__[sizeof("main") - 1] != 0) return 9;
    // A branch guarded by a folded literal read selects the live arm.
    int hits = 0;
    if (!("selected\n"[sizeof("selected\n") - 2] != '\n'))
        hits = 1;
    if (hits != 1) return 10;
    return 0;
}
