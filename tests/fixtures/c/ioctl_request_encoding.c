// `<sys/ioctl.h>` must provide the `_IO` / `_IOR` / `_IOW` / `_IOWR` request-
// encoding macros on every target. `_IOR`/`_IOW`/`_IOWR` take a *type* whose
// `sizeof` fills the size field, so the third argument is a type name rather
// than an expression. The Linux branch pulled these from <linux/ioctl.h>, but
// the macOS branch omitted them, so `_IOR('H', 1, int)` parsed as a call to an
// undefined `_IOR` and rejected the `int` type argument. The concrete request
// numbers differ per target (BSD vs Linux encodings); assert only the
// relationships that hold on both.

#include <sys/ioctl.h>

int main(void) {
    // The macros exist and accept a type argument (the regression: this must
    // parse, not reject `int` as a bad expression).
    if (_IOR('f', 127, int) == 0) return 1;

    // Read and write carry different direction bits.
    if (_IOR('f', 127, int) == _IOW('f', 127, int)) return 2;

    // The argument size is encoded, so distinct element sizes differ.
    if (_IOR('f', 127, char) == _IOR('f', 127, long long)) return 3;

    // A no-argument request differs from a read of the same group/number.
    if (_IO('t', 1) == _IOR('t', 1, int)) return 4;

    // Read/write is distinct from read-write.
    if (_IOWR('U', 0x12, int) == _IOR('U', 0x12, int)) return 5;

    return 0;
}
