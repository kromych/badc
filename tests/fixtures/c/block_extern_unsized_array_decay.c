// A block-scope `extern T name[];` declares an incomplete array whose
// definition lives elsewhere; a use decays to the array's address
// (C99 6.2.2p4, 6.3.2.1p3). Both block declaration paths used to
// collapse the unsized dimension to a scalar, so the name loaded the
// array's first bytes where its address belonged.
int table[3] = {10, 20, 30};

static int *top_level_decl(void) {
    extern int table[];
    return table;
}

static int *nested_decl(void) {
    do {
        extern int table[];
        return &table[1];
    } while (0);
}

int main(void) {
    int *p = top_level_decl();
    if (p != &table[0] || p[0] != 10 || p[2] != 30)
        return 1;
    if (nested_decl() != &table[1] || *nested_decl() != 20)
        return 2;
    return 0;
}
