// `__except` filters other than the constant EXCEPTION_EXECUTE_HANDLER on
// the PE targets: each is a funclet of its own, which reads and writes the
// function's objects through the frame the language handler passes it,
// sees the exception through GetExceptionCode and GetExceptionInformation,
// and decides to handle the exception, to pass it on, or to resume at the
// raising instruction. Elsewhere the program exits 0.

#ifdef _WIN32
#include <windows.h>
#include <malloc.h>
#include <stdarg.h>

static volatile int *volatile null_ptr = 0;
static volatile int fixed;

__attribute__((noinline)) static void raise_code(unsigned long code)
{
    RaiseException(code, 0, 0, 0);
}

__attribute__((noinline)) static int accept(unsigned long code, unsigned long want)
{
    return code == want ? EXCEPTION_EXECUTE_HANDLER : EXCEPTION_CONTINUE_SEARCH;
}

// The filter reads a local the region modified and a parameter, and
// writes a local the handler reads.
static int reads_and_writes(int k)
{
    int stage = 0, seen = 0;
    __try {
        stage = 1;
        raise_code(0xE0000010 + k);
        stage = 2;
    } __except (seen = stage * 10 + k,
                GetExceptionCode() == 0xE0000010 + (unsigned long)k ? EXCEPTION_EXECUTE_HANDLER
                                                                    : EXCEPTION_CONTINUE_SEARCH) {
        seen += 100;
    }
    return seen == 113 && stage == 1;
}

// An inner filter passes a code on to the outer handler, which a filter
// choosing by code takes, its body seeing the code; the inner one takes
// its own code.
static int chooses_by_code(unsigned long code)
{
    int inner = 0, outer = 0;
    __try {
        __try {
            raise_code(code);
        } __except (accept(GetExceptionCode(), 0xE0000020)) {
            inner = 1;
        }
    } __except (GetExceptionCode() == 0xE0000021 ? EXCEPTION_EXECUTE_HANDLER
                                                 : EXCEPTION_CONTINUE_SEARCH) {
        outer = GetExceptionCode() == 0xE0000021;
    }
    return inner * 2 + outer;
}

// The constant EXCEPTION_CONTINUE_SEARCH: the outer region takes it.
static int continue_search(void)
{
    int caught = 0;
    __try {
        __try {
            raise_code(0xE0000030);
        } __except (EXCEPTION_CONTINUE_SEARCH) {
            caught = -1;
        }
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        caught = caught == 0;
    }
    return caught;
}

// The constant EXCEPTION_CONTINUE_EXECUTION resumes after a continuable
// RaiseException.
static int continue_execution(void)
{
    int after = 0;
    __try {
        raise_code(0xE0000040);
        after = 1;
    } __except (EXCEPTION_CONTINUE_EXECUTION) {
        after = -1;
    }
    return after;
}

// The register holding the faulting address points at `fixed` once the
// filter returns, and the store runs again there.
static int repair(EXCEPTION_POINTERS *ep)
{
    ULONG_PTR bad = ep->ExceptionRecord->ExceptionInformation[1];
    int n = 0;
#if defined(_M_ARM64) || defined(__aarch64__)
    for (int i = 0; i < 31; i++)
        if (ep->ContextRecord->X[i] == bad) {
            ep->ContextRecord->X[i] = (ULONG_PTR)&fixed;
            n++;
        }
#else
    DWORD64 *r = &ep->ContextRecord->Rax;
    for (int i = 0; i < 16; i++)
        if (r[i] == bad) {
            r[i] = (ULONG_PTR)&fixed;
            n++;
        }
#endif
    return n ? EXCEPTION_CONTINUE_EXECUTION : EXCEPTION_EXECUTE_HANDLER;
}

static int fixes_the_fault(void)
{
    volatile int *p = (volatile int *)(ULONG_PTR)0x1230;
    __try {
        p[0] = 77;
    } __except (GetExceptionCode() == EXCEPTION_ACCESS_VIOLATION
                    ? repair(GetExceptionInformation())
                    : EXCEPTION_CONTINUE_SEARCH) {
        return -1;
    }
    return fixed == 77;
}

// The record GetExceptionInformation names: its code and the address of
// the raising instruction.
static int information(void)
{
    unsigned long code = 0;
    void *where = 0;
    __try {
        *null_ptr = 3;
    } __except (code = GetExceptionInformation()->ExceptionRecord->ExceptionCode,
                where = GetExceptionInformation()->ExceptionRecord->ExceptionAddress,
                EXCEPTION_EXECUTE_HANDLER) {
        code |= 0x100000;
    }
    return code == (EXCEPTION_ACCESS_VIOLATION | 0x100000) && where != 0;
}

// A variadic function: the filter reads a named parameter and a value
// va_arg fetched.
static int variadic(int n, ...)
{
    va_list ap;
    va_start(ap, n);
    int second = 0;
    second = va_arg(ap, int);
    va_end(ap);
    int caught = 0;
    __try {
        raise_code(0xE0000050);
    } __except (n == 2 && second == 42) {
        caught = n + second;
    }
    return caught == 44;
}

// An over-aligned object, which a realigned frame places off the frame
// pointer, read and written by the filter.
static int over_aligned(void)
{
    _Alignas(64) int big[4] = {1, 2, 3, 4};
    int caught = 0;
    __try {
        big[1] = 20;
        raise_code(0xE0000060);
    } __except (big[0] += big[1], ((unsigned long long)big & 63) == 0) {
        caught = big[0];
    }
    return caught == 21;
}

// A frame whose sp moves at run time.
static int dynamic(int n)
{
    char *p = _alloca(n);
    int caught = 0;
    p[0] = 6;
    __try {
        char *q = _alloca(n * 2);
        q[0] = 1;
        raise_code(0xE0000070);
    } __except (p[0] == 6) {
        caught = p[0] + 1;
    }
    return caught == 7;
}

// Nested filters, each on its own locals, the outer seeing what the inner
// filter left.
static int nested(void)
{
    int a = 0, b = 0;
    __try {
        __try {
            raise_code(0xE0000080);
        } __except (a = 1, EXCEPTION_CONTINUE_SEARCH) {
            a = -1;
        }
    } __except (b = a + 1, EXCEPTION_EXECUTE_HANDLER) {
        b *= 10;
    }
    return a == 1 && b == 20;
}

int main(void)
{
    if (!reads_and_writes(3))
        return 1;
    if (chooses_by_code(0xE0000020) != 2)
        return 2;
    if (chooses_by_code(0xE0000021) != 1)
        return 3;
    if (continue_search() != 1)
        return 4;
    if (continue_execution() != 1)
        return 5;
    if (!fixes_the_fault())
        return 6;
    if (!information())
        return 7;
    if (!variadic(2, 42))
        return 8;
    if (!over_aligned())
        return 9;
    if (!dynamic(16))
        return 10;
    if (!nested())
        return 11;
    return 0;
}
#else
int main(void) { return 0; }
#endif
