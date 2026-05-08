/*
** Bisection probe: minimal "hello world" with the same -include /
** -D set as the regular smoke. No sqlite, no shell, no fprintf --
** just a raw `write(2, "...", n)` so a successful run produces
** stderr output and exits 0. If THIS exits 127 on the Windows
** lane, the failure is in the entry stub / loader path itself,
** not sqlite-imports-related.
*/
#include <unistd.h>

int main(int argc, char **argv) {
    write(2, "hello-stderr\n", 13);
    return 0;
}
