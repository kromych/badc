// C99 6.3.1.4: a cast to an integer type inside a floating constant
// initializer truncates the operand before it rejoins the float
// expression, so `(int)1.9 + 0.5` is 1.5, not 2.4. The shared
// constant-expression evaluator applies the cast instead of
// discarding the cast type.
double cast_then_add = (int)1.9 + 0.5;
double cast_to_double = (double)7 / 2;

int main(void) {
    if (!(cast_then_add == 1.5)) return 1;
    if (!(cast_to_double == 3.5)) return 2;
    return 0;
}
