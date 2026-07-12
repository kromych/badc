// linux/cdrom.h -- the CD-ROM device ioctls and drive-status codes from the
// kernel uapi header. The audio playback / MSF address structures are not
// bundled; consumers here use only the tray and lock ioctls.

#pragma once

#ifdef __linux__

#include <limits.h>

#define CDROMEJECT         0x5309 // eject the media
#define CDROMCLOSETRAY     0x5319 // close the tray (pendant of CDROMEJECT)
#define CDROMEJECT_SW      0x530f // auto-eject on close/release
#define CDROM_GET_CAPABILITY 0x5331
#define CDROM_DRIVE_STATUS 0x5326 // tray position / disc presence
#define CDROM_MEDIA_CHANGED 0x5325
#define CDROM_LOCKDOOR     0x5329 // lock or unlock the door

// CDROM_DRIVE_STATUS return codes.
#define CDS_NO_INFO         0
#define CDS_NO_DISC         1
#define CDS_TRAY_OPEN       2
#define CDS_DRIVE_NOT_READY 3
#define CDS_DISC_OK         4

// Slot selectors for changer ioctls.
#define CDSL_NONE    (INT_MAX - 1)
#define CDSL_CURRENT INT_MAX

#endif /* __linux__ */
