// Functions MSVC's `code_seg` and `alloc_text` pragmas place in a code
// section of their own on the PE targets: a `__try` region there, with its
// filter and `__finally` funclets, and an exception unwinding through a
// frame there to a handler in `.text`. Elsewhere the program exits 0.

#ifdef _WIN32
#include <windows.h>

static volatile int *volatile null_ptr = 0;
static int finally_runs;

__declspec(noinline) static int load(volatile int *p)
{
    return *p;
}

__declspec(noinline) static int accept_av(unsigned long code)
{
    return code == EXCEPTION_ACCESS_VIOLATION ? EXCEPTION_EXECUTE_HANDLER
                                              : EXCEPTION_CONTINUE_SEARCH;
}

#pragma code_seg(push, paged, "PAGE")
__declspec(noinline) int guarded(int fault)
{
    volatile int local = 7;
    int r = 0;
    __try {
        __try {
            r = load(fault ? null_ptr : &local);
        } __finally {
            finally_runs++;
        }
    } __except (accept_av(GetExceptionCode())) {
        r = -1;
    }
    return r;
}

__declspec(noinline) int framed(int fault)
{
    volatile int buf[32];
    for (int i = 0; i < 32; i++)
        buf[i] = i;
    return load(fault ? null_ptr : &buf[5]) + buf[31];
}
#pragma code_seg(pop, paged)

#pragma alloc_text("INIT", early)
__declspec(noinline) int early(void)
{
    return 11;
}

int main(void)
{
    if (guarded(0) != 7 || guarded(1) != -1 || finally_runs != 2)
        return 1;
    int r = 0;
    __try {
        r = framed(1);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        r = -1;
    }
    if (r != -1 || framed(0) != 36)
        return 2;
    return early() == 11 ? 0 : 3;
}
#else
int main(void)
{
    return 0;
}
#endif
