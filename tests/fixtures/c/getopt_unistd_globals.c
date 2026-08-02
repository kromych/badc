// Regression: POSIX.1 requires <unistd.h> to declare the getopt parser state
// -- optarg, optind, opterr, optopt -- alongside getopt() itself. Declaring
// them only in <getopt.h> makes portable option-parsing code that includes
// just <unistd.h> fail with an undefined-variable error on `optind = 1`.

#include <unistd.h>

static char *argv0[] = {"prog", 0};

int main(void) {
    // Resetting the scan before a fresh getopt loop is the common use.
    optind = 1;
    opterr = 0;
    if (optarg != 0) return 1;
    if (optopt != 0) return 2;
    // Exercise the declaration against the bound libc entry point.
    if (getopt(1, argv0, "a") != -1) return 3;
    return 0;
}
