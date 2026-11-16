// delayimp.h -- the delay-load helper an image linked with `--delayload`
// (link.exe /DELAYLOAD) calls on the first call of each import from a
// delay-loaded DLL, and the hooks a program defines to observe or replace
// its steps.

#pragma once

#include <windows.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef IMAGE_THUNK_DATA *PImgThunkData;
typedef const IMAGE_THUNK_DATA *PCImgThunkData;
typedef DWORD RVA;

// One delay-loaded DLL: its name, module handle slot, import address and
// name tables, and the optional bound and unload tables.
typedef struct ImgDelayDescr {
    DWORD grAttrs;
    RVA rvaDLLName;
    RVA rvaHmod;
    RVA rvaIAT;
    RVA rvaINT;
    RVA rvaBoundIAT;
    RVA rvaUnloadIAT;
    DWORD dwTimeStamp;
} ImgDelayDescr, *PImgDelayDescr;
typedef const ImgDelayDescr *PCImgDelayDescr;

enum DLAttr {
    dlattrRva = 0x1,
};

// The notifications the hooks receive.
enum {
    dliStartProcessing,
    dliNoteStartProcessing = dliStartProcessing,
    dliNotePreLoadLibrary,
    dliNotePreGetProcAddress,
    dliFailLoadLib,
    dliFailGetProc,
    dliNoteEndProcessing,
};

typedef struct DelayLoadProc {
    BOOL fImportByName;
    union {
        LPCSTR szProcName;
        DWORD dwOrdinal;
    };
} DelayLoadProc;

typedef struct DelayLoadInfo {
    DWORD cb;
    PCImgDelayDescr pidd;
    FARPROC *ppfn;
    LPCSTR szDll;
    DelayLoadProc dlp;
    HMODULE hmodCur;
    FARPROC pfnCur;
    DWORD dwLastError;
} DelayLoadInfo, *PDelayLoadInfo;

typedef FARPROC(WINAPI *PfnDliHook)(unsigned dliNotify, PDelayLoadInfo pdli);

#define VcppException(sev, err) ((sev) | (FACILITY_VISUALCPP << 16) | (err))

// Null unless the program defines them.
extern const PfnDliHook __pfnDliNotifyHook2;
extern const PfnDliHook __pfnDliFailureHook2;

FARPROC WINAPI __delayLoadHelper2(PCImgDelayDescr pidd, FARPROC *ppfnIATEntry);
HRESULT WINAPI __HrLoadAllImportsForDll(LPCSTR szDll);

#ifdef __cplusplus
}
#endif
