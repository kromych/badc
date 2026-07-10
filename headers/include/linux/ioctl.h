// linux/ioctl.h -- the _IOC request-encoding macros from the kernel uapi
// header (real linux/ioctl.h just includes <asm/ioctl.h>). The asm-generic
// layout below is the one both aarch64 and x86_64 use -- badc's only Linux
// targets -- so the encoded request numbers match the kernel exactly. (The
// mips/powerpc/alpha/sparc variants differ; add arch gating if those Linux
// targets are ever supported.) Self-contained, matching the bundled linux/
// shims.

#pragma once

#ifdef __linux__
#define _IOC_NRBITS   8
#define _IOC_TYPEBITS 8
#define _IOC_SIZEBITS 14
#define _IOC_DIRBITS  2

#define _IOC_NRMASK   ((1 << _IOC_NRBITS) - 1)
#define _IOC_TYPEMASK ((1 << _IOC_TYPEBITS) - 1)
#define _IOC_SIZEMASK ((1 << _IOC_SIZEBITS) - 1)
#define _IOC_DIRMASK  ((1 << _IOC_DIRBITS) - 1)

#define _IOC_NRSHIFT   0
#define _IOC_TYPESHIFT (_IOC_NRSHIFT + _IOC_NRBITS)
#define _IOC_SIZESHIFT (_IOC_TYPESHIFT + _IOC_TYPEBITS)
#define _IOC_DIRSHIFT  (_IOC_SIZESHIFT + _IOC_SIZEBITS)

#define _IOC_NONE  0U
#define _IOC_WRITE 1U
#define _IOC_READ  2U

#define _IOC(dir, type, nr, size)      \
    (((dir) << _IOC_DIRSHIFT) |        \
     ((type) << _IOC_TYPESHIFT) |      \
     ((nr) << _IOC_NRSHIFT) |          \
     ((size) << _IOC_SIZESHIFT))

#define _IOC_TYPECHECK(t) (sizeof(t))

#define _IO(type, nr)             _IOC(_IOC_NONE, (type), (nr), 0)
#define _IOR(type, nr, argtype)   _IOC(_IOC_READ, (type), (nr), (_IOC_TYPECHECK(argtype)))
#define _IOW(type, nr, argtype)   _IOC(_IOC_WRITE, (type), (nr), (_IOC_TYPECHECK(argtype)))
#define _IOWR(type, nr, argtype)  _IOC(_IOC_READ | _IOC_WRITE, (type), (nr), (_IOC_TYPECHECK(argtype)))
#define _IOR_BAD(type, nr, argtype)  _IOC(_IOC_READ, (type), (nr), sizeof(argtype))
#define _IOW_BAD(type, nr, argtype)  _IOC(_IOC_WRITE, (type), (nr), sizeof(argtype))
#define _IOWR_BAD(type, nr, argtype) _IOC(_IOC_READ | _IOC_WRITE, (type), (nr), sizeof(argtype))

#define _IOC_DIR(nr)  (((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
#define _IOC_TYPE(nr) (((nr) >> _IOC_TYPESHIFT) & _IOC_TYPEMASK)
#define _IOC_NR(nr)   (((nr) >> _IOC_NRSHIFT) & _IOC_NRMASK)
#define _IOC_SIZE(nr) (((nr) >> _IOC_SIZESHIFT) & _IOC_SIZEMASK)

#define IOC_IN        (_IOC_WRITE << _IOC_DIRSHIFT)
#define IOC_OUT       (_IOC_READ << _IOC_DIRSHIFT)
#define IOC_INOUT     ((_IOC_WRITE | _IOC_READ) << _IOC_DIRSHIFT)
#define IOCSIZE_MASK  (_IOC_SIZEMASK << _IOC_SIZESHIFT)
#define IOCSIZE_SHIFT (_IOC_SIZESHIFT)
#endif
