/* <sys/sendfile.h> is Linux's; macOS declares sendfile in <sys/socket.h>
   with a different signature. The host tools that include this header
   only need the declaration to exist. */
#ifndef _HOSTCOMPAT_SYS_SENDFILE_H
#define _HOSTCOMPAT_SYS_SENDFILE_H

#include <sys/socket.h>
#include <sys/types.h>

#endif
