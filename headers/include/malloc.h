// malloc.h -- pre-POSIX compatibility header for `alloca` and the
// `malloc` / `free` family. Windows headers historically expose
// `alloca` from `<malloc.h>` rather than the POSIX `<alloca.h>`,
// so source that targets msvcrt reaches here for the declaration.
// The c5 entry route is identical -- pulling in `<alloca.h>`
// registers the `alloca` / `__builtin_alloca` intrinsics. The
// `malloc` / `free` family lives in `<stdlib.h>` and is exposed
// transitively for source that depends on the historical
// grouping.

#pragma once

#include <alloca.h>
#include <stdlib.h>

// glibc allocation introspection: `malloc_usable_size` returns the number
// of usable bytes in an allocation. macOS spells it `malloc_size` in
// <malloc/malloc.h>; Windows spells it `_msize`. Programs that account
// their own heap usage (e.g. a language runtime) reach for it here.
#ifdef __linux__
#pragma binding(libc::malloc_usable_size, "malloc_usable_size")
size_t malloc_usable_size(void *ptr);
#endif
