// C11 6.7.5 / GCC `aligned`: an alignment attribute in the type-specifier
// position raises the alignment of the type it appertains to. A pointer
// object holds a pointer-aligned value, so an over-alignment on the pointee
// type does not apply to the pointer -- `struct {...} aligned(16) *p` is a
// normal pointer, and an automatic pointer must not be rejected for it.

struct payload {
    int a;
    int b;
};

int via_struct_pointer(void *raw) {
    // The aligned(16) appertains to the anonymous struct type; get is a
    // plain pointer to it.
    struct {
        int a;
        int b;
    } __attribute__((aligned(16))) *get = raw;
    return get->a + get->b;
}

int via_scalar_pointer(int *arr) {
    __attribute__((aligned(64))) int *p = arr;
    return p[0] + p[3];
}

int main(void) {
    struct payload pl = {4, 5};
    if (via_struct_pointer(&pl) != 9) return 1;

    int arr[4] = {10, 20, 30, 40};
    if (via_scalar_pointer(arr) != 50) return 2;
    return 0;
}
