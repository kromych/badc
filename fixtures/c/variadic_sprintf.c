#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// `sprintf(buf, fmt, a, b, c, d)` -- two fixed args, four variadic.
// The macOS arm64 variadic ABI passes fixed args in `x0..x7` per
// AAPCS64 and spills the variadic tail to the stack at 8-byte
// spacing. badc used to special-case `printf` (one fixed arg)
// inside the variadic packer, which silently miscompiled
// every other variadic libc function on macOS -- the format
// string went to `x0` regardless of how many fixed args came
// before. This fixture exercises the corrected path: the binding's
// `is_variadic` + `fixed_args` come from the prototype the parser
// folded onto the `#pragma binding` for `sprintf`.
//
// Linux AAPCS64 / SysV x86_64 / Win64 don't have the macOS
// stack-packing quirk (variadic args ride registers identically
// to fixed args), so this also confirms the abi-driven path
// stays correct on those targets via the fixture-parity sweeps.
int main() {
    char *buf;
    int n;
    buf = malloc(64);
    n = sprintf(buf, "%d %d %d %d", 11, 22, 33, 44);
    if (n != 11) return 1;
    if (memcmp(buf, "11 22 33 44", 11) != 0) return 2;
    free(buf);
    return 0;
}
