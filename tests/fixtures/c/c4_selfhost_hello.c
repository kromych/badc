// Stable input for the c4 self-host tests: badc compiles c4.c,
// then the resulting c4 compiles and runs this program. Kept in
// the c4 subset (the original four-function dialect -- no local
// initializers, no features beyond what c4.c parses) so the
// self-host check stays decoupled from the demo `hello.c`, which
// is free to exercise wider c5 features. Prints "Hello 123" and
// exits 0.
#include <stdio.h>
#include <stdlib.h>

int main() {
    printf("Hello %d\n", 123);
    return 0;
}
