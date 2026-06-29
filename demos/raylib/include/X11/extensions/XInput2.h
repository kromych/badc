/* Minimal <X11/extensions/XInput2.h> for RGFW's raw-pointer path
 * (demo-local). Only the event-mask record and the mask helpers RGFW
 * uses; XISelectEvents is loaded at runtime via dlsym. */
#ifndef _X11_EXTENSIONS_XINPUT2_H_
#define _X11_EXTENSIONS_XINPUT2_H_

#include <X11/Xlib.h>

#define XIAllDevices 0
#define XIAllMasterDevices 1
#define XI_RawMotion 17

typedef struct {
    int deviceid;
    int mask_len;
    unsigned char *mask;
} XIEventMask;

typedef struct {
    int mask_len;
    unsigned char *mask;
    double *values;
} XIValuatorState;

typedef struct {
    int type;
    unsigned long serial;
    Bool send_event;
    Display *display;
    int extension;
    int evtype;
    Time time;
    int deviceid;
    int sourceid;
    int detail;
    int flags;
    XIValuatorState valuators;
    double *raw_values;
} XIRawEvent;

#define XIMaskLen(event) (((event) >> 3) + 1)
#define XISetMask(ptr, event) ((ptr)[(event) >> 3] |= (1 << ((event) & 7)))
#define XIMaskIsSet(ptr, event) ((ptr)[(event) >> 3] & (1 << ((event) & 7)))

int XISelectEvents(Display *dpy, Window win, XIEventMask *masks, int num_masks);

#endif /* _X11_EXTENSIONS_XINPUT2_H_ */
