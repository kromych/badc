/* GNU C: an attribute-specifier-list may follow a declarator
   (`direct-declarator attribute-list`). badc absorbs it without affecting
   the type. Both the scalar and array forms appear in system headers, e.g.
   an aligned scratch buffer. */

int main(void) {
    int b __attribute__((aligned(8)));
    char a[16] __attribute__((aligned(8)));
    a[0] = 7;
    b = a[0];
    return b - 7;
}
