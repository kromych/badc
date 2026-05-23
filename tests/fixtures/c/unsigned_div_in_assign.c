// C99 6.5.16.1 + 6.3.1.8: when an assignment's rhs contains an
// unsigned-typed division (e.g. `unsigned_long / int_const`), the
// parser routes the divide through `Op::Divu` and a masking dance
// that emits `Op::StLocI` / `Op::Or` / `Op::And` ops. Each of those
// inner ops routes through `ast_track_emit_op`, which pops the AST
// vstack; without a sentinel on entry the inner pops consume the
// outer assignment's lvalue and the resulting `Expr::Assign` lhs
// goes missing on the AST side. The walker then emits nothing for
// the assignment and the destination local stays uninitialised.
//
// Reproduces on a `long_local = struct_field_ul / int_const`
// shape -- the uninitialised lhs flows into a downstream
// allocator argument and trips SIGSEGV later in the program.
//
// Also exercises `%` (Op::Modu) since the same masking path is
// shared with the unsigned-modulus arm.

struct S {
    unsigned long off;
};

int outer(struct S *s) {
    int n, m;
    n = s->off / 24;
    m = s->off % 7;
    return n * 100 + m;
}

int main(void) {
    struct S s = { 240 };
    // 240/24 = 10; 240%7 = 2; expected = 10*100 + 2 = 1002
    return outer(&s) == 1002 ? 0 : 1;
}
