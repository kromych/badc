// basename and dirname on the Windows targets, as libmingwex defines them:
// POSIX's rules with `/` and `\` both separators and a drive designator kept
// with the directory ("C:name" is in "C:."). Elsewhere the file is empty; the
// link offers it like an archive member.

#ifdef _WIN32

#include <libgen.h>
#include <string.h>

static int is_sep(char c) { return c == '/' || c == '\\'; }

static size_t drive_of(const char *path) {
    char c = path[0];
    return ((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z')) && path[1] == ':' ? 2 : 0;
}

char *basename(char *path) {
    static char dot[2];
    size_t drive, end;
    char *base;
    dot[0] = '.';
    if (!path || (drive = drive_of(path), !path[drive]))
        return dot;
    end = strlen(path);
    while (end > drive + 1 && is_sep(path[end - 1]))
        end--;
    path[end] = '\0';
    if (end == drive + 1 && is_sep(path[drive]))
        return path + drive;
    for (base = path + end; base > path + drive && !is_sep(base[-1]); base--)
        ;
    return base;
}

char *dirname(char *path) {
    static char dot[4];
    size_t drive, end;
    if (!path || !*path)
        return strcpy(dot, ".");
    drive = drive_of(path);
    end = strlen(path);
    while (end > drive + 1 && is_sep(path[end - 1]))
        end--;
    while (end > drive && !is_sep(path[end - 1]))
        end--;
    if (end == drive) {
        memcpy(dot, path, drive);
        strcpy(dot + drive, ".");
        return dot;
    }
    while (end > drive + 1 && is_sep(path[end - 1]))
        end--;
    path[end] = '\0';
    return path;
}

#endif
