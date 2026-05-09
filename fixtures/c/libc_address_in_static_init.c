// DEFERRED: address-of-libc-function in a static initializer is
// lowered as `Imm 0` with a runtime-patch warning.
//
// sqlite3's per-platform VFS dispatch tables build a struct of
// function pointers at file scope -- entries like `.xClose =
// close, .xRead = read` reference libc symbols whose runtime
// addresses aren't known at compile time. Today the compiler
// lowers each slot to zero and emits a warning ("the runtime
// must overwrite the slot before first use"); sqlite3's
// `UnixOSData` initializer fills the table at init time, so
// the trick works there. Anywhere else that reaches one of
// these slots before the runtime patch fires would null-deref.
//
// The right fix is GOT-trampoline / IAT-slot resolution: emit
// a code-relocation entry per libc symbol so the loader / our
// emitter writes the resolved address into the slot at load
// time. Each per-target writer (Mach-O `__got`, ELF `.got` /
// `.got.plt`, PE import directory) already has the slot
// machinery for *function calls*; the static-init path bypasses
// it.
//
// Today this fixture exits 1: the table reads back as zeros
// because the compiler couldn't resolve the addresses. Once a
// trampoline pipeline lands, the addresses get patched in and
// the fixture exits 0.
#include <stdio.h>
#include <unistd.h>

// Same shape as sqlite3's UnixOSData VFS dispatch table:
// a struct of function pointers populated at file scope with
// libc symbols. The dialect handles this path with a warning
// + zero-fill (vs the bare scalar form, which is a hard
// compile error). The slot reads back as zero today; the fix
// is a GOT/IAT trampoline that resolves the address at load
// time.
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
