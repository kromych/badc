// A constant stored into a location and read back from it must yield
// that constant, whatever width and signedness the read uses, and
// whether the read sits in the storing block or in a block only that
// block reaches. This is what decides a build-time assertion written on
// a member the function just assigned; the values below pin the
// arithmetic the fold has to reproduce.
//
// The negative cases matter as much: a volatile read performs its own
// access, an aliasing write invalidates, and a call can write through
// any pointer that escaped.

struct widths {
    signed char sc;
    unsigned char uc;
    short s;
    unsigned short us;
    int i;
    unsigned u;
    long long ll;
};

struct guard {
    unsigned char lo;
    unsigned char hi;
};

static struct widths w;
static struct guard g;
static volatile unsigned char vol_cell;
static unsigned char *escaped;

static int sink;
static void clobber(void) { *escaped = 7; sink++; }

static int is_pow2_uc(unsigned char n) { return n != 0 && ((n & (n - 1)) == 0); }

// The member is written and then read back through the same pointer,
// once in the storing block and once past a branch that block decides.
static int power_of_two_member(struct widths *p)
{
    p->uc = 24 + 8;
    if (!is_pow2_uc(p->uc))
        return 1;
    return p->uc == 32 ? 0 : 2;
}

// Sign matters: 0x80 read as `signed char` is -128, as `unsigned char`
// is 128, from the same stored byte.
static int narrow_sign(struct widths *p)
{
    int rc = 0;
    p->sc = (signed char)0x80;
    p->uc = 0x80;
    if (p->sc != -128) rc |= 1;
    if (p->uc != 128) rc |= 2;
    p->s = (short)0x8000;
    p->us = 0x8000;
    if (p->s != -32768) rc |= 4;
    if (p->us != 32768) rc |= 8;
    p->i = (int)0x80000000;
    p->u = 0x80000000u;
    if (p->i != -2147483647 - 1) rc |= 16;
    if (p->u != 2147483648u) rc |= 32;
    p->ll = -1;
    if (p->ll != -1) rc |= 64;
    return rc;
}

// Two members one byte apart: writing one must not answer a read of the
// other.
static int neighbours(struct guard *p)
{
    p->lo = 1;
    p->hi = 2;
    p->lo = 3;
    return (p->lo == 3 && p->hi == 2) ? 0 : 1;
}

// A write through a pointer the function does not track invalidates.
static int aliased(unsigned char *a, unsigned char *b)
{
    *a = 4;
    *b = 9;
    return *a;
}

// A call can write through an escaped pointer.
static int across_call(unsigned char *p)
{
    *p = 5;
    clobber();
    return *p;
}

// A volatile object's read is a side effect performed as written.
static int volatile_cell(void)
{
    vol_cell = 6;
    return vol_cell;
}

// A frame slot the body only reaches through its own name.
static int frame_slot(int seed)
{
    int local = 12;
    if (seed)
        local += 0;
    return local;
}

int main(void)
{
    int rc = 0;

    if (power_of_two_member(&w) != 0) rc |= 1;
    if (narrow_sign(&w) != 0) rc |= 2;
    if (neighbours(&g) != 0) rc |= 4;

    escaped = &g.lo;
    if (aliased(&g.lo, &g.lo) != 9) rc |= 8;
    if (aliased(&g.lo, &g.hi) != 4) rc |= 16;
    if (across_call(&g.lo) != 7) rc |= 32;
    if (volatile_cell() != 6) rc |= 64;
    if (frame_slot(1) != 12) rc |= 128;
    if (frame_slot(0) != 12) rc |= 256;

    return rc;
}
