// A DLL cl builds for the structured exception handling test across a DLL
// boundary: a badc executable links its import library and raises, catches
// and unwinds through its functions. Without a C runtime the DLL takes
// __C_specific_handler from msvcrt.dll, as badc code does:
//
//   lib /nologo /machine:<arch> /def:seh_msvcrt.def /out:seh_msvcrt.lib
//   cl /nologo /O1 /GS- /Zl /LD seh_dll_cl.c seh_msvcrt.lib kernel32.lib
//      /link /NOENTRY /NODEFAULTLIB /OUT:seh_dll_cl.<arch>.dll
//      /IMPLIB:seh_dll_cl.<arch>.lib
//
// with <arch> x64 or arm64; the DLL is checked in as seh_dll_cl.<arch>.pe.
//
// Each `__finally` block appends 1 to `*flag` in decimal, or 2 when an
// exception or a `longjmp` runs it; the `__except` block appends 6.

#include <windows.h>

#define NOTE(flag) (*(flag) = *(flag) * 10 + (AbnormalTermination() ? 2 : 1))

__declspec(dllexport) void cl_dll_raise(unsigned long code, int *flag)
{
    __try {
        RaiseException(code, 0, 0, 0);
    } __finally {
        NOTE(flag);
    }
}

__declspec(dllexport) unsigned long cl_dll_catch(void (*fn)(int *), int *flag)
{
    unsigned long code = 0;
    __try {
        __try {
            fn(flag);
        } __finally {
            NOTE(flag);
        }
    } __except (code = GetExceptionCode(), code >= 0xE0000000) {
        *flag = *flag * 10 + 6;
    }
    return code;
}

__declspec(dllexport) void cl_dll_through(void (*fn)(int *), int *flag)
{
    __try {
        fn(flag);
    } __finally {
        NOTE(flag);
    }
}
