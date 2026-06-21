// C99 6.6: a conditional expression with a constant condition is itself
// a constant expression. When the arms are address constants, the
// selected arm's relocation must survive into the static initializer --
// the integer constant evaluator can fold the value but not carry the
// address. Surfaced by CPython's clinic tables (`_Py_LATIN1_CHR`), which
// initialize a pointer array with `(ch < 128 ? &a[ch] : &b[ch-128])`.

struct Cell {
    int tag;
    long value;
};

static int nums[4] = { 10, 20, 30, 40 };
static struct Cell cells[3] = {
    { 1, 100 },
    { 2, 200 },
    { 3, 300 },
};

// Each element selects an address constant through a constant condition;
// the parenthesised arms mix a plain `&`, a cast, and a member/index
// chain (the shapes the clinic tables produce).
static int *int_ptrs[3] = {
    (1 ? &nums[2] : &nums[0]),
    (0 ? &nums[1] : &nums[3]),
    ((5 < 3) ? (int *)&nums[0] : (int *)&nums[1]),
};
static long *field_ptrs[2] = {
    (1 ? &cells[0].value : &cells[2].value),
    ((2 + 2 == 4) ? &cells[1].value : &cells[0].value),
};

int main(void) {
    if (*int_ptrs[0] != 30) return 1;
    if (*int_ptrs[1] != 40) return 2;
    if (*int_ptrs[2] != 20) return 3;
    if (*field_ptrs[0] != 100) return 4;
    if (*field_ptrs[1] != 200) return 5;
    return 0;
}
