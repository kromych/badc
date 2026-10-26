// sys/attr.h -- macOS getattrlist/setattrlist file attributes.
//
// The attribute-list system calls, the request and reply structures and
// the attribute group bits of the macOS SDK's header, with its values.
// macOS only; libSystem supplies the calls.

#pragma once

#ifdef __APPLE__

#include <stddef.h>
#include <stdint.h>
#include <sys/types.h>

// Options for the calls' last argument.
#define FSOPT_NOFOLLOW          0x00000001
#define FSOPT_NOINMEMUPDATE     0x00000002
#define FSOPT_REPORT_FULLSIZE   0x00000004
#define FSOPT_PACK_INVAL_ATTRS  0x00000008
#define FSOPT_ATTR_CMN_EXTENDED 0x00000020
#define FSOPT_RETURN_REALDEV    0x00000200
#define FSOPT_NOFOLLOW_ANY      0x00000800
#define FSOPT_RESOLVE_BENEATH   0x00001000
#define FSOPT_UNIQUE            0x00002000

typedef u_int32_t text_encoding_t;
typedef u_int32_t fsobj_type_t;
typedef u_int32_t fsobj_tag_t;
typedef u_int32_t fsfile_type_t;
typedef u_int32_t fsvolid_t;
typedef struct fsobj_id {
    u_int32_t fid_objno;
    u_int32_t fid_generation;
} fsobj_id_t;
typedef u_int32_t attrgroup_t;

struct attrlist {
    u_short bitmapcount; /* ATTR_BIT_MAP_COUNT */
    u_int16_t reserved;
    attrgroup_t commonattr;
    attrgroup_t volattr;
    attrgroup_t dirattr;
    attrgroup_t fileattr;
    attrgroup_t forkattr;
};

#define ATTR_BIT_MAP_COUNT 5

typedef struct attribute_set {
    attrgroup_t commonattr;
    attrgroup_t volattr;
    attrgroup_t dirattr;
    attrgroup_t fileattr;
    attrgroup_t forkattr;
} attribute_set_t;

#define ATTRIBUTE_SET_INIT(a) \
    do { (a)->commonattr = (a)->volattr = (a)->dirattr = (a)->fileattr = (a)->forkattr = 0; } while (0)

// A variable-length attribute: its bytes start attr_dataoffset bytes past
// this structure.
typedef struct attrreference {
    int32_t attr_dataoffset;
    u_int32_t attr_length;
} attrreference_t;

#define ATTR_CMN_NAME                0x00000001
#define ATTR_CMN_DEVID               0x00000002
#define ATTR_CMN_FSID                0x00000004
#define ATTR_CMN_OBJTYPE             0x00000008
#define ATTR_CMN_OBJTAG              0x00000010
#define ATTR_CMN_OBJID               0x00000020
#define ATTR_CMN_OBJPERMANENTID      0x00000040
#define ATTR_CMN_PAROBJID            0x00000080
#define ATTR_CMN_SCRIPT              0x00000100
#define ATTR_CMN_CRTIME              0x00000200
#define ATTR_CMN_MODTIME             0x00000400
#define ATTR_CMN_CHGTIME             0x00000800
#define ATTR_CMN_ACCTIME             0x00001000
#define ATTR_CMN_BKUPTIME            0x00002000
#define ATTR_CMN_FNDRINFO            0x00004000
#define ATTR_CMN_OWNERID             0x00008000
#define ATTR_CMN_GRPID               0x00010000
#define ATTR_CMN_ACCESSMASK          0x00020000
#define ATTR_CMN_FLAGS               0x00040000
#define ATTR_CMN_GEN_COUNT           0x00080000
#define ATTR_CMN_DOCUMENT_ID         0x00100000
#define ATTR_CMN_USERACCESS          0x00200000
#define ATTR_CMN_EXTENDED_SECURITY   0x00400000
#define ATTR_CMN_UUID                0x00800000
#define ATTR_CMN_GRPUUID             0x01000000
#define ATTR_CMN_FILEID              0x02000000
#define ATTR_CMN_PARENTID            0x04000000
#define ATTR_CMN_FULLPATH            0x08000000
#define ATTR_CMN_ADDEDTIME           0x10000000
#define ATTR_CMN_ERROR               0x20000000
#define ATTR_CMN_DATA_PROTECT_FLAGS  0x40000000
#define ATTR_CMN_RETURNED_ATTRS      0x80000000
#define ATTR_CMN_VALIDMASK           0xFFFFFFFF
#define ATTR_CMN_SETMASK             0x51C7FF00
#define ATTR_CMN_VOLSETMASK          0x00006700

#define ATTR_VOL_FSTYPE              0x00000001
#define ATTR_VOL_SIGNATURE           0x00000002
#define ATTR_VOL_SIZE                0x00000004
#define ATTR_VOL_SPACEFREE           0x00000008
#define ATTR_VOL_SPACEAVAIL          0x00000010
#define ATTR_VOL_MINALLOCATION       0x00000020
#define ATTR_VOL_ALLOCATIONCLUMP     0x00000040
#define ATTR_VOL_IOBLOCKSIZE         0x00000080
#define ATTR_VOL_OBJCOUNT            0x00000100
#define ATTR_VOL_FILECOUNT           0x00000200
#define ATTR_VOL_DIRCOUNT            0x00000400
#define ATTR_VOL_MAXOBJCOUNT         0x00000800
#define ATTR_VOL_MOUNTPOINT          0x00001000
#define ATTR_VOL_NAME                0x00002000
#define ATTR_VOL_MOUNTFLAGS          0x00004000
#define ATTR_VOL_MOUNTEDDEVICE       0x00008000
#define ATTR_VOL_ENCODINGSUSED       0x00010000
#define ATTR_VOL_CAPABILITIES        0x00020000
#define ATTR_VOL_UUID                0x00040000
#define ATTR_VOL_MOUNTEXTFLAGS       0x00080000
#define ATTR_VOL_FSTYPENAME          0x00100000
#define ATTR_VOL_FSSUBTYPE           0x00200000
#define ATTR_VOL_OWNER               0x00400000
#define ATTR_VOL_SPACEUSED           0x00800000
#define ATTR_VOL_QUOTA_SIZE          0x10000000
#define ATTR_VOL_RESERVED_SIZE       0x20000000
#define ATTR_VOL_ATTRIBUTES          0x40000000
#define ATTR_VOL_INFO                0x80000000
#define ATTR_VOL_VALIDMASK           0xF0FFFFFF
#define ATTR_VOL_SETMASK             0x80002000

#define ATTR_DIR_LINKCOUNT           0x00000001
#define ATTR_DIR_ENTRYCOUNT          0x00000002
#define ATTR_DIR_MOUNTSTATUS         0x00000004
#define ATTR_DIR_ALLOCSIZE           0x00000008
#define ATTR_DIR_IOBLOCKSIZE         0x00000010
#define ATTR_DIR_DATALENGTH          0x00000020
#define DIR_MNTSTATUS_MNTPOINT       0x00000001
#define DIR_MNTSTATUS_TRIGGER        0x00000002
#define ATTR_DIR_VALIDMASK           0x0000003f
#define ATTR_DIR_SETMASK             0x00000000

#define ATTR_FILE_LINKCOUNT          0x00000001
#define ATTR_FILE_TOTALSIZE          0x00000002
#define ATTR_FILE_ALLOCSIZE          0x00000004
#define ATTR_FILE_IOBLOCKSIZE        0x00000008
#define ATTR_FILE_DEVTYPE            0x00000020
#define ATTR_FILE_FORKCOUNT          0x00000080
#define ATTR_FILE_FORKLIST           0x00000100
#define ATTR_FILE_DATALENGTH         0x00000200
#define ATTR_FILE_DATAALLOCSIZE      0x00000400
#define ATTR_FILE_RSRCLENGTH         0x00001000
#define ATTR_FILE_RSRCALLOCSIZE      0x00002000
#define ATTR_FILE_VALIDMASK          0x000037FF
#define ATTR_FILE_SETMASK            0x00000020

#define ATTR_FORK_TOTALSIZE          0x00000001
#define ATTR_FORK_ALLOCSIZE          0x00000002
#define ATTR_FORK_RESERVED           0xffffffff
#define ATTR_FORK_VALIDMASK          0x00000003
#define ATTR_FORK_SETMASK            0x00000000

#define ATTR_BULK_REQUIRED (ATTR_CMN_NAME | ATTR_CMN_RETURNED_ATTRS)

// The SDK declares these in <unistd.h>; the options are `unsigned int` on
// LP64.
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::getattrlist, "_getattrlist")
#pragma binding(libc::setattrlist, "_setattrlist")
#pragma binding(libc::fgetattrlist, "_fgetattrlist")
#pragma binding(libc::fsetattrlist, "_fsetattrlist")

int getattrlist(const char *path, void *attrList, void *attrBuf, size_t attrBufSize,
                unsigned int options);
int setattrlist(const char *path, void *attrList, void *attrBuf, size_t attrBufSize,
                unsigned int options);
int fgetattrlist(int fd, void *attrList, void *attrBuf, size_t attrBufSize,
                 unsigned int options);
int fsetattrlist(int fd, void *attrList, void *attrBuf, size_t attrBufSize,
                 unsigned int options);

#endif /* __APPLE__ */
