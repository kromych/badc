// POSIX / BSD `sig_t`: the signal-handler type, `void (*)(int)`,
// usable as the second argument to and return value of `signal()`.
// Exercised as a type (assignment and comparison) without requiring
// signal delivery.

#include <signal.h>

static void handler(int sig) {
    (void)sig;
}

int main(void) {
    sig_t f = handler;
    sig_t d = SIG_DFL;
    if (f != handler) return 1;
    if (d != SIG_DFL) return 2;
    return 0;
}
