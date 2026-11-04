// Funclets inside a `__finally` block on the PE targets: a filter or a
// `__finally` block nested in one reaches the outermost function's objects
// through the frame value its enclosing funclet holds, and a `__finally`
// block allocates on its own stack. Elsewhere the program exits 0.

#ifdef _WIN32
#include <windows.h>
#include <malloc.h>

__attribute__((noinline)) static void raise_code(unsigned long code)
{
    RaiseException(code, 0, 0, 0);
}

// A filter inside a `__finally` block that an exception runs, reading and
// writing the outermost function's local and the block's own.
static int filter_in_finally(void)
{
    int outer = 5, result = 0;
    __try {
        __try {
            raise_code(0xE0000001);
        } __finally {
            int inner = outer + 1;
            __try {
                raise_code(0xE0000002);
            } __except (outer += inner, GetExceptionCode() == 0xE0000002) {
                result = inner * 10;
            }
        }
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        result += 1;
    }
    return result == 61 && outer == 11;
}

// A `__finally` block inside one, on the normal path and on an unwind.
static int finally_in_finally(int raise)
{
    int outer = 2, seen = 0;
    __try {
        __try {
            if (raise)
                raise_code(0xE0000003);
        } __finally {
            int inner = outer * 3;
            __try {
                seen = inner;
            } __finally {
                seen += outer + AbnormalTermination() * 100;
            }
        }
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        seen += 1000;
    }
    return raise ? seen == 1008 : seen == 8;
}

// Three levels: a filter in a `__finally` block in a `__finally` block.
static int three_levels(void)
{
    int outer = 1;
    __try {
    } __finally {
        int middle = outer + 1;
        __try {
        } __finally {
            int inner = middle + 1;
            __try {
                raise_code(0xE0000004);
            } __except (outer = outer + middle + inner, 1) {
                outer *= 10;
            }
        }
    }
    return outer == 60;
}

// Over-aligned objects of the function and of the block, reached by the
// nested filter.
static int over_aligned(void)
{
    _Alignas(64) int top[2] = {1, 2};
    int ok = 0;
    __try {
    } __finally {
        _Alignas(32) int mid[2] = {3, 4};
        __try {
            raise_code(0xE0000005);
        } __except (ok = top[1] + mid[1] + (((unsigned long long)top & 63) == 0)
                         + (((unsigned long long)mid & 31) == 0),
                    1) {
            ok += 10;
        }
    }
    return ok == 18;
}

// A `__finally` block that allocates, with `_alloca` and a VLA, normally and
// on an unwind.
static int allocating(int n, int raise)
{
    int sum = 0;
    __try {
        __try {
            if (raise)
                raise_code(0xE0000006);
        } __finally {
            char *p = (char *)_alloca(n);
            int v[n];
            for (int i = 0; i < n; i++) {
                p[i] = (char)i;
                v[i] = i;
            }
            for (int i = 0; i < n; i++)
                sum += p[i] + v[i];
        }
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        sum += 1;
    }
    return sum == n * (n - 1) + raise;
}

int main(void)
{
    if (!filter_in_finally())
        return 1;
    if (!finally_in_finally(0))
        return 2;
    if (!finally_in_finally(1))
        return 3;
    if (!three_levels())
        return 4;
    if (!over_aligned())
        return 5;
    if (!allocating(40, 0))
        return 6;
    if (!allocating(40, 1))
        return 7;
    return 0;
}
#else
int main(void) { return 0; }
#endif
