// A block-scope array dimension built from the constant-maximum idiom:
// `__builtin_choose_expr` selected by a null-pointer-constant test
// (C99 6.5.15p6) whose operand nests another chooser with a statement
// expression in the unchosen arm. The chooser condition must fold
// through the nested conditional, and evaluating the dimension must
// not disturb the enclosing declarator's VLA context even though the
// statement-expression arm declares locals of its own.

enum { A = 5, B = 9 };

#define IS_CONSTEXPR(x) \
    (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))

#define CMAX(a, b) \
    __builtin_choose_expr(IS_CONSTEXPR((a) - (b)), \
        ((a) > (b) ? (a) : (b)), \
        ({ unsigned __x = (a); unsigned __y = (b); __x > __y ? __x : __y; }))

int main(void) {
    unsigned long buff[CMAX(CMAX((unsigned)A, (unsigned)B), (unsigned)3)];
    if (sizeof(buff) != (unsigned)B * sizeof(unsigned long)) return 1;
    buff[0] = sizeof(buff);
    // A dimension the constant evaluator cannot fold is a C99 6.7.6.2
    // VLA; the statement expression inside it declares a local, whose
    // declarator parse must not clear the outer VLA permission.
    int n = 3;
    unsigned long vla[({ int __k = n; __k + 1; })];
    vla[0] = 7;
    if (sizeof(vla) != 4 * sizeof(unsigned long)) return 2;
    return (int)(buff[0] - buff[0]) + (int)(vla[0] - 7);
}
