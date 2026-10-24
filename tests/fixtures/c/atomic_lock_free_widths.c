// C11 7.17.5 / GCC `__atomic_is_lock_free` and `__atomic_always_lock_free`
// report the widths that lower to a lock-free instruction: 1, 2, 4 and 8
// bytes, and 16 through the paired compare-exchange, as clang reports them
// on x86-64 with `cmpxchg16b` and on aarch64.
// Each check returns a distinct non-zero code on failure.

int main(void) {
    int i = 0;
    long long l = 0;
    unsigned __int128 w = 0;

    if (!__atomic_is_lock_free(1, 0)) {
        return 1;
    }
    if (!__atomic_is_lock_free(2, 0)) {
        return 2;
    }
    if (!__atomic_is_lock_free(sizeof(i), &i)) {
        return 3;
    }
    if (!__atomic_is_lock_free(sizeof(l), &l)) {
        return 4;
    }
    if (!__atomic_is_lock_free(sizeof(w), &w)) {
        return 5;
    }
    if (!__atomic_always_lock_free(4, 0)) {
        return 6;
    }
    if (!__atomic_always_lock_free(sizeof(w), 0)) {
        return 7;
    }
    return 0;
}
