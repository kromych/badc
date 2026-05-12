// Regression: when a name was previously bound (as a struct
// field, an outer local, etc.) with a 2D inner dimension,
// rebinding it later as a scalar / pointer / 1D array must not
// inherit the stale `inner_array_size`. Otherwise the
// identifier load decays via the 2D-stride trick and the next
// `[i]` postfix keeps the type pointer-shaped instead of
// emitting a scalar load -- so `arr[i] = 0` fails as
// "bad lvalue in assignment".
//
// C99 6.2.1 identifier scopes: each new binding starts fresh,
// so any per-symbol shape metadata must be cleared when the
// binding's scope begins. The fixture shadows a struct field
// of a 2D-array type with a pointer parameter of the same name
// and confirms the parameter behaves as a plain 1D pointer.

typedef short i16;

struct probe_state {
    /* 2D field setting `inner_array_size = 4` on the symbol
     * named `fast_ac`. */
    i16 fast_ac[2][4];
};

static int build_one(i16 *fast_ac, int n) {
    /* `fast_ac` here is a 1D pointer parameter; despite the
     * field above, indexing must scale by sizeof(i16) and
     * produce a writable lvalue. */
    int i;
    for (i = 0; i < n; ++i) {
        fast_ac[i] = (i16)(i * 3);
    }
    return (int)fast_ac[n - 1];
}

int main(void) {
    i16 buf[8];
    int last = build_one(buf, 8);
    if (last != 21) return 1;
    if ((int)buf[0] != 0 || (int)buf[7] != 21) return 2;
    /* Touch the struct field too so the field type isn't dead-
     * stripped by anything clever. */
    struct probe_state s;
    s.fast_ac[1][3] = 99;
    if (s.fast_ac[1][3] != 99) return 3;
    return 0;
}
