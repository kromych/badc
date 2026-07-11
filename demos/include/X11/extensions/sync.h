/* X Synchronization Extension types used by RGFW's frame-sync preload. RGFW
 * resolves the XSync* entry points at runtime via dlsym, so only the value /
 * counter types are needed here. */
#ifndef _X11_EXTENSIONS_SYNC_H
#define _X11_EXTENSIONS_SYNC_H

#include <X11/Xlib.h>

typedef XID XSyncCounter;
typedef struct _XSyncValue {
    int hi;
    unsigned int lo;
} XSyncValue;

#endif /* _X11_EXTENSIONS_SYNC_H */
