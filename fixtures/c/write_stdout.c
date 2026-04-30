#include <stdlib.h>
#include <unistd.h>

int main() {
    char *msg;
    msg = malloc(4);
    msg[0] = 'h'; msg[1] = 'i'; msg[2] = '\n'; msg[3] = 0;
    write(STDOUT_FILENO, msg, 3);
    return 0;
}
