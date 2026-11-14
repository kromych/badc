// <delayimp.h>'s helper on the Windows targets, as Microsoft documents it:
// the first call of a --delayload import loads its DLL once and stores the
// import's address in its slot. The hooks may supply each step; a failure
// they leave raises VcppException(ERROR_SEVERITY_ERROR, ERROR_MOD_NOT_FOUND
// or ERROR_PROC_NOT_FOUND) with the DelayLoadInfo. It compiles to nothing
// elsewhere; the native-link driver offers it like an archive member.

#ifdef _WIN32

#include <delayimp.h>
#include <string.h>

extern IMAGE_DOS_HEADER __ImageBase;

__attribute__((weak)) const PfnDliHook __pfnDliNotifyHook2;
__attribute__((weak)) const PfnDliHook __pfnDliFailureHook2;

static void *at_rva(DWORD rva) {
    return (char *)&__ImageBase + rva;
}

static FARPROC hook(PfnDliHook fn, unsigned what, PDelayLoadInfo dli) {
    return fn ? fn(what, dli) : NULL;
}

// A handler that continues execution leaves its address in pfnCur.
static FARPROC raise_failure(DWORD error, PDelayLoadInfo dli) {
    ULONG_PTR info = (ULONG_PTR)dli;
    RaiseException(VcppException(ERROR_SEVERITY_ERROR, error), 0, 1, &info);
    return dli->pfnCur;
}

FARPROC WINAPI __delayLoadHelper2(PCImgDelayDescr pidd, FARPROC *ppfnIATEntry) {
    DelayLoadInfo dli = {sizeof dli, pidd, ppfnIATEntry, at_rva(pidd->rvaDLLName)};
    HMODULE *slot = at_rva(pidd->rvaHmod);
    PCImgThunkData names = at_rva(pidd->rvaINT);
    PCImgThunkData name = names + (ppfnIATEntry - (FARPROC *)at_rva(pidd->rvaIAT));
    dli.dlp.fImportByName = !IMAGE_SNAP_BY_ORDINAL(name->u1.Ordinal);
    if (dli.dlp.fImportByName) {
        dli.dlp.szProcName = ((PIMAGE_IMPORT_BY_NAME)at_rva((DWORD)name->u1.AddressOfData))->Name;
    } else {
        dli.dlp.dwOrdinal = (DWORD)IMAGE_ORDINAL(name->u1.Ordinal);
    }
    FARPROC fn = hook(__pfnDliNotifyHook2, dliStartProcessing, &dli);
    HMODULE module = *slot;
    if (!fn) {
        if (!module) {
            module = (HMODULE)hook(__pfnDliNotifyHook2, dliNotePreLoadLibrary, &dli);
            if (!module) {
                module = LoadLibraryExA(dli.szDll, NULL, 0);
            }
            if (!module) {
                dli.dwLastError = GetLastError();
                module = (HMODULE)hook(__pfnDliFailureHook2, dliFailLoadLib, &dli);
            }
            if (!module) {
                return raise_failure(ERROR_MOD_NOT_FOUND, &dli);
            }
            // A thread that stored the module first keeps its reference.
            if (InterlockedExchangePointer((PVOID *)slot, module) == module) {
                FreeLibrary(module);
            }
        }
        dli.hmodCur = module;
        fn = hook(__pfnDliNotifyHook2, dliNotePreGetProcAddress, &dli);
        if (!fn) {
            LPCSTR proc = dli.dlp.fImportByName ? dli.dlp.szProcName
                                                : (LPCSTR)(ULONG_PTR)dli.dlp.dwOrdinal;
            fn = GetProcAddress(module, proc);
        }
        if (!fn) {
            dli.dwLastError = GetLastError();
            fn = hook(__pfnDliFailureHook2, dliFailGetProc, &dli);
        }
        if (!fn) {
            fn = raise_failure(ERROR_PROC_NOT_FOUND, &dli);
        }
        *ppfnIATEntry = fn;
    }
    if (__pfnDliNotifyHook2) {
        dli.dwLastError = 0;
        dli.hmodCur = module;
        dli.pfnCur = fn;
        __pfnDliNotifyHook2(dliNoteEndProcessing, &dli);
    }
    return fn;
}

HRESULT WINAPI __HrLoadAllImportsForDll(LPCSTR szDll) {
    PIMAGE_NT_HEADERS nt = at_rva((DWORD)__ImageBase.e_lfanew);
    DWORD table = nt->OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_DELAY_IMPORT].VirtualAddress;
    for (PCImgDelayDescr d = table ? at_rva(table) : NULL; d && d->rvaDLLName; d++) {
        if (_stricmp(at_rva(d->rvaDLLName), szDll) == 0) {
            for (FARPROC *entry = at_rva(d->rvaIAT); *entry; entry++) {
                __delayLoadHelper2(d, entry);
            }
            return S_OK;
        }
    }
    return HRESULT_FROM_WIN32(ERROR_MOD_NOT_FOUND);
}

#endif
