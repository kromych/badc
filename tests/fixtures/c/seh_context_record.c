// The CONTEXT record the kernel writes for an exception and the one
// RtlCaptureContext fills are read at the Windows SDK's layout: the
// program counter of a breakpoint agrees with the exception address, and
// the stack pointer captured in `main` lies just above a callee's frame.
// Elsewhere there is no SEH and the program exits 0.

#ifdef _WIN32
#include <windows.h>

#ifdef __aarch64__
#define PC(c) ((c)->Pc)
#define SP(c) ((c)->Sp)
#define BREAK_LEN 4
#define AT_BREAK(pc) (*(const DWORD *)(pc) == 0xD43E0000) // brk #0xF000
#else
#define PC(c) ((c)->Rip)
#define SP(c) ((c)->Rsp)
#define BREAK_LEN 1
#define AT_BREAK(pc) (*(const BYTE *)(pc) == 0xCC) // int3
#endif

static volatile LONG entries;
static volatile ULONG_PTR fault_pc, fault_addr;

// The breakpoint is reported at its own instruction; step over it. A
// second entry means the record was not read where the kernel wrote it.
static LONG WINAPI on_breakpoint(EXCEPTION_POINTERS *ep)
{
    if (ep->ExceptionRecord->ExceptionCode != EXCEPTION_BREAKPOINT || entries++)
        return EXCEPTION_CONTINUE_SEARCH;
    fault_pc = PC(ep->ContextRecord);
    fault_addr = (ULONG_PTR)ep->ExceptionRecord->ExceptionAddress;
    if (AT_BREAK(fault_pc))
        PC(ep->ContextRecord) += BREAK_LEN;
    return EXCEPTION_CONTINUE_EXECUTION;
}

// An exception nothing handles ends the process with its code.
static LONG WINAPI quiet_exit(EXCEPTION_POINTERS *ep)
{
    (void)ep;
    return EXCEPTION_EXECUTE_HANDLER;
}

__attribute__((noinline)) static ULONG_PTR below_caller(void)
{
    volatile char c = 0;
    return (ULONG_PTR)&c;
}

static ULONG_PTR distance(ULONG_PTR a, ULONG_PTR b) { return a > b ? a - b : b - a; }

int main(void)
{
    CONTEXT here;
    PVOID cookie;
    ULONG_PTR callee;

    SetUnhandledExceptionFilter(quiet_exit);
    cookie = AddVectoredExceptionHandler(1, on_breakpoint);
    if (!cookie) return 1;
    if (((ULONG_PTR)&here & 15) != 0) return 2;
    callee = below_caller();
    RtlCaptureContext(&here);
    if (here.ContextFlags == 0) return 3;
    if (SP(&here) < callee || SP(&here) - callee > 512) return 4;
    if (distance(PC(&here), (ULONG_PTR)&main) > 4096) return 5;
    DebugBreak();
    if (entries != 1) return 6;
    if (distance(fault_pc, fault_addr) > BREAK_LEN) return 7;
    if (RemoveVectoredExceptionHandler(cookie) == 0) return 8;
    return 0;
}
#else
int main(void) { return 0; }
#endif
