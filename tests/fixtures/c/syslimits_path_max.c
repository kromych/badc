// <sys/syslimits.h> ships as an embedded header (the BSD/macOS spelling
// of the kernel path/identity limits). It pulls PATH_MAX / NAME_MAX from
// <limits.h> and adds the remaining historical constants.
#include <sys/syslimits.h>

int main(void) {
    char path[PATH_MAX];
    return (sizeof(path) >= 1024 && NAME_MAX == 255 && OPEN_MAX > 0) ? 0 : 1;
}
