// `(TYPE)func` and `(TYPE)libc_func` in a static initializer --
// the dispatch-table shape sqlite uses (e.g. Windows VFS's
// `aSyscall[]` array, where each row casts a function name to
// the generic `(SYSCALL)` typedef before storing it).
//
// Pre-fix the const-init parser only accepted the bare
// `func` form; a `(TYPE)` cast prefix in the same position was
// rejected with "identifier `func` is not a constant-expression
// value". The cast is type-machinery only -- the underlying
// value is still the function's address -- so the parser now
// skips the (counted-paren) cast prefix and re-enters the
// function-name path.
//
// Token::Sys (libc-bound names like `atoi`) works the same way
// after the fix: the const-init path routes through the per-Sys
// trampoline registry, identical to how `fp = atoi;` (without a
// cast) already worked at runtime.
#include <stdio.h>
#include <stdlib.h>

typedef int (*int_fn_t)(int);
typedef int (*atoi_fn_t)(char *);

static int real_double(int x) { return x * 2; }
static int real_negate(int x) { return -x; }

struct entry {
    char *name;
    int_fn_t  user_fn;
    atoi_fn_t libc_fn;
};

static struct entry table[] = {
    { "double", (int_fn_t)real_double, (atoi_fn_t)atoi },
    { "negate", (int_fn_t)real_negate, (atoi_fn_t)atoi },
};

int main() {
    if (table[0].user_fn(21) != 42) return 1;
    if (table[1].user_fn(7)  != -7) return 2;
    if (table[0].libc_fn("100") != 100) return 3;
    if (table[1].libc_fn("-17") != -17) return 4;

    // Sanity: the c-string slot also round-trips.
    if (table[0].name[0] != 'd') return 5;
    if (table[1].name[0] != 'n') return 6;

    printf("OK\n");
    return 0;
}
