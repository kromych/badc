/* Minimal Xlib surface for the RGFW desktop backend, authored as a
 * demo-local embedded header (badc ships no system X11 headers and the
 * boxes carry no X11 dev package). Declares only the types, structs and
 * functions RGFW's X11 path references. Struct layouts follow the X11
 * 64-bit ABI so libX11 fills them at the offsets RGFW reads. */
#ifndef _X11_XLIB_H_
#define _X11_XLIB_H_

typedef unsigned long XID;
typedef unsigned long Atom;
typedef unsigned long Time;
typedef unsigned long VisualID;
typedef unsigned long XIDArray;
typedef XID Window;
typedef XID Drawable;
typedef XID Pixmap;
typedef XID Cursor;
typedef XID Colormap;
typedef XID GContext;
typedef XID KeySym;
typedef unsigned char KeyCode;
typedef int Bool;
typedef int Status;
typedef char *XPointer;

#define True 1
#define False 0
#define None 0L
#define AllocNone 0
#define InputOutput 1
#define CopyFromParent 0L

/* Opaque server objects: RGFW only passes their addresses around. */
typedef struct _XDisplay Display;
typedef struct _XGC *GC;
typedef struct _XIM *XIM;
typedef struct _XIC *XIC;

typedef struct {
    void *ext_data;
    VisualID visualid;
    int c_class;
    unsigned long red_mask, green_mask, blue_mask;
    int bits_per_rgb;
    int map_entries;
} Visual;

typedef struct {
    void *ext_data;
    struct _XDisplay *display;
    Window root;
    int width, height;
    int mwidth, mheight;
    int ndepths;
    void *depths;
    int root_depth;
    Visual *root_visual;
    GC default_gc;
    Colormap cmap;
    unsigned long white_pixel, black_pixel;
    int max_maps, min_maps;
    int backing_store;
    Bool save_unders;
    long root_input_mask;
} Screen;

typedef struct {
    Pixmap background_pixmap;
    unsigned long background_pixel;
    Pixmap border_pixmap;
    unsigned long border_pixel;
    int bit_gravity;
    int win_gravity;
    int backing_store;
    unsigned long backing_planes;
    unsigned long backing_pixel;
    Bool save_under;
    long event_mask;
    long do_not_propagate_mask;
    Bool override_redirect;
    Colormap colormap;
    Cursor cursor;
} XSetWindowAttributes;

typedef struct {
    int x, y;
    int width, height;
    int border_width;
    int depth;
    Visual *visual;
    Window root;
    int c_class;
    int bit_gravity;
    int win_gravity;
    int backing_store;
    unsigned long backing_planes;
    unsigned long backing_pixel;
    Bool save_under;
    Colormap colormap;
    Bool map_installed;
    int map_state;
    long all_event_masks;
    long your_event_mask;
    long do_not_propagate_mask;
    Bool override_redirect;
    Screen *screen;
} XWindowAttributes;

typedef struct {
    Visual *visual;
    VisualID visualid;
    int screen;
    int depth;
    int c_class;
    unsigned long red_mask, green_mask, blue_mask;
    int colormap_size;
    int bits_per_rgb;
} XVisualInfo;

#define VisualNoMask 0x0
#define VisualIDMask 0x1
#define VisualScreenMask 0x4
#define VisualDepthMask 0x8

typedef struct {
    long flags;
    int x, y;
    int width, height;
    int min_width, min_height;
    int max_width, max_height;
    int width_inc, height_inc;
    struct { int x, y; } min_aspect, max_aspect;
    int base_width, base_height;
    int win_gravity;
} XSizeHints;

#define USPosition (1L << 0)
#define USSize     (1L << 1)
#define PPosition  (1L << 2)
#define PSize      (1L << 3)
#define PMinSize   (1L << 4)
#define PMaxSize   (1L << 5)
#define PResizeInc (1L << 6)
#define PAspect    (1L << 7)
#define PBaseSize  (1L << 8)
#define PWinGravity (1L << 9)

typedef struct {
    char *res_name;
    char *res_class;
} XClassHint;

/* Event records. XEvent is a union padded to a fixed size; RGFW reads
 * `type`, the button/key/motion fields, and the selection records. */
typedef struct {
    int type;
    unsigned long serial;
    Bool send_event;
    Display *display;
    Window window;
} XAnyEvent;

typedef struct {
    int type;
    unsigned long serial;
    Bool send_event;
    Display *display;
    Window window;
    Window root;
    Window subwindow;
    Time time;
    int x, y;
    int x_root, y_root;
    unsigned int state;
    unsigned int button;
    Bool same_screen;
} XButtonEvent;

typedef struct {
    int type;
    unsigned long serial;
    Bool send_event;
    Display *display;
    Window window;
    Window root;
    Window subwindow;
    Time time;
    int x, y;
    int x_root, y_root;
    unsigned int state;
    unsigned int keycode;
    Bool same_screen;
} XKeyEvent;

typedef struct {
    int type;
    unsigned long serial;
    Bool send_event;
    Display *display;
    Window window;
    Window root;
    Window subwindow;
    Time time;
    int x, y;
    int x_root, y_root;
    unsigned int state;
    char is_hint;
    Bool same_screen;
} XMotionEvent;

typedef struct {
    int type;
    unsigned long serial;
    Bool send_event;
    Display *display;
    Window window;
    int x, y;
    int width, height;
    int count;
} XExposeEvent;

typedef struct {
    int type;
    unsigned long serial;
    Bool send_event;
    Display *display;
    Window event;
    Window window;
    int x, y;
    int width, height;
    int border_width;
    Window above;
    Bool override_redirect;
} XConfigureEvent;

typedef struct {
    int type;
    unsigned long serial;
    Bool send_event;
    Display *display;
    Window window;
    Atom message_type;
    int format;
    union {
        char b[20];
        short s[10];
        long l[5];
    } data;
} XClientMessageEvent;

typedef struct {
    int type;
    unsigned long serial;
    Bool send_event;
    Display *display;
    Window requestor;
    Atom selection;
    Atom target;
    Atom property;
    Time time;
} XSelectionEvent;

typedef struct {
    int type;
    unsigned long serial;
    Bool send_event;
    Display *display;
    Window owner;
    Window requestor;
    Atom selection;
    Atom target;
    Atom property;
    Time time;
} XSelectionRequestEvent;

typedef struct {
    int type;
    unsigned long serial;
    Bool send_event;
    Display *display;
    Window window;
    int mode;
    int detail;
} XFocusChangeEvent;

typedef struct {
    int type;
    unsigned long serial;
    Bool send_event;
    Display *display;
    Window window;
    int x, y;
    int width, height;
    Bool from_configure;
} XMapEvent;

typedef struct {
    int type;
    unsigned long serial;
    Bool send_event;
    Display *display;
    Window window;
    Window root;
    Window subwindow;
    Time time;
    int x, y;
    int x_root, y_root;
    int mode;
    int detail;
    Bool same_screen;
    Bool focus;
    unsigned int state;
} XCrossingEvent;

typedef struct {
    int type;
    int extension;
    unsigned long serial;
    Bool send_event;
    Display *display;
    int evtype;
    unsigned int cookie;
    void *data;
} XGenericEventCookie;

typedef union _XEvent {
    int type;
    XAnyEvent xany;
    XKeyEvent xkey;
    XButtonEvent xbutton;
    XMotionEvent xmotion;
    XCrossingEvent xcrossing;
    XExposeEvent xexpose;
    XConfigureEvent xconfigure;
    XClientMessageEvent xclient;
    XSelectionEvent xselection;
    XSelectionRequestEvent xselectionrequest;
    XFocusChangeEvent xfocus;
    XMapEvent xmap;
    XGenericEventCookie xcookie;
    long pad[24];
} XEvent;

/* Event mask bits used when selecting input. */
#define NoEventMask 0L
#define KeyPressMask (1L << 0)
#define KeyReleaseMask (1L << 1)
#define ButtonPressMask (1L << 2)
#define ButtonReleaseMask (1L << 3)
#define EnterWindowMask (1L << 4)
#define LeaveWindowMask (1L << 5)
#define PointerMotionMask (1L << 6)
#define ButtonMotionMask (1L << 13)
#define ExposureMask (1L << 15)
#define StructureNotifyMask (1L << 17)
#define FocusChangeMask (1L << 21)
#define PropertyChangeMask (1L << 22)

/* Event type codes. */
#define KeyPress 2
#define KeyRelease 3
#define ButtonPress 4
#define ButtonRelease 5
#define MotionNotify 6
#define EnterNotify 7
#define LeaveNotify 8
#define FocusIn 9
#define FocusOut 10
#define Expose 12
#define ConfigureNotify 22
#define ClientMessage 33
#define SelectionClear 29
#define SelectionRequest 30
#define SelectionNotify 31
#define GenericEvent 35

#define CWBackPixel (1L << 1)
#define CWBorderPixel (1L << 3)
#define CWEventMask (1L << 11)
#define CWColormap (1L << 13)
#define CWOverrideRedirect (1L << 9)

#define PropModeReplace 0
#define PropModePrepend 1
#define PropModeAppend 2

#define GrabModeSync 0
#define GrabModeAsync 1

#define Success 0
#define CurrentTime 0L
#define RevertToParent 2
#define RevertToNone 0
#define RevertToPointerRoot 1
#define AnyButton 0L
#define AnyKey 0L
#define IsUnmapped 0
#define IsUnviewable 1
#define IsViewable 2
#define PointerRoot 1L
#define QueuedAlready 0
#define QueuedAfterReading 1
#define QueuedAfterFlush 2
#define QLength(dpy) XEventsQueued((dpy), QueuedAlready)
#define ShiftMask (1 << 0)
#define LockMask (1 << 1)
#define ControlMask (1 << 2)
#define Mod1Mask (1 << 3)
#define Mod2Mask (1 << 4)
#define Mod3Mask (1 << 5)
#define Mod4Mask (1 << 6)
#define Mod5Mask (1 << 7)
#define Button1Mask (1 << 8)
#define Button2Mask (1 << 9)
#define Button3Mask (1 << 10)
#define Button4Mask (1 << 11)
#define Button5Mask (1 << 12)
#define Above 0
#define Below 1
#define AnyPropertyType 0L
#define WithdrawnState 0
#define NormalState 1
#define IconicState 3

Display *XOpenDisplay(const char *display_name);
int XCloseDisplay(Display *display);
Window XCreateWindow(Display *display, Window parent, int x, int y,
                     unsigned int width, unsigned int height,
                     unsigned int border_width, int depth, unsigned int c_class,
                     Visual *visual, unsigned long valuemask,
                     XSetWindowAttributes *attributes);
int XDestroyWindow(Display *display, Window w);
int XMapWindow(Display *display, Window w);
int XUnmapWindow(Display *display, Window w);
int XMoveWindow(Display *display, Window w, int x, int y);
int XResizeWindow(Display *display, Window w, unsigned int width,
                  unsigned int height);
int XStoreName(Display *display, Window w, const char *window_name);
int XFlush(Display *display);
int XSync(Display *display, Bool discard);
int XNextEvent(Display *display, XEvent *event_return);
int XPeekEvent(Display *display, XEvent *event_return);
int XPending(Display *display);
int XEventsQueued(Display *display, int mode);
int XSelectInput(Display *display, Window w, long event_mask);
int XSendEvent(Display *display, Window w, Bool propagate, long event_mask,
               XEvent *event_send);
Colormap XCreateColormap(Display *display, Window w, Visual *visual, int alloc);
Atom XInternAtom(Display *display, const char *atom_name, Bool only_if_exists);
int XSetWMProtocols(Display *display, Window w, Atom *protocols, int count);
int XChangeProperty(Display *display, Window w, Atom property, Atom type,
                    int format, int mode, const unsigned char *data,
                    int nelements);
int XDeleteProperty(Display *display, Window w, Atom property);
int XGetWindowProperty(Display *display, Window w, Atom property, long long_offset,
                       long long_length, Bool del, Atom req_type,
                       Atom *actual_type_return, int *actual_format_return,
                       unsigned long *nitems_return, unsigned long *bytes_after_return,
                       unsigned char **prop_return);
Status XGetWindowAttributes(Display *display, Window w,
                            XWindowAttributes *window_attributes_return);
Bool XTranslateCoordinates(Display *display, Window src_w, Window dest_w,
                           int src_x, int src_y, int *dest_x_return,
                           int *dest_y_return, Window *child_return);
int XWarpPointer(Display *display, Window src_w, Window dest_w, int src_x,
                 int src_y, unsigned int src_width, unsigned int src_height,
                 int dest_x, int dest_y);
Bool XQueryPointer(Display *display, Window w, Window *root_return,
                   Window *child_return, int *root_x_return, int *root_y_return,
                   int *win_x_return, int *win_y_return,
                   unsigned int *mask_return);
int XGrabPointer(Display *display, Window grab_window, Bool owner_events,
                 unsigned int event_mask, int pointer_mode, int keyboard_mode,
                 Window confine_to, Cursor cursor, Time time);
int XUngrabPointer(Display *display, Time time);
int XDefineCursor(Display *display, Window w, Cursor cursor);
Cursor XCreateFontCursor(Display *display, unsigned int shape);
int XFreeCursor(Display *display, Cursor cursor);
int XFree(void *data);
int XStoreName(Display *display, Window w, const char *window_name);
Window XDefaultRootWindow(Display *display);
Visual *XDefaultVisual(Display *display, int screen_number);
int XDisplayWidth(Display *display, int screen_number);
int XDisplayHeight(Display *display, int screen_number);
KeySym XkbKeycodeToKeysym(Display *display, KeyCode kc, int group, int level);
char *XKeysymToString(KeySym keysym);
Status XMatchVisualInfo(Display *display, int screen, int depth, int c_class,
                        XVisualInfo *vinfo_return);
XSizeHints *XAllocSizeHints(void);
void XSetWMNormalHints(Display *display, Window w, XSizeHints *hints);
Status XGetWMNormalHints(Display *display, Window w, XSizeHints *hints,
                         long *supplied_return);
XClassHint *XAllocClassHint(void);
int XSetClassHint(Display *display, Window w, XClassHint *class_hints);
int XInitThreads(void);
char *XResourceManagerString(Display *display);
int XConvertSelection(Display *display, Atom selection, Atom target, Atom property,
                      Window requestor, Time time);
Bool XSetSelectionOwner(Display *display, Atom selection, Window owner, Time time);
int XGetEventData(Display *display, XGenericEventCookie *cookie);
void XFreeEventData(Display *display, XGenericEventCookie *cookie);

typedef struct _XRegion *Region;
typedef struct _XImage XImage;

typedef struct {
    long function;
    unsigned long plane_mask;
    unsigned long foreground, background;
    int line_width, line_style, cap_style, join_style, fill_style, fill_rule;
    int arc_mode;
    Pixmap tile, stipple;
    int ts_x_origin, ts_y_origin;
    void *font;
    int subwindow_mode;
    Bool graphics_exposures;
    int clip_x_origin, clip_y_origin;
    Pixmap clip_mask;
    int dash_offset;
    char dashes;
} XGCValues;

typedef struct {
    int key_click_percent;
    int bell_percent;
    unsigned int bell_pitch, bell_duration;
    unsigned long led_mask;
    int global_auto_repeat;
    char auto_repeats[32];
} XKeyboardState;

Region XCreateRegion(void);
int XDestroyRegion(Region r);
GC XCreateGC(Display *display, Drawable d, unsigned long valuemask,
             XGCValues *values);
int XFreeGC(Display *display, GC gc);
XImage *XCreateImage(Display *display, Visual *visual, unsigned int depth,
                     int format, int offset, char *data, unsigned int width,
                     unsigned int height, int bitmap_pad, int bytes_per_line);
int XDestroyImage(XImage *ximage);
int XPutImage(Display *display, Drawable d, GC gc, XImage *image, int src_x,
              int src_y, int dest_x, int dest_y, unsigned int width,
              unsigned int height);
int XFreeColors(Display *display, Colormap colormap, unsigned long *pixels,
                int npixels, unsigned long planes);
int XGetKeyboardControl(Display *display, XKeyboardState *value_return);
int XIconifyWindow(Display *display, Window w, int screen_number);
void XSetWMSizeHints(Display *display, Window w, XSizeHints *hints, Atom property);

/* Display accessors. Xlib spells these as struct-poking macros by
 * default; libX11 also exports the function equivalents, so map the
 * convenience names onto them and keep Display opaque. */
int XDefaultScreen(Display *display);
Screen *XDefaultScreenOfDisplay(Display *display);
Window XRootWindow(Display *display, int screen_number);
int XScreenCount(Display *display);
int XConnectionNumber(Display *display);
int XDisplayWidthMM(Display *display, int screen_number);
int XDisplayHeightMM(Display *display, int screen_number);

#define DefaultScreen(dpy) XDefaultScreen(dpy)
#define DefaultScreenOfDisplay(dpy) XDefaultScreenOfDisplay(dpy)
#define DefaultRootWindow(dpy) XDefaultRootWindow(dpy)
#define RootWindow(dpy, scr) XRootWindow(dpy, scr)
#define ScreenCount(dpy) XScreenCount(dpy)
#define ConnectionNumber(dpy) XConnectionNumber(dpy)
#define DefaultVisual(dpy, scr) XDefaultVisual(dpy, scr)
#define DisplayWidthMM(dpy, scr) XDisplayWidthMM(dpy, scr)
#define DisplayHeightMM(dpy, scr) XDisplayHeightMM(dpy, scr)
#define DisplayWidth(dpy, scr) XDisplayWidth(dpy, scr)
#define DisplayHeight(dpy, scr) XDisplayHeight(dpy, scr)

#endif /* _X11_XLIB_H_ */
