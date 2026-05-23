// C99 6.8.1 + 6.8.4.2: a `goto`-target label that prefixes a
// `case` (or chain of cases) labels the same statement the
// case marks, so `goto foo;` from elsewhere in the function
// must land on the case body. The walker peels the `Labeled`
// wrapper while flattening the switch body and registers the
// label id as an alias for the partition's SSA block; without
// that registration `block_for_label` would allocate an orphan
// block on the goto site and execution would fall off the
// switch entirely.
//
// Surfaced by tcc's tccgen.c `precedence(int tok)`: its
// `default:` arm does `goto relat;` where `relat:` sits before
// `case TOK_ULT: case TOK_UGE:`. With the bug, `precedence(t)`
// returned garbage for relational tokens, the `expr_const`
// driver bailed before consuming `tok`, and every `#if`
// expression in tccdefs.h was rejected with `bad preprocessor
// expression`.

int classify(int n) {
    switch (n) {
        case 1: return 10;
        case 2: return 20;
    relat: case 3: case 4: return 30;
        default:
            if (n >= 5 && n <= 8) goto relat;
            return 0;
    }
}

int main(void) {
    if (classify(1) != 10) return 1;
    if (classify(2) != 20) return 2;
    if (classify(3) != 30) return 3;
    if (classify(4) != 30) return 4;
    if (classify(5) != 30) return 5;
    if (classify(7) != 30) return 6;
    if (classify(8) != 30) return 7;
    if (classify(0) != 0)  return 8;
    if (classify(9) != 0)  return 9;
    return 0;
}
