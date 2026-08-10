/* Shadows the SDK header of the same name.
 *
 * The kernel UAPI defines `uuid_t` as a struct and the macOS SDK typedefs it
 * to `unsigned char[16]`, which collides in scripts/mod/file2alias.c. The host
 * build suppresses the SDK typedef with -D_UUID_T; the SDK's own declaration
 * of gethostuuid() is then left without a type, so spell that argument here.
 */
#ifndef __GETHOSTUUID_H
#define __GETHOSTUUID_H

#include <sys/_types/_timespec.h>

int gethostuuid(unsigned char *, const struct timespec *);

#endif
