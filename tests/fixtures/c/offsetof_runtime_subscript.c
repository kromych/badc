/* GCC extension: `__builtin_offsetof(T, member[i])` accepts a non-constant
   array subscript, yielding the runtime offset `offsetof(T, member) + i *
   element-stride`. badc folded offsetof to a constant and rejected a
   variable subscript (`constant integer expected`), which edk2 firmware
   relies on (`__builtin_offsetof(VIRTIO_FS_CONFIG, Tag[Idx])`). The offset
   is now emitted as a runtime expression when a subscript is non-constant;
   a constant subscript still folds. The checks compare the runtime form to
   the constant base plus the scaled index, so they hold at any layout. */

struct S {
    int   x;
    char  tag[16];
    long  v[8];
    short m[4][6];
};

#define OF(member) __builtin_offsetof(struct S, member)

int main(void) {
    for (int i = 0; i < 8; i++) {
        if (OF(tag[i]) != OF(tag) + (unsigned long)i)
            return 1;
        if (OF(v[i]) != OF(v) + (unsigned long)i * sizeof(long))
            return 2;
    }
    /* Runtime index into a multi-dimensional member: the row stride is the
       inner dimension times the element size. */
    for (int r = 0; r < 4; r++) {
        if (OF(m[r]) != OF(m) + (unsigned long)r * 6 * sizeof(short))
            return 3;
    }
    /* A constant subscript still folds to a constant offset. */
    if (OF(tag[3]) != OF(tag) + 3)
        return 4;
    if (OF(v[2]) != OF(v) + 2 * sizeof(long))
        return 5;
    return 0;
}
