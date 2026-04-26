int main() {
    int fd;
    char *buf;
    fd = open("test_dummy.txt", 0);
    if (fd < 0) return 1;

    buf = malloc(10);
    read(fd, buf, 9);
    buf[9] = 0;
    close(fd);

    return 0;
}
