#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

int main() {
    int fd;
    char *buf;
    fd = open("test_dummy.txt", O_RDONLY);
    if (fd < 0) return 1;

    buf = malloc(10);
    read(fd, buf, 9);
    buf[9] = 0;
    close(fd);

    return 0;
}
