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
