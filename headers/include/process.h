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
#endif
