// A value builtin yields a scalar whatever its operand decayed from, and
// __builtin_choose_expr yields the chosen operand with its own type, an
// array included; the discarded operand leaves no shape behind.
int arr[10];
int main(void) {
    if (sizeof __builtin_nanf("") != sizeof(float)) return 1;
    if (sizeof __builtin_nan("123") != sizeof(double)) return 2;
    if (sizeof __builtin_choose_expr(1, arr, 0) != sizeof arr) return 3;
    if (sizeof __builtin_choose_expr(0, 0, arr) != sizeof arr) return 4;
    if (sizeof __builtin_choose_expr(1, 0, arr) != sizeof(int)) return 5;
    return 0;
}
