// <dirent.h>'s directory stream on the Windows targets, which mingw-w64
// declares and msvcrt does not define, over kernel32's file search. The
// file compiles to nothing elsewhere, and under msvc_compat.h's `_MSC_VER`,
// where the header declares nothing; the native-link driver offers it like
// an archive member.

#if defined(_WIN32) && !defined(_MSC_VER)

#include <dirent.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <windows.h>

struct __c5_DIR {
    HANDLE find;           // the search, INVALID_HANDLE_VALUE when none is open
    WIN32_FIND_DATAA data; // the entry the search found last
    int pending;           // `data` holds an entry readdir has yet to return
    long pos;              // the index of the next entry readdir returns
    struct dirent entry;   // what readdir returns
    char pattern[];        // the directory's name followed by `\*`
};

// Begin the search over `d->pattern`, recording the first entry.
static int dir_start(DIR *d) {
    d->find = FindFirstFileA(d->pattern, &d->data);
    d->pending = d->find != INVALID_HANDLE_VALUE;
    d->pos = 0;
    return d->pending;
}

DIR *opendir(const char *name) {
    size_t n;
    DWORD attrs;
    DIR *d;
    if (!name || !*name) {
        errno = ENOENT;
        return NULL;
    }
    attrs = GetFileAttributesA(name);
    if (attrs == INVALID_FILE_ATTRIBUTES) {
        errno = ENOENT;
        return NULL;
    }
    if (!(attrs & FILE_ATTRIBUTE_DIRECTORY)) {
        errno = ENOTDIR;
        return NULL;
    }
    n = strlen(name);
    d = malloc(sizeof *d + n + 3);
    if (!d) {
        errno = ENOMEM;
        return NULL;
    }
    memcpy(d->pattern, name, n);
    if (name[n - 1] != '\\' && name[n - 1] != '/' && name[n - 1] != ':') {
        d->pattern[n++] = '\\';
    }
    d->pattern[n++] = '*';
    d->pattern[n] = 0;
    if (!dir_start(d) && GetLastError() != ERROR_FILE_NOT_FOUND) {
        free(d);
        errno = EACCES;
        return NULL;
    }
    return d;
}

struct dirent *readdir(DIR *d) {
    size_t n;
    if (!d->pending) {
        if (d->find == INVALID_HANDLE_VALUE || !FindNextFileA(d->find, &d->data)) {
            return NULL;
        }
    }
    d->pending = 0;
    n = strlen(d->data.cFileName);
    if (n >= sizeof d->entry.d_name) {
        n = sizeof d->entry.d_name - 1;
    }
    d->entry.d_ino = 0;
    d->entry.d_reclen = 0;
    d->entry.d_namlen = (unsigned short)n;
    memcpy(d->entry.d_name, d->data.cFileName, n);
    d->entry.d_name[n] = 0;
    d->pos++;
    return &d->entry;
}

int closedir(DIR *d) {
    if (!d) {
        errno = EBADF;
        return -1;
    }
    if (d->find != INVALID_HANDLE_VALUE) {
        FindClose(d->find);
    }
    free(d);
    return 0;
}

void rewinddir(DIR *d) {
    if (d->find != INVALID_HANDLE_VALUE) {
        FindClose(d->find);
    }
    dir_start(d);
}

long telldir(DIR *d) { return d->pos; }

// The search only moves forward, so a seek restarts it and reads up to `loc`.
void seekdir(DIR *d, long loc) {
    rewinddir(d);
    while (d->pos < loc && readdir(d)) {
    }
}

#endif
