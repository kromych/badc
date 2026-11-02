// `__finally` on the PE targets: the block runs once on every exit from
// its `__try` body, with AbnormalTermination() as cl's code measures it --
// 0 for falling through and `__leave`, 1 for `return`, `goto`, `break`,
// `continue` and an exception -- and an unwinding `longjmp` runs it on the
// way to its frame. Elsewhere the program exits 0.

#ifdef _WIN32
#include <windows.h>
#include <setjmp.h>
#include <stdarg.h>

static int seen[8], runs;
static jmp_buf jb;

__attribute__((noinline)) static void raise_code(unsigned long code)
{
    RaiseException(code, 0, 0, 0);
}

static void note(int at, int abnormal)
{
    seen[at] = abnormal + 10;
    runs++;
}

static void fallthrough(void)
{
    __try {
        runs += 0;
    } __finally {
        note(0, AbnormalTermination());
    }
}

static void leave(int k)
{
    __try {
        if (k)
            __leave;
        runs += 100;
    } __finally {
        note(1, AbnormalTermination());
    }
}

// The value returned is computed before the block runs, which the block
// cannot change.
static int returns(int v)
{
    __try {
        return v * 2;
    } __finally {
        v = 0;
        note(2, AbnormalTermination());
    }
}

static void gotos(int k)
{
    __try {
        if (k)
            goto out;
        runs += 100;
    } __finally {
        note(3, AbnormalTermination());
    }
out:;
}

static void breaks(void)
{
    for (int i = 0; i < 3; i++) {
        __try {
            if (i == 1)
                break;
        } __finally {
            if (i == 1)
                note(4, AbnormalTermination());
        }
    }
}

static void continues(void)
{
    for (int i = 0; i < 3; i++) {
        __try {
            if (i == 1)
                continue;
        } __finally {
            if (i == 1)
                note(5, AbnormalTermination());
        }
    }
}

// An exception through two badc frames runs the blocks of both, innermost
// first, and the outer `__except` takes it.
static int order[4], depth;

__attribute__((noinline)) static void inner_frame(void)
{
    __try {
        raise_code(0xE0000001);
    } __finally {
        order[depth++] = AbnormalTermination() ? 1 : -1;
    }
}

__attribute__((noinline)) static void middle_frame(void)
{
    __try {
        __try {
            inner_frame();
        } __finally {
            order[depth++] = AbnormalTermination() ? 2 : -2;
        }
    } __finally {
        order[depth++] = AbnormalTermination() ? 3 : -3;
    }
}

static int unwinds(void)
{
    int caught = 0;
    __try {
        middle_frame();
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        caught = GetExceptionCode() == 0xE0000001;
    }
    return caught && depth == 3 && order[0] == 1 && order[1] == 2 && order[2] == 3;
}

// A `__try` / `__except` inside a `__try` / `__finally`, and the reverse,
// where the filter runs before the unwind runs the inner block.
static int nests(void)
{
    int a = 0, b = 0, filtered = -1;
    __try {
        __try {
            raise_code(0xE0000002);
        } __except (EXCEPTION_EXECUTE_HANDLER) {
            a = 1;
        }
    } __finally {
        a += AbnormalTermination() ? 100 : 10;
    }
    __try {
        __try {
            raise_code(0xE0000003);
        } __finally {
            b = AbnormalTermination() ? 2 : -1;
        }
    } __except (filtered = b, EXCEPTION_EXECUTE_HANDLER) {
        b += 10;
    }
    return a == 11 && b == 12 && filtered == 0;
}

// A `longjmp` across a frame with a `__finally` runs the block once.
__attribute__((noinline)) static void jump_out(int *count)
{
    __try {
        longjmp(jb, 5);
    } __finally {
        *count += AbnormalTermination() ? 1 : 100;
    }
}

static int long_jumps(void)
{
    volatile int count = 0;
    int r = setjmp(jb);
    if (r == 0)
        jump_out((int *)&count);
    return r == 5 && count == 1;
}

// A variadic function whose block reads a named parameter and a va_arg
// value, and an over-aligned object a block writes.
static int variadic(int n, ...)
{
    va_list ap;
    va_start(ap, n);
    int second = va_arg(ap, int);
    va_end(ap);
    int sum = 0;
    __try {
        sum = n;
    } __finally {
        sum += second;
    }
    return sum == 44;
}

static int over_aligned(void)
{
    _Alignas(64) int big[4] = {1, 2, 3, 4};
    __try {
        big[1] = 20;
    } __finally {
        big[0] += big[1] + (((unsigned long long)big & 63) == 0);
    }
    return big[0] == 22;
}

int main(void)
{
    fallthrough();
    leave(1);
    if (returns(21) != 42)
        return 1;
    gotos(1);
    breaks();
    continues();
    int want[6] = {10, 10, 11, 11, 11, 11};
    for (int i = 0; i < 6; i++)
        if (seen[i] != want[i])
            return 10 + i;
    if (runs != 6)
        return 2;
    if (!unwinds())
        return 3;
    if (!nests())
        return 4;
    if (!long_jumps())
        return 5;
    if (!variadic(2, 42))
        return 6;
    if (!over_aligned())
        return 7;
    return 0;
}
#else
int main(void) { return 0; }
#endif
