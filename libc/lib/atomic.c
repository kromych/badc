// The generic atomic functions of gcc's libatomic and clang's compiler-rt,
// which an `_Atomic` object no instruction covers is accessed through: each
// call holds the spin lock its object's address selects while it copies.
// Offered on demand like compiler_rt.c, after the link's own archives, so a
// libatomic on the link line supplies them instead. Windows objects carry
// their own lock word and call none of these.

#if !defined(_WIN32)

typedef __SIZE_TYPE__ __bcrt_size_t;
typedef __UINTPTR_TYPE__ __bcrt_uintptr_t;

#define __BCRT_ATOMIC_LOCKS 1024

static int __bcrt_atomic_locks[__BCRT_ATOMIC_LOCKS];

static int *__bcrt_atomic_lock(void *obj) {
    __bcrt_uintptr_t a = (__bcrt_uintptr_t)obj;
    return &__bcrt_atomic_locks[((a >> 4) ^ (a >> 14)) % __BCRT_ATOMIC_LOCKS];
}

// Exchange 1 in with acquire order (2); spin on relaxed loads (0) while
// another thread holds the lock.
static void __bcrt_atomic_acquire(int *lock) {
    while (__atomic_exchange_n(lock, 1, 2))
        while (__atomic_load_n(lock, 0))
            ;
}

// Release order (3).
static void __bcrt_atomic_release(int *lock) { __atomic_store_n(lock, 0, 3); }

static void __bcrt_atomic_copy(void *dst, const void *src, __bcrt_size_t n) {
    unsigned char *d = dst;
    const unsigned char *s = src;
    for (__bcrt_size_t i = 0; i < n; i++)
        d[i] = s[i];
}

void __atomic_load(__bcrt_size_t n, void *obj, void *ret, int order) {
    (void)order;
    int *lock = __bcrt_atomic_lock(obj);
    __bcrt_atomic_acquire(lock);
    __bcrt_atomic_copy(ret, obj, n);
    __bcrt_atomic_release(lock);
}

void __atomic_store(__bcrt_size_t n, void *obj, void *val, int order) {
    (void)order;
    int *lock = __bcrt_atomic_lock(obj);
    __bcrt_atomic_acquire(lock);
    __bcrt_atomic_copy(obj, val, n);
    __bcrt_atomic_release(lock);
}

void __atomic_exchange(__bcrt_size_t n, void *obj, void *val, void *ret, int order) {
    (void)order;
    int *lock = __bcrt_atomic_lock(obj);
    __bcrt_atomic_acquire(lock);
    __bcrt_atomic_copy(ret, obj, n);
    __bcrt_atomic_copy(obj, val, n);
    __bcrt_atomic_release(lock);
}

_Bool __atomic_compare_exchange(__bcrt_size_t n, void *obj, void *expected, void *desired,
                                int success, int failure) {
    (void)success;
    (void)failure;
    int *lock = __bcrt_atomic_lock(obj);
    __bcrt_atomic_acquire(lock);
    const unsigned char *o = obj, *e = expected;
    __bcrt_size_t i = 0;
    while (i < n && o[i] == e[i])
        i++;
    _Bool equal = i == n;
    if (equal)
        __bcrt_atomic_copy(obj, desired, n);
    else
        __bcrt_atomic_copy(expected, obj, n);
    __bcrt_atomic_release(lock);
    return equal;
}

#endif // !_WIN32
