/* Demo-local <dirent.h>. The compiler's bundled <dirent.h> is POSIX-only and
 * empty on _WIN32, but raylib's rcore.c uses opendir/readdir/closedir on every
 * platform. On _WIN32 this shim maps the POSIX directory API onto the Win32
 * FindFirstFile family; elsewhere it forwards to the bundled header. Only the
 * subset rcore.c reads (d_name) is provided. */
#ifndef RGFW_DEMO_DIRENT_H
#define RGFW_DEMO_DIRENT_H

#ifdef _WIN32

#include <windows.h>
#include <stdlib.h>
#include <string.h>

struct dirent {
    char d_name[260];
};

typedef struct __win_DIR {
    HANDLE          handle;
    WIN32_FIND_DATAA find;
    int             first;
    struct dirent   entry;
} DIR;

static DIR *opendir(const char *name) {
    char pattern[260 + 4];
    size_t n = strlen(name);
    if (n > 260) return (DIR *)0;
    strcpy(pattern, name);
    if (n > 0 && pattern[n - 1] != '\\' && pattern[n - 1] != '/') pattern[n++] = '\\';
    pattern[n++] = '*';
    pattern[n] = '\0';

    DIR *d = (DIR *)malloc(sizeof(DIR));
    if (d == (DIR *)0) return (DIR *)0;
    d->handle = FindFirstFileA(pattern, &d->find);
    if (d->handle == INVALID_HANDLE_VALUE) {
        free(d);
        return (DIR *)0;
    }
    d->first = 1;
    return d;
}

static struct dirent *readdir(DIR *d) {
    if (d == (DIR *)0) return (struct dirent *)0;
    if (d->first) {
        d->first = 0;
    } else if (!FindNextFileA(d->handle, &d->find)) {
        return (struct dirent *)0;
    }
    strncpy(d->entry.d_name, d->find.cFileName, sizeof(d->entry.d_name) - 1);
    d->entry.d_name[sizeof(d->entry.d_name) - 1] = '\0';
    return &d->entry;
}

static int closedir(DIR *d) {
    if (d != (DIR *)0) {
        if (d->handle != INVALID_HANDLE_VALUE) FindClose(d->handle);
        free(d);
    }
    return 0;
}

#else
#include_next <dirent.h>
#endif /* _WIN32 */

#endif /* RGFW_DEMO_DIRENT_H */
