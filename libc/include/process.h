#pragma once
#ifdef _WIN32
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
#pragma binding(msvcrt::_spawnvp,  "_spawnvp")
#pragma binding(msvcrt::_spawnv,   "_spawnv")
#pragma binding(msvcrt::_spawnl,   "_spawnl")
int _spawnvp(int mode, char *cmdname, char **argv);
int _spawnv(int mode, char *cmdname, char **argv);
int _spawnl(int mode, char *cmdname, char *arg0, ...);
// `_cwait` action flag: wait for the supplied child handle.
#define _WAIT_CHILD       0
#define _WAIT_GRANDCHILD  1
#define WAIT_CHILD        0
#define WAIT_GRANDCHILD   1
#pragma binding(msvcrt::_cwait, "_cwait")
int _cwait(int *termstat, int handle, int action);
#endif
