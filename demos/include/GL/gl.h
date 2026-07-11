/* Demo-local <GL/gl.h>. With GRAPHICS_API_OPENGL_33 the GL types and
 * entry points come from the bundled glad.h, which sets __gl_h_ before
 * this header is reached; this file is then a no-op. It only defines the
 * base GL types for a translation unit that includes <GL/gl.h> without
 * glad (none in this demo, but RGFW includes it unconditionally). */
#ifndef __gl_h_
#define __gl_h_ 1

typedef unsigned int GLenum;
typedef unsigned char GLboolean;
typedef unsigned int GLbitfield;
typedef signed char GLbyte;
typedef short GLshort;
typedef int GLint;
typedef int GLsizei;
typedef unsigned char GLubyte;
typedef unsigned short GLushort;
typedef unsigned int GLuint;
typedef float GLfloat;
typedef float GLclampf;
typedef double GLdouble;
typedef void GLvoid;
typedef char GLchar;

#endif /* __gl_h_ */
