// macOS getattrlist(2): ATTR_CMN_NAME returns the name through an
// attrreference_t, and FSOPT_NOFOLLOW reports a symbolic link itself
// (/tmp is one) rather than its target. SO_REUSEPORT is a socket-level
// option setsockopt accepts and getsockopt reads back. Other targets have
// neither and run an empty main.
#ifdef __APPLE__
#include <limits.h>
#include <string.h>
#include <sys/attr.h>
#include <sys/socket.h>
#include <unistd.h>

#define VDIR 2
#define VLNK 5

struct reply {
    u_int32_t length;
    attrreference_t name;
    fsobj_type_t type;
    char buf[NAME_MAX * 4 + 1];
};

static int query(const char *path, unsigned int options, struct reply *r) {
    struct attrlist al;
    memset(&al, 0, sizeof al);
    al.bitmapcount = ATTR_BIT_MAP_COUNT;
    al.commonattr = ATTR_CMN_NAME | ATTR_CMN_OBJTYPE;
    return getattrlist(path, &al, r, sizeof *r, options);
}

int main(void) {
    struct reply r;
    int s, one = 1, got = 0;
    socklen_t len = sizeof got;

    if (sizeof(attrreference_t) != 8 || sizeof(struct attrlist) != 24) return 1;
    if (query("/tmp", FSOPT_NOFOLLOW, &r) != 0) return 2;
    if (strcmp((char *)&r.name + r.name.attr_dataoffset, "tmp") != 0) return 3;
    if (r.name.attr_length != 4 || r.type != VLNK) return 4;
    if (query("/tmp", 0, &r) != 0 || r.type != VDIR) return 5;
    s = socket(AF_INET, SOCK_STREAM, 0);
    if (s < 0 || setsockopt(s, SOL_SOCKET, SO_REUSEPORT, &one, sizeof one) != 0) return 6;
    if (getsockopt(s, SOL_SOCKET, SO_REUSEPORT, &got, &len) != 0 || got == 0) return 7;
    close(s);
    return 0;
}
#else
int main(void) { return 0; }
#endif
