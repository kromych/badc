// C11 7.17.7 and the GCC `__atomic` / `__sync` builtins on a 16-byte
// integer: every form, with values whose carry, borrow and bits cross the
// boundary of the two 64-bit halves. A failed compare-exchange writes the
// prior contents over the comparand and a matched one leaves it alone.
// Returns 0.
typedef unsigned __int128 u128;

static u128 v;
static u128 w = ((u128)1 << 100) | 5;
u128 *volatile vp = &v;

int main(void) {
    const u128 hi = (u128)1 << 64;
    u128 *p = vp;
    u128 e = 0;
    if (!__atomic_compare_exchange_n(p, &e, hi + 5, 0, __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST) || e != 0)
        return 1;
    e = 3;
    if (__atomic_compare_exchange_n(p, &e, 9, 0, __ATOMIC_ACQ_REL, __ATOMIC_ACQUIRE) || e != hi + 5)
        return 2;
    if (__atomic_fetch_sub(p, 6, __ATOMIC_SEQ_CST) != hi + 5 || __atomic_load_n(p, __ATOMIC_ACQUIRE) != hi - 1)
        return 3;
    if (__atomic_add_fetch(p, 1, __ATOMIC_RELAXED) != hi)
        return 4;
    if (__atomic_exchange_n(p, w, __ATOMIC_SEQ_CST) != hi || v != w)
        return 5;
    if (__atomic_fetch_and(p, hi | 7, __ATOMIC_SEQ_CST) != w || v != 5)
        return 6;
    if (__atomic_or_fetch(p, (u128)3 << 99, __ATOMIC_SEQ_CST) != (((u128)3 << 99) | 5))
        return 7;
    if (__atomic_xor_fetch(p, (u128)1 << 99, __ATOMIC_SEQ_CST) != (((u128)1 << 100) | 5))
        return 8;
    __atomic_store_n(p, 42, __ATOMIC_RELEASE);
    if (__sync_val_compare_and_swap(p, 42, 43) != 42 || __sync_bool_compare_and_swap(p, 1, 2) || v != 43)
        return 9;
    u128 r, x = ~(u128)0;
    __atomic_store(p, &x, __ATOMIC_SEQ_CST);
    __atomic_load(p, &r, __ATOMIC_SEQ_CST);
    if (r != x || __sync_fetch_and_add(p, 1) != x || v != 0)
        return 10;
    return 0;
}
