// windows.h -- Win32 surface kept under its own name.
//
// dlfcn.h already aliases the loader trio (LoadLibraryA, etc.) to
// the portable POSIX-spelled names; this header is for sources that
// want to call the Win32 functions by their native names. Currently
// just the page-allocation trio plus the imports dlfcn.h doesn't
// expose, since that's what the badc fixtures reach for. Add more
// as you need them; the kernel32 dylib is the same one dlfcn.h
// declares, so include order doesn't matter.
//
// Including this header on a non-Windows target is a no-op -- the
// whole body is gated on `_WIN32` so cross-platform fixtures can
// `#include <windows.h>` unconditionally without having to wrap
// the include in their own `#ifdef`.

#pragma once

#ifdef _WIN32
#pragma dylib(kernel32, "kernel32.dll")
#pragma binding(kernel32::VirtualAlloc,            "VirtualAlloc")
#pragma binding(kernel32::VirtualProtect,          "VirtualProtect")
#pragma binding(kernel32::VirtualFree,             "VirtualFree")
#pragma binding(kernel32::LoadLibraryA,            "LoadLibraryA")
#pragma binding(kernel32::GetProcAddress,          "GetProcAddress")
#pragma binding(kernel32::FreeLibrary,             "FreeLibrary")
#pragma binding(kernel32::GetLastError,            "GetLastError")
#pragma binding(kernel32::ExitProcess,             "ExitProcess")
#pragma binding(kernel32::Sleep,                   "Sleep")
#pragma binding(kernel32::CreateThread,            "CreateThread")
#pragma binding(kernel32::WaitForSingleObject,     "WaitForSingleObject")
#pragma binding(kernel32::CloseHandle,             "CloseHandle")
#pragma binding(kernel32::GetExitCodeThread,       "GetExitCodeThread")
#pragma binding(kernel32::GetCurrentThreadId,      "GetCurrentThreadId")
#pragma binding(kernel32::InitializeCriticalSection, "InitializeCriticalSection")
#pragma binding(kernel32::EnterCriticalSection,    "EnterCriticalSection")
#pragma binding(kernel32::LeaveCriticalSection,    "LeaveCriticalSection")
#pragma binding(kernel32::DeleteCriticalSection,   "DeleteCriticalSection")

#define INFINITE        0xFFFFFFFF
#define WAIT_OBJECT_0   0
// CRITICAL_SECTION is a 40-byte opaque struct on x64; allocate 64
// for safety / future fields.
#define CRITICAL_SECTION_SIZE 64

char *VirtualAlloc(char *addr, int size, int type, int protect);
int VirtualProtect(char *addr, int size, int new_protect, int *old_protect);
int VirtualFree(char *addr, int size, int type);
char *LoadLibraryA(char *name);
char *GetProcAddress(char *module, char *name);
int FreeLibrary(char *module);
int GetLastError();
int ExitProcess(int status);
int Sleep(int milliseconds);

// CreateThread returns a thread HANDLE (kernel object) -- treat as
// an opaque int. Args mirror the Win32 prototype: lpThreadAttributes,
// dwStackSize, lpStartAddress, lpParameter, dwCreationFlags,
// lpThreadId.
int CreateThread(char *attrs, int stack_size, int *start, char *param,
                 int flags, int *thread_id);
int WaitForSingleObject(int handle, int millis);
int CloseHandle(int handle);
int GetExitCodeThread(int handle, int *exit_code);
int GetCurrentThreadId();
int InitializeCriticalSection(char *cs);
int EnterCriticalSection(char *cs);
int LeaveCriticalSection(char *cs);
int DeleteCriticalSection(char *cs);
#endif
