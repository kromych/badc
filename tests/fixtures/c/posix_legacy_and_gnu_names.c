// The names outside C99 that portable POSIX source still reaches for:
// the obsolescent <strings.h> and <sys/stat.h> spellings, the wide
// column widths, glibc's execvp-with-environment, and the shadow
// password database. Each is called or compared here, so a missing
// declaration is a compile error and a wrong binding a run failure.

#ifdef _WIN32
int main(void) { return 0; }
#else
#include <pwd.h>
#include <string.h>
#include <strings.h>
#include <sys/stat.h>
#include <unistd.h>
#include <wchar.h>
#ifdef __linux__
#include <shadow.h>
#endif

int main(void) {
    // <strings.h>: the pre-POSIX names for strchr / strrchr.
    char *s = "abracadabra";
    if (index(s, 'b') != strchr(s, 'b')) return 1;
    if (rindex(s, 'b') != strrchr(s, 'b')) return 2;
    if (index(s, 'z') != 0) return 3;

    // <sys/stat.h>: the pre-POSIX owner bits.
    if (S_IREAD != S_IRUSR) return 4;
    if (S_IWRITE != S_IWUSR) return 5;
    if (S_IEXEC != S_IXUSR) return 6;

    // <wchar.h>: POSIX column widths.
    if (wcwidth((wchar_t)'A') != 1) return 7;
    if (wcswidth(L"abc", 3) != 3) return 8;

    // <unistd.h>: the descriptor-table size is the RLIMIT_NOFILE soft
    // limit, which is at least the three standard descriptors.
    if (getdtablesize() < 3) return 9;

    // The target header's own include guard, which programs read to
    // pick between the platform's user-database interfaces.
#ifdef __linux__
#ifndef _PWD_H
    return 10;
#endif
#endif
#ifdef __APPLE__
#ifndef _PWD_H_
    return 11;
#endif
#endif

#ifdef __linux__
    // <unistd.h>: execvp with an explicit environment. A name no PATH
    // entry carries fails, so the call returns instead of replacing
    // this process.
    char *argv[2];
    char *envp[1];
    argv[0] = "badc-no-such-program";
    argv[1] = 0;
    envp[0] = 0;
    if (execvpe("badc-no-such-program", argv, envp) != -1) return 12;

    // <shadow.h>: a login name no database can carry.
    if (getspnam("badc-no-such-user") != 0) return 13;
#endif
    return 0;
}
#endif
