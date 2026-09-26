// An aggregate of 1, 2, 4 or 8 bytes crosses a call by value whatever its
// members: the Microsoft x64 convention passes it as an integer, so its bytes
// arrive in rcx, which the naked callees below return. Elsewhere the callees
// return the parameter's bytes from C. Bytes 1-3 of `struct cf` are padding.
#include <string.h>

typedef long long ll;
struct f2 { float x, y; };
struct d1 { double d; };
struct f1 { float f; };
struct cf { char c; float f; };

#if defined(_WIN32) && defined(__x86_64__) && (defined(__clang__) || !defined(__GNUC__)) \
    && !defined(_MSC_VER)
__attribute__((naked, noinline)) static ll bits_f2(struct f2 s) {
    __asm__("movq %rcx, %rax\n\tret");
}
__attribute__((naked, noinline)) static ll bits_d1(struct d1 s) {
    __asm__("movq %rcx, %rax\n\tret");
}
__attribute__((naked, noinline)) static ll bits_f1(struct f1 s) {
    __asm__("movl %ecx, %eax\n\tret");
}
__attribute__((naked, noinline)) static ll bits_cf(struct cf s, ll t) {
    __asm__("movq %rcx, %rax\n\taddq %rdx, %rax\n\tret");
}
#else
static ll bits_f2(struct f2 s) { ll r; memcpy(&r, &s, 8); return r; }
static ll bits_d1(struct d1 s) { ll r; memcpy(&r, &s, 8); return r; }
static ll bits_f1(struct f1 s) { unsigned r; memcpy(&r, &s, 4); return r; }
static ll bits_cf(struct cf s, ll t) { ll r; memcpy(&r, &s, 8); return r + t; }
#endif

static struct f2 make_f2(float x, float y) { struct f2 r = { x, y }; return r; }

int main(void) {
    struct f2 a = { 1.0f, 2.0f };
    struct d1 b = { 3.0 };
    struct f1 c = { 1.5f };
    struct cf d;
    memset(&d, 0, sizeof d);
    d.c = 'A';
    d.f = 2.5f;
    if (bits_f2(a) != 0x400000003f800000LL) return 1;
    if (bits_d1(b) != 0x4008000000000000LL) return 2;
    if (bits_f1(c) != 0x3fc00000LL) return 3;
    if ((bits_cf(d, 0) & 0xffffffff000000ffLL) != 0x4020000000000041LL) return 4;
    if (bits_f2(make_f2(3.0f, 4.0f)) != 0x4080000040400000LL) return 5;
    return 0;
}
