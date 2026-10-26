// mkstemp creates and opens a file whose name replaces the template's
// trailing XXXXXX, and mkdtemp a directory; ftruncate and truncate set a
// file's length, growing it with zeros; sleep and usleep return 0 after at
// least the time asked. glibc and mingw-w64 refuse a run of fewer than six
// X's with EINVAL, where the BSD functions take any run.

#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

static long size_of(const char *path) {
    int fd = open(path, O_RDONLY);
    long n;
    if (fd < 0)
        return -1;
    n = (long)lseek(fd, 0, SEEK_END);
    close(fd);
    return n;
}

int main(void) {
    const char *tmp = getenv("TMPDIR");
    char file[512], dir[512], inner[600];
    struct timespec t0, t1;
    long long ns;
    FILE *f;
    int fd;
    if (!tmp)
        tmp = getenv("TEMP");
    if (!tmp)
        tmp = "/tmp";
    snprintf(file, sizeof file, "%s/badc_mkstempXXXXXX", tmp);
    snprintf(dir, sizeof dir, "%s/badc_mkdtempXXXXXX", tmp);
    if ((fd = mkstemp(file)) < 0 || strstr(file, "XXXXXX"))
        return 1;
    if (write(fd, "abcdef", 6) != 6)
        return 2;
    if (ftruncate(fd, 2) || lseek(fd, 0, SEEK_END) != 2)
        return 3;
    if (ftruncate(fd, 10) || lseek(fd, 0, SEEK_END) != 10)
        return 4;
    close(fd);
    if (truncate(file, 4) || size_of(file) != 4)
        return 5;
    if (remove(file))
        return 6;
    if (mkdtemp(dir) != dir || strstr(dir, "XXXXXX"))
        return 7;
    snprintf(inner, sizeof inner, "%s/inner", dir);
    if (!(f = fopen(inner, "w")))
        return 8;
    fclose(f);
    if (remove(inner) || rmdir(dir))
        return 9;
#ifndef __APPLE__
    {
        char bad[] = "badc_shortXXXXX";
        errno = 0;
        if (mkstemp(bad) != -1 || errno != EINVAL || strcmp(bad, "badc_shortXXXXX"))
            return 10;
        errno = 0;
        if (mkdtemp(bad) || errno != EINVAL)
            return 11;
    }
#endif
    if (sleep(0) != 0)
        return 12;
    clock_gettime(CLOCK_MONOTONIC, &t0);
    if (usleep(2000) != 0)
        return 13;
    clock_gettime(CLOCK_MONOTONIC, &t1);
    ns = (long long)(t1.tv_sec - t0.tv_sec) * 1000000000LL + (t1.tv_nsec - t0.tv_nsec);
    return ns < 2000000 ? 14 : 0;
}
