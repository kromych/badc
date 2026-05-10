#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>

int main() {
    // Each pair of these is the same integer; the names just resolve
    // through the predefined symbol table.
    if (PROT_NONE  != 0) return 1;
    if (PROT_READ  != 1) return 2;
    if (PROT_WRITE != 2) return 3;
    if (PROT_EXEC  != 4) return 4;
    if (O_RDONLY   != 0) return 5;
    if (O_WRONLY   != 1) return 6;
    if (O_RDWR     != 2) return 7;
    if (STDIN_FILENO  != 0) return 8;
    if (STDOUT_FILENO != 1) return 9;
    if (STDERR_FILENO != 2) return 10;
    if (NULL          != 0) return 11;
    if (EXIT_SUCCESS  != 0) return 12;
    if (EXIT_FAILURE  != 1) return 13;
    return 0;
}
