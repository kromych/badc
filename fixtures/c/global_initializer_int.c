// Scalar global initializer: `int x = 42;`. Smoke test that
// the c5 frontend parses the `= <const>` form, the byte
// representation lands in `.data` at the symbol's offset, and
// the runtime sees the initialized value (no zero-init by
// accident).

#include <stdlib.h>

int answer = 42;
int sentinel = 99;

int main() {
    if (answer != 42) return 1;
    if (sentinel != 99) return 2;
    return answer + sentinel;
}
