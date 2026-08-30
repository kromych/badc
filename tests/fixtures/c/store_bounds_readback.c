// What a store puts in memory bounds a later read of the same location,
// but only where the read gives the value back unchanged. An assignment
// to a narrower or differently-signed object converts the value (C99
// 6.5.16.1p2 / 6.3.1.3), so the bytes read back carry a different
// number than the one the source expression ranged over; a write in
// between carries a different one again. Every case below reads through
// one of those and checks the value the bytes really hold, so a bound
// applied where it does not hold shows up as a wrong answer rather than
// as a missing fold.

static volatile int seed = 200;

struct box { signed char sc; unsigned char uc; short s; unsigned u; int i; };

// Taking the address keeps each object in its frame slot, so the reads
// below are reloads rather than register reuse.
__attribute__((noinline)) static void touch_int(int *p) { (void)p; }
__attribute__((noinline)) static void touch_box(struct box *p) { (void)p; }
__attribute__((noinline)) static void write_int(int *p, int v) { *p = v; }

// A value with a known range but no known value: [0, 511], and 200 here.
static int ranged(void) { return seed & 0x1ff; }

// Same width and signedness: the read gives the value back, and the
// bound it carries is the one the source expression had.
static int same_width(void) {
    int v;
    touch_int(&v);
    v = ranged();
    return (v >= 0) + 2 * (v <= 511);
}

// int -> signed char: 200 converts to -56, outside the source range.
static int narrow_signed(struct box *b) {
    b->sc = ranged();
    return (b->sc < 0) + 2 * (b->sc == -56);
}

// int -> unsigned char: 200 is representable, so it survives.
static int narrow_unsigned(struct box *b) {
    b->uc = ranged();
    return (b->uc >= 0) + 2 * (b->uc == 200);
}

// int -> short: 40000 converts to -25536, outside the source range.
static int narrow_short(struct box *b) {
    b->s = ranged() * 200;
    return (b->s < 0) + 2 * (b->s == -25536);
}

// A negative int in an unsigned member reads back above INT_MAX.
static int unsigned_member(struct box *b) {
    b->u = -(ranged() & 7) - 1;
    return (b->u > 0x7fffffffu) + 2 * (b->u == 0xffffffffu);
}

// A write through a pointer between the store and the read: the read
// yields what the write left.
static int aliased_write(void) {
    int v;
    touch_int(&v);
    v = ranged();
    write_int(&v, -7);
    return (v < 0) + 2 * (v == -7);
}

// A call between the store and the read can write through an address
// that escaped earlier.
static int escaped_across_call(void) {
    static int *saved;
    int v;
    saved = &v;
    touch_int(&v);
    v = ranged();
    write_int(saved, -3);
    return (v < 0) + 2 * (v == -3);
}

// A volatile object is read as written, every time.
static int volatile_object(void) {
    volatile int v = 3;
    v = ranged();
    return (v >= 0) + 2 * (v <= 511);
}

int main(void) {
    struct box b;
    int rc = 0;
    touch_box(&b);

    if (same_width() != 1 + 2) rc |= 1;
    if (narrow_signed(&b) != 1 + 2) rc |= 2;
    if (narrow_unsigned(&b) != 1 + 2) rc |= 4;
    if (narrow_short(&b) != 1 + 2) rc |= 8;
    if (unsigned_member(&b) != 1 + 2) rc |= 16;
    if (aliased_write() != 1 + 2) rc |= 32;
    if (escaped_across_call() != 1 + 2) rc |= 64;
    if (volatile_object() != 1 + 2) rc |= 128;

    return rc;
}
