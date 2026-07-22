// C99 6.5.3.2p3: `&arr` has type "pointer to array", not the decayed
// element pointer -- so `sizeof(&arr)` is a pointer's width and
// `typeof(&arr)` / `typeof(*(&arr))` round-trip. The Linux per-CPU
// `SHIFT_PERCPU_PTR` shape -- `(typeof(*(ptr)) *)((addr)(ptr) + off)` over
// `&array` -- relies on all of these. Returns 0 on success.

int arr[4] = { 10, 20, 30, 40 };

int main(void) {
    // `&arr` is a pointer: its size is a pointer's, not the array's.
    if (sizeof(&arr) != sizeof(int (*)[4])) return 1;
    if (sizeof(arr) != 4 * sizeof(int)) return 2;

    // `typeof(&arr)` is a pointer-to-array; deref + subscript reads elements.
    typeof(&arr) p = &arr;
    for (int i = 0; i < 4; i++)
        if ((*p)[i] != 10 + 10 * i) return 3;

    // `typeof(*(&arr))` is the array itself.
    if (sizeof(typeof(*(&arr))) != 4 * sizeof(int)) return 4;

    // Per-CPU shape: cast an integer address to `typeof(*(&arr)) *` (a
    // pointer-to-array), then deref and subscript.
    unsigned long long base = (unsigned long long)&arr;
    for (int i = 0; i < 4; i++) {
        int v = (*({ (typeof((typeof(*(&arr)) *)(&arr)))(base); }))[i];
        if (v != 10 + 10 * i) return 5;
    }

    // A string literal has array type char[N] (N counts the NUL).
    if (sizeof(typeof("hello")) != 6) return 6;
    return 0;
}
