// <dlfcn.h> on the Windows targets, over kernel32. POSIX reports a failed
// dlopen, dlsym or dlclose through dlerror -- text for the most recent
// failure, then NULL until the next one -- and dlclose returns 0 on success
// where FreeLibrary returns nonzero. A null path opens the global scope, the
// executable's handle; dlsym on it or on RTLD_DEFAULT searches every module
// of the process in load order, the executable first. A failure's code is kept when it
// happens, because any later Win32 call may overwrite GetLastError. The
// file compiles to nothing elsewhere; the native-link driver offers it like
// an archive member.

#ifdef _WIN32

#include <dlfcn.h>
#include <psapi.h>
#include <windows.h>

// The most recent failure dlerror has not yet reported, per thread, and the
// text it reports it with, in a TlsAlloc slot, which a program the JIT runs
// can use too. A thread's state is allocated on its first failure and lives
// as long as the process; without the memory, threads share a static one.
struct dl_state {
    DWORD failure;
    char text[256];
};

static volatile LONG dl_slot = (LONG)TLS_OUT_OF_INDEXES;
static struct dl_state dl_shared;

static struct dl_state *dl_state(BOOL create) {
    DWORD slot = (DWORD)dl_slot;
    struct dl_state *state;
    if (slot == TLS_OUT_OF_INDEXES) {
        DWORD fresh = TlsAlloc();
        LONG had = InterlockedCompareExchange(&dl_slot, (LONG)fresh, (LONG)slot);
        if (had != (LONG)slot) {
            TlsFree(fresh);
            fresh = (DWORD)had;
        }
        slot = fresh;
    }
    state = (struct dl_state *)TlsGetValue(slot);
    if (!state && create) {
        state = HeapAlloc(GetProcessHeap(), HEAP_ZERO_MEMORY, sizeof *state);
        state = state && TlsSetValue(slot, state) ? state : &dl_shared;
    }
    return state;
}

static void dl_fail(DWORD code) {
    dl_state(TRUE)->failure = code;
}

static void *dl_kept(void *result) {
    if (!result) {
        dl_fail(GetLastError());
    }
    return result;
}

void *dlopen(const char *path, int flags) {
    HMODULE self = NULL;
    (void)flags;
    if (path) {
        return dl_kept(LoadLibraryA(path));
    }
    // Counted, so dlclose's FreeLibrary balances it.
    if (!GetModuleHandleExW(0, NULL, &self)) {
        dl_fail(GetLastError());
    }
    return self;
}

static void *dl_global(const char *name) {
    HMODULE inline_list[64];
    HMODULE *modules = inline_list;
    HANDLE heap = GetProcessHeap();
    DWORD have = sizeof inline_list;
    DWORD need = 0;
    void *found = NULL;
    BOOL listed;
    // A module loaded between two calls grows the list; ask again.
    while ((listed = EnumProcessModules(GetCurrentProcess(), modules, have, &need)) &&
           need > have) {
        if (modules != inline_list) {
            HeapFree(heap, 0, modules);
        }
        have = need;
        modules = HeapAlloc(heap, 0, have);
        if (!modules) {
            dl_fail(ERROR_NOT_ENOUGH_MEMORY);
            return NULL;
        }
    }
    if (!listed) {
        dl_fail(GetLastError());
        need = 0;
    }
    for (DWORD i = 0; i < need / sizeof *modules && !found; i++) {
        found = (void *)GetProcAddress(modules[i], name);
    }
    if (!found && listed) {
        dl_fail(ERROR_PROC_NOT_FOUND);
    }
    if (modules != inline_list) {
        HeapFree(heap, 0, modules);
    }
    return found;
}

void *dlsym(void *restrict handle, const char *restrict name) {
    if (handle == RTLD_DEFAULT || handle == GetModuleHandleW(NULL)) {
        return dl_global(name);
    }
    return dl_kept((void *)GetProcAddress(handle, name));
}

int dlclose(void *handle) {
    if (FreeLibrary(handle)) {
        return 0;
    }
    dl_fail(GetLastError());
    return -1;
}

char *dlerror(void) {
    struct dl_state *state = dl_state(FALSE);
    char *dl_text;
    DWORD code, n;
    if (!state || !state->failure) {
        return NULL;
    }
    code = state->failure;
    state->failure = 0;
    dl_text = state->text;
    n = FormatMessageA(FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS, NULL, code, 0,
                       dl_text, sizeof state->text, NULL);
    // POSIX text ends without a newline; the system's ends with CR LF.
    while (n > 0 && (dl_text[n - 1] == '\r' || dl_text[n - 1] == '\n' || dl_text[n - 1] == ' ')) {
        n--;
    }
    if (n == 0) {
        // No system text for the code: name it in decimal.
        static const char prefix[] = "Win32 error ";
        char digits[10];
        int k = 0;
        do {
            digits[k++] = (char)('0' + code % 10);
            code /= 10;
        } while (code);
        for (; prefix[n]; n++) {
            dl_text[n] = prefix[n];
        }
        while (k > 0) {
            dl_text[n++] = digits[--k];
        }
    }
    dl_text[n] = 0;
    return dl_text;
}

#endif
