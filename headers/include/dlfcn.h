// dlfcn.h -- runtime dynamic linking.
//
// On Windows the portable c4 names alias the kernel32 surface
// directly: `dlopen` -> `LoadLibraryA`, `dlsym` -> `GetProcAddress`,
// `dlclose` -> `FreeLibrary`, `dlerror` -> `GetLastError`. The
// signatures aren't quite the same -- LoadLibraryA only takes one
// arg, GetLastError returns a numeric code rather than a string --
// but the c4 calls accept the loose match because pointers and
// integers share the same machine word.

#pragma once

#ifndef NULL
#define NULL 0
#endif

// `RTLD_LAZY` is only meaningful on POSIX; on Windows it's a no-op
// flag for the convenience of cross-platform fixtures that pass it
// through to `dlopen` regardless of target.
#define RTLD_LAZY 1
#define RTLD_NOW  2

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::dlopen,  "_dlopen")
#pragma binding(libc::dlsym,   "_dlsym")
#pragma binding(libc::dlclose, "_dlclose")
#pragma binding(libc::dlerror, "_dlerror")
#endif

#ifdef __linux__
#pragma dylib(libdl, "libdl.so.2")
#pragma binding(libdl::dlopen,  "dlopen")
#pragma binding(libdl::dlsym,   "dlsym")
#pragma binding(libdl::dlclose, "dlclose")
#pragma binding(libdl::dlerror, "dlerror")
#endif

#ifdef _WIN32
#pragma dylib(kernel32, "kernel32.dll")
#pragma binding(kernel32::dlopen,  "LoadLibraryA")
#pragma binding(kernel32::dlsym,   "GetProcAddress")
#pragma binding(kernel32::dlclose, "FreeLibrary")
#pragma binding(kernel32::dlerror, "GetLastError")
#endif

char *dlopen(char *path, int flags);
char *dlsym(char *handle, char *name);
int dlclose(char *handle);
char *dlerror();
