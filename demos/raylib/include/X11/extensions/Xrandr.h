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
typedef unsigned long XRRModeFlags;

/* Mode flags (randr.h) used in the refresh-rate calculation. */
#define RR_Interlace 0x00000010
#define RR_DoubleScan 0x00000020

/* CRTC rotation / reflection (randr.h). */
#define RR_Rotate_0 1
#define RR_Rotate_90 2
#define RR_Rotate_180 4
#define RR_Rotate_270 8
#define RR_Reflect_X 16
#define RR_Reflect_Y 32

typedef struct _XRRModeInfo {
    RRMode id;
    unsigned int width;
    unsigned int height;
    unsigned long dotClock;
    unsigned int hSyncStart;
    unsigned int hSyncEnd;
    unsigned int hTotal;
    unsigned int hSkew;
    unsigned int vSyncStart;
    unsigned int vSyncEnd;
    unsigned int vTotal;
    char *name;
    unsigned int nameLength;
    XRRModeFlags modeFlags;
} XRRModeInfo;

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

/* RandR event codes + selection masks (randr.h). */
#define RRScreenChangeNotify 0
#define RRNotify 1
#define RRNotify_CrtcChange 0
#define RRNotify_OutputChange 1
#define RRNotify_OutputProperty 2
#define RRScreenChangeNotifyMask (1L << 0)
#define RRCrtcChangeNotifyMask (1L << 1)
#define RROutputChangeNotifyMask (1L << 2)
#define RROutputPropertyNotifyMask (1L << 3)

/* Gamma-ramp control + mode configuration RGFW's monitor path uses. */
typedef struct {
    int size;
    unsigned short *red;
    unsigned short *green;
    unsigned short *blue;
} XRRCrtcGamma;

Bool XRRQueryExtension(Display *dpy, int *event_base_return,
                       int *error_base_return);
void XRRSelectInput(Display *dpy, Window window, int mask);
RROutput XRRGetOutputPrimary(Display *dpy, Window window);
int XRRGetCrtcGammaSize(Display *dpy, RRCrtc crtc);
XRRCrtcGamma *XRRGetCrtcGamma(Display *dpy, RRCrtc crtc);
XRRCrtcGamma *XRRAllocGamma(int size);
void XRRSetCrtcGamma(Display *dpy, RRCrtc crtc, XRRCrtcGamma *gamma);
void XRRFreeGamma(XRRCrtcGamma *gamma);
Status XRRSetCrtcConfig(Display *dpy, XRRScreenResources *resources, RRCrtc crtc,
                        Time timestamp, int x, int y, RRMode mode,
                        Rotation rotation, RROutput *outputs, int noutputs);

#endif /* _X11_EXTENSIONS_XRANDR_H_ */
