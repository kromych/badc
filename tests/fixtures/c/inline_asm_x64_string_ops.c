// x86-64 string primitives and the legacy prefixes through inline asm, with
// assembler comments in the templates. Covers the prefix as its own statement
// (`repe; cmpsb`) and leading its instruction (`rep stosl`), the AT&T size
// suffixes, and `fninit`. Returns 42 when every result is correct.
// Native x86-64 only.

static void fill32(unsigned *dst, unsigned long n, unsigned v) {
    __asm__ volatile("rep stosl /* n dwords of v at %%edi */"
                     : "+D"(dst), "+c"(n)
                     : "a"(v)
                     : "memory");
}

static void copy8(char *dst, const char *src, unsigned long n) {
    __asm__ volatile("rep movsb # byte copy"
                     : "+D"(dst), "+S"(src), "+c"(n)
                     :
                     : "memory");
}

// Scans n bytes for v and returns the count left when it stopped, so a match
// at index i leaves n - i - 1.
static unsigned long scan8(const char *p, unsigned long n, char v) {
    __asm__ volatile("repne; scasb"
                     : "+D"(p), "+c"(n)
                     : "a"(v)
                     : "memory");
    return n;
}

static void store16(unsigned short *dst, unsigned short v) {
    __asm__ volatile("stosw" : "+D"(dst) : "a"(v) : "memory");
}

int main(void) {
    unsigned buf[4];
    fill32(buf, 4, 0xA5A5A5A5u);
    for (int i = 0; i < 4; i++) {
        if (buf[i] != 0xA5A5A5A5u) {
            return 1;
        }
    }

    char src[6];
    char dst[6];
    for (int i = 0; i < 6; i++) {
        src[i] = (char)('a' + i);
        dst[i] = 0;
    }
    copy8(dst, src, 6);
    for (int i = 0; i < 6; i++) {
        if (dst[i] != (char)('a' + i)) {
            return 2;
        }
    }

    // 'd' is at index 3 of 6, so 6 - 3 - 1 = 2 remain.
    if (scan8(src, 6, 'd') != 2) {
        return 3;
    }

    unsigned short half[2];
    half[0] = 0;
    half[1] = 0x1234;
    store16(half, 0xBEEF);
    if (half[0] != 0xBEEF || half[1] != 0x1234) {
        return 4;
    }

    __asm__ volatile("fninit /* reset the x87 unit */");

    return 42;
}
