/* X Shape extension entry points used by RGFW (demo-local). */
#ifndef _X11_EXTENSIONS_SHAPE_H_
#define _X11_EXTENSIONS_SHAPE_H_

#include <X11/Xlib.h>
#include <X11/extensions/shapeconst.h>

void XShapeCombineMask(Display *dpy, Window dest, int dest_kind, int x_off,
                       int y_off, Pixmap src, int op);
void XShapeCombineRegion(Display *dpy, Window dest, int dest_kind, int x_off,
                         int y_off, Region region, int op);

#endif /* _X11_EXTENSIONS_SHAPE_H_ */
