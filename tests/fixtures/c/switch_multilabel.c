// C99 6.8.4.2: a `case` or `default` label labels the next
// statement, so a chain like `case 'a': case 'b': case 'c':
// body;` puts three labels on the same body. The parser builds
// this as nested `Stmt::Case` whose `body` field is the next
// Case (or finally the real statement). The walker has to peel
// every label in the chain so the dispatcher emits one
// comparison per case value -- otherwise only the outermost
// label's value gets dispatched and the rest go to the
// default arm.
//
// Surfaced by tcc: its lexer dispatch switches on the input
// character with the ASCII letters and digits laid out as
// fall-through chains. With only the first label dispatched,
// the lexer rejected `d` (and every other non-first letter)
// with "unrecognized character".

int classify(int c) {
    switch (c) {
        case 'a':
        case 'b':
        case 'c':
        case 'd':
            return 1;
        case 'A': case 'B':
            return 2;
        case '0': case '1': case '2': case '3':
            return 3;
        default:
            return 0;
    }
}

int main(void) {
    if (classify('a') != 1) return 1;
    if (classify('b') != 1) return 2;
    if (classify('c') != 1) return 3;
    if (classify('d') != 1) return 4;
    if (classify('A') != 2) return 5;
    if (classify('B') != 2) return 6;
    if (classify('0') != 3) return 7;
    if (classify('3') != 3) return 8;
    if (classify('?') != 0) return 9;
    return 0;
}
