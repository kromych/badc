// <dlfcn.h> on the Windows targets, over kernel32. POSIX reports a failed
// dlopen, dlsym or dlclose through dlerror -- text for the most recent
// failure, then NULL until the next one -- and dlclose returns 0 on success
// where FreeLibrary returns nonzero. A failure's code is kept when it
// happens, because any later Win32 call may overwrite GetLastError. The
// file compiles to nothing elsewhere; the native-link driver offers it like
// an archive member.

#ifdef _WIN32

#include <dlfcn.h>
#include <windows.h>

// The most recent failure dlerror has not yet reported, per thread, and the
// text it reports it with.
static _Thread_local DWORD dl_failure;
static _Thread_local char dl_text[256];

static void *dl_kept(void *result) {
    if (!result) {
        dl_failure = GetLastError();
    }
    return result;
}

void *dlopen(const char *path, int flags) {
    (void)flags;
    return dl_kept(LoadLibraryA(path));
}

void *dlsym(void *restrict handle, const char *restrict name) {
    return dl_kept((void *)GetProcAddress(handle, name));
}

int dlclose(void *handle) {
    if (FreeLibrary(handle)) {
        return 0;
    }
    dl_failure = GetLastError();
    return -1;
}

char *dlerror(void) {
    DWORD code = dl_failure;
    DWORD n;
    if (!code) {
        return NULL;
    }
    dl_failure = 0;
    n = FormatMessageA(FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS, NULL, code, 0,
                       dl_text, sizeof dl_text, NULL);
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
