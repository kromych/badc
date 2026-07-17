// GCC generic atomic builtins `__atomic_load(p, ret, memorder)` and
// `__atomic_store(p, val, memorder)`, which move the value through a
// pointer (usable for any-size object) rather than by value like the `_n`
// forms. Returns 0 on success; distinct non-zero per fail.

int main(void) {
    // 64-bit load / store.
    long long src = 0x1122334455667788LL;
    long long dst = 0;
    __atomic_load(&src, &dst, __ATOMIC_SEQ_CST);
    if (dst != 0x1122334455667788LL) {
        return 1;
    }
    long long p = 0;
    long long v = 0xdeadbeefcafeLL;
    __atomic_store(&p, &v, __ATOMIC_SEQ_CST);
    if (p != 0xdeadbeefcafeLL) {
        return 2;
    }

    // 32-bit.
    int is = 42;
    int id = 0;
    __atomic_load(&is, &id, __ATOMIC_RELAXED);
    if (id != 42) {
        return 3;
    }
    int ip = 0;
    int iv = -7;
    __atomic_store(&ip, &iv, __ATOMIC_RELAXED);
    if (ip != -7) {
        return 4;
    }

    // Pointer-sized value.
    void *pv = (void *)0x1000;
    void *pd = 0;
    __atomic_load(&pv, &pd, __ATOMIC_ACQUIRE);
    if (pd != (void *)0x1000) {
        return 5;
    }
    return 0;
}
