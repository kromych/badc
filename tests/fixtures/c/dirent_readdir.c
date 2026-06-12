// readdir fills a struct dirent whose d_name must be read at the platform's
// real offset (macOS places it at 21, glibc at 19). Reading "/" returns the
// "." entry every directory has; finding it by name confirms the layout.
// Windows uses a different directory API.

#ifdef _WIN32
int main(void) { return 0; }
#else
#include <dirent.h>
#include <string.h>

int main(void) {
    DIR *d = opendir("/");
    if (!d) return 1;
    struct dirent *e;
    int count = 0, found_dot = 0;
    while ((e = readdir(d)) != NULL) {
        count++;
        if (strcmp(e->d_name, ".") == 0)
            found_dot = 1;
    }
    closedir(d);
    return (count > 2 && found_dot) ? 0 : 2;
}
#endif
