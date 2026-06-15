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

// POSIX threads / semaphores option macros (POSIX.1 2.1.3). The
// supported non-Windows targets bind a host libc that implements
// pthreads and POSIX semaphores, so advertise both; code commonly
// selects its threading backend on `_POSIX_THREADS`. Windows is not a
// POSIX host and leaves them undefined.
#ifndef __BADC_WINDOWS__
#define _POSIX_THREADS              200809L
#define _POSIX_SEMAPHORES           200809L
#define _POSIX_THREAD_ATTR_STACKSIZE 200809L
#endif

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
#pragma binding(libc::chroot,    "_chroot")
#pragma binding(libc::getuid,    "_getuid")
#pragma binding(libc::geteuid,   "_geteuid")
#pragma binding(libc::getgid,    "_getgid")
#pragma binding(libc::getegid,   "_getegid")
#pragma binding(libc::getppid,   "_getppid")
#pragma binding(libc::getpid,    "_getpid")
#pragma binding(libc::sleep,     "_sleep")
#pragma binding(libc::alarm,     "_alarm")
#pragma binding(libc::pause,     "_pause")
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
#pragma binding(libc::vfork,     "_vfork")
#pragma binding(libc::execvp,    "_execvp")
#pragma binding(libc::execve,    "_execve")
#pragma binding(libc::setgid,    "_setgid")
#pragma binding(libc::setuid,    "_setuid")
#pragma binding(libc::_exit,     "__exit")
#pragma binding(libc::fchmod,    "_fchmod")
#pragma binding(libc::fchown,    "_fchown")
#pragma binding(libc::utimes,    "_utimes")
#pragma binding(libc::futimes,   "_futimes")
#pragma binding(libc::lutimes,   "_lutimes")
#pragma binding(libc::umask,     "_umask")
#pragma binding(libc::chmod,     "_chmod")
#pragma binding(libc::chown,     "_chown")
#pragma binding(libc::truncate,  "_truncate")
#pragma binding(libc::link,      "_link")
#pragma binding(libc::symlink,   "_symlink")
#pragma binding(libc::fstatat,   "_fstatat")
#pragma binding(libc::mkdirat,   "_mkdirat")
#pragma binding(libc::mknodat,   "_mknodat")
#pragma binding(libc::mkfifoat,  "_mkfifoat")
#pragma binding(libc::fchmodat,  "_fchmodat")
#pragma binding(libc::fchownat,  "_fchownat")
#pragma binding(libc::unlinkat,  "_unlinkat")
#pragma binding(libc::linkat,    "_linkat")
#pragma binding(libc::symlinkat, "_symlinkat")
#pragma binding(libc::readlinkat,"_readlinkat")
#pragma binding(libc::faccessat, "_faccessat")
#pragma binding(libc::renameat,  "_renameat")
#pragma binding(libc::utimensat, "_utimensat")
#pragma binding(libc::futimens,  "_futimens")
#pragma binding(libc::ttyname,   "_ttyname")
#pragma binding(libc::ttyname_r, "_ttyname_r")
#pragma binding(libc::ctermid,   "_ctermid")
#pragma binding(libc::ctermid_r, "_ctermid_r")
#pragma binding(libc::getlogin,  "_getlogin")
#pragma binding(libc::getlogin_r,"_getlogin_r")
#pragma binding(libc::getgroups, "_getgroups")
#pragma binding(libc::setgroups, "_setgroups")
#pragma binding(libc::initgroups,"_initgroups")
#pragma binding(libc::getgrouplist,"_getgrouplist")
#pragma binding(libc::seteuid,   "_seteuid")
#pragma binding(libc::setegid,   "_setegid")
#pragma binding(libc::setreuid,  "_setreuid")
#pragma binding(libc::setregid,  "_setregid")
#pragma binding(libc::lchown,    "_lchown")
#pragma binding(libc::lchmod,    "_lchmod")
#pragma binding(libc::chflags,   "_chflags")
#pragma binding(libc::lchflags,  "_lchflags")
#pragma binding(libc::getpgid,   "_getpgid")
#pragma binding(libc::getpgrp,   "_getpgrp")
#pragma binding(libc::setpgid,   "_setpgid")
#pragma binding(libc::setpgrp,   "_setpgrp")
#pragma binding(libc::setsid,    "_setsid")
#pragma binding(libc::getsid,    "_getsid")
#pragma binding(libc::tcgetpgrp, "_tcgetpgrp")
#pragma binding(libc::tcsetpgrp, "_tcsetpgrp")
#pragma binding(libc::getpriority,"_getpriority")
#pragma binding(libc::setpriority,"_setpriority")
#pragma binding(libc::nice,      "_nice")
#pragma binding(libc::fpathconf, "_fpathconf")
#pragma binding(libc::lockf,     "_lockf")
#pragma binding(libc::execv,     "_execv")
#pragma binding(libc::fexecve,   "_fexecve")
#pragma binding(libc::pathconf,  "_pathconf")
#pragma binding(libc::sysconf,   "_sysconf")
#pragma binding(libc::getpagesize, "_getpagesize")
#pragma binding(libc::getentropy, "_getentropy")
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
// libSystem owns the live `environ` cell; setenv / unsetenv mutate it
// and may reallocate the array. Mach-O has no COPY relocation, so bind
// the data symbol through the GOT: a reference to `environ` loads
// `_environ`'s address from the dyld-filled slot, keeping every read in
// sync with libSystem's current array (the analog of the ELF COPY
// relocation glibc's `__environ` uses).
#pragma binding(data libc::environ, "_environ")
extern char **environ;
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::open,      "open")
#pragma binding(libc::read,      "read")
#pragma binding(libc::pread,     "pread")
#pragma binding(libc::pread64,   "pread64")
#pragma binding(libc::close,     "close")
#pragma binding(libc::write,     "write")
#pragma binding(libc::pwrite,    "pwrite")
#pragma binding(libc::pwrite64,  "pwrite64")
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
#pragma binding(libc::chroot,    "chroot")
#pragma binding(libc::getuid,    "getuid")
#pragma binding(libc::geteuid,   "geteuid")
#pragma binding(libc::getgid,    "getgid")
#pragma binding(libc::getegid,   "getegid")
#pragma binding(libc::getppid,   "getppid")
#pragma binding(libc::getpid,    "getpid")
#pragma binding(libc::sleep,     "sleep")
#pragma binding(libc::alarm,     "alarm")
#pragma binding(libc::pause,     "pause")
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
#pragma binding(libc::vfork,     "vfork")
#pragma binding(libc::execvp,    "execvp")
#pragma binding(libc::execve,    "execve")
#pragma binding(libc::setgid,    "setgid")
#pragma binding(libc::setuid,    "setuid")
#pragma binding(libc::_exit,     "_exit")
#pragma binding(libc::fchmod,    "fchmod")
#pragma binding(libc::fchown,    "fchown")
#pragma binding(libc::utimes,    "utimes")
#pragma binding(libc::futimes,   "futimes")
#pragma binding(libc::lutimes,   "lutimes")
#pragma binding(libc::umask,     "umask")
#pragma binding(libc::chmod,     "chmod")
#pragma binding(libc::chown,     "chown")
#pragma binding(libc::truncate,  "truncate")
#pragma binding(libc::link,      "link")
#pragma binding(libc::symlink,   "symlink")
#pragma binding(libc::fstatat,   "fstatat")
#pragma binding(libc::mkdirat,   "mkdirat")
#pragma binding(libc::mknodat,   "mknodat")
#pragma binding(libc::mkfifoat,  "mkfifoat")
#pragma binding(libc::fchmodat,  "fchmodat")
#pragma binding(libc::fchownat,  "fchownat")
#pragma binding(libc::unlinkat,  "unlinkat")
#pragma binding(libc::linkat,    "linkat")
#pragma binding(libc::symlinkat, "symlinkat")
#pragma binding(libc::readlinkat,"readlinkat")
#pragma binding(libc::faccessat, "faccessat")
#pragma binding(libc::renameat,  "renameat")
#pragma binding(libc::utimensat, "utimensat")
#pragma binding(libc::futimens,  "futimens")
#pragma binding(libc::ttyname,   "ttyname")
#pragma binding(libc::ttyname_r, "ttyname_r")
#pragma binding(libc::ctermid,   "ctermid")
#pragma binding(libc::ctermid_r, "ctermid_r")
#pragma binding(libc::getlogin,  "getlogin")
#pragma binding(libc::getlogin_r,"getlogin_r")
#pragma binding(libc::getgroups, "getgroups")
#pragma binding(libc::setgroups, "setgroups")
#pragma binding(libc::initgroups,"initgroups")
#pragma binding(libc::getgrouplist,"getgrouplist")
#pragma binding(libc::seteuid,   "seteuid")
#pragma binding(libc::setegid,   "setegid")
#pragma binding(libc::setreuid,  "setreuid")
#pragma binding(libc::setregid,  "setregid")
#pragma binding(libc::lchown,    "lchown")
#pragma binding(libc::lchmod,    "lchmod")
#pragma binding(libc::getpgid,   "getpgid")
#pragma binding(libc::getpgrp,   "getpgrp")
#pragma binding(libc::setpgid,   "setpgid")
#pragma binding(libc::setpgrp,   "setpgrp")
#pragma binding(libc::setsid,    "setsid")
#pragma binding(libc::getsid,    "getsid")
#pragma binding(libc::tcgetpgrp, "tcgetpgrp")
#pragma binding(libc::tcsetpgrp, "tcsetpgrp")
#pragma binding(libc::getpriority,"getpriority")
#pragma binding(libc::setpriority,"setpriority")
#pragma binding(libc::nice,      "nice")
#pragma binding(libc::fpathconf, "fpathconf")
#pragma binding(libc::lockf,     "lockf")
#pragma binding(libc::execv,     "execv")
#pragma binding(libc::fexecve,   "fexecve")
#pragma binding(libc::fdatasync, "fdatasync")
#pragma binding(libc::pathconf,  "pathconf")
#pragma binding(libc::sysconf,   "sysconf")
#pragma binding(libc::getpagesize, "getpagesize")
#pragma binding(libc::getentropy, "getentropy")
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
// POSIX `environ` is exposed by glibc as the data symbol `__environ`
// (with `environ` as its alias). The `extern` slot lives in
// `lib/runtime.c`; the data binding makes the linker emit a COPY
// relocation so that slot and glibc's `__environ` share one cell.
// Without it, glibc's getenv / setenv / tzset read a different cell
// than a direct `environ = ...` assignment writes.
#pragma binding(data libc::environ, "__environ")
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
// POSIX: pread/pwrite take an off_t offset and size_t count; an `int`
// offset truncates positions past 2GB. Matches the pread64/pwrite64
// signatures below.
long pread(int fd, char *buf, unsigned long n, long offset);
int close(int fd);
int write(int fd, char *buf, int n);
long pwrite(int fd, char *buf, unsigned long n, long offset);
#ifdef __linux__
// glibc large-file variants (`_LARGEFILE64_SOURCE`). The offset and
// result are 64-bit; programs configured with `USE_PREAD64` (e.g.
// sqlite) reach for these names directly.
long pread64(int fd, void *buf, unsigned long n, long offset);
long pwrite64(int fd, const void *buf, unsigned long n, long offset);
#endif
int access(char *path, int mode);
// Fill a buffer with random bytes (BSD / glibc 2.25+). `size_t` is in
// <stddef.h>, pulled in transitively.
int getentropy(void *buf, unsigned long buflen);
// POSIX: lseek returns off_t and takes an off_t offset; ftruncate takes an
// off_t length. off_t is 64-bit, so `int` truncates offsets/lengths past
// 2GB. `long` matches off_t on LP64 (the POSIX targets this block serves).
long lseek(int fd, long offset, int whence);
int fsync(int fd);
int ftruncate(int fd, long len);
int fcntl(int fd, int cmd, ...);
int stat(char *path, char *buf);
int lstat(char *path, char *buf);
int fstat(int fd, char *buf);
int unlink(char *path);
int rmdir(char *path);
char *getcwd(char *buf, int n);
int chdir(char *path);
int chroot(char *path);
int getuid();
int geteuid();
int getgid();
int getegid();
int getppid();
int getpid();
int sleep(int seconds);
// Schedule a SIGALRM after `seconds`; returns the prior alarm's
// remaining seconds (POSIX). Both counts are unsigned.
unsigned int alarm(unsigned int seconds);
int usleep(int microseconds);
// Suspend until a signal is delivered; always returns -1 with EINTR.
int pause(void);
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
int vfork();
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
int futimes(int fd, char *times);
int lutimes(char *path, char *times);
int umask(int mode);
int chmod(char *path, int mode);
int chown(char *path, int uid, int gid);
int truncate(char *path, int len);
int link(char *from, char *to);
int symlink(char *from, char *to);
// The *at family (POSIX): operate relative to a directory descriptor
// `dirfd` (or AT_FDCWD from <fcntl.h>). The stat / timespec buffers are
// opaque to c5, matching the plain stat() convention above.
int fstatat(int dirfd, char *path, char *buf, int flag);
int mkdirat(int dirfd, char *path, int mode);
int mknodat(int dirfd, char *path, int mode, int dev);
int mkfifoat(int dirfd, char *path, int mode);
int fchmodat(int dirfd, char *path, int mode, int flag);
int fchownat(int dirfd, char *path, int uid, int gid, int flag);
int unlinkat(int dirfd, char *path, int flag);
int linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, int flag);
int symlinkat(char *target, int newdirfd, char *linkpath);
int readlinkat(int dirfd, char *path, char *buf, int bufsiz);
int faccessat(int dirfd, char *path, int mode, int flag);
int renameat(int olddirfd, char *oldpath, int newdirfd, char *newpath);
int utimensat(int dirfd, char *path, char *times, int flag);
int futimens(int fd, char *times);
// Terminal and login identity (POSIX).
char *ttyname(int fd);
int ttyname_r(int fd, char *buf, unsigned long len);
char *ctermid(char *s);
char *ctermid_r(char *s);
char *getlogin(void);
int getlogin_r(char *buf, unsigned long len);
// Supplementary group lists (the gid lists are opaque to c5).
int getgroups(int size, int *list);
int setgroups(unsigned long size, int *list);
int initgroups(char *user, int group);
int getgrouplist(char *user, int group, int *groups, int *ngroups);
// Real/effective credential changes (POSIX).
int seteuid(int uid);
int setegid(int gid);
int setreuid(int ruid, int euid);
int setregid(int rgid, int egid);
int lchown(char *path, int owner, int group);
int lchmod(char *path, int mode);
#ifdef __APPLE__
// BSD per-file flags (macOS).
int chflags(char *path, unsigned long flags);
int lchflags(char *path, unsigned long flags);
#endif
// Process groups, sessions, and controlling-terminal foreground (POSIX).
int getpgid(int pid);
int getpgrp(void);
int setpgid(int pid, int pgid);
int setpgrp(void);
int setsid(void);
int getsid(int pid);
int tcgetpgrp(int fd);
int tcsetpgrp(int fd, int pgrp);
// Scheduling priority (POSIX getpriority/setpriority, BSD nice).
int getpriority(int which, int who);
int setpriority(int which, int who, int prio);
int nice(int inc);
// Per-descriptor limits, advisory locks, and exec without a PATH search.
long fpathconf(int fd, int name);
int lockf(int fd, int cmd, long len);
int execv(char *path, char **argv);
int fexecve(int fd, char **argv, char **envp);
#ifdef __linux__
// glibc-only: flush a file's data without its metadata.
int fdatasync(int fd);
#endif
// POSIX: pathconf / sysconf return long; some limits exceed 32 bits.
long pathconf(char *path, int name);
long sysconf(int name);
// Legacy BSD/POSIX page-size query; returns the system page size.
int getpagesize(void);
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
// sysconf(3) selectors. Names match POSIX; the numeric value is the
// one the bound libc reads -- different on Darwin and Linux -- so the
// selectors are target-specific. msvcrt has no `sysconf` entry, so the
// selector macros stay out of the Windows path; source that gates on
// `defined _SC_PAGESIZE` falls back to its non-sysconf branch there.
#ifdef __APPLE__
#define _SC_ARG_MAX       1
#define _SC_OPEN_MAX      5
#define _SC_PAGESIZE      29
#define _SC_NPROCESSORS_ONLN 58
#define _SC_GETPW_R_SIZE_MAX 71
#define _SC_GETGR_R_SIZE_MAX 70
#define _SC_TTY_NAME_MAX  101
#else
#define _SC_ARG_MAX       0
#define _SC_OPEN_MAX      4
#define _SC_PAGESIZE      30
#define _SC_NPROCESSORS_ONLN 84
#define _SC_GETPW_R_SIZE_MAX 70
#define _SC_GETGR_R_SIZE_MAX 69
#define _SC_TTY_NAME_MAX  72
#endif
#define _SC_PAGE_SIZE     _SC_PAGESIZE
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
