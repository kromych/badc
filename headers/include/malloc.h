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
