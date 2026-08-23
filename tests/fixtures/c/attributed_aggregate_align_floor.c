// A variable-level GNU `aligned(N)` sets the object's alignment rather
// than raising it, but placement keeps the type's attribute-free
// alignment as a floor. An aggregate whose own alignment is
// attribute-derived has the same floor: its members' natural alignment.
// clang places these objects on the member boundary and reports the
// lowered `__alignof__`; only the placement is observable, so the checks
// read the runtime address. `__int128` members carry a 16-byte natural
// alignment, above the 8-byte granularity of the data section, so an
// object placed without the floor lands misaligned. gcc keeps no floor
// for a lowered request and places these objects byte-tight; clang's
// floor for an automatic object stops at the 8-byte slot, so the frame
// case checks 8. Returns 0, distinct non-zero per failure.

struct raised {
    __int128 q;
} __attribute__((aligned(64)));

struct natural {
    __int128 q;
};

struct member_raised {
    __int128 q __attribute__((aligned(64)));
};

struct nested {
    struct raised r;
};

// Odd-sized fillers ahead of each object keep the running data offset off
// every 16-byte boundary, so a dropped floor shows up in the address.
char pad1[9] = "1";
struct raised g_raised __attribute__((aligned(1))) = { 1 };
char pad2[9] = "2";
struct natural g_natural __attribute__((aligned(1))) = { 2 };
char pad3[9] = "3";
struct member_raised g_member __attribute__((aligned(1))) = { 3 };
char pad4[9] = "4";
struct nested g_nested __attribute__((aligned(2))) = { { 4 } };
char pad5[9] = "5";

static int misaligned(const void *p, unsigned long want) {
    return ((unsigned long)p & (want - 1)) != 0;
}

int main(void) {
    static struct raised s_raised __attribute__((aligned(1))) = { 6 };
    struct raised l_raised __attribute__((aligned(1)));

    if (misaligned(&g_raised, 16)) return 1;
    if (misaligned(&g_natural, 16)) return 2;
    if (misaligned(&g_member, 16)) return 3;
    if (misaligned(&g_nested, 16)) return 4;
    if (misaligned(&s_raised, 16)) return 5;
    if (misaligned(&l_raised, 8)) return 6;

    // The lowered request is what `__alignof__` reports; the floor
    // applies to placement only.
    if (__alignof__(g_raised) != 1) return 7;
    if (__alignof__(g_nested) != 2) return 8;
    if (__alignof__(struct raised) != 64) return 9;
    if (__alignof__(struct natural) != 16) return 10;

    l_raised.q = 7;
    if ((int)l_raised.q != 7) return 11;
    if ((int)g_raised.q != 1 || (int)g_natural.q != 2) return 12;
    if ((int)g_member.q != 3 || (int)g_nested.r.q != 4) return 13;
    if ((int)s_raised.q != 6) return 14;
    if (pad1[0] != '1' || pad5[0] != '5') return 15;
    return 0;
}
