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
#pragma binding(kernel32::VirtualAlloc,   "VirtualAlloc")
#pragma binding(kernel32::VirtualProtect, "VirtualProtect")
#pragma binding(kernel32::VirtualFree,    "VirtualFree")
#pragma binding(kernel32::LoadLibraryA,   "LoadLibraryA")
#pragma binding(kernel32::GetProcAddress, "GetProcAddress")
#pragma binding(kernel32::FreeLibrary,    "FreeLibrary")
#pragma binding(kernel32::GetLastError,   "GetLastError")
#pragma binding(kernel32::ExitProcess,    "ExitProcess")

char *VirtualAlloc(char *addr, int size, int type, int protect);
int VirtualProtect(char *addr, int size, int new_protect, int *old_protect);
int VirtualFree(char *addr, int size, int type);
char *LoadLibraryA(char *name);
char *GetProcAddress(char *module, char *name);
int FreeLibrary(char *module);
int GetLastError();
int ExitProcess(int status);
#endif
