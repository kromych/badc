/* Minimal desktop GL 1.1 declarations. In the raylib build GLAD is
 * included first and defines __gl_h_, so this body is skipped and GLAD's
 * declarations are used; this header only contributes when RGFW is
 * compiled without GLAD. */
#ifndef __gl_h_
#define __gl_h_ 1

#include <stdint.h>

typedef unsigned int GLenum;
typedef unsigned char GLboolean;
typedef unsigned int GLbitfield;
typedef void GLvoid;
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

#define GL_COLOR_BUFFER_BIT 0x00004000
#define GL_DEPTH_BUFFER_BIT 0x00000100
#define GL_TEXTURE_2D 0x0DE1
#define GL_RGBA 0x1908
#define GL_UNSIGNED_BYTE 0x1401
#define GL_TRIANGLES 0x0004
#define GL_QUADS 0x0007

void glViewport(GLint x, GLint y, GLsizei width, GLsizei height);
void glClear(GLbitfield mask);
void glClearColor(GLclampf r, GLclampf g, GLclampf b, GLclampf a);
void glEnable(GLenum cap);
void glDisable(GLenum cap);
void glBindTexture(GLenum target, GLuint texture);
void glGenTextures(GLsizei n, GLuint *textures);
void glDeleteTextures(GLsizei n, const GLuint *textures);
void glTexParameteri(GLenum target, GLenum pname, GLint param);
void glTexImage2D(GLenum target, GLint level, GLint internalformat,
                  GLsizei width, GLsizei height, GLint border, GLenum format,
                  GLenum type, const GLvoid *pixels);
void glFlush(void);
void glFinish(void);

#endif /* __gl_h_ */
