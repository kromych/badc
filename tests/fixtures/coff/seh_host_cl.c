// An executable cl builds for the structured exception handling test across
// a DLL boundary: it imports from seh_badc.dll, which the test builds with
// badc, and raises, catches and unwinds through its functions. Without a C
// runtime it takes __C_specific_handler from msvcrt.dll, as badc code does:
//
//   lib /nologo /machine:<arch> /def:seh_msvcrt.def /out:seh_msvcrt.lib
//   lib /nologo /machine:<arch> /def:seh_badc.def /out:seh_badc.lib
//   cl /nologo /O1 /GS- /Zl seh_host_cl.c seh_msvcrt.lib seh_badc.lib kernel32.lib
//      /link /ENTRY:start /SUBSYSTEM:CONSOLE /NODEFAULTLIB
//      /OUT:seh_host_cl.<arch>.exe
//
// with <arch> x64 or arm64; the executable is checked in as
// seh_host_cl.<arch>.pe.
//
// Each `__finally` block appends 1 to `*flag` in decimal, or 2 when an
// exception or a `longjmp` runs it; seh_badc.dll's blocks append 3 and 4,
// its `__except` block 7 and its `longjmp` 5. The exit status names the
// first failed check.

#include <windows.h>

__declspec(dllimport) void badc_raise(unsigned long code, int *flag);
__declspec(dllimport) unsigned long badc_catch(void (*fn)(int *), int *flag);
__declspec(dllimport) int badc_jump_across(void (*fn)(void (*)(int *), int *), int *flag);

#define NOTE(flag) (*(flag) = *(flag) * 10 + (AbnormalTermination() ? 2 : 1))

static int flag;

static void cl_raiser(int *f)
{
    __try {
        RaiseException(0xE0000C02, 0, 0, 0);
    } __finally {
        NOTE(f);
    }
}

static void cl_through(void (*fn)(int *), int *f)
{
    __try {
        fn(f);
    } __finally {
        NOTE(f);
    }
}

static int run(void)
{
    int caught = 0;
    // badc raises and cl catches: badc's `__finally` runs, then cl's.
    __try {
        __try {
            badc_raise(0xE0000B01, &flag);
        } __finally {
            NOTE(&flag);
        }
    } __except (GetExceptionCode() == 0xE0000B01) {
        caught = 1;
    }
    if (!caught || flag != 42)
        return 1;
    // cl raises and badc catches: cl's `__finally` runs, then badc's, then
    // badc's `__except` block.
    flag = 0;
    if (badc_catch(cl_raiser, &flag) != 0xE0000C02 || flag != 247)
        return 2;
    // badc's `longjmp` to its `setjmp` leaves a cl frame, running its
    // `__finally`.
    flag = 0;
    if (badc_jump_across(cl_through, &flag) != 52)
        return 3;
    return 0;
}

void start(void)
{
    ExitProcess(run());
}
