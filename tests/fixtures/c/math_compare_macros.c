// C99 7.12.14 relational macros (isgreater / isgreaterequal / isless /
// islessequal / islessgreater / isunordered). A NaN operand compares false
// and is unordered. Returns 0 on success.

#include <math.h>

int main(void) {
    double nan = 0.0 / 0.0;

    if (!(isgreater(2.0, 1.0) && !isgreater(1.0, 2.0) && !isgreater(nan, 1.0))) {
        return 1;
    }
    if (!(isgreaterequal(2.0, 2.0) && isgreaterequal(3.0, 2.0) && !isgreaterequal(nan, 2.0))) {
        return 2;
    }
    if (!(isless(1.0, 2.0) && !isless(2.0, 1.0) && !isless(nan, 2.0))) {
        return 3;
    }
    if (!(islessequal(2.0, 2.0) && islessequal(1.0, 2.0) && !islessequal(nan, 2.0))) {
        return 4;
    }
    if (!(islessgreater(1.0, 2.0) && !islessgreater(2.0, 2.0) && !islessgreater(nan, 2.0))) {
        return 5;
    }
    if (!(isunordered(nan, 1.0) && isunordered(1.0, nan) && !isunordered(1.0, 2.0))) {
        return 6;
    }
    return 0;
}
