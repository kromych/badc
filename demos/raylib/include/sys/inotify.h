/* inotify slice used by RGFW's minigamepad backend to watch /dev/input for
 * gamepad hotplug. Linux-only; the calls bind to libc.so.6. */
#ifndef _SYS_INOTIFY_H
#define _SYS_INOTIFY_H

struct inotify_event {
    int wd;
    unsigned int mask;
    unsigned int cookie;
    unsigned int len;
    char name[];
};

/* Watch-event bits (inotify.h). */
#define IN_ATTRIB 0x00000004
#define IN_CREATE 0x00000100
#define IN_DELETE 0x00000200
/* inotify_init1 flags mirror O_NONBLOCK / O_CLOEXEC. */
#define IN_NONBLOCK 0x00000800
#define IN_CLOEXEC  0x00080000

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::inotify_init1,    "inotify_init1")
#pragma binding(libc::inotify_add_watch, "inotify_add_watch")
#pragma binding(libc::inotify_rm_watch,  "inotify_rm_watch")
#endif

int inotify_init1(int flags);
int inotify_add_watch(int fd, const char *pathname, unsigned int mask);
int inotify_rm_watch(int fd, int wd);

#endif /* _SYS_INOTIFY_H */
