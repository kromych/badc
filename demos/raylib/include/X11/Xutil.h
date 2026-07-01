/* Minimal <X11/Xutil.h> for RGFW (demo-local). The window-property and
 * visual structs RGFW uses live in <X11/Xlib.h>; this header pulls them
 * in and adds the X resource-manager entry points RGFW's DPI path calls. */
#ifndef _X11_XUTIL_H_
#define _X11_XUTIL_H_

#include <X11/Xlib.h>

typedef struct _XrmHashBucketRec *XrmDatabase;

typedef struct {
    unsigned int size;
    void *addr;
} XrmValue;

XrmDatabase XrmGetStringDatabase(const char *data);
void XrmDestroyDatabase(XrmDatabase database);
Bool XrmGetResource(XrmDatabase database, const char *str_name,
                    const char *str_class, char **str_type_return,
                    XrmValue *value_return);

/* Per-window context association (XSaveContext / XFindContext). */
typedef int XContext;

/* Error-handler event passed to XSetErrorHandler's callback. */
typedef struct {
    int type;
    Display *display;
    XID resourceid;
    unsigned long serial;
    unsigned char error_code;
    unsigned char request_code;
    unsigned char minor_code;
} XErrorEvent;

/* Input-method / input-context surface RGFW uses for key composition. */
typedef unsigned long XIMStyle;
typedef struct {
    unsigned short count_styles;
    XIMStyle *supported_styles;
} XIMStyles;
typedef void (*XIMProc)(XIM, XPointer, XPointer);
typedef struct {
    XPointer client_data;
    XIMProc callback;
} XIMCallback;

#define XNInputStyle       "inputStyle"
#define XNClientWindow     "clientWindow"
#define XNFocusWindow      "focusWindow"
#define XNDestroyCallback  "destroyCallback"
#define XNQueryInputStyle  "queryInputStyle"
#define XIMPreeditNothing  0x0008L
#define XIMStatusNothing   0x0400L

typedef int (*XErrorHandler)(Display *, XErrorEvent *);
typedef void (*XIDProc)(Display *, XPointer, XPointer);

/* Input-method / input-context lifecycle. XCreateIC / X{Get,Set}IMValues
 * take a NULL-terminated attribute-name/value varargs list. */
XIM XOpenIM(Display *dpy, XrmDatabase rdb, char *res_name, char *res_class);
Status XCloseIM(XIM im);
XIC XCreateIC(XIM im, ...);
void XDestroyIC(XIC ic);
void XSetICFocus(XIC ic);
void XUnsetICFocus(XIC ic);
char *XGetIMValues(XIM im, ...);
char *XSetIMValues(XIM im, ...);
char *XSetLocaleModifiers(const char *modifier_list);
Bool XRegisterIMInstantiateCallback(Display *dpy, XrmDatabase rdb,
                                    char *res_name, char *res_class,
                                    XIDProc callback, XPointer client_data);
Bool XUnregisterIMInstantiateCallback(Display *dpy, XrmDatabase rdb,
                                      char *res_name, char *res_class,
                                      XIDProc callback, XPointer client_data);

/* Per-window context association and the error handler. XUniqueContext is a
 * macro over XrmUniqueQuark in Xlib, not a libX11 export. */
typedef int XrmQuark;
XrmQuark XrmUniqueQuark(void);
#define XUniqueContext() ((XContext) XrmUniqueQuark())
int XSaveContext(Display *dpy, XID rid, XContext context, const char *data);
int XFindContext(Display *dpy, XID rid, XContext context, XPointer *data_return);
int XDeleteContext(Display *dpy, XID rid, XContext context);
XErrorHandler XSetErrorHandler(XErrorHandler handler);
int XGetErrorText(Display *dpy, int code, char *buffer, int length);

/* Composed-key lookup status (Xutil.h) and the UTF-8 lookup entry point. */
#define XBufferOverflow (-1)
#define XLookupNone 1
#define XLookupChars 2
#define XLookupKeySym 3
#define XLookupBoth 4

int Xutf8LookupString(XIC ic, XKeyEvent *event, char *buffer_return,
                      int bytes_buffer, KeySym *keysym_return,
                      Status *status_return);
void Xutf8SetWMProperties(Display *dpy, Window w, const char *window_name,
                         const char *icon_name, char **argv, int argc,
                         XSizeHints *normal_hints, XWMHints *wm_hints,
                         XClassHint *class_hints);

#endif /* _X11_XUTIL_H_ */
