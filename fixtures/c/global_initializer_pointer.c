// Pointer-to-global initializer: `int *p = &x;`. Exercises the
// per-format relocation channel (ELF: absolute VA written at
// emit time; Mach-O: rebase opcode; PE: `.reloc` DIR64 entry).
// At runtime `*p` reads through the relocated pointer, so
// failing to apply the relocation surfaces as a wrong value
// (or a crash dereferencing a stale pointer).

#include <stdlib.h>

int target = 7;
int *p = &target;

int main() {
    if (*p != 7) return 1;
    target = 11;
    if (*p != 11) return 2;
    return 0;
}
