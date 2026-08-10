// C99 6.5.2.5p1: a compound literal `( type-name ){ initializer-list }`
// is a primary expression, usable anywhere a primary expression is --
// including as a sub-expression inside another aggregate's brace
// initializer. The struct-initializer element path detected a leading
// `( type-name ){` and treated it as a redundant cast to the member's
// type, consuming the braces as a nested initializer. That is correct
// only when the literal is the whole element value; when a postfix
// (`.`/`->`/`[`/`(`) or an operator follows the literal's `}`, the
// literal is a sub-expression of a larger element and the whole run must
// go to the expression parser. Otherwise `T t = { (S){...}.m }` failed
// to parse.

typedef struct {
    int p;
} S;

typedef struct {
    int q;
} T;

typedef struct {
    int a[3];
} A;

int main(void) {
    // Compound literal nested inside another compound literal's
    // initializer, itself a sub-expression: inner `.p` is 0, so 0 + 1.
    S b = (S){((S){0}).p + 1};
    if (b.p != 1) return 1;

    // Compound literal as a sub-expression (postfix `.member`) inside a
    // struct brace initializer.
    T t = {(S){7}.p};
    if (t.q != 7) return 2;

    // Postfix `[index]` on a compound literal inside a struct brace
    // initializer.
    T u = {(A){{4, 5, 6}}.a[2]};
    if (u.q != 6) return 3;

    // Arithmetic on a grouped compound literal member inside a struct
    // brace initializer.
    T v = {((S){5}).p * 2 + 3};
    if (v.q != 13) return 4;

    // A bare compound literal that IS the whole element value still
    // elides the redundant member-type cast and fills in place.
    T w = {(int){9}};
    if (w.q != 9) return 5;

    // Block-scope compound literal has automatic storage lasting to the
    // end of the block; its address is writable and reads back.
    S *q = &(S){((S){4}).p};
    q->p += 1;
    if (q->p != 5) return 6;

    return 0;
}
