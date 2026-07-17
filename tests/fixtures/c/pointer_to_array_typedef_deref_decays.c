// C99 6.3.2.1p3: dereferencing a pointer-to-array yields the array,
// which decays to a pointer to its first element -- the address itself,
// with no load. So `*(A *)p` where `A` is an array typedef reproduces
// `p`; it must not load the first element and pass that as the pointer.
//
// This is the shape a jmp_buf stashed through a `void *` uses:
//   sigjmp_buf env;  void *slot = &env;  siglongjmp(*(sigjmp_buf *)slot, 1);
// The array element is an 8-byte integer / pointer (the case that
// previously loaded through the address instead of decaying). Uses
// `long long` so the element is 64-bit under both LP64 and LLP64.

typedef long long jb[8];

// Parameter of array-typedef type is adjusted to `long long *`; writing
// through it must reach the caller's array, which only happens when the
// argument decayed to the array's address rather than a loaded value.
static void store_through(jb env, long long v) {
    env[0] = v;
    env[7] = v + 1;
}

static long long read_first(jb env) {
    return env[0];
}

struct box {
    void *slot;
};

int main(void) {
    jb a;
    a[0] = -1;
    a[7] = -1;

    struct box b;
    b.slot = &a; // void * <- pointer to array

    // `*(jb *)b.slot` decays to `(long long *)&a`. If it instead loaded
    // a[0] (== -1) and passed that as the pointer, the store faults or
    // writes to a wild address.
    store_through(*(jb *)b.slot, 0x1234567);
    if (a[0] != 0x1234567 || a[7] != 0x1234568) {
        return 1;
    }

    // Same decay in an rvalue read position.
    if (read_first(*(jb *)b.slot) != 0x1234567) {
        return 2;
    }

    // Subscripting the pointer-to-array cast strides by the whole row,
    // so `[0]` is the same array and `[0][k]` indexes its elements.
    if (((jb *)b.slot)[0][7] != 0x1234568) {
        return 3;
    }

    return 0;
}
