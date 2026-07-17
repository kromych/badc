// `typeof` / `__typeof__` (a GCC extension, C23 6.7.2.5) names the type of a
// parenthesized type-name or unevaluated expression. It must work as a
// file-scope declaration specifier, the same as at block scope: the
// block-scope path already routed through the shared helper, while the
// file-scope declaration loop lacked the branch and rejected the specifier.

typeof(int) g_scalar = 7;               // type-name operand
__typeof__(int) g_gnu = 42;             // GNU spelling
int g_base = 5;
typeof(g_base + 1) g_expr = 9;          // unevaluated-expression operand
typeof(&g_base) g_ptr;                  // pointer type from an expression
typeof(const int) g_const = 11;         // qualified type-name
typeof(int) g_a = 1, g_b = 2, g_c = 3;  // one specifier, several declarators

typedef typeof(long long) my_i64;       // typeof inside a typedef
my_i64 g_typedefed = 123456789012345LL;

typeof(int) ret_int(void);              // function return type
typeof(int) ret_int(void) { return 8; }

int main(void) {
    if (g_scalar != 7) return 1;
    if (g_gnu != 42) return 2;
    if (g_expr != 9) return 3;
    g_ptr = &g_base;
    if (*g_ptr != 5) return 4;
    if (g_const != 11) return 5;
    if (g_a + g_b + g_c != 6) return 6;
    if (g_typedefed != 123456789012345LL) return 7;
    if (ret_int() != 8) return 8;

    // The file-scope typeof produced the right widths.
    if (sizeof(g_scalar) != sizeof(int)) return 9;
    if (sizeof(g_ptr) != sizeof(void *)) return 10;
    return 0;
}
