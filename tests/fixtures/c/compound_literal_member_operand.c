// C99 6.5.2.5: a compound literal is a value expression and may appear
// as an operand of any operator, including the right-hand operand of a
// binary operator: `x != (struct S){...}.member`. Building the literal
// runs a field-fill whose dual-emit bookkeeping pushed onto the shared
// parser vstack; left unbalanced, those residual entries sat on top of
// the caller's already-pushed left operand, so the wrapping operator
// popped the wrong slot and the whole expression collapsed (often to a
// constant 0). The literal must be vstack-neutral.

typedef struct { int id; } label;

int ne_rhs(label a) { return a.id != ((label){-1}).id; }   // a.id != -1
int eq_rhs(label a) { return a.id == ((label){-1}).id; }   // a.id == -1
int add_rhs(label a) { return a.id + ((label){-1}).id; }   // a.id + (-1)
int swapped(label a) { return ((label){-1}).id != a.id; }  // -1 != a.id

int main(void) {
    label a = {5};
    if (ne_rhs(a) != 1) return 1;       // 5 != -1 -> 1
    if (eq_rhs(a) != 0) return 2;       // 5 == -1 -> 0
    if (add_rhs(a) != 4) return 3;      // 5 + (-1) -> 4
    if (swapped(a) != 1) return 4;      // -1 != 5 -> 1

    // The left operand must survive even when it is itself a struct
    // value's member and the literal carries several fields.
    label b = {-1};
    if ((b.id != ((label){7}).id) != 1) return 5;  // -1 != 7 -> 1

    // A negative result confirms the left operand isn't dropped.
    if ((((label){3}).id - a.id) != -2) return 6;  // 3 - 5 -> -2
    return 0;
}
