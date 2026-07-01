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

#endif /* _X11_XUTIL_H_ */
