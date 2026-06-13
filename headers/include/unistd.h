// unistd.h -- POSIX file descriptor I/O.
//
// On Windows, msvcrt exports the underscored forms (`_open`, `_read`,
// `_close`, `_write`) since the unprefixed versions belong to MSVC's
// "deprecated" Posix-compat layer that isn't always available. The
// portable c5-side names stay the same; only the bound symbol differs.

#pragma once

/* Pull in the canonical `struct timeval` definition so the
** `struct rusage` declaration below references the same type
** that `<time.h>` and the bound libc functions agree on. */
#include <time.h>
/* POSIX-2017 mandates that `<unistd.h>` make `ssize_t`,
** `size_t`, `off_t`, `pid_t`, `uid_t`, `gid_t` visible; the
** width-sensitive ones live in `<sys/types.h>` already. */
#include <sys/types.h>

#define STDIN_FILENO  0
#define STDOUT_FILENO 1
#define STDERR_FILENO 2

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::open,      "_open")
#pragma binding(libc::read,      "_read")
#pragma binding(libc::pread,     "_pread")
#pragma binding(libc::close,     "_close")
#pragma binding(libc::write,     "_write")
#pragma binding(libc::pwrite,    "_pwrite")
#pragma binding(libc::access,    "_access")
#pragma binding(libc::lseek,     "_lseek")
#pragma binding(libc::fsync,     "_fsync")
#pragma binding(libc::ftruncate, "_ftruncate")
#pragma binding(libc::fcntl,     "_fcntl")
#pragma binding(libc::stat,      "_stat")
#pragma binding(libc::lstat,     "_lstat")
#pragma binding(libc::fstat,     "_fstat")
#pragma binding(libc::unlink,    "_unlink")
#pragma binding(libc::rmdir,     "_rmdir")
#pragma binding(libc::getcwd,    "_getcwd")
#pragma binding(libc::chdir,     "_chdir")
#pragma binding(libc::getuid,    "_getuid")
#pragma binding(libc::geteuid,   "_geteuid")
#pragma binding(libc::getpid,    "_getpid")
#pragma binding(libc::sleep,     "_sleep")
#pragma binding(libc::usleep,    "_usleep")
#pragma binding(libc::isatty,    "_isatty")
#pragma binding(libc::readlink,  "_readlink")
#pragma binding(libc::mkdir,     "_mkdir")
#pragma binding(libc::mknod,     "_mknod")
#pragma binding(libc::mkfifo,    "_mkfifo")
#pragma binding(libc::dup,       "_dup")
#pragma binding(libc::dup2,      "_dup2")
#pragma binding(libc::pipe,      "_pipe")
#pragma binding(libc::fork,      "_fork")
#pragma binding(libc::execvp,    "_execvp")
#pragma binding(libc::execve,    "_execve")
#pragma binding(libc::setgid,    "_setgid")
#pragma binding(libc::setuid,    "_setuid")
#pragma binding(libc::_exit,     "__exit")
#pragma binding(libc::fchmod,    "_fchmod")
#pragma binding(libc::fchown,    "_fchown")
#pragma binding(libc::utimes,    "_utimes")
#pragma binding(libc::umask,     "_umask")
#pragma binding(libc::chmod,     "_chmod")
#pragma binding(libc::chown,     "_chown")
#pragma binding(libc::truncate,  "_truncate")
#pragma binding(libc::link,      "_link")
#pragma binding(libc::symlink,   "_symlink")
#pragma binding(libc::pathconf,  "_pathconf")
#pragma binding(libc::sysconf,   "_sysconf")
#pragma binding(libc::getrusage, "_getrusage")
#pragma binding(libc::flock,     "_flock")
#pragma binding(libc::nanosleep, "_nanosleep")
#pragma binding(libc::getenv,    "_getenv")
#pragma binding(libc::setenv,    "_setenv")
#pragma binding(libc::unsetenv,  "_unsetenv")
#pragma binding(libc::realpath,  "_realpath")
#pragma binding(libc::fchdir,    "_fchdir")
#pragma binding(libc::getopt,    "_getopt")
#pragma binding(libc::sync,      "_sync")
#pragma binding(libc::confstr,   "_confstr")
// macOS does not expose the SysV-style `environ` global through
// libSystem; the supported accessor is `_NSGetEnviron`, which
// returns a `char ***` pointing at the per-process environ
// slot. Programs that walk the environment portably reach for
// it inside a Mach-O #ifdef branch.
#pragma binding(libc::_NSGetEnviron, "__NSGetEnviron")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::open,      "open")
#pragma binding(libc::read,      "read")
#pragma binding(libc::pread,     "pread")
#pragma binding(libc::close,     "close")
#pragma binding(libc::write,     "write")
#pragma binding(libc::pwrite,    "pwrite")
#pragma binding(libc::access,    "access")
#pragma binding(libc::lseek,     "lseek")
#pragma binding(libc::fsync,     "fsync")
#pragma binding(libc::ftruncate, "ftruncate")
#pragma binding(libc::fcntl,     "fcntl")
#pragma binding(libc::stat,      "stat")
#pragma binding(libc::lstat,     "lstat")
#pragma binding(libc::fstat,     "fstat")
#pragma binding(libc::unlink,    "unlink")
#pragma binding(libc::rmdir,     "rmdir")
#pragma binding(libc::getcwd,    "getcwd")
#pragma binding(libc::chdir,     "chdir")
#pragma binding(libc::getuid,    "getuid")
#pragma binding(libc::geteuid,   "geteuid")
#pragma binding(libc::getpid,    "getpid")
#pragma binding(libc::sleep,     "sleep")
#pragma binding(libc::usleep,    "usleep")
#pragma binding(libc::isatty,    "isatty")
#pragma binding(libc::readlink,  "readlink")
#pragma binding(libc::mkdir,     "mkdir")
#pragma binding(libc::mknod,     "mknod")
#pragma binding(libc::mkfifo,    "mkfifo")
#pragma binding(libc::dup,       "dup")
#pragma binding(libc::dup2,      "dup2")
#pragma binding(libc::pipe,      "pipe")
#pragma binding(libc::fork,      "fork")
#pragma binding(libc::execvp,    "execvp")
#pragma binding(libc::execve,    "execve")
#pragma binding(libc::setgid,    "setgid")
#pragma binding(libc::setuid,    "setuid")
#pragma binding(libc::_exit,     "_exit")
#pragma binding(libc::fchmod,    "fchmod")
#pragma binding(libc::fchown,    "fchown")
#pragma binding(libc::utimes,    "utimes")
#pragma binding(libc::umask,     "umask")
#pragma binding(libc::chmod,     "chmod")
#pragma binding(libc::chown,     "chown")
#pragma binding(libc::truncate,  "truncate")
#pragma binding(libc::link,      "link")
#pragma binding(libc::symlink,   "symlink")
#pragma binding(libc::pathconf,  "pathconf")
#pragma binding(libc::sysconf,   "sysconf")
#pragma binding(libc::getrusage, "getrusage")
#pragma binding(libc::flock,     "flock")
#pragma binding(libc::nanosleep, "nanosleep")
#pragma binding(libc::getenv,    "getenv")
#pragma binding(libc::setenv,    "setenv")
#pragma binding(libc::unsetenv,  "unsetenv")
#pragma binding(libc::realpath,  "realpath")
#pragma binding(libc::fchdir,    "fchdir")
#pragma binding(libc::getopt,    "getopt")
#pragma binding(libc::sync,      "sync")
#pragma binding(libc::confstr,   "confstr")
// POSIX `environ` is exposed by glibc as a data symbol pointing
// at the per-process environment vector. The single definition
// lives in `lib/runtime.c` and ships with every native ELF
// image; here we declare the extern so user code can read or
// write it. Programs that need the real glibc environ value
// -- e.g., to pass it through to a child process -- populate
// it themselves from the `envp` argument of `main`.
// TODO: replace this slot with a real data import once
// `#pragma binding`'s data form lands so glibc's own `environ`
// is bound directly.
extern char **environ;
#endif

#ifdef _WIN32
#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(msvcrt::open,  "_open")
#pragma binding(msvcrt::read,  "_read")
#pragma binding(msvcrt::close, "_close")
#pragma binding(msvcrt::write, "_write")
#pragma binding(msvcrt::access,"_access")
#pragma binding(msvcrt::lseek, "_lseek")
#pragma binding(msvcrt::isatty,"_isatty")
#pragma binding(msvcrt::dup,   "_dup")
#pragma binding(msvcrt::dup2,  "_dup2")
#pragma binding(msvcrt::getcwd, "_getcwd")
#pragma binding(msvcrt::unlink, "_unlink")
#endif

int open(char *path, int flags, ...);
int read(int fd, char *buf, int n);
int pread(int fd, char *buf, int n, int offset);
int close(int fd);
int write(int fd, char *buf, int n);
int pwrite(int fd, char *buf, int n, int offset);
int access(char *path, int mode);
int lseek(int fd, int offset, int whence);
int fsync(int fd);
int ftruncate(int fd, int len);
int fcntl(int fd, int cmd, ...);
int stat(char *path, char *buf);
int lstat(char *path, char *buf);
int fstat(int fd, char *buf);
int unlink(char *path);
int rmdir(char *path);
char *getcwd(char *buf, int n);
int chdir(char *path);
int getuid();
int geteuid();
int getpid();
int sleep(int seconds);
int usleep(int microseconds);
int isatty(int fd);
int readlink(char *path, char *buf, int n);
int mkdir(char *path, int mode);
// POSIX: create a filesystem node. The device argument is unused for
// regular / FIFO nodes; callers pass 0.
int mknod(char *path, int mode, int dev);
int mkfifo(char *path, int mode);
int dup(int fd);
int dup2(int oldfd, int newfd);
int pipe(int *fds);
int fork();
int execvp(char *file, char **argv);
int execve(char *path, char **argv, char **envp);
int setgid(int gid);
int setuid(int uid);
// `_exit` skips the libc atexit / fflush chain. Programs use it
// after a failed exec in the child branch of fork+exec to avoid
// running the parent's exit handlers a second time.
_Noreturn int _exit(int status);
int fchmod(int fd, int mode);
int fchown(int fd, int uid, int gid);
int utimes(char *path, char *times);
int umask(int mode);
int chmod(char *path, int mode);
int chown(char *path, int uid, int gid);
int truncate(char *path, int len);
int link(char *from, char *to);
int symlink(char *from, char *to);
int pathconf(char *path, int name);
int sysconf(int name);
int getrusage(int who, char *usage);
int flock(int fd, int operation);
int nanosleep(char *req, char *rem);
char *getenv(char *name);
#ifdef __APPLE__
// libSystem accessor for the per-process environ slot. Returns a
// `char ***` whose deref yields the SysV-style `char **environ`.
char ***_NSGetEnviron(void);
#endif
int setenv(char *name, char *value, int overwrite);
int unsetenv(char *name);
char *realpath(char *path, char *resolved);
int fchdir(int fd);
int getopt(int argc, char **argv, char *opts);
int sync();
int confstr(int name, char *buf, int len);

#define LOCK_SH 1
#define LOCK_EX 2
#define LOCK_UN 8
#define LOCK_NB 4

// getrusage(2) selectors and the per-process resource shape.
#define RUSAGE_SELF      0
#define RUSAGE_CHILDREN -1
#define RUSAGE_THREAD    1

/* `struct timeval` is also defined in <time.h>; the two
** definitions must stay in sync. The `struct rusage` shape
** below references it by tag name so getrusage()'s `ru_utime`
** / `ru_stime` typecheck as `struct timeval *` callers expect.
** Earlier this header carried a private `struct __c5_timeval`
** alias that broke that type-check. */
struct rusage {
    struct timeval ru_utime;
    struct timeval ru_stime;
    int ru_maxrss;
    int ru_ixrss;
    int ru_idrss;
    int ru_isrss;
    int ru_minflt;
    int ru_majflt;
    int ru_nswap;
    int ru_inblock;
    int ru_oublock;
    int ru_msgsnd;
    int ru_msgrcv;
    int ru_nsignals;
    int ru_nvcsw;
    int ru_nivcsw;
    char __pad[64];
};

#ifndef _WIN32
// sysconf(3) selectors. Names match POSIX; the underlying value
// is platform-specific but the bound libc reads it directly.
// msvcrt has no `sysconf` entry, so the selector macros stay out
// of the Windows path -- source that gates on `defined
// _SC_PAGESIZE` falls back to its non-sysconf branch there.
#define _SC_PAGESIZE      29
#define _SC_PAGE_SIZE     _SC_PAGESIZE
#define _SC_NPROCESSORS_ONLN 84
#define _SC_OPEN_MAX      4
#define _SC_ARG_MAX       0
#define _SC_NPROC_ONLN    _SC_NPROCESSORS_ONLN
#endif

// Standard fd numbers. Already defined above; redeclared here
// for grep-ability.
#ifndef SEEK_SET
#define SEEK_SET 0
#define SEEK_CUR 1
#define SEEK_END 2
#endif

#define F_OK 0
#define R_OK 4
#define W_OK 2
#define X_OK 1
