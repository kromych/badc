// copyfile.h -- macOS file copy with metadata/xattr/ACL preservation.
//
// The copyfile(3) API and the operation flags used to copy a file's
// extended attributes and ACL. macOS only; libSystem supplies the
// symbol. Callers in this codebase pass a NULL state, so the opaque
// state type is forward-declared without its accessors.

#ifndef _C5_COPYFILE_H
#define _C5_COPYFILE_H

#ifdef __APPLE__

typedef struct _copyfile_state *copyfile_state_t;
typedef unsigned int copyfile_flags_t;

#define COPYFILE_ACL            (1<<0)
#define COPYFILE_STAT           (1<<1)
#define COPYFILE_XATTR          (1<<2)
#define COPYFILE_DATA           (1<<3)
#define COPYFILE_SECURITY       (COPYFILE_STAT | COPYFILE_ACL)
#define COPYFILE_METADATA       (COPYFILE_SECURITY | COPYFILE_XATTR)
#define COPYFILE_ALL            (COPYFILE_METADATA | COPYFILE_DATA)

#define COPYFILE_EXCL           (1<<17)
#define COPYFILE_NOFOLLOW_SRC   (1<<18)
#define COPYFILE_NOFOLLOW_DST   (1<<19)
#define COPYFILE_MOVE           (1<<20)
#define COPYFILE_UNLINK         (1<<21)
#define COPYFILE_NOFOLLOW       (COPYFILE_NOFOLLOW_SRC | COPYFILE_NOFOLLOW_DST)

#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::copyfile, "_copyfile")

int copyfile(char *from, char *to, copyfile_state_t state,
             copyfile_flags_t flags);

#endif /* __APPLE__ */

#endif /* _C5_COPYFILE_H */
