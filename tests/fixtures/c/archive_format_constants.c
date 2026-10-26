// <cpio.h> and <tar.h>: the archive formats' magic strings, type flags and
// mode bits, which POSIX fixes and glibc and the SDK define alike, are
// constant expressions of their values.
#define _XOPEN_SOURCE 700
#include <cpio.h>
#include <string.h>
#include <tar.h>

_Static_assert(C_IRUSR == 0400 && C_IWUSR == 0200 && C_IXUSR == 0100, "owner");
_Static_assert(C_IRGRP == 040 && C_IWGRP == 020 && C_IXGRP == 010, "group");
_Static_assert(C_IROTH == 04 && C_IWOTH == 02 && C_IXOTH == 01, "other");
_Static_assert(C_ISUID == 04000 && C_ISGID == 02000 && C_ISVTX == 01000, "special");
_Static_assert(C_ISDIR == 040000 && C_ISFIFO == 010000 && C_ISREG == 0100000, "types");
_Static_assert(C_ISBLK == 060000 && C_ISCHR == 020000 && C_ISCTG == 0110000, "devices");
_Static_assert(C_ISLNK == 0120000 && C_ISSOCK == 0140000, "links");
_Static_assert(sizeof(MAGIC) == 7 && sizeof(TMAGIC) == TMAGLEN, "magic lengths");
_Static_assert(sizeof(TVERSION) - 1 == TVERSLEN, "version length");
_Static_assert(REGTYPE == '0' && AREGTYPE == '\0' && LNKTYPE == '1' && SYMTYPE == '2', "flags");
_Static_assert(CHRTYPE == '3' && BLKTYPE == '4' && DIRTYPE == '5', "device flags");
_Static_assert(FIFOTYPE == '6' && CONTTYPE == '7', "fifo flags");
_Static_assert(TSUID == 04000 && TSGID == 02000 && TSVTX == 01000, "tar special");
_Static_assert(TUREAD == 0400 && TUWRITE == 0200 && TUEXEC == 0100, "tar owner");
_Static_assert(TGREAD == 040 && TGWRITE == 020 && TGEXEC == 010, "tar group");
_Static_assert(TOREAD == 04 && TOWRITE == 02 && TOEXEC == 01, "tar other");

int main(void) {
    // A ustar header's magic field holds TMAGIC with its terminator.
    char header[512] = {0};
    memcpy(header + 257, TMAGIC, TMAGLEN);
    memcpy(header + 263, TVERSION, TVERSLEN);
    header[156] = DIRTYPE;
    if (strcmp(header + 257, "ustar") != 0 || header[263] != '0') return 1;
    return strcmp(MAGIC, "070707") != 0 ? 2 : header[156] != '5';
}
