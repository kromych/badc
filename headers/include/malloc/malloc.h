// malloc/malloc.h -- macOS allocation introspection. malloc_size
// reports the usable size of a heap block; on Linux the equivalent is
// malloc_usable_size in <malloc.h>, on Windows _msize in <malloc.h>.

#pragma once

#include <stddef.h>

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::malloc_size, "_malloc_size")
#endif

size_t malloc_size(const void *ptr);
