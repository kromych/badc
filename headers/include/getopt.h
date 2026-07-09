// getopt.h -- command-line option parsing (POSIX getopt plus the GNU
// getopt_long extension). `getopt` itself and its per-target binding come
// from <unistd.h>; this header adds the parser's global state variables
// and the long-option interface. The globals are libc data symbols, bound
// through the GOT the same way <unistd.h> binds `environ`.

#pragma once

#include <unistd.h>

#ifdef __APPLE__
#pragma binding(data libc::optarg, "_optarg")
#pragma binding(data libc::optind, "_optind")
#pragma binding(data libc::opterr, "_opterr")
#pragma binding(data libc::optopt, "_optopt")
// BSD/Darwin `optreset`: set to 1 to restart option scanning.
#pragma binding(data libc::optreset, "_optreset")
extern int optreset;
#pragma binding(libc::getopt_long, "_getopt_long")
#pragma binding(libc::getopt_long_only, "_getopt_long_only")
#endif

#ifdef __linux__
#pragma binding(data libc::optarg, "optarg")
#pragma binding(data libc::optind, "optind")
#pragma binding(data libc::opterr, "opterr")
#pragma binding(data libc::optopt, "optopt")
#pragma binding(libc::getopt_long, "getopt_long")
#pragma binding(libc::getopt_long_only, "getopt_long_only")
#endif

extern char *optarg;
extern int optind;
extern int opterr;
extern int optopt;

// `has_arg` values for `struct option`.
#define no_argument 0
#define required_argument 1
#define optional_argument 2

struct option {
    const char *name;
    int has_arg;
    int *flag;
    int val;
};

int getopt_long(int argc, char *const *argv, const char *optstring,
                const struct option *longopts, int *longindex);
int getopt_long_only(int argc, char *const *argv, const char *optstring,
                     const struct option *longopts, int *longindex);
