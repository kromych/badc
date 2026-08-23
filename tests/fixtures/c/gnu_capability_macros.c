// snapshot-flags: --gnu
// Each GNU capability macro the `--gnu` predefine set claims, checked
// against the behaviour it promises. Compiled with `--gnu`; a macro that
// is claimed without its feature, or a feature reported by the wrong
// value, fails here. Distinct non-zero code per check.

// The version claim itself: GCC 4.3 documents the byte-swap builtins and
// the hot / cold / alloc_size / error / warning attributes.
_Static_assert(__GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 3),
               "claim covers the features asserted below");
__attribute__((cold)) static int cold_fn(void) { return 1; }
__attribute__((hot)) static int hot_fn(void) { return 2; }
void *alloc_n(unsigned n) __attribute__((alloc_size(1)));

// C11 7.17.5, GCC spelling: 2 means the type is always lock-free.
_Static_assert(__GCC_ATOMIC_BOOL_LOCK_FREE == 2, "bool");
_Static_assert(__GCC_ATOMIC_CHAR_LOCK_FREE == 2, "char");
_Static_assert(__GCC_ATOMIC_CHAR16_T_LOCK_FREE == 2, "char16_t");
_Static_assert(__GCC_ATOMIC_CHAR32_T_LOCK_FREE == 2, "char32_t");
_Static_assert(__GCC_ATOMIC_WCHAR_T_LOCK_FREE == 2, "wchar_t");
_Static_assert(__GCC_ATOMIC_SHORT_LOCK_FREE == 2, "short");
_Static_assert(__GCC_ATOMIC_INT_LOCK_FREE == 2, "int");
_Static_assert(__GCC_ATOMIC_LONG_LOCK_FREE == 2, "long");
_Static_assert(__GCC_ATOMIC_LLONG_LOCK_FREE == 2, "long long");
_Static_assert(__GCC_ATOMIC_POINTER_LOCK_FREE == 2, "pointer");

// The widths the __sync_* family covers, and the one it does not.
_Static_assert(__GCC_HAVE_SYNC_COMPARE_AND_SWAP_1 == 1, "sync 1");
_Static_assert(__GCC_HAVE_SYNC_COMPARE_AND_SWAP_2 == 1, "sync 2");
_Static_assert(__GCC_HAVE_SYNC_COMPARE_AND_SWAP_4 == 1, "sync 4");
_Static_assert(__GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 == 1, "sync 8");
#ifdef __GCC_HAVE_SYNC_COMPARE_AND_SWAP_16
#error "a 16-byte compare-exchange has no lowering"
#endif

// C11 6.10.8.2 encoding of the u/U literal prefixes.
_Static_assert(__STDC_UTF_16__ == 1, "utf-16");
_Static_assert(__STDC_UTF_32__ == 1, "utf-32");

// The x86 named address spaces, reported per target.
#if defined(__SEG_GS) != defined(__x86_64__)
#error "__SEG_GS must follow the target"
#endif

int main(void) {
    // Every type the lock-free macros name is a width the atomic
    // builtins report lock-free.
    if (!__atomic_always_lock_free(sizeof(_Bool), 0)
        || !__atomic_always_lock_free(sizeof(char), 0)
        || !__atomic_always_lock_free(sizeof(__CHAR16_TYPE__), 0)
        || !__atomic_always_lock_free(sizeof(__CHAR32_TYPE__), 0)
        || !__atomic_always_lock_free(sizeof(__WCHAR_TYPE__), 0)
        || !__atomic_always_lock_free(sizeof(short), 0)
        || !__atomic_always_lock_free(sizeof(int), 0)
        || !__atomic_always_lock_free(sizeof(long), 0)
        || !__atomic_always_lock_free(sizeof(long long), 0)
        || !__atomic_always_lock_free(sizeof(void *), 0)) {
        return 1;
    }
    // ... and one the macros do not name.
    if (__atomic_always_lock_free(16, 0)) {
        return 2;
    }
    // The value __atomic_test_and_set writes is the one the macro states.
    char flag = 0;
    if (__atomic_test_and_set(&flag, __ATOMIC_SEQ_CST)) {
        return 3;
    }
    if (flag != __GCC_ATOMIC_TEST_AND_SET_TRUEVAL) {
        return 4;
    }
    if (!__atomic_test_and_set(&flag, __ATOMIC_SEQ_CST)) {
        return 5;
    }
    __atomic_clear(&flag, __ATOMIC_SEQ_CST);
    if (flag != 0) {
        return 6;
    }
    // Each __sync_* width the macros claim.
    char c = 1;
    short s = 1;
    int i = 1;
    long long l = 1;
    if (!__sync_bool_compare_and_swap(&c, 1, 2) || c != 2) {
        return 7;
    }
    if (!__sync_bool_compare_and_swap(&s, 1, 2) || s != 2) {
        return 8;
    }
    if (!__sync_bool_compare_and_swap(&i, 1, 2) || i != 2) {
        return 9;
    }
    if (!__sync_bool_compare_and_swap(&l, 1, 2) || l != 2) {
        return 10;
    }
    // The 4.3 byte-swap builtins the version claim covers.
    if (__builtin_bswap32(0x11223344u) != 0x44332211u) {
        return 11;
    }
    if (__builtin_bswap64(0x1122334455667788ull) != 0x8877665544332211ull) {
        return 12;
    }
    // UTF-16 / UTF-32 code units, per the macros above.
    const __CHAR16_TYPE__ *u16 = u"A\u00e9";
    const __CHAR32_TYPE__ *u32 = U"A\U0001F600";
    if (u16[0] != 0x41 || u16[1] != 0xe9 || u16[2] != 0) {
        return 13;
    }
    if (u32[0] != 0x41 || u32[1] != 0x1F600 || u32[2] != 0) {
        return 14;
    }
    if (cold_fn() + hot_fn() != 3) {
        return 15;
    }
    return 0;
}
