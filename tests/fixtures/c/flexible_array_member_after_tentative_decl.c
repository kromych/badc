// A file-scope object of a struct with a flexible array member (C99
// 6.7.2.1) that is forward-declared before it is defined must reserve
// storage for the initialized FAM elements, not just the fixed part.
//
// A tentative / `extern` declaration reserves only the fixed size (the
// element count is unknown without an initializer). The later defining
// `= { ..., .fam = { e0, e1, ... } }` must therefore allocate fresh
// storage sized to include the elements; reusing the tentative slot
// overflows the FAM data into whatever global follows it -- the FAM
// entries stomp the next global's contents. `long long` keeps the element 64-bit under
// both LP64 and LLP64.

struct FamList {
    const char *name;
    long long tag;
    long long items[];
};

// Forward declaration: reserves only the fixed part.
extern struct FamList big;

// A reference emitted BEFORE big's definition. The address it takes must
// be big's final storage, not a stranded fixed-size placeholder -- the
// address is taken long before the list is defined further down the file.
struct FamList *early_ref(void) {
    return &big;
}

// A global defined between the forward declaration and big's definition.
// If big's definition reuses / overflows a tentative slot, big's FAM
// elements would land in this object.
struct FamList victim = { .name = "victim", .tag = 0x5a5a5a5a };

// Definition with 11 FAM elements: needs fixed_size + 11*sizeof(long long).
struct FamList big = {
    .name = "big",
    .tag = 1,
    .items = { 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20 },
};

int main(void) {
    // The pre-definition reference must resolve to big's real storage.
    struct FamList *p = early_ref();
    if (p != &big || p->tag != 1) {
        return 4;
    }
    // victim must be untouched by big's element data.
    if (victim.tag != 0x5a5a5a5a) {
        return 1;
    }
    // big's elements must all read back correctly.
    for (int i = 0; i < 11; i++) {
        if (big.items[i] != 10 + i) {
            return 2;
        }
    }
    // big and victim must be distinct objects.
    if ((void *)&big == (void *)&victim) {
        return 3;
    }
    return 0;
}
