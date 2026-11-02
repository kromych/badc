// Structured exception handling compiled by cl, for a badc link to place:
// each function's .xdata names __C_specific_handler with an image-relative
// field. Built on Windows by
//   cl /nologo /c /O1 /GS- /Zl seh_cl.c /Foseh_cl.x64.coff
// and, with the arm64 cross compiler, /Foseh_cl.arm64.coff.

#include <windows.h>

// The access violation reading `p`, caught: -1; otherwise `*p`.
int cl_read_or_minus_one(volatile int *p)
{
    __try {
        return *p;
    } __except (GetExceptionCode() == EXCEPTION_ACCESS_VIOLATION ? EXCEPTION_EXECUTE_HANDLER
                                                                  : EXCEPTION_CONTINUE_SEARCH) {
        return -1;
    }
}

// `*flag` is 1 when the __finally body runs on the normal path and 2 when
// the unwinder runs it for an exception raised by `fn`.
int cl_finally(int *flag, void (*fn)(void))
{
    __try {
        fn();
    } __finally {
        *flag = AbnormalTermination() ? 2 : 1;
    }
    return 0;
}

// Runs `fn` and returns the code of the exception it raises, or 0.
unsigned long cl_catch(void (*fn)(void))
{
    __try {
        fn();
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        return GetExceptionCode();
    }
    return 0;
}

// A filter funclet over the frames of `fn` and what it calls: it takes the
// code `want`, recording in `*seen` the step the region reached, and
// passes on any other code.
int cl_filter(void (*fn)(void), unsigned long want, int *seen)
{
    int step = 0;
    __try {
        step = 1;
        fn();
        step = 2;
    } __except (*seen = step * 10 + (GetExceptionCode() == want),
                GetExceptionCode() == want ? EXCEPTION_EXECUTE_HANDLER
                                           : EXCEPTION_CONTINUE_SEARCH) {
        return -1;
    }
    return step;
}

// A store through `p`, which raises in this frame for a filter of the
// caller's to see.
void cl_store(volatile int *p, int v)
{
    *p = v;
}
