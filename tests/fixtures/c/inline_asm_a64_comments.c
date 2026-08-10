// Assembler comments in aarch64 inline-asm templates: `//` and `/* */` are
// comments, while `#` prefixes an immediate and only starts a comment when it
// opens a statement. A `;` separates statements and is never a comment.
// Returns 42 when every template computed the expected value.
// Native aarch64 only.

static long add_imm(long x) {
    long r;
    // `#1` mid-statement is an immediate, not a comment.
    __asm__("add %0, %1, #1 // plus one" : "=r"(r) : "r"(x));
    return r;
}

static long shifted(long x) {
    long r;
    __asm__("movz %0, #0x1234, lsl #16 /* high half */ ; add %0, %0, %1"
            : "=&r"(r)
            : "r"(x));
    return r;
}

static long two_statements(long x) {
    long r;
    // A statement-opening `#` comments to the end of its line and swallows the
    // `;` after it, so only the two `sub`s run.
    __asm__("sub %0, %1, #2\n\t"
            "# sub %0, %0, #100 ; sub %0, %0, #100\n\t"
            "sub %0, %0, #3"
            : "=&r"(r)
            : "r"(x));
    return r;
}

static long block_comment_only(long x) {
    long r;
    __asm__("/* multi\n"
            "   line */ mov %0, %1"
            : "=r"(r)
            : "r"(x));
    return r;
}

int main(void) {
    if (add_imm(41) != 42) {
        return 1;
    }
    if (shifted(5) != 0x12340000L + 5) {
        return 2;
    }
    if (two_statements(50) != 45) {
        return 3;
    }
    if (block_comment_only(7) != 7) {
        return 4;
    }
    return 42;
}
