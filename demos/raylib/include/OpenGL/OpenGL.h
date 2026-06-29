/* CGL (Core OpenGL) surface used by RGFW on macOS. RGFW references one
 * renderer-id constant when requesting a software renderer; the opaque
 * CGL object types round out the minimal surface. */
#ifndef _CGL_OPENGL_H
#define _CGL_OPENGL_H

typedef struct _CGLContextObject *CGLContextObj;
typedef struct _CGLPixelFormatObject *CGLPixelFormatObj;
typedef struct _CGLRendererInfoObject *CGLRendererInfoObj;

/* From CGLRenderers.h: the generic floating-point software renderer. */
#define kCGLRendererGenericFloatID 0x00020400

CGLContextObj CGLGetCurrentContext(void);

#endif /* _CGL_OPENGL_H */
