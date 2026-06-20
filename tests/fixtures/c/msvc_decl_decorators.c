// MSVC decorators on badc's GNU surface: __declspec(thread) -> thread-local
// storage, __forceinline -> inline, __declspec(noreturn) -> noreturn, and
// other __declspec forms (dllexport) are accepted no-ops. Single-threaded
// here, so the thread-local reads and writes like a plain global.
#include <stdlib.h>

__declspec(thread) int tls_counter = 7;

__forceinline int add1(int x) {
    return x + 1;
}

__declspec(dllexport) int exported(void) {
    return 3;
}

__declspec(noreturn) static void halt(void) {
    for (;;) {
    }
}

int main(void) {
    tls_counter = add1(tls_counter) + exported();
    if (tls_counter != 11) {
        halt();
    }
    return 0;
}
