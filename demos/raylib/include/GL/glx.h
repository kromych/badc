/* Minimal GLX surface for the RGFW desktop backend (demo-local embedded
 * header). Declares the opaque GLX handles, the framebuffer-config and
 * context-attribute tokens RGFW passes to glXChooseFBConfig /
 * glXCreateContextAttribsARB, and the directly-linked glX entry points.
 * The ARB / EXT entry points are loaded at runtime via glXGetProcAddress,
 * so only their function-pointer typedefs appear here. */
#ifndef _GL_GLX_H_
#define _GL_GLX_H_

#include <X11/Xlib.h>

typedef struct __GLXcontextRec *GLXContext;
typedef struct __GLXFBConfigRec *GLXFBConfig;
typedef XID GLXDrawable;
typedef void (*__GLXextFuncPtr)(void);
typedef void (*PFNGLXSWAPINTERVALEXTPROC)(Display *dpy, GLXDrawable drawable,
                                          int interval);

#define GLX_DOUBLEBUFFER 5
#define GLX_STEREO 6
#define GLX_AUX_BUFFERS 7
#define GLX_RED_SIZE 8
#define GLX_GREEN_SIZE 9
#define GLX_BLUE_SIZE 10
#define GLX_ALPHA_SIZE 11
#define GLX_DEPTH_SIZE 12
#define GLX_STENCIL_SIZE 13
#define GLX_X_VISUAL_TYPE 0x22
#define GLX_TRUE_COLOR 0x8002
#define GLX_SAMPLE_BUFFERS 100000
#define GLX_SAMPLES 100001
#define GLX_DRAWABLE_TYPE 0x8010
#define GLX_RENDER_TYPE 0x8011
#define GLX_X_RENDERABLE 0x8012
#define GLX_RGBA_BIT 0x00000001
#define GLX_WINDOW_BIT 0x00000001
#define GLX_CONTEXT_MAJOR_VERSION_ARB 0x2091
#define GLX_CONTEXT_MINOR_VERSION_ARB 0x2092
#define GLX_CONTEXT_PROFILE_MASK_ARB 0x9126
#define GLX_CONTEXT_CORE_PROFILE_BIT_ARB 0x00000001
#define GLX_CONTEXT_COMPATIBILITY_PROFILE_BIT_ARB 0x00000002

GLXFBConfig *glXChooseFBConfig(Display *dpy, int screen, const int *attribList,
                               int *nitems);
int glXGetFBConfigAttrib(Display *dpy, GLXFBConfig config, int attribute,
                         int *value);
XVisualInfo *glXGetVisualFromFBConfig(Display *dpy, GLXFBConfig config);
void glXDestroyContext(Display *dpy, GLXContext ctx);
Bool glXMakeCurrent(Display *dpy, GLXDrawable drawable, GLXContext ctx);
void glXSwapBuffers(Display *dpy, GLXDrawable drawable);
__GLXextFuncPtr glXGetProcAddress(const unsigned char *procName);
__GLXextFuncPtr glXGetProcAddressARB(const unsigned char *procName);

#endif /* _GL_GLX_H_ */
