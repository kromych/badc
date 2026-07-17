// GNU conditional with omitted middle operand `a ?: b` (GCC extension):
// equivalent to `a ? a : b` but `a` is evaluated exactly once. Ubiquitous
// in real-world C (`x ?: "default"`) such as the Linux kernel.

static int calls = 0;
static int side_effect(int v) {
    calls++;
    return v;
}

// Constant-context forms fold in the constant-expression evaluator.
enum { EA = 5 ?: 99, EB = 0 ?: 42 };

int main(void) {
    volatile int zero = 0;
    volatile int five = 5;

    // Truthy keeps the value; falsy takes the alternative.
    if ((five ?: 99) != 5) return 1;
    if ((zero ?: 99) != 99) return 2;

    // Single evaluation of the condition: side_effect runs exactly once
    // whether the value is taken or not (a naive `a ? a : b` expansion
    // would call it twice when taken).
    calls = 0;
    int r = side_effect(7) ?: 100;
    if (r != 7 || calls != 1) return 3;
    calls = 0;
    int r2 = side_effect(0) ?: 100;
    if (r2 != 100 || calls != 1) return 4;

    // Pointer form (a common real-world shape).
    char *p = 0;
    const char *name = "x";
    if ((name ?: "unnamed")[0] != 'x') return 5;
    if ((p ?: "unnamed")[0] != 'u') return 6;

    // Nested, right-associative.
    if ((zero ?: zero ?: five) != 5) return 7;
    if ((zero ?: five ?: 99) != 5) return 8;

    // Result type is the usual-arithmetic-conversions common type:
    // `int ?: long long` is long-long-width.
    long long big = 0x100000000LL;
    long long w = five ?: big;
    if (w != 5) return 9;
    long long w2 = zero ?: big;
    if (w2 != 0x100000000LL) return 10;

    // Constant-context results.
    if (EA != 5) return 11;
    if (EB != 42) return 12;

    return 0;
}
