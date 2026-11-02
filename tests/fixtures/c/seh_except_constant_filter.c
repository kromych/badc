// `__try` / `__except` with a constant filter on the PE targets, as cl
// covers a region: a store, a load, an integer division and a call in the
// guarded block may raise, and the handler sees the code and the values
// the block stored. Elsewhere the program exits 0.

#ifdef _WIN32
#include <windows.h>
#include <malloc.h>

static volatile int zero = 0;
static volatile int *volatile null_ptr = 0;
static volatile long long sink;

__attribute__((noinline)) static void raise_code(unsigned long code)
{
    RaiseException(code, 0, 0, 0);
}

__attribute__((noinline)) static int fault_in_callee(int v)
{
    *null_ptr = v;
    return v + 1;
}

// A null write, caught with its code.
static unsigned long null_write(void)
{
    unsigned long code = 0;
    __try {
        *null_ptr = 1;
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        code = GetExceptionCode();
    }
    return code;
}

// An integer division by zero, caught with its code.
static unsigned long divide(int n)
{
    unsigned long code = 0;
    __try {
        sink = n / zero;
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        code = GetExceptionCode();
    }
    return code;
}

// A raised code, read in the body; the region's stores are seen there.
static int raised(void)
{
    int steps = 0;
    unsigned long code = 0;
    __try {
        steps = 1;
        raise_code(0xE0004242);
        steps = 2;
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        code = GetExceptionCode();
    }
    return code == 0xE0004242 && steps == 1;
}

// The inner handler takes the inner fault; a later one in the outer
// region reaches the outer handler.
static int nested(void)
{
    int inner = 0, outer = 0;
    __try {
        __try {
            *null_ptr = 2;
        } __except (EXCEPTION_EXECUTE_HANDLER) {
            inner = 1;
        }
        raise_code(0xE0000001);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        outer = GetExceptionCode() == 0xE0000001;
    }
    return inner && outer;
}

// A loop in the region, whose blocks layout may place apart, and values
// modified in it read by the handler.
static int split(int n)
{
    int sum = 0, i = 0;
    __try {
        for (i = 0; i < n; i++) {
            if (i == 7)
                raise_code(0xE0000007);
            sum += i;
        }
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        sum = -sum;
    }
    return sum == -21 && i == 7;
}

// A call that is the last instruction of its region.
static int call_ends(void)
{
    int caught = 0;
    __try {
        raise_code(0xE0000002);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        caught = 1;
    }
    return caught;
}

// A frame whose sp moves at run time: the handler resets sp from the frame.
static int dynamic(int n)
{
    char *p = _alloca(n);
    int v[n];
    int caught = 0;
    p[0] = 5;
    v[n - 1] = 9;
    __try {
        char *q = _alloca(n * 4);
        q[0] = 1;
        raise_code(0xE0000003);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        caught = p[0] + v[n - 1];
    }
    return caught == 14;
}

// A fault in a badc callee frame, caught by its caller.
static int in_callee(void)
{
    int r = 0;
    __try {
        r = fault_in_callee(3);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        r = GetExceptionCode() == EXCEPTION_ACCESS_VIOLATION ? -1 : -2;
    }
    return r == -1;
}

int main(void)
{
    if (null_write() != EXCEPTION_ACCESS_VIOLATION)
        return 1;
    if (divide(5) != EXCEPTION_INT_DIVIDE_BY_ZERO)
        return 2;
    if (!raised())
        return 3;
    if (!nested())
        return 4;
    if (!split(20))
        return 5;
    if (!call_ends())
        return 6;
    if (!dynamic(16))
        return 7;
    if (!in_callee())
        return 8;
    return 0;
}
#else
int main(void) { return 0; }
#endif
