// dlfcn.h -- runtime dynamic linking.

#pragma once

#ifndef NULL
#define NULL 0
#endif

// `RTLD_LAZY` is only meaningful on POSIX; on Windows it's a no-op
// flag for the convenience of cross-platform fixtures that pass it
// through to `dlopen` regardless of target.
#define RTLD_LAZY    1
#define RTLD_NOW     2
#define RTLD_LOCAL   0
#define RTLD_GLOBAL  256

// `RTLD_DEFAULT` / `RTLD_NEXT` are pseudo-handles whose numeric
// values differ across platforms:
//
//   * Linux glibc:    DEFAULT = NULL,         NEXT = (void*)-1
//   * macOS dyld:     DEFAULT = (void*)-2,    NEXT = (void*)-1
//   * Windows:        not meaningful (LoadLibraryA wants a real path)
//
// Get them right per-target -- a NULL handle on macOS dlsym hits
// the slow "search every image" fallback instead of the dyld
// shortcut that DEFAULT actually maps to. Programs that pass
// RTLD_DEFAULT to dlsym will silently miss libc symbols on macOS
// otherwise.
#ifdef __APPLE__
#define RTLD_DEFAULT ((void*)-2)
#define RTLD_NEXT    ((void*)-1)
#endif
#ifdef __linux__
#define RTLD_DEFAULT ((void*)0)
#define RTLD_NEXT    ((void*)-1)
#endif
#ifdef _WIN32
#define RTLD_DEFAULT ((void*)0)
#define RTLD_NEXT    ((void*)-1)
#endif

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::dlopen,  "_dlopen")
#pragma binding(libc::dlsym,   "_dlsym")
#pragma binding(libc::dlclose, "_dlclose")
#pragma binding(libc::dlerror, "_dlerror")
#pragma binding(libc::dladdr,  "_dladdr")
#endif

#ifdef __linux__
#pragma dylib(libdl, "libdl.so.2")
#pragma binding(libdl::dlopen,  "dlopen")
#pragma binding(libdl::dlsym,   "dlsym")
#pragma binding(libdl::dlclose, "dlclose")
#pragma binding(libdl::dlerror, "dlerror")
#pragma binding(libdl::dladdr,  "dladdr")
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

#ifndef __BADC_WINDOWS__
// Symbol / module lookup for an address (POSIX `dladdr`).
typedef struct {
    const char *dli_fname;
    void *dli_fbase;
    const char *dli_sname;
    void *dli_saddr;
} Dl_info;
int dladdr(const void *addr, Dl_info *info);
#endif
