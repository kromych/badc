// GCC and Clang predefine __LP64__ and _LP64 on every LP64 target
// (64-bit long, 64-bit pointer) and leave them undefined on LLP64
// (Windows, 32-bit long). Code that selects a 64-bit-wide integer type
// or an overflow-checking path branches on these macros, so the
// predefine must agree with the actual `long` width. macOS-aarch64 and
// Linux x86_64/aarch64 are LP64; Windows x64/arm64 are LLP64.
int main(void) {
#ifdef __LP64__
    if (sizeof(long) != 8) {
        return 1;
    }
#ifndef _LP64
    return 2;
#endif
    return (sizeof(void *) == 8) ? 0 : 3;
#else
    return (sizeof(long) == 4) ? 0 : 4;
#endif
}
