// spawn.h -- POSIX process spawning (posix_spawn / posix_spawnp).

#pragma once

#if defined(__APPLE__) || defined(__linux__)
#include <signal.h>

// The attribute and file-action objects are opaque. macOS implements
// each as a single pointer (8 bytes) the init call fills; glibc stores
// the state inline (attr ~336 B, file actions ~80 B). An oversized
// buffer covers both: macOS uses only the leading pointer, glibc uses
// the whole region.
typedef struct { unsigned char __opaque[512]; } posix_spawnattr_t;
typedef struct { unsigned char __opaque[128]; } posix_spawn_file_actions_t;

// Attribute flags (the value reaches the host libc, so each target uses
// its own numbering).
#define POSIX_SPAWN_RESETIDS   0x01
#define POSIX_SPAWN_SETPGROUP  0x02
#define POSIX_SPAWN_SETSIGDEF  0x04
#define POSIX_SPAWN_SETSIGMASK 0x08
#ifdef __APPLE__
#define POSIX_SPAWN_SETSID     0x0400
#else
#define POSIX_SPAWN_SETSCHEDPARAM 0x10
#define POSIX_SPAWN_SETSCHEDULER  0x20
#define POSIX_SPAWN_SETSID        0x80
#endif

#ifdef __APPLE__
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::posix_spawn,  "_posix_spawn")
#pragma binding(libc::posix_spawnp, "_posix_spawnp")
#pragma binding(libc::posix_spawnattr_init,    "_posix_spawnattr_init")
#pragma binding(libc::posix_spawnattr_destroy, "_posix_spawnattr_destroy")
#pragma binding(libc::posix_spawnattr_setflags,"_posix_spawnattr_setflags")
#pragma binding(libc::posix_spawnattr_setpgroup,"_posix_spawnattr_setpgroup")
#pragma binding(libc::posix_spawnattr_setsigmask,"_posix_spawnattr_setsigmask")
#pragma binding(libc::posix_spawnattr_setsigdefault,"_posix_spawnattr_setsigdefault")
#pragma binding(libc::posix_spawn_file_actions_init,    "_posix_spawn_file_actions_init")
#pragma binding(libc::posix_spawn_file_actions_destroy, "_posix_spawn_file_actions_destroy")
#pragma binding(libc::posix_spawn_file_actions_addopen, "_posix_spawn_file_actions_addopen")
#pragma binding(libc::posix_spawn_file_actions_addclose,"_posix_spawn_file_actions_addclose")
#pragma binding(libc::posix_spawn_file_actions_adddup2, "_posix_spawn_file_actions_adddup2")
#endif

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::posix_spawn,  "posix_spawn")
#pragma binding(libc::posix_spawnp, "posix_spawnp")
#pragma binding(libc::posix_spawnattr_init,    "posix_spawnattr_init")
#pragma binding(libc::posix_spawnattr_destroy, "posix_spawnattr_destroy")
#pragma binding(libc::posix_spawnattr_setflags,"posix_spawnattr_setflags")
#pragma binding(libc::posix_spawnattr_setpgroup,"posix_spawnattr_setpgroup")
#pragma binding(libc::posix_spawnattr_setsigmask,"posix_spawnattr_setsigmask")
#pragma binding(libc::posix_spawnattr_setsigdefault,"posix_spawnattr_setsigdefault")
#pragma binding(libc::posix_spawnattr_setschedparam,"posix_spawnattr_setschedparam")
#pragma binding(libc::posix_spawnattr_setschedpolicy,"posix_spawnattr_setschedpolicy")
#pragma binding(libc::posix_spawn_file_actions_init,    "posix_spawn_file_actions_init")
#pragma binding(libc::posix_spawn_file_actions_destroy, "posix_spawn_file_actions_destroy")
#pragma binding(libc::posix_spawn_file_actions_addopen, "posix_spawn_file_actions_addopen")
#pragma binding(libc::posix_spawn_file_actions_addclose,"posix_spawn_file_actions_addclose")
#pragma binding(libc::posix_spawn_file_actions_adddup2, "posix_spawn_file_actions_adddup2")
#endif

int posix_spawn(int *pid, char *path, const posix_spawn_file_actions_t *fa,
                const posix_spawnattr_t *attr, char **argv, char **envp);
int posix_spawnp(int *pid, char *file, const posix_spawn_file_actions_t *fa,
                 const posix_spawnattr_t *attr, char **argv, char **envp);

int posix_spawnattr_init(posix_spawnattr_t *attr);
int posix_spawnattr_destroy(posix_spawnattr_t *attr);
int posix_spawnattr_setflags(posix_spawnattr_t *attr, short flags);
int posix_spawnattr_setpgroup(posix_spawnattr_t *attr, int pgroup);
int posix_spawnattr_setsigmask(posix_spawnattr_t *attr, const sigset_t *mask);
int posix_spawnattr_setsigdefault(posix_spawnattr_t *attr, const sigset_t *def);
#ifdef __linux__
// `struct sched_param` is opaque to c5; pass its address.
int posix_spawnattr_setschedparam(posix_spawnattr_t *attr, char *param);
int posix_spawnattr_setschedpolicy(posix_spawnattr_t *attr, int policy);
#endif

int posix_spawn_file_actions_init(posix_spawn_file_actions_t *fa);
int posix_spawn_file_actions_destroy(posix_spawn_file_actions_t *fa);
int posix_spawn_file_actions_addopen(posix_spawn_file_actions_t *fa, int fd,
                                     char *path, int oflag, int mode);
int posix_spawn_file_actions_addclose(posix_spawn_file_actions_t *fa, int fd);
int posix_spawn_file_actions_adddup2(posix_spawn_file_actions_t *fa, int fd,
                                     int newfd);
#endif
