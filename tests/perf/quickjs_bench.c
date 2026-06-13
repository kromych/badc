// QuickJS interpreter stress for the perf table. Builds the full engine
// (eight translation units, pulled in via the perf harness's per-fixture
// flags) and times a call-heavy recursive workload through the bytecode
// interpreter loop -- the path the computed-goto opcode dispatch drives.
// The result is checked against the known value so a miscompilation
// surfaces as a non-zero exit rather than a wrong timing.

#include "quickjs.h"

#include <stdio.h>
#include <string.h>
#include <time.h>

static const char *SRC =
    "function fib(n){ return n < 2 ? n : fib(n - 1) + fib(n - 2); }\n"
    "fib(30);\n";

int main(void) {
    JSRuntime *rt = JS_NewRuntime();
    JSContext *ctx = JS_NewContext(rt);

    struct timespec t0, t1;
    clock_gettime(CLOCK_MONOTONIC, &t0);
    JSValue v = JS_Eval(ctx, SRC, strlen(SRC), "<bench>", JS_EVAL_TYPE_GLOBAL);
    int32_t result = 0;
    JS_ToInt32(ctx, &result, v);
    clock_gettime(CLOCK_MONOTONIC, &t1);

    long secs = t1.tv_sec - t0.tv_sec;
    long nsecs = t1.tv_nsec - t0.tv_nsec;
    double ms = (double)secs * 1000.0 + (double)nsecs / 1000000.0;
    printf("quickjs fib(30) = %d in %.2f ms\n", result, ms);

    JS_FreeValue(ctx, v);
    JS_FreeContext(ctx);
    JS_FreeRuntime(rt);

    if (result != 832040) {
        printf("WRONG: expected 832040\n");
        return 1;
    }
    return 0;
}
