// badc target header: macos-aarch64
//
// `#pragma dylib(name, "path")` introduces a logical dylib handle;
// `#pragma binding(name::c4_fn, "real_symbol")` attaches a binding
// to it. The pair is order-free -- a binding can come before or
// after the matching dylib declaration, and bindings can be
// regrouped freely. Constants below come from `#define` and are
// substituted by the preprocessor before the lexer sees the source.

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

// macOS libc + POSIX libdl all live in libSystem.B.dylib. The
// classic Mach-O calling convention prefixes every C symbol with
// a leading underscore.
#pragma dylib(libsystem, "/usr/lib/libSystem.B.dylib")

#pragma binding(libsystem::open, "_open")
#pragma binding(libsystem::read, "_read")
#pragma binding(libsystem::close, "_close")
#pragma binding(libsystem::printf, "_printf")
#pragma binding(libsystem::malloc, "_malloc")
#pragma binding(libsystem::free, "_free")
#pragma binding(libsystem::memset, "_memset")
#pragma binding(libsystem::memcmp, "_memcmp")
#pragma binding(libsystem::memcpy, "_memcpy")
#pragma binding(libsystem::mprotect, "_mprotect")
#pragma binding(libsystem::exit, "_exit")
#pragma binding(libsystem::write, "_write")
#pragma binding(libsystem::getenv, "_getenv")
#pragma binding(libsystem::setenv, "_setenv")
#pragma binding(libsystem::dlopen, "_dlopen")
#pragma binding(libsystem::dlsym, "_dlsym")
#pragma binding(libsystem::dlclose, "_dlclose")
#pragma binding(libsystem::dlerror, "_dlerror")

// Function prototypes -- supply the parser's type signatures so it
// can type-check call sites. `char` is exactly one byte; `int` is
// the c4 machine word (8 bytes under our runtime). These are
// forward declarations: the implementation is provided by the
// dylibs bound above.
int open(char *path, int flags);
int read(int fd, char *buf, int n);
int close(int fd);
int printf(char *fmt, ...);
char *malloc(int size);
int free(char *ptr);
char *memset(char *dst, int byte, int n);
int memcmp(char *a, char *b, int n);
char *memcpy(char *dst, char *src, int n);
int mprotect(char *addr, int len, int prot);
int exit(int status);
int write(int fd, char *buf, int n);
char *getenv(char *name);
int setenv(char *name, char *value, int overwrite);
char *dlopen(char *path, int flags);
char *dlsym(char *handle, char *name);
int dlclose(char *handle);
char *dlerror();
