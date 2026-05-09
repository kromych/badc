/*
** Bisection probe for the windows shell exit=STATUS_ENTRYPOINT_NOT_FOUND
** (0xC0000139, errorlevel=-1073741511) lockup.
**
** Loads msvcrt.dll and kernel32.dll at runtime and looks up every
** symbol the hello+sqlite IAT pulls in. Prints `OK <name>` /
** `MISSING <name>` for each so the next CI log narrows which import
** the static-link IAT is referencing but the loader can't bind.
**
** Doesn't pull in sqlite3.c -- the static IAT only needs the loader
** + GetProcAddress trio plus a write fd. If even THIS probe is
** rejected, we have a deeper structural issue.
*/

#include <stdio.h>
#include <unistd.h>
#include <windows.h>

static void probe(char *dll_handle, char *name) {
    char *p = GetProcAddress(dll_handle, name);
    if (p) {
        printf("OK      %s\n", name);
    } else {
        printf("MISSING %s\n", name);
    }
}

int main(int argc, char **argv) {
    char *m = LoadLibraryA("msvcrt.dll");
    char *k = LoadLibraryA("kernel32.dll");
    printf("msvcrt=%p kernel32=%p\n", (void *)m, (void *)k);
    if (!m || !k) {
        printf("LoadLibrary failed\n");
        return 1;
    }

    /* msvcrt symbols hello+sqlite uses. Mirrors the static IAT
    ** dump from objdump -p. */
    probe(m, "__iob_func");
    probe(m, "malloc");
    probe(m, "_write");
    probe(m, "free");
    probe(m, "fputs");
    probe(m, "printf");
    probe(m, "abort");
    probe(m, "memset");
    probe(m, "localtime");
    probe(m, "memcpy");
    probe(m, "strcmp");
    probe(m, "_msize");
    probe(m, "realloc");
    probe(m, "strlen");
    probe(m, "strchr");
    probe(m, "memmove");
    probe(m, "strspn");
    probe(m, "strncmp");
    probe(m, "memcmp");
    probe(m, "strrchr");
    probe(m, "strcspn");
    probe(m, "fabs");
    probe(m, "memchr");
    probe(m, "fprintf");
    probe(m, "fflush");
    probe(m, "fopen");
    probe(m, "fclose");
    probe(m, "__getmainargs");
    probe(m, "exit");

    /* kernel32 symbols. */
    probe(k, "GetLastError");
    probe(k, "Sleep");
    probe(k, "WaitForSingleObject");
    probe(k, "CloseHandle");
    probe(k, "AreFileApisANSI");
    probe(k, "FlushViewOfFile");
    probe(k, "GetModuleHandleW");
    probe(k, "GetNativeSystemInfo");
    probe(k, "GetProcessHeap");
    probe(k, "CreateFileA");
    probe(k, "CreateFileMappingA");
    probe(k, "CreateFileMappingW");
    probe(k, "CreateFileW");
    probe(k, "CreateMutexW");
    probe(k, "DeleteFileA");
    probe(k, "DeleteFileW");
    probe(k, "FlushFileBuffers");
    probe(k, "FormatMessageA");
    probe(k, "FormatMessageW");
    probe(k, "GetCurrentProcessId");
    probe(k, "GetDiskFreeSpaceA");
    probe(k, "GetDiskFreeSpaceW");
    probe(k, "GetFileAttributesA");
    probe(k, "GetFileAttributesExW");
    probe(k, "GetFileAttributesW");
    probe(k, "GetFileSize");
    probe(k, "GetFullPathNameA");
    probe(k, "GetFullPathNameW");
    probe(k, "GetSystemInfo");
    probe(k, "GetSystemTime");
    probe(k, "GetSystemTimeAsFileTime");
    probe(k, "GetTempPathA");
    probe(k, "GetTempPathW");
    probe(k, "GetTickCount");
    probe(k, "GetVersionExA");
    probe(k, "GetVersionExW");
    probe(k, "HeapAlloc");
    probe(k, "HeapCompact");
    probe(k, "HeapCreate");
    probe(k, "HeapDestroy");
    probe(k, "HeapFree");
    probe(k, "HeapReAlloc");
    probe(k, "HeapSize");
    probe(k, "HeapValidate");
    probe(k, "InterlockedCompareExchange");
    probe(k, "LocalFree");
    probe(k, "LockFile");
    probe(k, "LockFileEx");
    probe(k, "MapViewOfFile");
    probe(k, "MultiByteToWideChar");
    probe(k, "OutputDebugStringA");
    probe(k, "OutputDebugStringW");
    probe(k, "QueryPerformanceCounter");
    probe(k, "ReadFile");
    probe(k, "SetEndOfFile");
    probe(k, "SetFilePointer");
    probe(k, "SystemTimeToFileTime");
    probe(k, "UnlockFile");
    probe(k, "UnlockFileEx");
    probe(k, "UnmapViewOfFile");
    probe(k, "WaitForSingleObjectEx");
    probe(k, "WideCharToMultiByte");
    probe(k, "WriteFile");

    return 0;
}
