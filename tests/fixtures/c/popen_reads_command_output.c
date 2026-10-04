// popen runs a command through the shell and reads its output as a stream;
// pclose waits for it and returns its status (POSIX). On Windows the names
// reach the C runtime's _popen and _pclose, as mingw-w64's do. The exit
// code names the first check that fails.
#include <stdio.h>
#include <string.h>

int main(void) {
    char line[64];
    size_t n;
    FILE *p = popen("echo piped", "r");
    if (!p)
        return 1;
    if (!fgets(line, sizeof line, p))
        return 2;
    n = strlen(line);
    while (n && (line[n - 1] == '\n' || line[n - 1] == '\r' || line[n - 1] == ' '))
        line[--n] = 0;
    if (strcmp(line, "piped") != 0)
        return 3;
    if (pclose(p) != 0)
        return 4;
    return 0;
}
