// badc target header: windows-x64
//
// Auto-prepended to every source compiled for this target. Holds
// POSIX-style constants -- the c4 runtime / VM honours these masks
// itself, so the values are portable across hosts (the Windows
// codegen translates POSIX `prot` to Windows `PAGE_*` inside the
// mprotect thunk; the source still uses POSIX names). Stage B will
// extend this with `#pragma comment(dylib, ...)` and function
// declarations to drive the import table.

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
