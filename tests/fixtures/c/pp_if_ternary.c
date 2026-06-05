// C99 6.10.1p1 / 6.5.15: the `#if` constant-expression accepts
// the ternary `cond ? then : else` at the top of the precedence
// chain. badc used to stop on the bare `?` token and surface
// "missing `)` in `#if` expression" inside a parenthesised
// ternary; the preprocessor expression parser now resolves
// ternary at every recursion entry (`#if`, `(...)`).

#if (1 ? 2 : 3) != 2
#error fail-positive-cond
#endif

#if (0 ? 2 : 3) != 3
#error fail-zero-cond
#endif

// Right-associative chains (C99 6.5.15p3): the else arm is itself
// a ternary expression.
#if (0 ? 1 : 1 ? 2 : 3) != 2
#error fail-right-assoc
#endif

// Nested parens, no whitespace.
#if ((1+1)==2 ? 7 : 8) != 7
#error fail-nested
#endif

int main(void) { return 0; }
