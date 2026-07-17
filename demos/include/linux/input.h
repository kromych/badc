/* Linux evdev slice used by RGFW's minigamepad backend: the device id /
 * absinfo / event structs and the EVIOCG* query ioctls. The event codes come
 * from <linux/input-event-codes.h>; the ioctl encodings follow the kernel's
 * _IOC scheme. */
#ifndef _LINUX_INPUT_H
#define _LINUX_INPUT_H

#include <sys/time.h>
#include <linux/input-event-codes.h>

struct input_id {
    unsigned short bustype;
    unsigned short vendor;
    unsigned short product;
    unsigned short version;
};

struct input_absinfo {
    int value;
    int minimum;
    int maximum;
    int fuzz;
    int flat;
    int resolution;
};

struct input_event {
    struct timeval time;
    unsigned short type;
    unsigned short code;
    int value;
};

/* ioctl number encoding (asm-generic/ioctl.h). */
#define _IOC_NONE  0U
#define _IOC_WRITE 1U
#define _IOC_READ  2U
#define _IOC_DIRSHIFT  30
#define _IOC_SIZESHIFT 16
#define _IOC_TYPESHIFT 8
#define _IOC_NRSHIFT   0
#define _IOC(dir, type, nr, size) \
    (((dir) << _IOC_DIRSHIFT) | ((size) << _IOC_SIZESHIFT) | \
     ((type) << _IOC_TYPESHIFT) | ((nr) << _IOC_NRSHIFT))
#define _IOR(type, nr, size) _IOC(_IOC_READ, (type), (nr), sizeof(size))

#define EVIOCGID          _IOR('E', 0x02, struct input_id)
#define EVIOCGNAME(len)   _IOC(_IOC_READ, 'E', 0x06, len)
#define EVIOCGBIT(ev, len) _IOC(_IOC_READ, 'E', 0x20 + (ev), len)
#define EVIOCGABS(abs)    _IOR('E', 0x40 + (abs), struct input_absinfo)

#endif /* _LINUX_INPUT_H */
