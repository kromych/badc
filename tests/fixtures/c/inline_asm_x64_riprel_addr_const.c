/* x86-64 `%c` RIP-relative operand naming a C99 6.6p9 address constant.
 * The `i`-class operand is the address of a function or of a
 * static-storage object; casts between object-pointer and integer types
 * of the same width keep the address, so the operand stays an address
 * constant through them. gcc assembles each site as
 * `leaq <symbol>(%rip), %reg`. */

static int stat_fn(void) { return 5; }
int glob_fn(void) { return 7; }

static struct {
    char pad[16];
    int v;
} obj = {{0}, 11};

static int arr[4] = {1, 2, 19, 4};

#define REL_PTR(x)                                                             \
    ({                                                                         \
        void *p_;                                                              \
        __asm__("leaq %c1(%%rip), %0" : "=r"(p_) : "i"((void *)(x)));           \
        p_;                                                                    \
    })

int main(void) {
    int (*sf)(void) = (int (*)(void))REL_PTR((unsigned long)&stat_fn);
    int (*gf)(void) = (int (*)(void))REL_PTR((unsigned long)glob_fn);
    int *pv = (int *)REL_PTR((unsigned long)&obj.v);
    int *pa = (int *)REL_PTR((unsigned long)&arr[2]);

    if (sf != stat_fn || gf != glob_fn || pv != &obj.v || pa != &arr[2])
        return 1;
    return sf() + gf() + *pv + *pa; /* 5 + 7 + 11 + 19 = 42 */
}
