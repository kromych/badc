// C99 6.5.2.5p5: a compound literal is an unnamed object of the named
// type, so it is placed on that type's boundary (C99 6.2.8). A literal of
// a type whose alignment exceeds the 8-byte data granularity -- an
// aggregate carrying `aligned(16)`, or one holding an `__int128` -- lands
// misaligned when the placement uses the granularity instead. The
// preceding 8-byte literals keep the running data offset off every
// 16-byte boundary. Returns 0, distinct non-zero per failure.

typedef struct __attribute__((aligned(16))) {
    long a;
    long b;
} a16;

typedef struct {
    __int128 q;
} wide;

static long *p0 = &(long){ 7 };
static a16 *l0 = &(a16){ 1, 2 };
static long *p1 = &(long){ 9 };
static a16 *l1 = &(a16){ 3, 4 };
static long *p2 = &(long){ 11 };
static wide *w0 = &(wide){ 5 };
static long *p3 = &(long){ 13 };
static a16 *arr = (a16[]){ { 6, 7 }, { 8, 9 } };

static int misaligned(const void *p, unsigned long want) {
    return ((unsigned long)p & (want - 1)) != 0;
}

int main(void) {
    if (misaligned(l0, 16)) return 1;
    if (misaligned(l1, 16)) return 2;
    if (misaligned(w0, 16)) return 3;
    if (misaligned(arr, 16)) return 4;

    if (l0->a != 1 || l0->b != 2) return 5;
    if (l1->a != 3 || l1->b != 4) return 6;
    if ((int)w0->q != 5) return 7;
    if (arr[0].a != 6 || arr[1].b != 9) return 8;
    if (*p0 != 7 || *p1 != 9 || *p2 != 11 || *p3 != 13) return 9;

    // A block-scope literal of the same type is copied into a frame slot,
    // which the over-aligned frame region places.
    a16 *b = &(a16){ 10, 11 };
    if (misaligned(b, 16)) return 10;
    if (b->a != 10 || b->b != 11) return 11;
    return 0;
}
