#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dlfcn.h>

// Reach the system's `strlen` via the `dlopen(NULL, RTLD_NOW)` +
// `dlsym` two-step. Picked over `sscanf` for the README's
// "Fun recipes" because variadic `dlsym` targets need
// target-specific stack-arg layout (macOS AAPCS64 puts varargs on
// the stack, AArch64 Linux puts them in registers, SysV x86_64 needs
// AL = 0 for XMM count, ...) and `Op::Jsri` doesn't yet know whether
// the dlsym'd target is variadic. `strlen` is non-variadic, so the
// existing register-only arg lowering matches AAPCS64 / SysV
// expectations everywhere POSIX.
//
// On Windows, `dlopen` lands on `LoadLibraryA`, which has different
// flag values; this fixture is POSIX-only.
int main() {
    int *h;
    int *fn;
    h = dlopen(0, 2);              // RTLD_NOW
    fn = dlsym(h, "strlen");
    return fn("hello, world!");    // 13 -- length without the NUL
}
