#pragma once
#ifdef _WIN32
#include <__badc_wprocess.h>
// Thread creation through the C runtime. _beginthreadex initializes
// per-thread CRT state, unlike the raw kernel32 CreateThread.
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::_beginthreadex, "_beginthreadex")
#pragma binding(msvcrt::_endthreadex,   "_endthreadex")
#pragma binding(msvcrt::_beginthread,   "_beginthread")
#pragma binding(msvcrt::_endthread,     "_endthread")

unsigned long long _beginthreadex(void *security, unsigned stack_size,
                                  void *start, void *arglist,
                                  unsigned initflag, unsigned *thrdaddr);
void _endthreadex(unsigned retval);
unsigned long long _beginthread(void *start, unsigned stack_size, void *arglist);
void _endthread(void);

// msvcrt's `_spawn*` family takes a mode argument up front. `_P_NOWAIT`
// returns the child handle immediately; the other modes block until the child
// exits. MSVC defines both the underscore-prefixed canonical names and the
// bare POSIX-compat aliases here (the latter under the default
// _CRT_DECLARE_NONSTDC_NAMES); real code uses the bare `P_NOWAIT`.
#define _P_WAIT          0
#define _P_NOWAIT        1
#define _P_OVERLAY       2
#define _P_NOWAITO       3
#define _P_DETACH        4
#define P_WAIT           0
#define P_NOWAIT         1
#define P_OVERLAY        2
#define P_NOWAITO        3
#define P_DETACH         4
// A `_P_NOWAIT` spawn returns the child's process handle, which `_cwait`
// takes; both are pointer-sized, as the UCRT declares them.
#pragma binding(msvcrt::_spawnl, "_spawnl")
#pragma binding(msvcrt::_spawnle, "_spawnle")
#pragma binding(msvcrt::_spawnlp, "_spawnlp")
#pragma binding(msvcrt::_spawnlpe, "_spawnlpe")
#pragma binding(msvcrt::_spawnv, "_spawnv")
#pragma binding(msvcrt::_spawnvp, "_spawnvp")
#pragma binding(msvcrt::_spawnve, "_spawnve")
#pragma binding(msvcrt::_spawnvpe, "_spawnvpe")
#pragma binding(msvcrt::_execl, "_execl")
#pragma binding(msvcrt::_execle, "_execle")
#pragma binding(msvcrt::_execlp, "_execlp")
#pragma binding(msvcrt::_execlpe, "_execlpe")
#pragma binding(msvcrt::_execv, "_execv")
#pragma binding(msvcrt::_execvp, "_execvp")
#pragma binding(msvcrt::_execve, "_execve")
#pragma binding(msvcrt::_execvpe, "_execvpe")
__INTPTR_TYPE__ _spawnl(int mode, const char *cmdname, const char *arg0, ...);
__INTPTR_TYPE__ _spawnle(int mode, const char *cmdname, const char *arg0, ...);
__INTPTR_TYPE__ _spawnlp(int mode, const char *cmdname, const char *arg0, ...);
__INTPTR_TYPE__ _spawnlpe(int mode, const char *cmdname, const char *arg0, ...);
__INTPTR_TYPE__ _spawnv(int mode, const char *cmdname, const char *const *argv);
__INTPTR_TYPE__ _spawnvp(int mode, const char *cmdname, const char *const *argv);
__INTPTR_TYPE__ _spawnve(int mode, const char *cmdname, const char *const *argv,
                         const char *const *envp);
__INTPTR_TYPE__ _spawnvpe(int mode, const char *cmdname, const char *const *argv,
                          const char *const *envp);
__INTPTR_TYPE__ _execl(const char *cmdname, const char *arg0, ...);
__INTPTR_TYPE__ _execle(const char *cmdname, const char *arg0, ...);
__INTPTR_TYPE__ _execlp(const char *cmdname, const char *arg0, ...);
__INTPTR_TYPE__ _execlpe(const char *cmdname, const char *arg0, ...);
__INTPTR_TYPE__ _execv(const char *cmdname, const char *const *argv);
__INTPTR_TYPE__ _execvp(const char *cmdname, const char *const *argv);
__INTPTR_TYPE__ _execve(const char *cmdname, const char *const *argv, const char *const *envp);
__INTPTR_TYPE__ _execvpe(const char *cmdname, const char *const *argv, const char *const *envp);
// `_cwait` action flag: wait for the supplied child handle.
#define _WAIT_CHILD       0
#define _WAIT_GRANDCHILD  1
#define WAIT_CHILD        0
#define WAIT_GRANDCHILD   1
#pragma binding(msvcrt::_cwait, "_cwait")
__INTPTR_TYPE__ _cwait(int *termstat, __INTPTR_TYPE__ handle, int action);
// The exec family under its POSIX names, as mingw-w64 declares it here for
// gcc: the result is `int`, since a successful call does not return.
#pragma binding(msvcrt::execl,  "_execl")
#pragma binding(msvcrt::execle, "_execle")
#pragma binding(msvcrt::execlp, "_execlp")
#pragma binding(msvcrt::execv,  "_execv")
#pragma binding(msvcrt::execve, "_execve")
#pragma binding(msvcrt::execvp, "_execvp")
int execl(const char *path, const char *arg, ...);
int execle(const char *path, const char *arg, ...);
int execlp(const char *file, const char *arg, ...);
int execv(const char *path, char *const argv[]);
int execve(const char *path, char *const argv[], char *const envp[]);
int execvp(const char *file, char *const argv[]);
#endif
