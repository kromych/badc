// C11 __atomic_*_fetch read-modify-write builtins: unlike the
// __atomic_fetch_* family (which return the prior value), these return the
// updated value. Exercise add / sub / and / or / xor and confirm both the
// return value and the final stored value.

int main(void) {
    int x = 10;
    if (__atomic_add_fetch(&x, 5, __ATOMIC_SEQ_CST) != 15) return 1;
    if (__atomic_sub_fetch(&x, 3, __ATOMIC_SEQ_CST) != 12) return 2;
    if (__atomic_and_fetch(&x, 0xF, __ATOMIC_SEQ_CST) != 12) return 3;
    if (__atomic_or_fetch(&x, 0x1, __ATOMIC_SEQ_CST) != 13) return 4;
    if (__atomic_xor_fetch(&x, 0x3, __ATOMIC_SEQ_CST) != 14) return 5;
    if (x != 14) return 6;

    // The older __sync_*_and_fetch spelling returns the updated value too.
    long y = 100;
    if (__sync_add_and_fetch(&y, 7) != 107) return 7;
    if (__sync_sub_and_fetch(&y, 10) != 97) return 8;
    if (y != 97) return 9;
    return 0;
}
