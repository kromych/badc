// The GCC integer absolute-value builtins fold in every
// constant-expression context: a static initializer, an enum value,
// and an array dimension. The operand narrows to the parameter type
// first, matching the library functions' runtime behavior.

static const int ai = __builtin_abs(-6);
static const long al = __builtin_labs(-60000000000L);
static const long long all = __builtin_llabs(-7LL);
enum { EA = __builtin_abs(-3) };
static int arr[__builtin_abs(-3)];

int main(void) {
    if (ai != 6) return 1;
    if (sizeof(long) == 8 && al != 60000000000L) return 2;
    if (all != 7) return 3;
    if (EA != 3) return 4;
    if (sizeof(arr) / sizeof(arr[0]) != 3) return 5;
    return 0;
}
