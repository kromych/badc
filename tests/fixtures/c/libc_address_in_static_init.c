// C99 6.7.8: an aggregate initializer may name addresses of
// objects with static storage duration, including libc
// functions. Pre-fix, c5 lowered an `&libc_fn` slot to `Imm 0`
// with a runtime-patch warning; any reader of the slot before
// a runtime overwrite would null-deref.
//
// The fix is a per-symbol trampoline: a synthesized c5 function
// that re-pushes its declared args and re-dispatches via
// JsrExt; the writer patches the slot to the trampoline's
// address at load time. Each per-target writer (Mach-O `__got`,
// ELF `.got` / `.got.plt`, PE import directory) already has
// the slot machinery for function calls; this fixture pins the
// static-init path against regression.
#include <stdio.h>
#include <unistd.h>

// A struct of function pointers populated at file scope with
// libc symbols. The dialect handles this path with a warning
// when the address can't be resolved at compile time; the
// trampoline pipeline resolves it at load time.
struct VfsOps {
    int (*close_fn)(int);
    long (*read_fn)(int, char *, long);
};

static struct VfsOps g_ops = { close, read };

int main() {
    if (g_ops.close_fn == 0) return 1;
    if (g_ops.read_fn == 0) return 2;
    return 0;
}
