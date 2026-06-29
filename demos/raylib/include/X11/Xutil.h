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

#endif /* _X11_XUTIL_H_ */
