/* GCC `__builtin_object_size(ptr, type)`: a size_t constant. A known
 * declared array folds to its byte count; an unknown pointer yields
 * (size_t)-1 for the maximum forms (types 0 and 1) and 0 for the
 * minimum forms (types 2 and 3). The pointer operand is unevaluated. */
typedef unsigned long usize;

static char buf[16];

int main(void) {
    if (__builtin_object_size(buf, 0) != 16)
        return 1;
    if (__builtin_object_size(buf, 1) != 16)
        return 2;
    if (__builtin_object_size(buf, 2) != 16)
        return 3;

    char *p = buf;
    if (__builtin_object_size(p, 0) != (usize)-1)
        return 4;
    if (__builtin_object_size(p, 1) != (usize)-1)
        return 5;
    if (__builtin_object_size(p, 2) != 0)
        return 6;
    if (__builtin_object_size(p, 3) != 0)
        return 7;

    /* Unevaluated operand: no side effect from the call. */
    int n = 0;
    usize s = __builtin_object_size((n++, p), 0);
    if (s != (usize)-1)
        return 8;
    if (n != 0)
        return 9;
    return 0;
}
