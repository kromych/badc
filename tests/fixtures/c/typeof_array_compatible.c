// C99 6.7.6.2: an array type and a pointer type are never compatible, even
// with the same element type. `__builtin_types_compatible_p(typeof(arr),
// typeof(&arr[0]))` must therefore be 0, which is what QEMU's QEMU_IS_ARRAY
// and ARRAY_SIZE rely on. Returns 0 on success; distinct non-zero per fail.

#define QEMU_IS_ARRAY(x) (!__builtin_types_compatible_p(typeof(x), typeof(&(x)[0])))
#define BUG_STRUCT(x)                                                          \
    struct {                                                                   \
        int : (x) ? -1 : 1;                                                    \
    }
#define BUG_ON_ZERO(x) (int)(sizeof(BUG_STRUCT(x)) - sizeof(BUG_STRUCT(x)))
#define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0])) + BUG_ON_ZERO(!QEMU_IS_ARRAY(x)))

int main(void) {
    int nums[10];
    const char *strs[5];
    struct {
        int f[3];
    } s;

    // Array is not compatible with its decayed pointer.
    if (__builtin_types_compatible_p(typeof(nums), typeof(&nums[0])) != 0) {
        return 1;
    }
    // Two arrays of the same shape are compatible; a pointer matches a
    // pointer.
    if (__builtin_types_compatible_p(typeof(nums), typeof(nums)) != 1) {
        return 2;
    }
    if (__builtin_types_compatible_p(typeof(&nums[0]), typeof(&nums[0])) != 1) {
        return 3;
    }
    // Plain scalar types are unaffected.
    if (__builtin_types_compatible_p(typeof(nums[0]), int) != 1) {
        return 4;
    }

    if (QEMU_IS_ARRAY(nums) != 1 || QEMU_IS_ARRAY(&nums[0]) != 0) {
        return 5;
    }
    if (ARRAY_SIZE(nums) != 10) {
        return 6;
    }
    if (ARRAY_SIZE(strs) != 5) {
        return 7;
    }
    if (ARRAY_SIZE(s.f) != 3) {
        return 8;
    }
    return 0;
}
