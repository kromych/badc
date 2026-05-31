// Regression for the x86_64 Binop emit gap that surfaced as a
// quicksort -O SIGSEGV. When the SSA allocator places rhs and dst
// in the same register and lhs is spilled, the lhs spill-load to
// rd happens before the rhs-staging mov, destroying the rhs value.
// The commutative shortcut then emits `add rd, rd` which computes
// `lhs + lhs` instead of `lhs + rhs`. The fix preserves rhs into
// the scratch reg ahead of the lhs spill load.
//
// Shape: a function with enough live values to force one parameter
// (the array base) into a spill, plus a loop body that computes
// `base[i]` -- the `add base, i*4` is the offending Binop add.

int sum_at_high(int *base, int low, int high) {
    int i;
    int total;
    int pivot;
    pivot = base[high];
    total = 0;
    for (i = low; i <= high; i++) {
        total = total + base[i];
    }
    return total + pivot;
}

int main() {
    int arr[5];
    arr[0] = 12;
    arr[1] = 7;
    arr[2] = 15;
    arr[3] = 5;
    arr[4] = 10;
    return sum_at_high(arr, 0, 4);
}
