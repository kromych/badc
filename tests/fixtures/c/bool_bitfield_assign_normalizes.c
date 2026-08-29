/* C99 6.5.16.1p2 initializes / assigns "as if by conversion to the type
   of the left operand"; 6.3.1.2 makes that conversion for `_Bool` a
   zero / nonzero test, not a truncation to the field's width. A store
   that only masks the value to `bit_width` drops every set bit above
   bit 0, so `flag = x & 4` lands as 0 for every x.

   The shape is the kernel's `data->allow_reinit = flags &
   PERCPU_REF_ALLOW_REINIT`, where the tested flag sits above the
   field's own bit. Non-`_Bool` fields keep the C99 6.7.2.1 truncation. */

struct Ref {
    _Bool force_atomic : 1;
    _Bool allow_reinit : 1;
    unsigned mode : 3;
    signed bias : 4;
};

/* The reported shape: a `_Bool` field at bit 1 fed bit 2 of a flag word,
   behind a member that pushes the unit off offset 0. */
struct Padded {
    unsigned long pad;
    _Bool a : 1;
    _Bool b : 1;
    _Bool c : 1;
};

/* The control. A plain narrow bit-field converts by C99 6.7.2.1
   truncation to its width, which was already right and must stay so:
   only a `_Bool` field takes the 6.3.1.2 test instead. */
struct Plain {
    unsigned long pad;
    unsigned b : 1;
    unsigned w : 3;
};

/* Constant initializers take the same conversion (C99 6.7.9p11). */
static struct Ref g_static = { 1, 6, 9, 1.5 };
static _Bool g_scalar = 4;
static _Bool g_array[3] = { 4, 0, 7 };
/* A floating source is tested against 0 before the C99 6.3.1.4
   truncation would round it away. */
static _Bool g_half = 0.5;
static _Bool g_zero = 0.0;
static _Bool g_neg_zero = -0.0;
static _Bool g_float_array[3] = { 0.5, 0.0, 1.5 };
static struct Ref g_bf_half = { 0.5, 0.0, 0, 0 };

#define INIT_ATOMIC 1u
#define ALLOW_REINIT 4u

static int init_ref(struct Ref *r, unsigned flags) {
    r->force_atomic = flags & INIT_ATOMIC;
    r->allow_reinit = flags & ALLOW_REINIT;
    return r->allow_reinit;
}

int main(void) {
    struct Ref r = { 0, 0, 0, 0 };
    unsigned flags = ALLOW_REINIT;
    double d = 0.5;

    /* The reported miscompile: a flag above bit 0 must still set it. */
    if (init_ref(&r, flags) != 1) return 1;
    if (r.allow_reinit != 1) return 2;
    if (r.force_atomic != 0) return 3;

    if (init_ref(&r, INIT_ATOMIC) != 0) return 4;
    if (r.force_atomic != 1) return 5;

    /* Constants take the same conversion. */
    r.allow_reinit = 2;   if (r.allow_reinit != 1) return 6;
    r.allow_reinit = 256; if (r.allow_reinit != 1) return 7;
    r.allow_reinit = 0;   if (r.allow_reinit != 0) return 8;

    /* Compound assignment is `E1 = E1 op E2` (C99 6.5.16.2p3). */
    r.force_atomic = 0;
    r.force_atomic |= flags & ALLOW_REINIT;
    if (r.force_atomic != 1) return 9;

    /* `++` / `--` on a `_Bool` field converts the stepped value too. */
    r.allow_reinit = 1; r.allow_reinit++;
    if (r.allow_reinit != 1) return 10;
    r.force_atomic = 0; r.force_atomic--;
    if (r.force_atomic != 1) return 11;

    /* A floating source converts to the declared type first
       (C99 6.3.1.4 then 6.3.1.2). */
    r.allow_reinit = d;   if (r.allow_reinit != 1) return 12;
    r.mode = 2.5;         if (r.mode != 2u) return 13;
    r.bias = 1.5;         if (r.bias != 1) return 14;

    /* A non-`_Bool` field still truncates to its width. */
    r.mode = 8u;          if (r.mode != 0u) return 15;
    r.mode = 9u;          if (r.mode != 1u) return 16;
    r.bias = 9;           if (r.bias != -7) return 17;

    /* Constant initializers. */
    if (g_static.force_atomic != 1) return 18;
    if (g_static.allow_reinit != 1) return 19;
    if (g_static.mode != 1u) return 20;
    if (g_static.bias != 1) return 21;
    if (g_scalar != 1) return 22;
    if (g_array[0] != 1 || g_array[1] != 0 || g_array[2] != 1) return 23;
    if (g_half != 1) return 25;
    if (g_zero != 0) return 26;
    if (g_neg_zero != 0) return 27;
    if (g_float_array[0] != 1) return 28;
    if (g_float_array[1] != 0) return 29;
    if (g_float_array[2] != 1) return 30;
    if (g_bf_half.force_atomic != 1) return 31;
    if (g_bf_half.allow_reinit != 0) return 32;

    /* A runtime brace initializer converts as well. */
    {
        struct Ref b = { 0, flags & ALLOW_REINIT, 0, 0 };
        if (b.allow_reinit != 1) return 24;
    }

    /* The reported repro: bit 2 of the flag word into the field at bit 1. */
    {
        struct Padded p = { 0, 0, 0, 0 };
        unsigned f8 = 8u;
        p.b = flags & (1u << 2);
        if (p.b != 1) return 33;
        if (p.a != 0 || p.c != 0) return 34;
        p.b = 0;
        p.b = f8 & 8u;
        if (p.b != 1) return 35;
        if ((f8 & 8u) != 0 ? !p.b : p.b) return 36;
    }

    /* A `_Bool` field takes a pointer through the same conversion. */
    {
        struct Padded p = { 0, 0, 0, 0 };
        void *nn = &p;
        void *nul = 0;
        p.b = nn;
        if (p.b != 1) return 37;
        p.b = nul;
        if (p.b != 0) return 38;
    }

    /* Control: plain narrow bit-fields still truncate to their width. */
    {
        struct Plain q = { 0, 0, 0 };
        unsigned f = 4u;
        q.b = f & 4u;
        if (q.b != 0u) return 39;
        q.w = f & 0x30u;
        if (q.w != 0u) return 40;
        q.b = 3u;
        if (q.b != 1u) return 41;
        q.w = 0x0Au;
        if (q.w != 2u) return 42;
        q.b = 0u;
        q.b |= f & 4u;
        if (q.b != 0u) return 43;
    }
    return 0;
}
