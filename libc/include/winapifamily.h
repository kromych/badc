#pragma once
// The API families and partitions of the Windows SDK. A build targets one
// family, the desktop one by default; each WINAPI_PARTITION_* is 1 when the
// family includes the partition, and a build may define one to enable it.
// WINAPI_FAMILY_PARTITION(p) is p.

#define WINAPI_FAMILY_PC_APP        2
#define WINAPI_FAMILY_PHONE_APP     3
#define WINAPI_FAMILY_SYSTEM        4
#define WINAPI_FAMILY_SERVER        5
#define WINAPI_FAMILY_GAMES         6
#define WINAPI_FAMILY_DESKTOP_APP   100
#define WINAPI_FAMILY_APP           WINAPI_FAMILY_PC_APP

#ifndef WINAPI_FAMILY
#define WINAPI_FAMILY WINAPI_FAMILY_DESKTOP_APP
#endif

#if WINAPI_FAMILY != WINAPI_FAMILY_DESKTOP_APP && WINAPI_FAMILY != WINAPI_FAMILY_PC_APP       \
    && WINAPI_FAMILY != WINAPI_FAMILY_PHONE_APP && WINAPI_FAMILY != WINAPI_FAMILY_SYSTEM     \
    && WINAPI_FAMILY != WINAPI_FAMILY_GAMES && WINAPI_FAMILY != WINAPI_FAMILY_SERVER
#error "winapifamily.h: unknown WINAPI_FAMILY"
#endif

#ifndef WINAPI_PARTITION_DESKTOP
#define WINAPI_PARTITION_DESKTOP (WINAPI_FAMILY == WINAPI_FAMILY_DESKTOP_APP)
#endif
#ifndef WINAPI_PARTITION_APP
#define WINAPI_PARTITION_APP                                                                     \
    (WINAPI_FAMILY == WINAPI_FAMILY_DESKTOP_APP || WINAPI_FAMILY == WINAPI_FAMILY_PC_APP         \
     || WINAPI_FAMILY == WINAPI_FAMILY_PHONE_APP)
#endif
#ifndef WINAPI_PARTITION_PC_APP
#define WINAPI_PARTITION_PC_APP                                                                  \
    (WINAPI_FAMILY == WINAPI_FAMILY_DESKTOP_APP || WINAPI_FAMILY == WINAPI_FAMILY_PC_APP)
#endif
#ifndef WINAPI_PARTITION_PHONE_APP
#define WINAPI_PARTITION_PHONE_APP (WINAPI_FAMILY == WINAPI_FAMILY_PHONE_APP)
#endif
#ifndef WINAPI_PARTITION_GAMES
#define WINAPI_PARTITION_GAMES                                                                   \
    (WINAPI_FAMILY == WINAPI_FAMILY_GAMES || WINAPI_FAMILY == WINAPI_FAMILY_DESKTOP_APP)
#endif
#ifndef WINAPI_PARTITION_SYSTEM
#define WINAPI_PARTITION_SYSTEM                                                                  \
    (WINAPI_FAMILY == WINAPI_FAMILY_SYSTEM || WINAPI_FAMILY == WINAPI_FAMILY_SERVER)
#endif
#define WINAPI_PARTITION_PHONE WINAPI_PARTITION_PHONE_APP

#define WINAPI_FAMILY_PARTITION(Partitions) (Partitions)
