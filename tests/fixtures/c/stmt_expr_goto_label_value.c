// GCC statement expression whose value expression is a labeled tail:
// `({ ... goto out; ... out: v; })`. The construct's value and type are
// those of the labeled expression-statement, evaluated at the label, so
// paths that enter through `goto` yield the same value as fall-through.
// Each check exits with a distinct non-zero code on failure.

typedef unsigned long long word;
#define WORD_BITS 64ULL

// The find-next-set-bit macro shape: two gotos into the tail label, a
// scan loop between them, `sz` carrying the not-found result.
#define FIND_NEXT(addr, size, start)                                   \
    ({                                                                 \
        word f_idx, f_tmp, f_sz = (size), f_start = (start);           \
        if (f_start >= f_sz)                                           \
            goto out;                                                  \
        f_idx = f_start / WORD_BITS;                                   \
        f_tmp = (addr)[f_idx] & (~0ULL << (f_start % WORD_BITS));      \
        while (!f_tmp) {                                               \
            if ((f_idx + 1) * WORD_BITS >= f_sz)                       \
                goto out;                                              \
            f_idx++;                                                   \
            f_tmp = (addr)[f_idx];                                     \
        }                                                              \
        f_sz = f_idx * WORD_BITS + (word)__builtin_ctzll(f_tmp);       \
        if (f_sz > (size))                                             \
            f_sz = (size);                                             \
    out:                                                               \
        f_sz;                                                          \
    })

static word find_next(const word *addr, word size, word start)
{
    return FIND_NEXT(addr, size, start);
}

static word early(word start, word nbits)
{
    word sz = nbits + 3;
    return ({
        word idx;
        if (start >= nbits)
            goto done;
        idx = start / 8;
        sz = idx + 1;
    done:
        sz;
    });
}

static long long nested(int sel)
{
    // A statement expression with a labeled tail nested inside another.
    return ({
        long long outer;
        outer = ({
            long long inner = 5;
            if (sel)
                goto in;
            inner = 6;
        in:
            inner + 10;
        });
        if (sel)
            goto ok;
        outer += 100;
    ok:
        outer;
    });
}

int main(void)
{
    // Early goto reaches the tail label; value is `sz` there, not the
    // last fall-through temporary.
    if (early(9, 7) != 10)
        return 1;
    if (early(16, 64) != 3)
        return 2;

    // Chained labels on the tail still supply the value.
    long long v = ({
        long long x = 1;
        goto a;
    a:
    b:
        x + 41;
    });
    if (v != 42)
        return 3;

    // A single labeled statement is the whole block.
    long long big = 0x1234567890abcdefLL;
    if (({ lone: big; }) != 0x1234567890abcdefLL)
        return 4;

    // The labeled tail fixes the construct's type: 64-bit, not int.
    if (sizeof(({ w: big; })) != sizeof(long long))
        return 5;

    if (nested(0) != 116 || nested(1) != 15)
        return 6;

    // Iterate set bits; the boundary return (start >= nbits => nbits)
    // terminates the walk. A regression yields garbage indices, so the
    // guarded loop miscounts instead of hanging.
    word bits[2] = { 0x8000000000000011ULL, 0x101ULL };
    word nbits = 100, count = 0, sum = 0, guard = 0;
    for (word i = find_next(bits, nbits, 0); i < nbits && guard < 200;
         i = find_next(bits, nbits, i + 1), guard++) {
        count++;
        sum += i;
    }
    if (count != 5)
        return 7;
    if (sum != 0 + 4 + 63 + 64 + 72)
        return 8;

    // Boundary inputs: start at and past nbits.
    if (find_next(bits, nbits, 100) != 100)
        return 9;
    if (find_next(bits, nbits, 700) != 100)
        return 10;
    // Not found below nbits: bits 73..99 are clear.
    if (find_next(bits, nbits, 73) != 100)
        return 11;

    return 0;
}
