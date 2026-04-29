// badc target header: linux-x64
//
// Same shape as `headers/badc-linux-aarch64.h` -- the dynamic
// linker / library layout is identical between the two Linux
// targets; only the codegen instruction set differs.

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
