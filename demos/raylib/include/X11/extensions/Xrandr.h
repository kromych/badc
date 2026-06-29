/* Minimal <X11/extensions/Xrandr.h> for RGFW's monitor query
 * (demo-local). Struct layouts follow the libXrandr ABI so the CRTC
 * geometry RGFW reads lands at the right offsets. */
#ifndef _X11_EXTENSIONS_XRANDR_H_
#define _X11_EXTENSIONS_XRANDR_H_

#include <X11/Xlib.h>

#define RR_Connected 0
#define RR_Disconnected 1
#define RR_UnknownConnection 2

typedef XID RRCrtc;
typedef XID RROutput;
typedef XID RRMode;
typedef unsigned short Rotation;
typedef struct _XRRModeInfo XRRModeInfo;

typedef struct {
    Time timestamp;
    Time configTimestamp;
    int ncrtc;
    RRCrtc *crtcs;
    int noutput;
    RROutput *outputs;
    int nmode;
    XRRModeInfo *modes;
} XRRScreenResources;

typedef struct {
    Time timestamp;
    int x, y;
    unsigned int width, height;
    RRMode mode;
    Rotation rotation;
    int noutput;
    RROutput *outputs;
    Rotation rotations;
    int npossible;
    RROutput *possible;
} XRRCrtcInfo;

typedef struct {
    Time timestamp;
    RRCrtc crtc;
    char *name;
    int nameLen;
    unsigned long mm_width;
    unsigned long mm_height;
    int connection;
    int subpixel_order;
    int ncrtc;
    RRCrtc *crtcs;
    int nclone;
    RROutput *clones;
    int nmode;
    int npreferred;
    RRMode *modes;
} XRROutputInfo;

XRRScreenResources *XRRGetScreenResources(Display *dpy, Window window);
XRRScreenResources *XRRGetScreenResourcesCurrent(Display *dpy, Window window);
void XRRFreeScreenResources(XRRScreenResources *resources);
XRRCrtcInfo *XRRGetCrtcInfo(Display *dpy, XRRScreenResources *resources,
                            RRCrtc crtc);
void XRRFreeCrtcInfo(XRRCrtcInfo *crtcInfo);
XRROutputInfo *XRRGetOutputInfo(Display *dpy, XRRScreenResources *resources,
                                RROutput output);
void XRRFreeOutputInfo(XRROutputInfo *outputInfo);

#endif /* _X11_EXTENSIONS_XRANDR_H_ */
