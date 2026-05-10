/* Minimal X11 "Hello, world!" demo for the Linux targets.
 *
 * Opens a 480x240 window, registers for Expose + KeyPress
 * events, draws "Hello from badc!" using XDrawString, and
 * exits when any key is pressed. No XCB, no XKB, no
 * compositing -- just the core libX11.so.6 surface every
 * Linux desktop ships.
 *
 * Build:
 *
 *     badc --target=linux-x64 demos/gui_hello/hello_x11.c -o hello-x11
 *     ./hello-x11        # needs $DISPLAY set
 *
 * libX11's struct shapes (XEvent, XGCValues, XSetWindowAttributes)
 * are big and irregular. We declare just the entry points we
 * call and treat the opaque return values (Display *, Window,
 * GC) as `void *` / `unsigned long`. The event union goes
 * through an opaque buffer big enough to hold the worst-case
 * `XEvent` (~96 bytes per the X.org headers); we read the
 * `type` field at offset 0 to dispatch. */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#pragma dylib(libx11, "libX11.so.6")
#pragma binding(libx11::XOpenDisplay,         "XOpenDisplay")
#pragma binding(libx11::XCloseDisplay,        "XCloseDisplay")
#pragma binding(libx11::XDefaultScreen,       "XDefaultScreen")
#pragma binding(libx11::XRootWindow,          "XRootWindow")
#pragma binding(libx11::XBlackPixel,          "XBlackPixel")
#pragma binding(libx11::XWhitePixel,          "XWhitePixel")
#pragma binding(libx11::XCreateSimpleWindow,  "XCreateSimpleWindow")
#pragma binding(libx11::XSelectInput,         "XSelectInput")
#pragma binding(libx11::XMapWindow,           "XMapWindow")
#pragma binding(libx11::XStoreName,           "XStoreName")
#pragma binding(libx11::XDefaultGC,           "XDefaultGC")
#pragma binding(libx11::XDrawString,          "XDrawString")
#pragma binding(libx11::XNextEvent,           "XNextEvent")
#pragma binding(libx11::XFlush,               "XFlush")

void *        XOpenDisplay(char *name);
int           XCloseDisplay(void *display);
int           XDefaultScreen(void *display);
unsigned long XRootWindow(void *display, int screen);
unsigned long XBlackPixel(void *display, int screen);
unsigned long XWhitePixel(void *display, int screen);
unsigned long XCreateSimpleWindow(
    void *display, unsigned long parent,
    int x, int y, unsigned int w, unsigned int h,
    unsigned int border_width,
    unsigned long border, unsigned long background);
int  XSelectInput(void *display, unsigned long window, long event_mask);
int  XMapWindow(void *display, unsigned long window);
int  XStoreName(void *display, unsigned long window, char *title);
void *XDefaultGC(void *display, int screen);
int  XDrawString(void *display, unsigned long window, void *gc,
                 int x, int y, char *str, int n);
int  XNextEvent(void *display, void *event_buffer);
int  XFlush(void *display);

#define ExposureMask        (1L << 15)
#define KeyPressMask        (1L << 0)
#define StructureNotifyMask (1L << 17)

#define Expose      12
#define KeyPress    2

static char *kHello = "Hello from badc!";
static char *kTitle = "badc X11 hello";

int main(int argc, char **argv) {
    (void)argc; (void)argv;
    void *dpy = XOpenDisplay((char *)0);
    if (!dpy) {
        fprintf(stderr, "XOpenDisplay: cannot connect to $DISPLAY\n");
        return 1;
    }
    int screen = XDefaultScreen(dpy);
    unsigned long root = XRootWindow(dpy, screen);
    unsigned long win = XCreateSimpleWindow(
        dpy, root, 100, 100, 480, 240, 1,
        XBlackPixel(dpy, screen),
        XWhitePixel(dpy, screen));
    XSelectInput(dpy, win, ExposureMask | KeyPressMask | StructureNotifyMask);
    XStoreName(dpy, win, kTitle);
    XMapWindow(dpy, win);
    XFlush(dpy);

    /* XEvent is a union of every X event struct -- the largest
     * member tops out at ~192 bytes per the X.org sources. The
     * `type` field is the first int in every variant, so we
     * read it from offset 0. */
    char event_buf[256];
    while (1) {
        XNextEvent(dpy, event_buf);
        int type = *(int *)event_buf;
        if (type == Expose) {
            void *gc = XDefaultGC(dpy, screen);
            XDrawString(dpy, win, gc, 24, 32, kHello, 16);
        } else if (type == KeyPress) {
            break;
        }
    }
    XCloseDisplay(dpy);
    return 0;
}
