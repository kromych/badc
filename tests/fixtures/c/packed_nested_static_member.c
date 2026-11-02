// Members of an aggregate nested in a packed one, in static objects at
// offsets the packing leaves unaligned: reads and writes through the inner
// member and through an element of an inner array, each at the alignment
// the packed object gives it. The exit code names the first check that
// fails.

#define NOINLINE __attribute__((noinline))

struct in {
    int a;
    short b;
};

#pragma pack(push, 1)
struct out {
    char c;
    struct in i;
    struct in arr[2];
};
#pragma pack(pop)

static const char pad[15] = "fifteen bytes.";
static const struct out ro = {1, {2, 3}, {{4, 5}, {6, 7}}};
static struct out rw;
static struct out grid[2][1];

NOINLINE static int read_ro(int k) { return ro.i.a + ro.arr[1].a + ro.i.b + ro.arr[k].b; }

NOINLINE static void write_rw(int v) {
    rw.i.a = v;
    rw.i.b = (short)(v + 1);
    rw.arr[1].a = v + 2;
}

NOINLINE static int grid_sum(int k) {
    grid[k][0].i.a = 10 + k;
    grid[1][0].arr[1].b = 20;
    return grid[k][0].i.a + grid[1][0].arr[1].b;
}

int main(void) {
    if (pad[0] != 'f') return 1;
    if (read_ro(0) != 2 + 6 + 3 + 5) return 2;
    if (read_ro(1) != 2 + 6 + 3 + 7) return 3;
    write_rw(40);
    if (rw.i.a != 40 || rw.i.b != 41 || rw.arr[1].a != 42) return 4;
    if (grid_sum(1) != 31 || grid_sum(0) != 30) return 5;
    return 0;
}
