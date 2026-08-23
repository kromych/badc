// Locks the copy loops whose non-overlap is a runtime test rather than
// a proof: the indexed copy through pointers, and the pointer-walking
// loop that advances a block of elements per iteration. Each is called
// with disjoint ranges, with a destination above an overlapping source
// (where the loop replicates and no library copy does), and with one
// below (where the two agree), plus the trip counts the test admits
// none of. The walking forms also have to leave their control
// variables where the loop would.
//
// Each failure returns a distinct nonzero code.

#include <string.h>

static unsigned char buf[64];
static unsigned char ref[64];

static void indexed(unsigned char *d, const unsigned char *s, int n) {
    for (int i = 0; i < n; i++) {
        d[i] = s[i];
    }
}

// One base names a declared array and the other a pointer, so an
// operand of the test is the array's address.
static void into_array(const unsigned char *s, int n) {
    for (int i = 0; i < n; i++) {
        buf[i] = s[i];
    }
}

static void out_of_array(unsigned char *d, int n) {
    for (int i = 0; i < n; i++) {
        d[i] = buf[i];
    }
}

static void blocked3(unsigned char *d, const unsigned char *s, unsigned n) {
    while (n > 2) {
        d[0] = s[0];
        d[1] = s[1];
        d[2] = s[2];
        d += 3;
        s += 3;
        n -= 3;
    }
    // The leftover the block loop cannot take, so a wrong exit value
    // shows up in the result.
    while (n) {
        *d++ = *s++;
        n--;
    }
}

static void walk1(unsigned char *d, const unsigned char *s, unsigned n) {
    while (n > 0) {
        *d = *s;
        d++;
        s++;
        n--;
    }
}

static void words4(unsigned *d, const unsigned *s, unsigned n) {
    while (n >= 4) {
        d[0] = s[0];
        d[1] = s[1];
        d[2] = s[2];
        d[3] = s[3];
        d += 4;
        s += 4;
        n -= 4;
    }
}

// The ascending element copy the loops perform, spelled so no idiom
// applies: a volatile induction variable is read and written once per
// iteration, which no single transfer reproduces.
static void expect(unsigned char *d, const unsigned char *s, int n) {
    volatile int i;
    for (i = 0; i < n; i++) {
        d[i] = s[i];
    }
}

static void seed(void) {
    for (int i = 0; i < 64; i++) {
        buf[i] = (unsigned char)(i + 1);
        ref[i] = (unsigned char)(i + 1);
    }
}

// `f` and the reference loop have to agree on every placement of the
// two ranges, overlapping or not.
static int same(void (*f)(unsigned char *, const unsigned char *, unsigned), int dst,
                int src, unsigned n) {
    seed();
    f(buf + dst, buf + src, n);
    expect(ref + dst, ref + src, (int)n);
    return memcmp(buf, ref, 64) == 0;
}

int main(void) {
    static unsigned words[16];
    static unsigned wref[16];

    for (int d = 0; d < 8; d++) {
        for (int s = 0; s < 8; s++) {
            for (unsigned n = 0; n <= 20; n++) {
                if (!same(blocked3, d, s, n)) {
                    return 1;
                }
                if (!same(walk1, d, s, n)) {
                    return 2;
                }
            }
        }
    }

    for (int d = 0; d < 8; d++) {
        for (int s = 0; s < 8; s++) {
            for (int n = 0; n <= 20; n++) {
                seed();
                indexed(buf + d, buf + s, n);
                expect(ref + d, ref + s, n);
                if (memcmp(buf, ref, 64) != 0) {
                    return 3;
                }
            }
        }
    }

    // A negative count writes nothing.
    seed();
    indexed(buf, buf + 8, -3);
    if (memcmp(buf, ref, 64) != 0) {
        return 4;
    }

    // The array-and-pointer mix, in both directions.
    for (int s = 0; s < 8; s++) {
        for (int n = 0; n <= 20; n++) {
            seed();
            into_array(buf + s, n);
            expect(ref, ref + s, n);
            if (memcmp(buf, ref, 64) != 0) {
                return 9;
            }
            seed();
            out_of_array(buf + s, n);
            expect(ref + s, ref, n);
            if (memcmp(buf, ref, 64) != 0) {
                return 10;
            }
        }
    }

    // The control variables the walking loops leave behind.
    {
        unsigned char *d = buf;
        const unsigned char *s = buf + 32;
        unsigned n = 11;
        seed();
        while (n > 2) {
            d[0] = s[0];
            d[1] = s[1];
            d[2] = s[2];
            d += 3;
            s += 3;
            n -= 3;
        }
        if (n != 2 || d != buf + 9 || s != buf + 41) {
            return 5;
        }
        if (memcmp(buf, ref + 32, 9) != 0 || buf[9] != ref[9]) {
            return 6;
        }
    }

    for (int i = 0; i < 16; i++) {
        words[i] = 0x01020304u * (unsigned)(i + 1);
        wref[i] = words[i];
    }
    words4(words, words + 8, 8);
    if (memcmp(words, wref + 8, 8 * sizeof(unsigned)) != 0) {
        return 7;
    }
    // Below four elements the loop, and the transfer, do nothing.
    for (int i = 0; i < 16; i++) {
        words[i] = wref[i];
    }
    words4(words, words + 8, 3);
    if (memcmp(words, wref, sizeof wref) != 0) {
        return 8;
    }
    return 0;
}
