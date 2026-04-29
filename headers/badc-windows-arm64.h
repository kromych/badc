// badc target header: windows-arm64
//
// Same dylib split as `windows-x64`: msvcrt for the libc shapes,
// kernel32 for the system calls and the `dlopen` family. The COFF
// symbol names match too -- ARM64 Windows follows the same C ABI
// as x64 Windows in this regard.

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

#pragma binding(kernel32::mprotect, "VirtualProtect")
#pragma binding(kernel32::exit, "ExitProcess")
#pragma binding(kernel32::dlopen, "LoadLibraryA")
#pragma binding(kernel32::dlsym, "GetProcAddress")
#pragma binding(kernel32::dlclose, "FreeLibrary")
#pragma binding(kernel32::dlerror, "GetLastError")
