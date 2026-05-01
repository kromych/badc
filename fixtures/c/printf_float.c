// Variadic FP packer test. `printf("%f\n", x)` with `x` a `double`
// drops the float arg into the wrong ABI slot today: SysV / Win64
// expect FP variadic args in XMM0..7 (with AL = XMM-count for
// SysV); the current libc-call lowering routes everything through
// the integer arg registers, so the formatted output prints
// garbage.
//
// `printf` returns the number of bytes written (`fprintf`-style),
// so the fixture compares that count against the bytes a correct
// `%f\n` for `1.5` produces ("1.500000\n" = 9 bytes). On a broken
// packer the bit pattern fed to printf isn't a valid double, the
// `%f` formatter prints whatever `__chk_fail`'s fallback produces
// (often "(null)" or a 0.0), and the exit code differs.
//
// Wired into native_elf and native_elf_x64 once the variadic FP
// packer ships -- until then this fixture lives outside the
// runner lists, runnable manually as documentation of the gap.

#include <stdio.h>
#include <stdlib.h>

int main() {
    int n;
    n = printf("%f\n", 1.5);
    if (n != 9) return 1;       // "1.500000\n"
    return 0;
}
