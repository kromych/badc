// A static initializer leaf may be the constant address of a global
// object's sub-object: a member, an array member that decays to its
// address, or an indexed element's member reached through a
// parenthesised `(&arr[i])->field` form (C99 6.6 address constants).

struct slot {
    int tag;
    unsigned char *p;
    unsigned char buf[4];
};

struct slot table[] = {
    { .tag = 0 },
    { .tag = 1, .p = table[0].buf },
    { .tag = 2, .p = (&table[1])->buf },
};

int main(void) {
    // table[1].p points at table[0].buf; table[2].p at table[1].buf.
    if (table[1].p != table[0].buf) return 1;
    if (table[2].p != (&table[1])->buf) return 2;
    if (table[2].p != table[1].buf) return 3;
    return 0;
}
