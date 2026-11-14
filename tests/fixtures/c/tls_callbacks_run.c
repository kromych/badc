// TLS callbacks a unit places in `.CRT$XL*`: the loader calls each, in
// section-name order, on process attach before the entry point and on
// thread attach and detach. `_tls_used` names the image's TLS directory,
// whose null-terminated callback array lists them. Exits 0 when they ran
// in that order and once each for the one thread the program starts.

#ifdef _WIN32
#include <windows.h>

static volatile int order, attached, detached;
static volatile DWORD worker_id;

static void NTAPI first(PVOID module, DWORD reason, PVOID reserved) {
    (void)module, (void)reserved;
    if (reason == DLL_PROCESS_ATTACH) order = order * 10 + 1;
}

static void NTAPI second(PVOID module, DWORD reason, PVOID reserved) {
    (void)module, (void)reserved;
    if (reason == DLL_PROCESS_ATTACH) order = order * 10 + 2;
    if (GetCurrentThreadId() != worker_id) return;
    if (reason == DLL_THREAD_ATTACH) attached++;
    if (reason == DLL_THREAD_DETACH) detached++;
}

#pragma comment(linker, "/INCLUDE:_tls_used")
#pragma section(".CRT$XLC", read)
#pragma section(".CRT$XLB", read)
__declspec(allocate(".CRT$XLC")) PIMAGE_TLS_CALLBACK p_second = second;
__declspec(allocate(".CRT$XLB")) PIMAGE_TLS_CALLBACK p_first = first;

extern const IMAGE_TLS_DIRECTORY _tls_used;

static DWORD WINAPI worker(LPVOID arg) { return (DWORD)(ULONG_PTR)arg; }

int main(void) {
    if (order != 12) return 1;
    PIMAGE_TLS_CALLBACK *cb = (PIMAGE_TLS_CALLBACK *)_tls_used.AddressOfCallBacks;
    if (!cb || cb[0] != first || cb[1] != second || cb[2]) return 2;
    DWORD id;
    HANDLE t = CreateThread(NULL, 0, worker, NULL, CREATE_SUSPENDED, &id);
    if (!t) return 3;
    worker_id = id;
    ResumeThread(t);
    WaitForSingleObject(t, INFINITE);
    CloseHandle(t);
    return attached == 1 && detached == 1 ? 0 : 4;
}
#else
int main(void) { return 0; }
#endif
