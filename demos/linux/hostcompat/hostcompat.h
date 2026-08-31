/* Force-included into every host-tool translation unit on macOS.
 *
 * The Linux interfaces the kernel's host programs call that the macOS SDK
 * does not declare. usr/gen_init_cpio.c uses both.
 */
#ifndef _BADC_HOSTCOMPAT_H
#define _BADC_HOSTCOMPAT_H

#include <errno.h>
#include <fcntl.h>
#include <sys/types.h>
#include <unistd.h>

/* Every macOS off_t is 64-bit, so the request is already satisfied. */
#ifndef O_LARGEFILE
#define O_LARGEFILE 0
#endif

static inline ssize_t
copy_file_range(int fd_in, off_t *off_in, int fd_out, off_t *off_out,
		size_t len, unsigned int flags)
{
	char buf[65536];
	ssize_t done = 0;

	if (flags) {
		errno = EINVAL;
		return -1;
	}
	while ((size_t)done < len) {
		size_t want = len - (size_t)done;
		ssize_t r, w;

		if (want > sizeof(buf))
			want = sizeof(buf);
		r = off_in ? pread(fd_in, buf, want, *off_in + done)
			   : read(fd_in, buf, want);
		if (r < 0)
			return done ? done : -1;
		if (r == 0)
			break;
		w = off_out ? pwrite(fd_out, buf, (size_t)r, *off_out + done)
			    : write(fd_out, buf, (size_t)r);
		if (w < 0)
			return done ? done : -1;
		done += w;
		if (w < r)
			break;
	}
	if (off_in)
		*off_in += done;
	if (off_out)
		*off_out += done;
	return done;
}

#endif

/* objtool reaches <elf.h> through libelf's <gelf.h>, which resolves to
   libelf's own copy; that copy omits the x86 relocation constants the
   tool names. Defining them here reaches every host tool whichever
   <elf.h> wins, without redefining libelf's types. */
#ifndef R_X86_64_NONE
#define R_X86_64_NONE 0
#define R_X86_64_64 1
#define R_X86_64_PC32 2
#define R_X86_64_GOT32 3
#define R_X86_64_PLT32 4
#define R_X86_64_COPY 5
#define R_X86_64_GLOB_DAT 6
#define R_X86_64_JUMP_SLOT 7
#define R_X86_64_RELATIVE 8
#define R_X86_64_GOTPCREL 9
#define R_X86_64_32 10
#define R_X86_64_32S 11
#define R_X86_64_16 12
#define R_X86_64_PC16 13
#define R_X86_64_8 14
#define R_X86_64_PC8 15
#define R_X86_64_PC64 24
#define R_X86_64_REX_GOTPCRELX 42
#endif

/* The kernel's bitfield layout macros; the host tools build for
   little-endian targets, and `struct orc_entry`'s members sit behind
   this name. */
#ifndef __LITTLE_ENDIAN_BITFIELD
#define __LITTLE_ENDIAN_BITFIELD
#endif

/* The tools' <asm-generic/bitops/fls.h> defines `fls` as a macro; the
   SDK declares a function of that name, so the declaration has to be
   seen first or it expands into a conflicting prototype. */
#include <strings.h>

#ifndef R_X86_64_GOTPC32
#define R_X86_64_GOTPC32 26
#endif

/* Linux's sendfile(2) copies between any two descriptors; the macOS one
   sends to a socket and takes a different argument list. The host tools
   use it to copy a file, which a read/write loop does portably. */
#ifndef HOSTCOMPAT_SENDFILE
#define HOSTCOMPAT_SENDFILE
#include <sys/types.h>
#include <unistd.h>
/* The SDK's own declaration has to be parsed before the name becomes a
   macro, or every later include of <sys/socket.h> expands it. */
#include <sys/socket.h>
static inline ssize_t hostcompat_sendfile(int out_fd, int in_fd, off_t *offset,
                                          size_t count)
{
    char buf[65536];
    ssize_t done = 0;
    if (offset != NULL && lseek(in_fd, *offset, SEEK_SET) == (off_t)-1)
        return -1;
    while ((size_t)done < count) {
        size_t want = count - (size_t)done;
        ssize_t n = read(in_fd, buf, want < sizeof(buf) ? want : sizeof(buf));
        if (n < 0)
            return -1;
        if (n == 0)
            break;
        for (ssize_t off = 0; off < n; ) {
            ssize_t w = write(out_fd, buf + off, (size_t)(n - off));
            if (w < 0)
                return -1;
            off += w;
        }
        done += n;
    }
    if (offset != NULL)
        *offset += done;
    return done;
}
#define sendfile(o, i, off, n) hostcompat_sendfile((o), (i), (off), (n))
#endif
