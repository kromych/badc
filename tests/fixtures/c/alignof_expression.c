// GCC __alignof__ accepts an expression operand (C11 _Alignof takes a
// type-name); the result is the alignment of the operand's type. The
// operand is unevaluated, so the null-pointer derefs never execute.
struct m { long long v; char c; };
struct r { struct m *m; };
struct e { int a[4]; long long s[2]; };
int main(void) {
    struct r *r = 0;
    struct e *e = 0;
    return (__alignof__(*r->m) == 8
            && __alignof__(e->a[0]) == 4
            && __alignof__(e->s[0]) == 8
            && __alignof__(long long) == 8)
               ? 0
               : 1;
}
