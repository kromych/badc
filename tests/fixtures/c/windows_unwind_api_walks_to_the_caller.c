// <windows.h>'s table-based unwinding: from a captured context,
// RtlLookupFunctionEntry and RtlVirtualUnwind step frame by frame to the
// caller, and the entry found for each frame's address names its function.
// GetModuleHandleExA and RtlPcToFileHeader name the image holding an
// address. Exits 0 when the walk reaches main and both queries name the
// executable; elsewhere there is nothing to check.

#ifdef _WIN32
#include <windows.h>

static DWORD64 pc_of(const CONTEXT *c) {
#ifdef __aarch64__
    return c->Pc;
#else
    return c->Rip;
#endif
}

static DWORD begin_of(DWORD64 pc) {
    DWORD64 base = 0;
    PRUNTIME_FUNCTION fn = RtlLookupFunctionEntry(pc, &base, NULL);
    return fn ? fn->BeginAddress : 0;
}

// The number of frames from here up to the function starting at `target`.
__attribute__((noinline)) static int frames_to(DWORD target) {
    CONTEXT c;
    RtlCaptureContext(&c);
    for (int i = 1; i <= 8; i++) {
        DWORD64 base = 0;
        PRUNTIME_FUNCTION fn = RtlLookupFunctionEntry(pc_of(&c), &base, NULL);
        PVOID data = 0;
        DWORD64 frame = 0;
        if (!fn)
            return -1;
        RtlVirtualUnwind(UNW_FLAG_NHANDLER, base, pc_of(&c), fn, &c, &data, &frame, NULL);
        if (begin_of(pc_of(&c)) == target)
            return i;
    }
    return 0;
}

__attribute__((noinline)) static int middle(DWORD target) {
    volatile int n = frames_to(target);
    return n;
}

int main(void) {
    HMODULE self = GetModuleHandleA(NULL), held = 0;
    PVOID base = 0;
    DWORD64 image = 0;
    if (!RtlLookupFunctionEntry((DWORD64)&main, &image, NULL) || image != (DWORD64)self)
        return 1;
    if (middle(begin_of((DWORD64)&main)) < 2)
        return 2;
    if (!GetModuleHandleExA(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS |
                                GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT,
                            (LPCSTR)&main, &held) ||
        held != self)
        return 3;
    if (RtlPcToFileHeader((PVOID)&main, &base) != (PVOID)self || base != (PVOID)self)
        return 4;
    return 0;
}
#else
int main(void) {
    return 0;
}
#endif
