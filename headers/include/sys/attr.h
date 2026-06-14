// sys/attr.h -- macOS getattrlist/setattrlist file attributes.
//
// The Darwin attribute-list syscalls and the subset of attribute
// group flags used to read and write a file's resource-fork length
// and Finder info. macOS only; libSystem supplies the syscalls.

#ifndef _C5_SYS_ATTR_H
#define _C5_SYS_ATTR_H

#ifdef __APPLE__

#include <sys/types.h>

typedef u_int32_t attrgroup_t;

struct attrlist {
    unsigned short bitmapcount;  /* number of attribute bit sets (5) */
    u_int16_t      reserved;     /* 4-byte alignment padding */
    attrgroup_t    commonattr;   /* common attribute group */
    attrgroup_t    volattr;      /* volume attribute group */
    attrgroup_t    dirattr;      /* directory attribute group */
    attrgroup_t    fileattr;     /* file attribute group */
    attrgroup_t    forkattr;     /* fork attribute group */
};

#define ATTR_BIT_MAP_COUNT      5
#define ATTR_CMN_FNDRINFO       0x00004000
#define ATTR_FILE_RSRCLENGTH    0x00001000

#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::getattrlist, "_getattrlist")
#pragma binding(libc::setattrlist, "_setattrlist")

int getattrlist(char *path, void *attrList, void *attrBuf,
                unsigned long attrBufSize, unsigned long options);
int setattrlist(char *path, void *attrList, void *attrBuf,
                unsigned long attrBufSize, unsigned long options);

#endif /* __APPLE__ */

#endif /* _C5_SYS_ATTR_H */
