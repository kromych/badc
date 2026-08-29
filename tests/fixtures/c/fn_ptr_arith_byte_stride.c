// Arithmetic on a pointer to function. C99 6.5.6 admits additive
// operands only for pointers to complete object types, so it leaves
// this case open; GCC and Clang define it with a one-byte stride, and
// the kernel relies on that: kernel/bpf/fixups.c derives a BPF helper's
// call immediate as `fn->func - __bpf_call_base` and the JIT recovers
// the helper with `(u8 *)__bpf_call_base + imm`. Scaling the difference
// by the pointee size instead makes every JIT-compiled helper call jump
// to an address inside an unrelated function.

typedef unsigned long long u64;

static u64 f1(u64 a, u64 b, u64 c, u64 d, u64 e) { return a + b + c + d + e; }
static u64 f2(u64 a, u64 b, u64 c, u64 d, u64 e) { return a * b + c + d + e; }

typedef u64 (*fn_t)(u64, u64, u64, u64, u64);

struct proto { fn_t func; };

static long imm_of(const struct proto *p) { return p->func - f1; }

int main(void) {
    struct proto p;
    fn_t a = f1;
    fn_t b = f2;
    long bytes = (char *)b - (char *)a;

    p.func = f2;
    // The kernel's shape: a function-pointer struct member minus a
    // function designator.
    if (imm_of(&p) != bytes) return 1;
    // Both operands as values.
    if (b - a != bytes) return 2;
    // Both operands as designators.
    if (f2 - f1 != bytes) return 3;
    // Pointer plus integer, in both operand orders, and minus.
    if ((char *)(a + 3) != (char *)a + 3) return 4;
    if ((char *)(3 + a) != (char *)a + 3) return 5;
    if ((char *)(a - 3) != (char *)a - 3) return 6;
    // The offset round-trips back to a callable address.
    if (((fn_t)((char *)a + (b - a)))(2, 3, 4, 5, 6) != f2(2, 3, 4, 5, 6)) return 7;
    // `++` / `--` / `+=` / `-=` take the same one-byte stride.
    {
        fn_t q = a;
        q++;
        if ((char *)q != (char *)a + 1) return 10;
        --q;
        if ((char *)q != (char *)a) return 11;
        q += 3;
        if ((char *)q != (char *)a + 3) return 12;
        q -= 5;
        if ((char *)q != (char *)a - 2) return 13;
    }
    // An array of function pointers decays to a pointer to one, so it
    // keeps the pointer stride; only the pointed-to function is the
    // one-byte case.
    {
        fn_t tab[3];
        fn_t *e = tab;
        tab[0] = f1;
        tab[1] = f2;
        tab[2] = f1;
        if (e + 2 != &tab[2]) return 16;
        if ((e + 2) - e != 2) return 17;
        e++;
        if (e != &tab[1]) return 18;
        e += 1;
        if (e != &tab[2]) return 19;
        if ((*(tab + 1))(2, 3, 4, 5, 6) != f2(2, 3, 4, 5, 6)) return 20;
    }
    // A data pointer keeps its own stride.
    {
        int arr[4];
        int *q = &arr[3];
        if (q - &arr[0] != 3) return 8;
        if ((char *)q - (char *)&arr[0] != 3 * (long)sizeof(int)) return 9;
        q--;
        if (q != &arr[2]) return 14;
        q -= 2;
        if (q != &arr[0]) return 15;
    }
    return 0;
}
