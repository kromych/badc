// GCC __atomic_* / __sync_* builtins. Each operation is checked against
// its defined result and post-state; the file returns 0 only when every
// builtin matches. Single-threaded, so it validates the value semantics
// (the memory ordering is exercised by the emitted barriers, not here).

static int fail; // distinct non-zero code per failed check

#define CHECK(n, cond) do { if (!(cond) && !fail) fail = (n); } while (0)

int main(void) {
    int v;

    // __atomic load / store / exchange.
    v = 10;
    CHECK(1, __atomic_load_n(&v, __ATOMIC_SEQ_CST) == 10);
    __atomic_store_n(&v, 20, __ATOMIC_SEQ_CST);
    CHECK(2, v == 20);
    CHECK(3, __atomic_exchange_n(&v, 30, __ATOMIC_SEQ_CST) == 20);
    CHECK(4, v == 30);

    // __atomic fetch family -- returns the prior value.
    v = 100;
    CHECK(5, __atomic_fetch_add(&v, 5, __ATOMIC_SEQ_CST) == 100 && v == 105);
    CHECK(6, __atomic_fetch_sub(&v, 5, __ATOMIC_SEQ_CST) == 105 && v == 100);
    v = 0xF0;
    CHECK(7, __atomic_fetch_and(&v, 0x3C, __ATOMIC_SEQ_CST) == 0xF0 && v == 0x30);
    CHECK(8, __atomic_fetch_or(&v, 0x0F, __ATOMIC_SEQ_CST) == 0x30 && v == 0x3F);
    CHECK(9, __atomic_fetch_xor(&v, 0xFF, __ATOMIC_SEQ_CST) == 0x3F && v == 0xC0);

    // __atomic_compare_exchange_n -- bool result, updates *expected on fail.
    v = 7;
    int exp = 7;
    CHECK(10, __atomic_compare_exchange_n(&v, &exp, 8, 0,
              __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST) == 1 && v == 8);
    exp = 7; // wrong now (v == 8)
    CHECK(11, __atomic_compare_exchange_n(&v, &exp, 9, 0,
              __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST) == 0 && v == 8 && exp == 8);

    // __sync fetch-and-op (returns old) and op-and-fetch (returns new).
    v = 100;
    CHECK(12, __sync_fetch_and_add(&v, 7) == 100 && v == 107);
    CHECK(13, __sync_sub_and_fetch(&v, 7) == 100 && v == 100);
    CHECK(14, __sync_add_and_fetch(&v, 1) == 101 && v == 101);
    v = 0xCC;
    CHECK(15, __sync_fetch_and_or(&v, 0x33) == 0xCC && v == 0xFF);
    CHECK(16, __sync_and_and_fetch(&v, 0x0F) == 0x0F && v == 0x0F);
    CHECK(17, __sync_xor_and_fetch(&v, 0xFF) == 0xF0 && v == 0xF0);

    // __sync compare-and-swap: val returns the prior contents, bool the flag.
    v = 5;
    CHECK(18, __sync_val_compare_and_swap(&v, 5, 6) == 5 && v == 6);
    CHECK(19, __sync_val_compare_and_swap(&v, 5, 7) == 6 && v == 6); // no swap
    CHECK(20, __sync_bool_compare_and_swap(&v, 6, 8) == 1 && v == 8);
    CHECK(21, __sync_bool_compare_and_swap(&v, 6, 9) == 0 && v == 8);

    // __sync_lock_test_and_set (exchange, returns old) / lock_release.
    v = 1;
    CHECK(22, __sync_lock_test_and_set(&v, 2) == 1 && v == 2);
    __sync_lock_release(&v);
    CHECK(23, v == 0);

    // __atomic_test_and_set on a byte / __atomic_clear.
    unsigned char flag = 0;
    CHECK(24, __atomic_test_and_set(&flag, __ATOMIC_SEQ_CST) == 0 && flag != 0);
    CHECK(25, __atomic_test_and_set(&flag, __ATOMIC_SEQ_CST) != 0);
    __atomic_clear(&flag, __ATOMIC_SEQ_CST);
    CHECK(26, flag == 0);

    // Fences emit a barrier and yield nothing; reaching here is the check.
    __atomic_thread_fence(__ATOMIC_SEQ_CST);
    __atomic_signal_fence(__ATOMIC_SEQ_CST);
    __sync_synchronize();
    CHECK(27, __atomic_is_lock_free(4, &v) == 1);

    return fail;
}
