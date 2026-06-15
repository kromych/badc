// Exercises a data binding (environ) through the single-TU emit_native
// path the native fixture harness uses. The CLI links multi-TU and
// resolves environ via the GOT data import; this path historically
// produced an image that faulted on the first environ read.
#include <stdlib.h>
#include <unistd.h>
extern char **environ;
int main(void) {
    setenv("BADC_PROBE", "1", 1);
    int n = 0;
    for (char **e = environ; *e; e++) { n++; }
    return n > 0 ? 0 : 1;
}
