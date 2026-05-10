// Exercise the lexer's no-op keyword absorption: const, volatile,
// restrict, signed, unsigned, short, long, _Bool, register, auto,
// inline. None of these have semantic effect in c5 (every integer is
// 64-bit, no const-correctness, no inline expansion); the test just
// pins that they parse cleanly at every declaration position so
// unmodified C source from the wild lexes and runs. No local
// initializers / array types here -- those wait for later milestones.

// File-scope: storage class + qualifier + int modifier + base type
// + trailing modifier, all collapsing to int.
static const unsigned long long g_count;

// File-scope: bare modifier with implicit-int rule.
static unsigned g_flags;

// Pointer-level qualifier in a global declaration with initializer
// (the supported address-constant initializer shape).
static const char *const g_name;

// Function specifier on a function definition.
static inline int add(const int a, const unsigned int b) {
    return a + b;
}

// Pointer parameter with multiple qualifiers + restrict + int modifier
// in a parameter type.
static int read_one(const int *restrict p, register unsigned long n) {
    int v;
    long i;
    v = 0;
    i = 0;
    while (i < n) {
        v = v + *p;
        i = i + 1;
    }
    return v;
}

// Struct field with qualifier and int modifier.
struct Counter {
    const unsigned long ticks;
    volatile int active;
};

int main() {
    // Local with qualifier + int modifier + trailing modifier.
    const unsigned long long sum;
    // Local with implicit-int via bare modifier.
    register short i;
    // Local with function specifier (silly but accepted).
    inline auto int total;
    // Local with pointer-level qualifier.
    const char *const tag;

    int v;
    int *p;
    // Local with qualified pointer type, declared at the top of the
    // block (c5 only supports leading declarations today).
    const char *q;

    v = 7;
    p = &v;

    if (add(1, 2) != 3) return 1;
    if (read_one(p, 1) != 7) return 2;

    // Cast with qualified type name: `(const char *)expr`.
    q = (const char *)"badc";
    if (q[0] != 'b') return 3;

    // sizeof with qualified type-name and pointer-level qualifier.
    if (sizeof(const unsigned long long) != 8) return 4;
    if (sizeof(const char *) != 8) return 5;
    if (sizeof(const char *const) != 8) return 6;

    g_flags = 1;
    if (g_flags != 1) return 7;

    return 0;
}
