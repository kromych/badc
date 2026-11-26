// Loads of a loop-invariant address in a loop that stores. A load may
// move before the loop only when no store of the loop reaches its bytes:
// the same base at other offsets, or rows of a strided array at another
// field. A store that can reach the loaded bytes -- the same row one
// iteration on, a stride an unbounded index wraps modulo 2^64, an
// unrelated pointer, a local whose address the loop's stores receive --
// keeps the load in the loop, and the loop sees each stored value.
// Returns 0 when every result is right; each failure returns its own code.

struct body {
    double x, y, z, vx, vy, vz, mass;
};

static struct body rows[5] = {
    {1, 2, 4, 0, 0, 0, 5},  {3, 7, 5, 0, 0, 0, 7},    {8, 1, 9, 0, 0, 0, 11},
    {2, 12, 6, 0, 0, 0, 13}, {13, 4, 15, 0, 0, 0, 17},
};

// The fields read are disjoint from every field written, through the same
// row and through the other row.
__attribute__((noinline)) void pull(void) {
    for (int i = 0; i < 5; i++) {
        struct body *bi = &rows[i];
        for (int j = i + 1; j < 5; j++) {
            struct body *bj = &rows[j];
            double dx = bi->x - bj->x, dy = bi->y - bj->y, dz = bi->z - bj->z;
            bi->vx -= dx * bj->mass;
            bi->vy -= dy * bj->mass;
            bi->vz -= dz * bj->mass;
            bj->vx += dx * bi->mass;
            bj->vy += dy * bi->mass;
            bj->vz += dz * bi->mass;
        }
    }
}

static long cells[16];

// The load reads `cells[i + 1]` while the loop writes `cells[j]`, the
// same bytes when `j == i + 1`.
__attribute__((noinline)) long next_row(int i, int n) {
    if (i < 0 || i > 14)
        return -1;
    long sum = 0;
    const long *src = &cells[i + 1];
    for (int j = 0; j < n; j++) {
        sum += *src;
        cells[j] = j * 10;
    }
    return sum;
}

// Odd cells read, even cells written: disjoint at every index.
__attribute__((noinline)) long odd_even(int i, int n) {
    if (i < 0 || i > 7)
        return -1;
    long sum = 0;
    const long *src = &cells[2 * i + 1];
    for (int j = 0; j < n; j++) {
        sum += *src;
        cells[2 * j] = j;
    }
    return sum;
}

struct pair {
    long long a, b, pad[5];
};

static struct pair pairs[8];

// Stride 56, the load at field `b` of row `i`, the store at row `k + 1`
// computed in unsigned integer arithmetic: `56 * (k + 1)` wraps modulo
// 2^64 onto any multiple of 8, here onto row `i`'s field `b`.
__attribute__((noinline)) long long wrapped(int i, unsigned long long k, int n) {
    if (i < 0 || i > 7)
        return -1;
    long long sum = 0;
    const long long *src = &pairs[i].b;
    for (int j = 0; j < n; j++) {
        sum += *src;
        *(long long *)((unsigned long long)pairs + 56 * (k + 1)) = j + 100;
    }
    return sum;
}

// No iteration runs, so the load through `p` never happens.
__attribute__((noinline)) long zero_trip(const struct body *p, int n) {
    double s = 0;
    for (int j = 0; j < n; j++) {
        s += p->mass;
        rows[j].vx = s;
    }
    return (long)s;
}

// `q` names `rows[2].mass`; the store through it changes what the loop reads.
__attribute__((noinline)) double through(double *q, int n) {
    double s = 0;
    for (int j = 0; j < n; j++) {
        s += rows[2].mass;
        *q = j;
    }
    return s;
}

// A local whose address does not escape is not written by the stores the
// loop makes through a pointer.
__attribute__((noinline)) long local_kept(long *out, int n) {
    long t[2] = {3, 4};
    long s = 0;
    for (int j = 0; j < n; j++) {
        s += t[1];
        out[j] = s;
    }
    return s;
}

// A local whose address the loop's stores receive through `out`.
__attribute__((noinline)) long local_escaped(long **out, int n) {
    long t[2] = {3, 4};
    long s = 0;
    *out = &t[1];
    for (int j = 0; j < n; j++) {
        s += t[1];
        **out = j;
    }
    return s;
}

int main(void) {
    static const double want[5][3] = {
        {308, 188, 275}, {202, -77, 222}, {-63, 241, 10}, {255, -342, 169}, {-328, 82, -308},
    };
    pull();
    for (int i = 0; i < 5; i++) {
        if (rows[i].vx != want[i][0] || rows[i].vy != want[i][1] || rows[i].vz != want[i][2])
            return 1 + i;
    }
    for (int i = 0; i < 16; i++)
        cells[i] = 1;
    // `cells[3]` reads 1 until the store at j == 3 makes it 30.
    if (next_row(2, 6) != 1 + 1 + 1 + 1 + 30 + 30)
        return 10;
    for (int i = 0; i < 16; i++)
        cells[i] = i;
    if (odd_even(3, 8) != 8 * 7)
        return 11;
    // 7 * 0x6db6db6db6db6db7 == 1 modulo 2^64, so `56 * (k + 1)` is
    // `56 * 3 + 8` modulo 2^64.
    pairs[3].b = 9;
    if (wrapped(3, 2 + 0x6db6db6db6db6db7ULL, 4) != 9 + 100 + 101 + 102)
        return 12;
    if (zero_trip((const struct body *)0, 0) != 0)
        return 13;
    rows[2].mass = 11;
    if (through(&rows[2].mass, 4) != 11 + 0 + 1 + 2)
        return 14;
    long out[4];
    if (local_kept(out, 4) != 16 || out[3] != 16)
        return 15;
    long *slot;
    if (local_escaped(&slot, 4) != 4 + 0 + 1 + 2)
        return 16;
    return 0;
}
