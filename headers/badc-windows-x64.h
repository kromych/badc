// badc target header: windows-x64
//
// Two import dylibs cover the libc shapes that c4 uses:
//
// * `msvcrt`   -- Microsoft's classic C runtime. Most POSIX names
//   live here under their underscore-prefixed form (`_open`,
//   `_read`, ...). `printf` / `malloc` / `free` / etc ship
//   unprefixed.
// * `kernel32` -- Windows system calls. We re-bind a couple of
//   POSIX names here: `mprotect` -> `VirtualProtect` (still relies
//   on a codegen-side prot-translation thunk for now), `exit` ->
//   `ExitProcess`, and the `dlopen` family to
//   `LoadLibraryA` / `GetProcAddress` / `FreeLibrary` /
//   `GetLastError`.

#define PROT_NONE 0
#define PROT_READ 1
#define PROT_WRITE 2
#define PROT_EXEC 4

#define O_RDONLY 0
#define O_WRONLY 1
#define O_RDWR 2

#define STDIN_FILENO 0
#define STDOUT_FILENO 1
#define STDERR_FILENO 2

#define NULL 0
#define EXIT_SUCCESS 0
#define EXIT_FAILURE 1

// Convenience macro for cross-platform sources that need to gate
// out POSIX-only ops the Windows headers don't bind (mprotect for
// instance, since VirtualProtect has a different shape and there
// is no in-text translation thunk anymore).
#define __BADC_WINDOWS__ 1

#pragma dylib(msvcrt, "msvcrt.dll")
#pragma dylib(kernel32, "kernel32.dll")

#pragma binding(msvcrt::open, "_open")
#pragma binding(msvcrt::read, "_read")
#pragma binding(msvcrt::close, "_close")
#pragma binding(msvcrt::printf, "printf")
#pragma binding(msvcrt::malloc, "malloc")
#pragma binding(msvcrt::free, "free")
#pragma binding(msvcrt::memset, "memset")
#pragma binding(msvcrt::memcmp, "memcmp")
#pragma binding(msvcrt::memcpy, "memcpy")
#pragma binding(msvcrt::write, "_write")
#pragma binding(msvcrt::getenv, "getenv")
#pragma binding(msvcrt::setenv, "_putenv_s")

#pragma binding(kernel32::exit, "ExitProcess")
#pragma binding(kernel32::dlopen, "LoadLibraryA")
#pragma binding(kernel32::dlsym, "GetProcAddress")
#pragma binding(kernel32::dlclose, "FreeLibrary")
#pragma binding(kernel32::dlerror, "GetLastError")
// Page allocation + protection trio. Currently declarative -- they
// describe what the dylib offers; calling them from c4 source needs
// a generic extern-call mechanism that's still in flight.
#pragma binding(kernel32::VirtualAlloc, "VirtualAlloc")
#pragma binding(kernel32::VirtualProtect, "VirtualProtect")
#pragma binding(kernel32::VirtualFree, "VirtualFree")

// More libc surface. Declarative only -- reach via `dlopen(NULL,
// RTLD_NOW)` + `dlsym` (which routes through `LoadLibraryA` /
// `GetProcAddress` on Windows). See the README's "Fun recipes".
#pragma binding(msvcrt::sprintf, "sprintf")
#pragma binding(msvcrt::snprintf, "_snprintf")
#pragma binding(msvcrt::sscanf, "sscanf")
#pragma binding(msvcrt::fputs, "fputs")
#pragma binding(msvcrt::fgets, "fgets")
#pragma binding(msvcrt::fopen, "fopen")
#pragma binding(msvcrt::fclose, "fclose")
#pragma binding(msvcrt::fread, "fread")
#pragma binding(msvcrt::fwrite, "fwrite")
#pragma binding(msvcrt::strlen, "strlen")
#pragma binding(msvcrt::strcpy, "strcpy")
#pragma binding(msvcrt::strncpy, "strncpy")
#pragma binding(msvcrt::strcmp, "strcmp")
#pragma binding(msvcrt::strncmp, "strncmp")
#pragma binding(msvcrt::strchr, "strchr")
#pragma binding(msvcrt::strstr, "strstr")
#pragma binding(msvcrt::atoi, "atoi")
#pragma binding(msvcrt::atol, "atol")
#pragma binding(msvcrt::abs, "abs")
#pragma binding(msvcrt::abort, "abort")
#pragma binding(msvcrt::system, "system")

// Function prototypes -- the parser's type signatures. `char` is
// one byte; `int` is the c4 machine word (8 bytes). Forward
// declarations only; bindings above point at the actual symbols.
int open(char *path, int flags);
int read(int fd, char *buf, int n);
int close(int fd);
int printf(char *fmt, ...);
char *malloc(int size);
int free(char *ptr);
char *memset(char *dst, int byte, int n);
int memcmp(char *a, char *b, int n);
char *memcpy(char *dst, char *src, int n);
int exit(int status);
int write(int fd, char *buf, int n);
char *getenv(char *name);
int setenv(char *name, char *value, int overwrite);
char *dlopen(char *path, int flags);
char *dlsym(char *handle, char *name);
int dlclose(char *handle);
char *dlerror();
