/* The Win32 prototypes a program may repeat after the bundled <windows.h>,
** each with the types the Windows SDK 10.0.26100.0 gives the function
** (C99 6.7p4). Compiled for the Windows targets. The last block spells
** the types out as raylib's rcore.c does. */

#include <windows.h>

LPVOID VirtualAlloc(LPVOID lpAddress, SIZE_T dwSize, DWORD flAllocationType,
                    DWORD flProtect);
BOOL VirtualProtect(LPVOID lpAddress, SIZE_T dwSize, DWORD flNewProtect,
                    PDWORD lpflOldProtect);
BOOL VirtualFree(LPVOID lpAddress, SIZE_T dwSize, DWORD dwFreeType);
HMODULE LoadLibraryA(LPCSTR lpLibFileName);
HMODULE LoadLibraryExA(LPCSTR lpLibFileName, HANDLE hFile, DWORD dwFlags);
HMODULE LoadLibraryExW(LPCWSTR lpLibFileName, HANDLE hFile, DWORD dwFlags);
FARPROC GetProcAddress(HMODULE hModule, LPCSTR lpProcName);
BOOL FreeLibrary(HMODULE hLibModule);
DWORD GetLastError(VOID);
VOID ExitProcess(UINT uExitCode);
VOID Sleep(DWORD dwMilliseconds);
BOOLEAN RtlAddFunctionTable(PRUNTIME_FUNCTION FunctionTable, DWORD EntryCount,
                            DWORD64 BaseAddress);
BOOLEAN RtlDeleteFunctionTable(PRUNTIME_FUNCTION FunctionTable);
HANDLE CreateThread(LPSECURITY_ATTRIBUTES lpThreadAttributes,
                    SIZE_T dwStackSize, LPTHREAD_START_ROUTINE lpStartAddress,
                    LPVOID lpParameter, DWORD dwCreationFlags,
                    LPDWORD lpThreadId);
DWORD WaitForSingleObject(HANDLE hHandle, DWORD dwMilliseconds);
BOOL CloseHandle(HANDLE hObject);
BOOL GetExitCodeThread(HANDLE hThread, LPDWORD lpExitCode);
BOOL SetThreadPriority(HANDLE hThread, int nPriority);
DWORD GetCurrentThreadId(VOID);
VOID InitializeCriticalSection(LPCRITICAL_SECTION lpCriticalSection);
BOOL InitializeCriticalSectionEx(LPCRITICAL_SECTION lpCriticalSection,
                                 DWORD dwSpinCount, DWORD Flags);
VOID EnterCriticalSection(LPCRITICAL_SECTION lpCriticalSection);
VOID LeaveCriticalSection(LPCRITICAL_SECTION lpCriticalSection);
VOID DeleteCriticalSection(LPCRITICAL_SECTION lpCriticalSection);
DWORD TlsAlloc(VOID);
LPVOID TlsGetValue(DWORD dwTlsIndex);
BOOL TlsSetValue(DWORD dwTlsIndex, LPVOID lpTlsValue);
BOOL TlsFree(DWORD dwTlsIndex);
VOID InitializeSRWLock(PSRWLOCK SRWLock);
VOID AcquireSRWLockExclusive(PSRWLOCK SRWLock);
VOID ReleaseSRWLockExclusive(PSRWLOCK SRWLock);
VOID AcquireSRWLockShared(PSRWLOCK SRWLock);
VOID ReleaseSRWLockShared(PSRWLOCK SRWLock);
BOOLEAN TryAcquireSRWLockExclusive(PSRWLOCK SRWLock);
BOOLEAN TryAcquireSRWLockShared(PSRWLOCK SRWLock);
VOID InitializeConditionVariable(PCONDITION_VARIABLE ConditionVariable);
BOOL SleepConditionVariableSRW(PCONDITION_VARIABLE ConditionVariable,
                               PSRWLOCK SRWLock, DWORD dwMilliseconds,
                               ULONG Flags);
BOOL SleepConditionVariableCS(PCONDITION_VARIABLE ConditionVariable,
                              PCRITICAL_SECTION CriticalSection,
                              DWORD dwMilliseconds);
VOID WakeConditionVariable(PCONDITION_VARIABLE ConditionVariable);
VOID WakeAllConditionVariable(PCONDITION_VARIABLE ConditionVariable);
HANDLE CreateSemaphoreW(LPSECURITY_ATTRIBUTES lpSemaphoreAttributes,
                        LONG lInitialCount, LONG lMaximumCount, LPCWSTR lpName);
BOOL ReleaseSemaphore(HANDLE hSemaphore, LONG lReleaseCount,
                      LPLONG lpPreviousCount);
HANDLE GetCurrentThread(VOID);
BOOL GetProcessTimes(HANDLE hProcess, LPFILETIME lpCreationTime,
                     LPFILETIME lpExitTime, LPFILETIME lpKernelTime,
                     LPFILETIME lpUserTime);
BOOL CancelIoEx(HANDLE hFile, LPOVERLAPPED lpOverlapped);
BOOL GetNumberOfConsoleInputEvents(HANDLE hConsoleInput,
                                   LPDWORD lpNumberOfEvents);
UINT SetErrorMode(UINT uMode);
UINT GetErrorMode(VOID);
DWORD WaitForMultipleObjects(DWORD nCount, const HANDLE *lpHandles,
                             BOOL bWaitAll, DWORD dwMilliseconds);
BOOL GetThreadTimes(HANDLE hThread, LPFILETIME lpCreationTime,
                    LPFILETIME lpExitTime, LPFILETIME lpKernelTime,
                    LPFILETIME lpUserTime);
HANDLE OpenThread(DWORD dwDesiredAccess, BOOL bInheritHandle, DWORD dwThreadId);
int CompareStringOrdinal(LPCWCH lpString1, int cchCount1, LPCWCH lpString2,
                         int cchCount2, BOOL bIgnoreCase);
BOOL GetOverlappedResult(HANDLE hFile, LPOVERLAPPED lpOverlapped,
                         LPDWORD lpNumberOfBytesTransferred, BOOL bWait);
NTSTATUS BCryptGenRandom(BCRYPT_ALG_HANDLE hAlgorithm, PUCHAR pbBuffer,
                         ULONG cbBuffer, ULONG dwFlags);
UINT GetACP(VOID);
int GetLocaleInfoA(LCID Locale, LCTYPE LCType, LPSTR lpLCData, int cchData);
DWORD GetFinalPathNameByHandleW(HANDLE hFile, LPWSTR lpszFilePath,
                                DWORD cchFilePath, DWORD dwFlags);
HANDLE CreateWaitableTimerExW(LPSECURITY_ATTRIBUTES lpTimerAttributes,
                              LPCWSTR lpTimerName, DWORD dwFlags,
                              DWORD dwDesiredAccess);
BOOL ConnectNamedPipe(HANDLE hNamedPipe, LPOVERLAPPED lpOverlapped);
VOID GetCurrentThreadStackLimits(PULONG_PTR LowLimit, PULONG_PTR HighLimit);
BOOL SetThreadStackGuarantee(PULONG StackSizeInBytes);
DWORD GetModuleFileNameW(HMODULE hModule, LPWSTR lpFilename, DWORD nSize);
DWORD GetFileType(HANDLE hFile);
BOOL GetFileInformationByHandle(HANDLE hFile,
                                LPBY_HANDLE_FILE_INFORMATION lpFileInformation);
BOOL GetFileInformationByHandleEx(HANDLE hFile,
                                  FILE_INFO_BY_HANDLE_CLASS FileInformationClass,
                                  LPVOID lpFileInformation, DWORD dwBufferSize);
BOOL SetFileInformationByHandle(HANDLE hFile,
                                FILE_INFO_BY_HANDLE_CLASS FileInformationClass,
                                LPVOID lpFileInformation, DWORD dwBufferSize);
BOOL GetHandleInformation(HANDLE hObject, LPDWORD lpdwFlags);
BOOL SetHandleInformation(HANDLE hObject, DWORD dwMask, DWORD dwFlags);
BOOL GetNamedPipeHandleStateW(HANDLE hNamedPipe, LPDWORD lpState,
                              LPDWORD lpCurInstances,
                              LPDWORD lpMaxCollectionCount,
                              LPDWORD lpCollectDataTimeout, LPWSTR lpUserName,
                              DWORD nMaxUserNameSize);
BOOL SetNamedPipeHandleState(HANDLE hNamedPipe, LPDWORD lpMode,
                             LPDWORD lpMaxCollectionCount,
                             LPDWORD lpCollectDataTimeout);
BOOL CreatePipe(PHANDLE hReadPipe, PHANDLE hWritePipe,
                LPSECURITY_ATTRIBUTES lpPipeAttributes, DWORD nSize);
BOOL DeviceIoControl(HANDLE hDevice, DWORD dwIoControlCode, LPVOID lpInBuffer,
                     DWORD nInBufferSize, LPVOID lpOutBuffer,
                     DWORD nOutBufferSize, LPDWORD lpBytesReturned,
                     LPOVERLAPPED lpOverlapped);
BOOL CreateHardLinkW(LPCWSTR lpFileName, LPCWSTR lpExistingFileName,
                     LPSECURITY_ATTRIBUTES lpSecurityAttributes);
BOOLEAN CreateSymbolicLinkW(LPCWSTR lpSymlinkFileName, LPCWSTR lpTargetFileName,
                            DWORD dwFlags);
BOOL MoveFileExW(LPCWSTR lpExistingFileName, LPCWSTR lpNewFileName,
                 DWORD dwFlags);
BOOL MoveFileExA(LPCSTR lpExistingFileName, LPCSTR lpNewFileName, DWORD dwFlags);
BOOL SetEnvironmentVariableW(LPCWSTR lpName, LPCWSTR lpValue);
UINT GetDriveTypeW(LPCWSTR lpRootPathName);
BOOL GetDiskFreeSpaceExW(LPCWSTR lpDirectoryName,
                         PULARGE_INTEGER lpFreeBytesAvailableToCaller,
                         PULARGE_INTEGER lpTotalNumberOfBytes,
                         PULARGE_INTEGER lpTotalNumberOfFreeBytes);
DWORD GetLogicalDriveStringsW(DWORD nBufferLength, LPWSTR lpBuffer);
BOOL GetVolumePathNameW(LPCWSTR lpszFileName, LPWSTR lpszVolumePathName,
                        DWORD cchBufferLength);
BOOL GetVolumePathNamesForVolumeNameW(LPCWSTR lpszVolumeName,
                                      LPWCH lpszVolumePathNames,
                                      DWORD cchBufferLength,
                                      PDWORD lpcchReturnLength);
HANDLE FindFirstVolumeW(LPWSTR lpszVolumeName, DWORD cchBufferLength);
BOOL FindNextVolumeW(HANDLE hFindVolume, LPWSTR lpszVolumeName,
                     DWORD cchBufferLength);
BOOL FindVolumeClose(HANDLE hFindVolume);
DWORD GetActiveProcessorCount(WORD GroupNumber);
HANDLE OpenProcess(DWORD dwDesiredAccess, BOOL bInheritHandle, DWORD dwProcessId);
DLL_DIRECTORY_COOKIE AddDllDirectory(PCWSTR NewDirectory);
BOOL RemoveDllDirectory(DLL_DIRECTORY_COOKIE Cookie);
BOOL SetWaitableTimer(HANDLE hTimer, const LARGE_INTEGER *lpDueTime,
                      LONG lPeriod, PTIMERAPCROUTINE pfnCompletionRoutine,
                      LPVOID lpArgToCompletionRoutine, BOOL fResume);
BOOL SetWaitableTimerEx(HANDLE hTimer, const LARGE_INTEGER *lpDueTime,
                        LONG lPeriod, PTIMERAPCROUTINE pfnCompletionRoutine,
                        LPVOID lpArgToCompletionRoutine,
                        PREASON_CONTEXT WakeContext, ULONG TolerableDelay);
BOOL GetStringTypeW(DWORD dwInfoType, LPCWCH lpSrcStr, int cchSrc,
                    LPWORD lpCharType);
DWORD PssCaptureSnapshot(HANDLE ProcessHandle, PSS_CAPTURE_FLAGS CaptureFlags,
                         DWORD ThreadContextFlags, HPSS *SnapshotHandle);
DWORD PssFreeSnapshot(HANDLE ProcessHandle, HPSS SnapshotHandle);
DWORD PssQuerySnapshot(HPSS SnapshotHandle,
                       PSS_QUERY_INFORMATION_CLASS InformationClass,
                       void *Buffer, DWORD BufferLength);
BOOL GetUserNameW(LPWSTR lpBuffer, LPDWORD pcbBuffer);
BOOL ConvertStringSecurityDescriptorToSecurityDescriptorW(LPCWSTR StringSecurityDescriptor,
                                                          DWORD StringSDRevision,
                                                          PSECURITY_DESCRIPTOR *SecurityDescriptor,
                                                          PULONG SecurityDescriptorSize);
HRESULT PathCchSkipRoot(PCWSTR pszPath, PCWSTR *ppszRootEnd);
HRESULT PathCchCombineEx(PWSTR pszPathOut, size_t cchPathOut, PCWSTR pszPathIn,
                         PCWSTR pszMore, ULONG dwFlags);
DWORD GetFileVersionInfoSizeW(LPCWSTR lptstrFilename, LPDWORD lpdwHandle);
BOOL GetFileVersionInfoW(LPCWSTR lptstrFilename, DWORD dwHandle, DWORD dwLen,
                         LPVOID lpData);
BOOL VerQueryValueW(LPCVOID pBlock, LPCWSTR lpSubBlock, LPVOID *lplpBuffer,
                    PUINT puLen);
LSTATUS RegCloseKey(HKEY hKey);
LSTATUS RegConnectRegistryW(LPCWSTR lpMachineName, HKEY hKey, PHKEY phkResult);
LSTATUS RegCreateKeyW(HKEY hKey, LPCWSTR lpSubKey, PHKEY phkResult);
LSTATUS RegCreateKeyExW(HKEY hKey, LPCWSTR lpSubKey, DWORD Reserved,
                        LPWSTR lpClass, DWORD dwOptions, REGSAM samDesired,
                        const LPSECURITY_ATTRIBUTES lpSecurityAttributes,
                        PHKEY phkResult, LPDWORD lpdwDisposition);
LSTATUS RegDeleteKeyW(HKEY hKey, LPCWSTR lpSubKey);
LSTATUS RegDeleteKeyExW(HKEY hKey, LPCWSTR lpSubKey, REGSAM samDesired,
                        DWORD Reserved);
LSTATUS RegDeleteValueW(HKEY hKey, LPCWSTR lpValueName);
LSTATUS RegEnumKeyExW(HKEY hKey, DWORD dwIndex, LPWSTR lpName,
                      LPDWORD lpcchName, LPDWORD lpReserved, LPWSTR lpClass,
                      LPDWORD lpcchClass, PFILETIME lpftLastWriteTime);
LSTATUS RegEnumValueW(HKEY hKey, DWORD dwIndex, LPWSTR lpValueName,
                      LPDWORD lpcchValueName, LPDWORD lpReserved,
                      LPDWORD lpType, LPBYTE lpData, LPDWORD lpcbData);
LSTATUS RegFlushKey(HKEY hKey);
LSTATUS RegLoadKeyW(HKEY hKey, LPCWSTR lpSubKey, LPCWSTR lpFile);
LSTATUS RegOpenKeyExW(HKEY hKey, LPCWSTR lpSubKey, DWORD ulOptions,
                      REGSAM samDesired, PHKEY phkResult);
LSTATUS RegQueryInfoKeyW(HKEY hKey, LPWSTR lpClass, LPDWORD lpcchClass,
                         LPDWORD lpReserved, LPDWORD lpcSubKeys,
                         LPDWORD lpcbMaxSubKeyLen, LPDWORD lpcbMaxClassLen,
                         LPDWORD lpcValues, LPDWORD lpcbMaxValueNameLen,
                         LPDWORD lpcbMaxValueLen,
                         LPDWORD lpcbSecurityDescriptor,
                         PFILETIME lpftLastWriteTime);
LSTATUS RegQueryValueExW(HKEY hKey, LPCWSTR lpValueName, LPDWORD lpReserved,
                         LPDWORD lpType, LPBYTE lpData, LPDWORD lpcbData);
LSTATUS RegSaveKeyW(HKEY hKey, LPCWSTR lpFile,
                    const LPSECURITY_ATTRIBUTES lpSecurityAttributes);
LSTATUS RegSetValueExW(HKEY hKey, LPCWSTR lpValueName, DWORD Reserved,
                       DWORD dwType, const BYTE *lpData, DWORD cbData);
BOOL AreFileApisANSI(VOID);
BOOL CancelIo(HANDLE hFile);
HANDLE CreateEventA(LPSECURITY_ATTRIBUTES lpEventAttributes, BOOL bManualReset,
                    BOOL bInitialState, LPCSTR lpName);
BOOL FlushViewOfFile(LPCVOID lpBaseAddress, SIZE_T dwNumberOfBytesToFlush);
HMODULE GetModuleHandleA(LPCSTR lpModuleName);
HMODULE GetModuleHandleW(LPCWSTR lpModuleName);
VOID GetNativeSystemInfo(LPSYSTEM_INFO lpSystemInfo);
HANDLE GetProcessHeap(VOID);
FARPROC GetProcAddressA(HMODULE hModule, LPCSTR lpProcName);
LPWSTR CharLowerW(LPWSTR lpsz);
LPWSTR CharUpperW(LPWSTR lpsz);
HANDLE CreateFileA(LPCSTR lpFileName, DWORD dwDesiredAccess, DWORD dwShareMode,
                   LPSECURITY_ATTRIBUTES lpSecurityAttributes,
                   DWORD dwCreationDisposition, DWORD dwFlagsAndAttributes,
                   HANDLE hTemplateFile);
HANDLE CreateFileMappingA(HANDLE hFile,
                          LPSECURITY_ATTRIBUTES lpFileMappingAttributes,
                          DWORD flProtect, DWORD dwMaximumSizeHigh,
                          DWORD dwMaximumSizeLow, LPCSTR lpName);
HANDLE CreateFileMappingW(HANDLE hFile,
                          LPSECURITY_ATTRIBUTES lpFileMappingAttributes,
                          DWORD flProtect, DWORD dwMaximumSizeHigh,
                          DWORD dwMaximumSizeLow, LPCWSTR lpName);
HANDLE CreateFileW(LPCWSTR lpFileName, DWORD dwDesiredAccess, DWORD dwShareMode,
                   LPSECURITY_ATTRIBUTES lpSecurityAttributes,
                   DWORD dwCreationDisposition, DWORD dwFlagsAndAttributes,
                   HANDLE hTemplateFile);
HANDLE CreateFileTransactedA(LPCSTR lpFileName, DWORD dwDesiredAccess,
                             DWORD dwShareMode,
                             LPSECURITY_ATTRIBUTES lpSecurityAttributes,
                             DWORD dwCreationDisposition,
                             DWORD dwFlagsAndAttributes, HANDLE hTemplateFile,
                             HANDLE hTransaction, PUSHORT pusMiniVersion,
                             PVOID lpExtendedParameter);
HANDLE CreateFileTransactedW(LPCWSTR lpFileName, DWORD dwDesiredAccess,
                             DWORD dwShareMode,
                             LPSECURITY_ATTRIBUTES lpSecurityAttributes,
                             DWORD dwCreationDisposition,
                             DWORD dwFlagsAndAttributes, HANDLE hTemplateFile,
                             HANDLE hTransaction, PUSHORT pusMiniVersion,
                             PVOID lpExtendedParameter);
DWORD GetProcessId(HANDLE Process);
LPSTR lstrcpyA(LPSTR lpString1, LPCSTR lpString2);
LPWSTR lstrcpyW(LPWSTR lpString1, LPCWSTR lpString2);
HANDLE CreateMutexW(LPSECURITY_ATTRIBUTES lpMutexAttributes, BOOL bInitialOwner,
                    LPCWSTR lpName);
BOOL DeleteFileA(LPCSTR lpFileName);
BOOL DeleteFileW(LPCWSTR lpFileName);
BOOL FileTimeToLocalFileTime(const FILETIME *lpFileTime,
                             LPFILETIME lpLocalFileTime);
BOOL FileTimeToSystemTime(const FILETIME *lpFileTime, LPSYSTEMTIME lpSystemTime);
BOOL FlushFileBuffers(HANDLE hFile);
DWORD FormatMessageA(DWORD dwFlags, LPCVOID lpSource, DWORD dwMessageId,
                     DWORD dwLanguageId, LPSTR lpBuffer, DWORD nSize,
                     va_list *Arguments);
DWORD FormatMessageW(DWORD dwFlags, LPCVOID lpSource, DWORD dwMessageId,
                     DWORD dwLanguageId, LPWSTR lpBuffer, DWORD nSize,
                     va_list *Arguments);
DWORD GetCurrentProcessId(VOID);
BOOL GetDiskFreeSpaceA(LPCSTR lpRootPathName, LPDWORD lpSectorsPerCluster,
                       LPDWORD lpBytesPerSector, LPDWORD lpNumberOfFreeClusters,
                       LPDWORD lpTotalNumberOfClusters);
BOOL GetDiskFreeSpaceW(LPCWSTR lpRootPathName, LPDWORD lpSectorsPerCluster,
                       LPDWORD lpBytesPerSector, LPDWORD lpNumberOfFreeClusters,
                       LPDWORD lpTotalNumberOfClusters);
DWORD GetFileAttributesA(LPCSTR lpFileName);
BOOL GetFileAttributesExW(LPCWSTR lpFileName,
                          GET_FILEEX_INFO_LEVELS fInfoLevelId,
                          LPVOID lpFileInformation);
DWORD GetFileAttributesW(LPCWSTR lpFileName);
DWORD GetFileSize(HANDLE hFile, LPDWORD lpFileSizeHigh);
DWORD GetFullPathNameA(LPCSTR lpFileName, DWORD nBufferLength, LPSTR lpBuffer,
                       LPSTR *lpFilePart);
DWORD GetFullPathNameW(LPCWSTR lpFileName, DWORD nBufferLength, LPWSTR lpBuffer,
                       LPWSTR *lpFilePart);
VOID GetSystemInfo(LPSYSTEM_INFO lpSystemInfo);
VOID GetSystemTime(LPSYSTEMTIME lpSystemTime);
VOID GetSystemTimeAsFileTime(LPFILETIME lpSystemTimeAsFileTime);
DWORD GetTempPathA(DWORD nBufferLength, LPSTR lpBuffer);
DWORD GetTempPathW(DWORD nBufferLength, LPWSTR lpBuffer);
DWORD GetTickCount(VOID);
BOOL GetVersionExA(LPOSVERSIONINFOA lpVersionInformation);
BOOL GetVersionExW(LPOSVERSIONINFOW lpVersionInformation);
BOOL VerifyVersionInfoW(LPOSVERSIONINFOEXW lpVersionInformation,
                        DWORD dwTypeMask, DWORDLONG dwlConditionMask);
ULONGLONG VerSetConditionMask(ULONGLONG ConditionMask, ULONG TypeMask,
                              UCHAR Condition);
BOOL GetComputerNameExW(COMPUTER_NAME_FORMAT NameType, LPWSTR lpBuffer,
                        LPDWORD nSize);
LPVOID HeapAlloc(HANDLE hHeap, DWORD dwFlags, SIZE_T dwBytes);
SIZE_T HeapCompact(HANDLE hHeap, DWORD dwFlags);
HANDLE HeapCreate(DWORD flOptions, SIZE_T dwInitialSize, SIZE_T dwMaximumSize);
BOOL HeapDestroy(HANDLE hHeap);
BOOL HeapFree(HANDLE hHeap, DWORD dwFlags, LPVOID lpMem);
LPVOID HeapReAlloc(HANDLE hHeap, DWORD dwFlags, LPVOID lpMem, SIZE_T dwBytes);
SIZE_T HeapSize(HANDLE hHeap, DWORD dwFlags, LPCVOID lpMem);
BOOL HeapValidate(HANDLE hHeap, DWORD dwFlags, LPCVOID lpMem);
HMODULE LoadLibraryW(LPCWSTR lpLibFileName);
HLOCAL LocalFree(HLOCAL hMem);
BOOL LockFile(HANDLE hFile, DWORD dwFileOffsetLow, DWORD dwFileOffsetHigh,
              DWORD nNumberOfBytesToLockLow, DWORD nNumberOfBytesToLockHigh);
BOOL LockFileEx(HANDLE hFile, DWORD dwFlags, DWORD dwReserved,
                DWORD nNumberOfBytesToLockLow, DWORD nNumberOfBytesToLockHigh,
                LPOVERLAPPED lpOverlapped);
LPVOID MapViewOfFile(HANDLE hFileMappingObject, DWORD dwDesiredAccess,
                     DWORD dwFileOffsetHigh, DWORD dwFileOffsetLow,
                     SIZE_T dwNumberOfBytesToMap);
int MultiByteToWideChar(UINT CodePage, DWORD dwFlags, LPCCH lpMultiByteStr,
                        int cbMultiByte, LPWSTR lpWideCharStr, int cchWideChar);
VOID OutputDebugStringA(LPCSTR lpOutputString);
VOID OutputDebugStringW(LPCWSTR lpOutputString);
BOOL QueryPerformanceCounter(LARGE_INTEGER *lpPerformanceCount);
BOOL ReadFile(HANDLE hFile, LPVOID lpBuffer, DWORD nNumberOfBytesToRead,
              LPDWORD lpNumberOfBytesRead, LPOVERLAPPED lpOverlapped);
BOOL SetEndOfFile(HANDLE hFile);
DWORD SetFilePointer(HANDLE hFile, LONG lDistanceToMove,
                     PLONG lpDistanceToMoveHigh, DWORD dwMoveMethod);
BOOL SystemTimeToFileTime(const SYSTEMTIME *lpSystemTime, LPFILETIME lpFileTime);
BOOL UnlockFile(HANDLE hFile, DWORD dwFileOffsetLow, DWORD dwFileOffsetHigh,
                DWORD nNumberOfBytesToUnlockLow,
                DWORD nNumberOfBytesToUnlockHigh);
BOOL UnlockFileEx(HANDLE hFile, DWORD dwReserved,
                  DWORD nNumberOfBytesToUnlockLow,
                  DWORD nNumberOfBytesToUnlockHigh, LPOVERLAPPED lpOverlapped);
BOOL UnmapViewOfFile(LPCVOID lpBaseAddress);
DWORD WaitForSingleObjectEx(HANDLE hHandle, DWORD dwMilliseconds,
                            BOOL bAlertable);
int WideCharToMultiByte(UINT CodePage, DWORD dwFlags, LPCWCH lpWideCharStr,
                        int cchWideChar, LPSTR lpMultiByteStr, int cbMultiByte,
                        LPCCH lpDefaultChar, LPBOOL lpUsedDefaultChar);
BOOL WriteFile(HANDLE hFile, LPCVOID lpBuffer, DWORD nNumberOfBytesToWrite,
               LPDWORD lpNumberOfBytesWritten, LPOVERLAPPED lpOverlapped);
HANDLE FindFirstFileA(LPCSTR lpFileName, LPWIN32_FIND_DATAA lpFindFileData);
HANDLE FindFirstFileW(LPCWSTR lpFileName, LPWIN32_FIND_DATAW lpFindFileData);
BOOL FindNextFileA(HANDLE hFindFile, LPWIN32_FIND_DATAA lpFindFileData);
BOOL FindNextFileW(HANDLE hFindFile, LPWIN32_FIND_DATAW lpFindFileData);
BOOL FindClose(HANDLE hFindFile);
BOOL SetCurrentDirectoryA(LPCSTR lpPathName);
BOOL SetCurrentDirectoryW(LPCWSTR lpPathName);
DWORD GetCurrentDirectoryA(DWORD nBufferLength, LPSTR lpBuffer);
DWORD GetCurrentDirectoryW(DWORD nBufferLength, LPWSTR lpBuffer);
BOOL CreateDirectoryA(LPCSTR lpPathName,
                      LPSECURITY_ATTRIBUTES lpSecurityAttributes);
BOOL CreateDirectoryW(LPCWSTR lpPathName,
                      LPSECURITY_ATTRIBUTES lpSecurityAttributes);
BOOL RemoveDirectoryA(LPCSTR lpPathName);
BOOL RemoveDirectoryW(LPCWSTR lpPathName);
BOOL SetFileAttributesA(LPCSTR lpFileName, DWORD dwFileAttributes);
BOOL SetFileAttributesW(LPCWSTR lpFileName, DWORD dwFileAttributes);
DWORD GetEnvironmentVariableA(LPCSTR lpName, LPSTR lpBuffer, DWORD nSize);
DWORD GetEnvironmentVariableW(LPCWSTR lpName, LPWSTR lpBuffer, DWORD nSize);
BOOL SetFileTime(HANDLE hFile, const FILETIME *lpCreationTime,
                 const FILETIME *lpLastAccessTime,
                 const FILETIME *lpLastWriteTime);
BOOL GetFileTime(HANDLE hFile, LPFILETIME lpCreationTime,
                 LPFILETIME lpLastAccessTime, LPFILETIME lpLastWriteTime);
UINT GetTempFileNameA(LPCSTR lpPathName, LPCSTR lpPrefixString, UINT uUnique,
                      LPSTR lpTempFileName);
UINT GetTempFileNameW(LPCWSTR lpPathName, LPCWSTR lpPrefixString, UINT uUnique,
                      LPWSTR lpTempFileName);
HANDLE GetCurrentProcess(VOID);
BOOL DuplicateHandle(HANDLE hSourceProcessHandle, HANDLE hSourceHandle,
                     HANDLE hTargetProcessHandle, LPHANDLE lpTargetHandle,
                     DWORD dwDesiredAccess, BOOL bInheritHandle, DWORD dwOptions);
BOOL SetFilePointerEx(HANDLE hFile, LARGE_INTEGER liDistanceToMove,
                      PLARGE_INTEGER lpNewFilePointer, DWORD dwMoveMethod);
BOOL GetFileSizeEx(HANDLE hFile, PLARGE_INTEGER lpFileSize);
HANDLE CreateMutexA(LPSECURITY_ATTRIBUTES lpMutexAttributes, BOOL bInitialOwner,
                    LPCSTR lpName);
HANDLE CreateEventW(LPSECURITY_ATTRIBUTES lpEventAttributes, BOOL bManualReset,
                    BOOL bInitialState, LPCWSTR lpName);
BOOL ReleaseMutex(HANDLE hMutex);
BOOL SetEvent(HANDLE hEvent);
BOOL ResetEvent(HANDLE hEvent);
HANDLE CreateIoCompletionPort(HANDLE FileHandle, HANDLE ExistingCompletionPort,
                              ULONG_PTR CompletionKey,
                              DWORD NumberOfConcurrentThreads);
BOOL GetQueuedCompletionStatus(HANDLE CompletionPort,
                               LPDWORD lpNumberOfBytesTransferred,
                               PULONG_PTR lpCompletionKey,
                               LPOVERLAPPED *lpOverlapped, DWORD dwMilliseconds);
BOOL PostQueuedCompletionStatus(HANDLE CompletionPort,
                                DWORD dwNumberOfBytesTransferred,
                                ULONG_PTR dwCompletionKey,
                                LPOVERLAPPED lpOverlapped);
BOOL RegisterWaitForSingleObject(PHANDLE phNewWaitObject, HANDLE hObject,
                                 WAITORTIMERCALLBACK Callback, PVOID Context,
                                 ULONG dwMilliseconds, ULONG dwFlags);
BOOL UnregisterWait(HANDLE WaitHandle);
BOOL UnregisterWaitEx(HANDLE WaitHandle, HANDLE CompletionEvent);
HANDLE OpenMutexA(DWORD dwDesiredAccess, BOOL bInheritHandle, LPCSTR lpName);
HANDLE OpenMutexW(DWORD dwDesiredAccess, BOOL bInheritHandle, LPCWSTR lpName);
HANDLE OpenEventA(DWORD dwDesiredAccess, BOOL bInheritHandle, LPCSTR lpName);
HANDLE OpenEventW(DWORD dwDesiredAccess, BOOL bInheritHandle, LPCWSTR lpName);
VOID RaiseException(DWORD dwExceptionCode, DWORD dwExceptionFlags,
                    DWORD nNumberOfArguments, const ULONG_PTR *lpArguments);
BOOL IsDebuggerPresent(VOID);
VOID DebugBreak(VOID);
LPTOP_LEVEL_EXCEPTION_FILTER SetUnhandledExceptionFilter(LPTOP_LEVEL_EXCEPTION_FILTER lpTopLevelExceptionFilter);
PVOID AddVectoredExceptionHandler(ULONG First,
                                  PVECTORED_EXCEPTION_HANDLER Handler);
ULONG RemoveVectoredExceptionHandler(PVOID Handle);
BOOL TerminateProcess(HANDLE hProcess, UINT uExitCode);
UINT GetSystemDirectoryA(LPSTR lpBuffer, UINT uSize);
UINT GetSystemDirectoryW(LPWSTR lpBuffer, UINT uSize);
UINT GetWindowsDirectoryA(LPSTR lpBuffer, UINT uSize);
UINT GetWindowsDirectoryW(LPWSTR lpBuffer, UINT uSize);
DWORD ExpandEnvironmentStringsA(LPCSTR lpSrc, LPSTR lpDst, DWORD nSize);
DWORD ExpandEnvironmentStringsW(LPCWSTR lpSrc, LPWSTR lpDst, DWORD nSize);
DWORD SearchPathA(LPCSTR lpPath, LPCSTR lpFileName, LPCSTR lpExtension,
                  DWORD nBufferLength, LPSTR lpBuffer, LPSTR *lpFilePart);
DWORD SearchPath(LPCSTR lpPath, LPCSTR lpFileName, LPCSTR lpExtension,
                 DWORD nBufferLength, LPSTR lpBuffer, LPSTR *lpFilePart);
DWORD GetModuleFileNameA(HMODULE hModule, LPSTR lpFilename, DWORD nSize);
DWORD SearchPathW(LPCWSTR lpPath, LPCWSTR lpFileName, LPCWSTR lpExtension,
                  DWORD nBufferLength, LPWSTR lpBuffer, LPWSTR *lpFilePart);
BOOL CreateProcessA(LPCSTR lpApplicationName, LPSTR lpCommandLine,
                    LPSECURITY_ATTRIBUTES lpProcessAttributes,
                    LPSECURITY_ATTRIBUTES lpThreadAttributes,
                    BOOL bInheritHandles, DWORD dwCreationFlags,
                    LPVOID lpEnvironment, LPCSTR lpCurrentDirectory,
                    LPSTARTUPINFOA lpStartupInfo,
                    LPPROCESS_INFORMATION lpProcessInformation);
BOOL CreateProcessW(LPCWSTR lpApplicationName, LPWSTR lpCommandLine,
                    LPSECURITY_ATTRIBUTES lpProcessAttributes,
                    LPSECURITY_ATTRIBUTES lpThreadAttributes,
                    BOOL bInheritHandles, DWORD dwCreationFlags,
                    LPVOID lpEnvironment, LPCWSTR lpCurrentDirectory,
                    LPSTARTUPINFOW lpStartupInfo,
                    LPPROCESS_INFORMATION lpProcessInformation);
HANDLE GetStdHandle(DWORD nStdHandle);
BOOL SetStdHandle(DWORD nStdHandle, HANDLE hHandle);
BOOL GetConsoleMode(HANDLE hConsoleHandle, LPDWORD lpMode);
BOOL SetConsoleMode(HANDLE hConsoleHandle, DWORD dwMode);
UINT GetConsoleOutputCP(VOID);
BOOL SetConsoleOutputCP(UINT wCodePageID);
UINT GetConsoleCP(VOID);
BOOL SetConsoleCP(UINT wCodePageID);
BOOL WriteConsoleW(HANDLE hConsoleOutput, const VOID *lpBuffer,
                   DWORD nNumberOfCharsToWrite, LPDWORD lpNumberOfCharsWritten,
                   LPVOID lpReserved);
BOOL WriteConsoleA(HANDLE hConsoleOutput, const VOID *lpBuffer,
                   DWORD nNumberOfCharsToWrite, LPDWORD lpNumberOfCharsWritten,
                   LPVOID lpReserved);
BOOL ReadConsoleW(HANDLE hConsoleInput, LPVOID lpBuffer,
                  DWORD nNumberOfCharsToRead, LPDWORD lpNumberOfCharsRead,
                  PCONSOLE_READCONSOLE_CONTROL pInputControl);
BOOL ReadConsoleA(HANDLE hConsoleInput, LPVOID lpBuffer,
                  DWORD nNumberOfCharsToRead, LPDWORD lpNumberOfCharsRead,
                  PCONSOLE_READCONSOLE_CONTROL pInputControl);
BOOL FlushConsoleInputBuffer(HANDLE hConsoleInput);
BOOL GetConsoleScreenBufferInfo(HANDLE hConsoleOutput,
                                PCONSOLE_SCREEN_BUFFER_INFO lpConsoleScreenBufferInfo);
BOOL SetConsoleScreenBufferSize(HANDLE hConsoleOutput, COORD dwSize);
BOOL SetConsoleCursorPosition(HANDLE hConsoleOutput, COORD dwCursorPosition);
BOOL SetConsoleTextAttribute(HANDLE hConsoleOutput, WORD wAttributes);
BOOL FillConsoleOutputCharacterA(HANDLE hConsoleOutput, CHAR cCharacter,
                                 DWORD nLength, COORD dwWriteCoord,
                                 LPDWORD lpNumberOfCharsWritten);
BOOL FillConsoleOutputCharacterW(HANDLE hConsoleOutput, WCHAR cCharacter,
                                 DWORD nLength, COORD dwWriteCoord,
                                 LPDWORD lpNumberOfCharsWritten);
BOOL FillConsoleOutputAttribute(HANDLE hConsoleOutput, WORD wAttribute,
                                DWORD nLength, COORD dwWriteCoord,
                                LPDWORD lpNumberOfAttrsWritten);
BOOL ScrollConsoleScreenBufferA(HANDLE hConsoleOutput,
                                const SMALL_RECT *lpScrollRectangle,
                                const SMALL_RECT *lpClipRectangle,
                                COORD dwDestinationOrigin,
                                const CHAR_INFO *lpFill);
BOOL ScrollConsoleScreenBufferW(HANDLE hConsoleOutput,
                                const SMALL_RECT *lpScrollRectangle,
                                const SMALL_RECT *lpClipRectangle,
                                COORD dwDestinationOrigin,
                                const CHAR_INFO *lpFill);
BOOL SetConsoleTitleA(LPCSTR lpConsoleTitle);
BOOL SetConsoleTitleW(LPCWSTR lpConsoleTitle);
DWORD GetConsoleTitleA(LPSTR lpConsoleTitle, DWORD nSize);
DWORD GetConsoleTitleW(LPWSTR lpConsoleTitle, DWORD nSize);
BOOL PeekConsoleInputA(HANDLE hConsoleInput, PINPUT_RECORD lpBuffer,
                       DWORD nLength, LPDWORD lpNumberOfEventsRead);
BOOL PeekConsoleInputW(HANDLE hConsoleInput, PINPUT_RECORD lpBuffer,
                       DWORD nLength, LPDWORD lpNumberOfEventsRead);
BOOL ReadConsoleInputA(HANDLE hConsoleInput, PINPUT_RECORD lpBuffer,
                       DWORD nLength, LPDWORD lpNumberOfEventsRead);
BOOL ReadConsoleInputW(HANDLE hConsoleInput, PINPUT_RECORD lpBuffer,
                       DWORD nLength, LPDWORD lpNumberOfEventsRead);
BOOL WriteConsoleInputA(HANDLE hConsoleInput, const INPUT_RECORD *lpBuffer,
                        DWORD nLength, LPDWORD lpNumberOfEventsWritten);
BOOL WriteConsoleInputW(HANDLE hConsoleInput, const INPUT_RECORD *lpBuffer,
                        DWORD nLength, LPDWORD lpNumberOfEventsWritten);
BOOL SetConsoleCtrlHandler(PHANDLER_ROUTINE HandlerRoutine, BOOL Add);
BOOL GenerateConsoleCtrlEvent(DWORD dwCtrlEvent, DWORD dwProcessGroupId);
BOOL AllocConsole(VOID);
BOOL FreeConsole(VOID);
BOOL AttachConsole(DWORD dwProcessId);
DWORD GetConsoleProcessList(LPDWORD lpdwProcessList, DWORD dwProcessCount);
HWND GetConsoleWindow(VOID);
VOID GetSystemTimePreciseAsFileTime(LPFILETIME lpSystemTimeAsFileTime);
BOOL QueryPerformanceFrequency(LARGE_INTEGER *lpFrequency);
ULONGLONG GetTickCount64(VOID);
BOOL SwitchToThread(VOID);
DWORD SleepEx(DWORD dwMilliseconds, BOOL bAlertable);
DWORD GetTimeZoneInformation(LPTIME_ZONE_INFORMATION lpTimeZoneInformation);
BOOL SystemTimeToTzSpecificLocalTime(const TIME_ZONE_INFORMATION *lpTimeZoneInformation,
                                     const SYSTEMTIME *lpUniversalTime,
                                     LPSYSTEMTIME lpLocalTime);
BOOL TzSpecificLocalTimeToSystemTime(const TIME_ZONE_INFORMATION *lpTimeZoneInformation,
                                     const SYSTEMTIME *lpLocalTime,
                                     LPSYSTEMTIME lpUniversalTime);
VOID GetLocalTime(LPSYSTEMTIME lpSystemTime);
VOID SetLastError(DWORD dwErrCode);
RPC_STATUS UuidCreate(UUID *Uuid);
RPC_STATUS UuidCreateSequential(UUID *Uuid);
HANDLE CreateNamedPipeW(LPCWSTR lpName, DWORD dwOpenMode, DWORD dwPipeMode,
                        DWORD nMaxInstances, DWORD nOutBufferSize,
                        DWORD nInBufferSize, DWORD nDefaultTimeOut,
                        LPSECURITY_ATTRIBUTES lpSecurityAttributes);
BOOL WaitNamedPipeW(LPCWSTR lpNamedPipeName, DWORD nTimeOut);
BOOL PeekNamedPipe(HANDLE hNamedPipe, LPVOID lpBuffer, DWORD nBufferSize,
                   LPDWORD lpBytesRead, LPDWORD lpTotalBytesAvail,
                   LPDWORD lpBytesLeftThisMessage);
BOOL GetExitCodeProcess(HANDLE hProcess, LPDWORD lpExitCode);
DWORD ResumeThread(HANDLE hThread);
BOOL TerminateThread(HANDLE hThread, DWORD dwExitCode);
DWORD GetVersion(VOID);
DWORD GetLongPathNameW(LPCWSTR lpszShortPath, LPWSTR lpszLongPath,
                       DWORD cchBuffer);
DWORD GetShortPathNameW(LPCWSTR lpszLongPath, LPWSTR lpszShortPath,
                        DWORD cchBuffer);
HANDLE OpenFileMappingW(DWORD dwDesiredAccess, BOOL bInheritHandle,
                        LPCWSTR lpName);
SIZE_T VirtualQuery(LPCVOID lpAddress, PMEMORY_BASIC_INFORMATION lpBuffer,
                    SIZE_T dwLength);
HRESULT CopyFile2(PCWSTR pwszExistingFileName, PCWSTR pwszNewFileName,
                  COPYFILE2_EXTENDED_PARAMETERS *pExtendedParameters);
BOOL NeedCurrentDirectoryForExePathW(LPCWSTR ExeName);
int LCMapStringEx(LPCWSTR lpLocaleName, DWORD dwMapFlags, LPCWSTR lpSrcStr,
                  int cchSrc, LPWSTR lpDestStr, int cchDest,
                  LPNLSVERSIONINFO lpVersionInformation, LPVOID lpReserved,
                  LPARAM sortHandle);
BOOL InitializeProcThreadAttributeList(LPPROC_THREAD_ATTRIBUTE_LIST lpAttributeList,
                                       DWORD dwAttributeCount, DWORD dwFlags,
                                       PSIZE_T lpSize);
BOOL UpdateProcThreadAttribute(LPPROC_THREAD_ATTRIBUTE_LIST lpAttributeList,
                               DWORD dwFlags, DWORD_PTR Attribute,
                               PVOID lpValue, SIZE_T cbSize,
                               PVOID lpPreviousValue, PSIZE_T lpReturnSize);
VOID DeleteProcThreadAttributeList(LPPROC_THREAD_ATTRIBUTE_LIST lpAttributeList);
BOOL OpenProcessToken(HANDLE ProcessHandle, DWORD DesiredAccess,
                      PHANDLE TokenHandle);
BOOL LookupPrivilegeValueW(LPCWSTR lpSystemName, LPCWSTR lpName, PLUID lpLuid);
BOOL AdjustTokenPrivileges(HANDLE TokenHandle, BOOL DisableAllPrivileges,
                           PTOKEN_PRIVILEGES NewState, DWORD BufferLength,
                           PTOKEN_PRIVILEGES PreviousState, PDWORD ReturnLength);
UINT GetRawInputDeviceList(PRAWINPUTDEVICELIST pRawInputDeviceList,
                           PUINT puiNumDevices, UINT cbSize);
UINT GetRawInputDeviceInfoA(HANDLE hDevice, UINT uiCommand, LPVOID pData,
                            PUINT pcbSize);
UINT GetRawInputDeviceInfoW(HANDLE hDevice, UINT uiCommand, LPVOID pData,
                            PUINT pcbSize);
HGLOBAL GlobalAlloc(UINT uFlags, SIZE_T dwBytes);
HGLOBAL GlobalFree(HGLOBAL hMem);
LPVOID GlobalLock(HGLOBAL hMem);
BOOL GlobalUnlock(HGLOBAL hMem);
SIZE_T GlobalSize(HGLOBAL hMem);
HWND CreateWindowExA(DWORD dwExStyle, LPCSTR lpClassName, LPCSTR lpWindowName,
                     DWORD dwStyle, int X, int Y, int nWidth, int nHeight,
                     HWND hWndParent, HMENU hMenu, HINSTANCE hInstance,
                     LPVOID lpParam);
ATOM RegisterClassA(const WNDCLASSA *lpWndClass);
LRESULT DefWindowProcA(HWND hWnd, UINT Msg, WPARAM wParam, LPARAM lParam);
HWND CreateWindowExW(DWORD dwExStyle, LPCWSTR lpClassName, LPCWSTR lpWindowName,
                     DWORD dwStyle, int X, int Y, int nWidth, int nHeight,
                     HWND hWndParent, HMENU hMenu, HINSTANCE hInstance,
                     LPVOID lpParam);
ATOM RegisterClassW(const WNDCLASSW *lpWndClass);
LRESULT DefWindowProcW(HWND hWnd, UINT Msg, WPARAM wParam, LPARAM lParam);
HANDLE GetPropW(HWND hWnd, LPCWSTR lpString);
BOOL SetPropW(HWND hWnd, LPCWSTR lpString, HANDLE hData);
HANDLE RemovePropW(HWND hWnd, LPCWSTR lpString);
LSTATUS RegGetValueW(HKEY hkey, LPCWSTR lpSubKey, LPCWSTR lpValue,
                     DWORD dwFlags, LPDWORD pdwType, PVOID pvData,
                     LPDWORD pcbData);
BOOL GetKeyboardState(PBYTE lpKeyState);
HKL GetKeyboardLayout(DWORD idThread);
UINT MapVirtualKeyW(UINT uCode, UINT uMapType);
int ToUnicodeEx(UINT wVirtKey, UINT wScanCode, const BYTE *lpKeyState,
                LPWSTR pwszBuff, int cchBuff, UINT wFlags, HKL dwhkl);
LONG ChangeDisplaySettingsExW(LPCWSTR lpszDeviceName, DEVMODEW *lpDevMode,
                              HWND hwnd, DWORD dwflags, LPVOID lParam);
BOOL EnumDisplayDevicesW(LPCWSTR lpDevice, DWORD iDevNum,
                         PDISPLAY_DEVICEW lpDisplayDevice, DWORD dwFlags);
BOOL EnumDisplaySettingsW(LPCWSTR lpszDeviceName, DWORD iModeNum,
                          DEVMODEW *lpDevMode);
BOOL FlashWindowEx(PFLASHWINFO pfwi);
BOOL GetMonitorInfoW(HMONITOR hMonitor, LPMONITORINFO lpmi);
BOOL IsZoomed(HWND hWnd);
HICON LoadIconA(HINSTANCE hInstance, LPCSTR lpIconName);
HANDLE LoadImageA(HINSTANCE hInst, LPCSTR name, UINT type, int cx, int cy,
                  UINT fuLoad);
LONG_PTR GetWindowLongPtrW(HWND hWnd, int nIndex);
LONG_PTR SetWindowLongPtrW(HWND hWnd, int nIndex, LONG_PTR dwNewLong);
BOOL SetWindowTextW(HWND hWnd, LPCWSTR lpString);
LRESULT SendMessageW(HWND hWnd, UINT Msg, WPARAM wParam, LPARAM lParam);
HWND SetFocus(HWND hWnd);
BOOL SetForegroundWindow(HWND hWnd);
UINT_PTR SetTimer(HWND hWnd, UINT_PTR nIDEvent, UINT uElapse,
                  TIMERPROC lpTimerFunc);
BOOL KillTimer(HWND hWnd, UINT_PTR uIDEvent);
HDC BeginPaint(HWND hWnd, LPPAINTSTRUCT lpPaint);
BOOL EndPaint(HWND hWnd, const PAINTSTRUCT *lpPaint);
BOOL BringWindowToTop(HWND hWnd);
BOOL AdjustWindowRectEx(LPRECT lpRect, DWORD dwStyle, BOOL bMenu,
                        DWORD dwExStyle);
BOOL MoveWindow(HWND hWnd, int X, int Y, int nWidth, int nHeight, BOOL bRepaint);
BOOL BitBlt(HDC hdc, int x, int y, int cx, int cy, HDC hdcSrc, int x1, int y1,
            DWORD rop);
HDC CreateDCW(LPCWSTR pwszDriver, LPCWSTR pwszDevice, LPCWSTR pszPort,
              const DEVMODEW *pdm);
BOOL GetDeviceGammaRamp(HDC hdc, LPVOID lpRamp);
BOOL SetDeviceGammaRamp(HDC hdc, LPVOID lpRamp);
BOOL ShowWindow(HWND hWnd, int nCmdShow);
HDC GetDC(HWND hWnd);
int ReleaseDC(HWND hWnd, HDC hDC);
BOOL GetWindowRect(HWND hWnd, LPRECT lpRect);
BOOL GetClientRect(HWND hWnd, LPRECT lpRect);
BOOL DestroyWindow(HWND hWnd);
BOOL PeekMessageA(LPMSG lpMsg, HWND hWnd, UINT wMsgFilterMin,
                  UINT wMsgFilterMax, UINT wRemoveMsg);
BOOL TranslateMessage(const MSG *lpMsg);
LRESULT DispatchMessageA(const MSG *lpMsg);
BOOL PostMessageW(HWND hWnd, UINT Msg, WPARAM wParam, LPARAM lParam);
DWORD MsgWaitForMultipleObjects(DWORD nCount, const HANDLE *pHandles,
                                BOOL fWaitAll, DWORD dwMilliseconds,
                                DWORD dwWakeMask);
HCURSOR LoadCursorA(HINSTANCE hInstance, LPCSTR lpCursorName);
SHORT GetKeyState(int nVirtKey);
int GetKeyNameTextA(LONG lParam, LPSTR lpString, int cchSize);
UINT MapVirtualKeyA(UINT uCode, UINT uMapType);
int ToAscii(UINT uVirtKey, UINT uScanCode, const BYTE *lpKeyState,
            LPWORD lpChar, UINT uFlags);
UINT GetRawInputData(HRAWINPUT hRawInput, UINT uiCommand, LPVOID pData,
                     PUINT pcbSize, UINT cbSizeHeader);
BOOL RegisterRawInputDevices(PCRAWINPUTDEVICE pRawInputDevices,
                             UINT uiNumDevices, UINT cbSize);
BOOL ClipCursor(const RECT *lpRect);
BOOL GetCursorPos(LPPOINT lpPoint);
BOOL SetCursorPos(int X, int Y);
BOOL ClientToScreen(HWND hWnd, LPPOINT lpPoint);
BOOL ScreenToClient(HWND hWnd, LPPOINT lpPoint);
BOOL IsWindow(HWND hWnd);
BOOL IsWindowVisible(HWND hWnd);
BOOL GetWindowPlacement(HWND hWnd, WINDOWPLACEMENT *lpwndpl);
ULONG_PTR SetClassLongPtrA(HWND hWnd, int nIndex, LONG_PTR dwNewLong);
HCURSOR SetCursor(HCURSOR hCursor);
BOOL DestroyCursor(HCURSOR hCursor);
BOOL DestroyIcon(HICON hIcon);
BOOL SetWindowPos(HWND hWnd, HWND hWndInsertAfter, int X, int Y, int cx, int cy,
                  UINT uFlags);
BOOL SetWindowTextA(HWND hWnd, LPCSTR lpString);
LONG GetWindowLongW(HWND hWnd, int nIndex);
LONG SetWindowLongW(HWND hWnd, int nIndex, LONG dwNewLong);
LONG GetWindowLongA(HWND hWnd, int nIndex);
LONG SetWindowLongA(HWND hWnd, int nIndex, LONG dwNewLong);
BOOL GetLayeredWindowAttributes(HWND hwnd, COLORREF *pcrKey, BYTE *pbAlpha,
                                DWORD *pdwFlags);
BOOL SetLayeredWindowAttributes(HWND hwnd, COLORREF crKey, BYTE bAlpha,
                                DWORD dwFlags);
int GetSystemMetrics(int nIndex);
HMONITOR MonitorFromPoint(POINT pt, DWORD dwFlags);
HMONITOR MonitorFromWindow(HWND hwnd, DWORD dwFlags);
BOOL EnumDisplayMonitors(HDC hdc, LPCRECT lprcClip, MONITORENUMPROC lpfnEnum,
                         LPARAM dwData);
BOOL EnumDisplayDevicesA(LPCSTR lpDevice, DWORD iDevNum,
                         PDISPLAY_DEVICEA lpDisplayDevice, DWORD dwFlags);
BOOL GetMonitorInfoA(HMONITOR hMonitor, LPMONITORINFO lpmi);
BOOL SetProcessDPIAware(VOID);
HWND GetForegroundWindow(VOID);
BOOL OpenClipboard(HWND hWndNewOwner);
BOOL CloseClipboard(VOID);
HANDLE GetClipboardData(UINT uFormat);
BOOL EmptyClipboard(VOID);
HANDLE SetClipboardData(UINT uFormat, HANDLE hMem);
DWORD CharLowerBuffA(LPSTR lpsz, DWORD cchLength);
int ChoosePixelFormat(HDC hdc, const PIXELFORMATDESCRIPTOR *ppfd);
BOOL SetPixelFormat(HDC hdc, int format, const PIXELFORMATDESCRIPTOR *ppfd);
int DescribePixelFormat(HDC hdc, int iPixelFormat, UINT nBytes,
                        LPPIXELFORMATDESCRIPTOR ppfd);
BOOL SwapBuffers(HDC hdc);
int GetDeviceCaps(HDC hdc, int index);
HBITMAP CreateBitmap(int nWidth, int nHeight, UINT nPlanes, UINT nBitCount,
                     const VOID *lpBits);
HBITMAP CreateDIBSection(HDC hdc, const BITMAPINFO *pbmi, UINT usage,
                         VOID **ppvBits, HANDLE hSection, DWORD offset);
HDC CreateCompatibleDC(HDC hdc);
BOOL DeleteDC(HDC hdc);
BOOL DeleteObject(HGDIOBJ ho);
HGDIOBJ SelectObject(HDC hdc, HGDIOBJ h);
HICON CreateIconIndirect(PICONINFO piconinfo);
HGLRC wglCreateContext(HDC hdc);
BOOL wglDeleteContext(HGLRC hglrc);
BOOL wglMakeCurrent(HDC hdc, HGLRC hglrc);
PROC wglGetProcAddress(LPCSTR lpszProc);
HDC wglGetCurrentDC(VOID);
HGLRC wglGetCurrentContext(VOID);
BOOL wglShareLists(HGLRC hglrc1, HGLRC hglrc2);

/* rcore.c (raylib 6.0), lines 159-166: the SDK's types spelled out. */
struct HINSTANCE__;
__declspec(dllimport) unsigned long __stdcall GetModuleFileNameA(struct HINSTANCE__ *hModule,
                                                                 char *lpFilename,
                                                                 unsigned long nSize);
__declspec(dllimport) unsigned long __stdcall GetModuleFileNameW(struct HINSTANCE__ *hModule,
                                                                 wchar_t *lpFilename,
                                                                 unsigned long nSize);
__declspec(dllimport) int __stdcall WideCharToMultiByte(unsigned int cp, unsigned long flags,
                                                        const wchar_t *widestr, int cchwide,
                                                        char *str, int cbmb, const char *defchar,
                                                        int *used_default);
__declspec(dllimport) int __stdcall MultiByteToWideChar(unsigned int CodePage,
                                                        unsigned long dwFlags,
                                                        const char *lpMultiByteStr,
                                                        int cbMultiByte, wchar_t *lpWideCharStr,
                                                        int cchWideChar);
__declspec(dllimport) struct HINSTANCE__ *__stdcall LoadLibraryA(const char *lpLibFileName);
__declspec(dllimport) long long (__stdcall *__stdcall GetProcAddress(struct HINSTANCE__ *hModule,
                                                                     const char *lpProcName))();
__declspec(dllimport) int __stdcall FreeLibrary(struct HINSTANCE__ *hLibModule);
__declspec(dllimport) unsigned long __stdcall GetLastError(void);
__declspec(dllimport) void *__stdcall VirtualAlloc(void *lpAddress, unsigned long long dwSize,
                                                   unsigned long flAllocationType,
                                                   unsigned long flProtect);
__declspec(dllimport) int __stdcall VirtualFree(void *lpAddress, unsigned long long dwSize,
                                                unsigned long dwFreeType);
__declspec(dllimport) unsigned long __stdcall WaitForSingleObject(void *hHandle,
                                                                  unsigned long dwMilliseconds);
__declspec(dllimport) int __stdcall CloseHandle(void *hObject);
__declspec(dllimport) void __stdcall Sleep(unsigned long dwMilliseconds);
