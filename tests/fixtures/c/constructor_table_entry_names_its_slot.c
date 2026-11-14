// A name a unit defines in a constructor table entry labels the entry's
// slot: it reads the function the entry holds, and an `/INCLUDE:` of it
// keeps the entry. Exits 0 when the initializer and the TLS callback ran
// before `main` and each name reads its function.

#ifdef _WIN32
#include <windows.h>

static volatile int ran, attached;

static int initializer(void) {
    ran = 1;
    return 0;
}

static void NTAPI callback(PVOID module, DWORD reason, PVOID reserved) {
    (void)module, (void)reserved;
    if (reason == DLL_PROCESS_ATTACH) attached = 1;
}

#pragma comment(linker, "/INCLUDE:_tls_used")
#pragma comment(linker, "/INCLUDE:p_initializer")
#pragma comment(linker, "/INCLUDE:p_callback")
#pragma section(".CRT$XIU", long, read)
#pragma section(".CRT$XLB", long, read)
__declspec(allocate(".CRT$XIU")) int (*p_initializer)(void) = initializer;
__declspec(allocate(".CRT$XLB")) PIMAGE_TLS_CALLBACK p_callback = callback;

int main(void) {
    if (!ran || !attached) return 1;
    if (p_initializer != initializer) return 2;
    return p_callback == callback ? 0 : 3;
}
#else
int main(void) { return 0; }
#endif
