/* AArch64 barrier instructions through the general inline-asm path:
 * dmb / dsb with each domain option, isb, and clrex. All execute as
 * ordering points with no register effect, so a store-load pair
 * around them checks pass-through. */

int main(void) {
    int v = 40;
    asm volatile("dmb ish" ::: "memory");
    asm volatile("dmb ishld\n\tdmb ishst" ::: "memory");
    asm volatile("dmb osh\n\tdmb oshld\n\tdmb oshst" ::: "memory");
    asm volatile("dmb nsh\n\tdmb nshld\n\tdmb nshst" ::: "memory");
    asm volatile("dmb sy\n\tdmb ld\n\tdmb st" ::: "memory");
    v += 1;
    asm volatile("dsb ish\n\tdsb ishst\n\tdsb sy" ::: "memory");
    asm volatile("isb" ::: "memory");
    asm volatile("isb sy" ::: "memory");
    asm volatile("clrex");
    v += 1;
    return v;
}
