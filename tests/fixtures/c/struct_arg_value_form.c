// C99 6.5.2.2p6: a call whose callee has no declared parameter list in
// scope passes each argument by the default promotions, so a by-value
// aggregate of at most one machine word travels as that word rather
// than as the address of the caller's copy. A parameterless function
// typedef (`typedef unsigned fn_t();`) redeclaring a defined function
// is one way to reach that state; the Linux kernel's `typeof`-based
// redeclarations are another.
//
// The callee's own definition still declares an aggregate parameter, so
// it reads the object out of a body local. The two forms differ only in
// what the argument word holds, and both ends have to agree: the SSA
// interpreter used to treat the value form's word as an address and
// fault copying from it.

typedef struct {
    unsigned val;
} kuid_t;

typedef struct {
    unsigned lo, hi;
} pair_t;

typedef unsigned fn1_t();
typedef unsigned long long fn2_t();

unsigned take_kuid(kuid_t k) { return k.val; }
unsigned long long take_pair(pair_t p) { return ((unsigned long long)p.hi << 32) | p.lo; }

/* The declared parameter list goes out of scope at the call site. */
extern fn1_t take_kuid;
extern fn2_t take_pair;

/* The address form stays available through a prototype of its own. */
unsigned take_kuid_proto(kuid_t k) { return k.val; }

int main(void) {
    kuid_t k = {0xdeadbeefu};
    pair_t p = {0x11223344u, 0x55667788u};

    if (take_kuid(k) != 0xdeadbeefu) return 1;
    if (take_pair(p) != 0x5566778811223344ULL) return 2;
    if (take_kuid_proto(k) != 0xdeadbeefu) return 3;

    /* The caller's copy is unchanged by either form. */
    if (k.val != 0xdeadbeefu) return 4;
    if (p.lo != 0x11223344u || p.hi != 0x55667788u) return 5;
    return 0;
}
