// badc target header: linux-aarch64
//
// See `headers/badc-macos-aarch64.h` for the directive vocabulary.
// Linux splits libc proper from POSIX libdl: the dlopen family
// lives in libdl.so.2 (still shipped as a stub on glibc 2.34+
// which folded the bodies back into libc itself).

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

#pragma dylib(libc, "libc.so.6")
#pragma dylib(libdl, "libdl.so.2")

#pragma binding(libc::open, "open")
#pragma binding(libc::read, "read")
#pragma binding(libc::close, "close")
#pragma binding(libc::printf, "printf")
#pragma binding(libc::malloc, "malloc")
#pragma binding(libc::free, "free")
#pragma binding(libc::memset, "memset")
#pragma binding(libc::memcmp, "memcmp")
#pragma binding(libc::memcpy, "memcpy")
#pragma binding(libc::mprotect, "mprotect")
#pragma binding(libc::exit, "exit")
#pragma binding(libc::write, "write")
#pragma binding(libc::getenv, "getenv")
#pragma binding(libc::setenv, "setenv")

#pragma binding(libdl::dlopen, "dlopen")
#pragma binding(libdl::dlsym, "dlsym")
#pragma binding(libdl::dlclose, "dlclose")
#pragma binding(libdl::dlerror, "dlerror")

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
int mprotect(char *addr, int len, int prot);
int exit(int status);
int write(int fd, char *buf, int n);
char *getenv(char *name);
int setenv(char *name, char *value, int overwrite);
char *dlopen(char *path, int flags);
char *dlsym(char *handle, char *name);
int dlclose(char *handle);
char *dlerror();
