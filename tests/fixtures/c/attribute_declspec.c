// MSVC `__declspec(...)` is a declaration decorator the dialect treats
// like a GCC `__attribute__`. `__declspec(dllexport)` exports the symbol,
// the equivalent of `#pragma export`; the remaining hints here --
// `noinline`, `align`, calling convention -- are advisory and discarded.
// Real-world Windows C gates these on `_WIN32` (not just `_MSC_VER`),
// so a GNU-C-on-Windows toolchain must accept them. Spelled here
// unconditionally so the parser path is exercised on every target;
// host clang rejects `__declspec` without `-fdeclspec`, so this fixture
// is checked against badc only.

__declspec(dllexport) int exported(int x);
__declspec(noinline) static int slow(int x) { return x * 2; }
struct __declspec(align(8)) Aligned { int a; };

int exported(int x) { return x + 1; }

int main(void) {
    if (exported(4) != 5) return 1;
    if (slow(3) != 6) return 2;
    struct Aligned s;
    s.a = 7;
    if (s.a != 7) return 3;
    return 0;
}
