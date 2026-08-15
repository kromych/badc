// libproc.h -- Darwin process introspection. macOS only. Prototypes
// match the macOS SDK header of the same name; every entry below is
// exported by libSystem.
//
// The audit-token and rusage variants (proc_pidpath_audittoken,
// proc_pid_rusage, the signal/terminate delegates) take types from
// <bsm/audit.h> and <sys/resource.h> that badc does not bundle, and are
// left out. The per-flavour info structures live in <sys/proc_info.h>,
// which is likewise not bundled: proc_pidinfo callers supply their own
// buffer layout.

#pragma once

#include <stdint.h>
#include <sys/types.h>
#include <sys/param.h>

#ifdef __APPLE__
// proc_listpidspath() flags.
#define PROC_LISTPIDSPATH_PATH_IS_VOLUME  1
#define PROC_LISTPIDSPATH_EXCLUDE_EVTONLY 2

// Buffer sizes for proc_pidpath().
#define PROC_PIDPATHINFO_SIZE    (MAXPATHLEN)
#define PROC_PIDPATHINFO_MAXSIZE (4 * MAXPATHLEN)

// proc_setpcontrol() modes.
#define PROC_SETPC_NONE        0
#define PROC_SETPC_THROTTLEMEM 1
#define PROC_SETPC_SUSPEND     2
#define PROC_SETPC_TERMINATE   3

#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::proc_listpids,        "_proc_listpids")
#pragma binding(libc::proc_listallpids,     "_proc_listallpids")
#pragma binding(libc::proc_listpgrppids,    "_proc_listpgrppids")
#pragma binding(libc::proc_listchildpids,   "_proc_listchildpids")
#pragma binding(libc::proc_pidinfo,         "_proc_pidinfo")
#pragma binding(libc::proc_pidfdinfo,       "_proc_pidfdinfo")
#pragma binding(libc::proc_pidfileportinfo, "_proc_pidfileportinfo")
#pragma binding(libc::proc_name,            "_proc_name")
#pragma binding(libc::proc_regionfilename,  "_proc_regionfilename")
#pragma binding(libc::proc_kmsgbuf,         "_proc_kmsgbuf")
#pragma binding(libc::proc_pidpath,         "_proc_pidpath")
#pragma binding(libc::proc_libversion,      "_proc_libversion")
#pragma binding(libc::proc_setpcontrol,     "_proc_setpcontrol")
#pragma binding(libc::proc_track_dirty,     "_proc_track_dirty")
#pragma binding(libc::proc_set_dirty,       "_proc_set_dirty")
#pragma binding(libc::proc_get_dirty,       "_proc_get_dirty")
#pragma binding(libc::proc_clear_dirty,     "_proc_clear_dirty")
#pragma binding(libc::proc_terminate,       "_proc_terminate")

// Each list call returns the byte count written, so a null buffer sizes
// the request.
int proc_listpids(uint32_t type, uint32_t typeinfo, void *buffer, int buffersize);
int proc_listallpids(void *buffer, int buffersize);
int proc_listpgrppids(pid_t pgrpid, void *buffer, int buffersize);
int proc_listchildpids(pid_t ppid, void *buffer, int buffersize);

int proc_pidinfo(int pid, int flavor, uint64_t arg, void *buffer, int buffersize);
int proc_pidfdinfo(int pid, int fd, int flavor, void *buffer, int buffersize);
int proc_pidfileportinfo(int pid, uint32_t fileport, int flavor, void *buffer,
                         int buffersize);

int proc_name(int pid, void *buffer, uint32_t buffersize);
// The mapped file backing `address` in `pid`, if the region has one.
int proc_regionfilename(int pid, uint64_t address, void *buffer,
                        uint32_t buffersize);
int proc_kmsgbuf(void *buffer, uint32_t buffersize);
int proc_pidpath(int pid, void *buffer, uint32_t buffersize);
int proc_libversion(int *major, int *minor);

int proc_setpcontrol(const int control);
int proc_track_dirty(pid_t pid, uint32_t flags);
int proc_set_dirty(pid_t pid, _Bool dirty);
int proc_get_dirty(pid_t pid, uint32_t *flags);
int proc_clear_dirty(pid_t pid, uint32_t flags);
// Sends the signal reported through `sig`; SIGTERM unless the process
// opted into a different one.
int proc_terminate(pid_t pid, int *sig);
#endif
