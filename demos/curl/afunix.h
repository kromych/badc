/* Demo-local <afunix.h>: the AF_UNIX socket address of the Windows SDK and
 * mingw-w64 10 and later, which curl includes under a mingw-w64 of that
 * version. Layout as in those headers. */
#ifndef _AFUNIX_
#define _AFUNIX_

#include <winsock2.h>

#define UNIX_PATH_MAX 108

typedef struct sockaddr_un {
    ADDRESS_FAMILY sun_family;
    char sun_path[UNIX_PATH_MAX];
} SOCKADDR_UN, *PSOCKADDR_UN;

#endif
