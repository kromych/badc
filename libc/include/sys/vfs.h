#pragma once

// sys/vfs.h -- filesystem statistics via statfs(2)/fstatfs(2). glibc
// re-exports <sys/statfs.h> from here. badc keeps `struct statfs` and its
// entry points in <sys/stat.h>, so route to it; the f_type magic numbers
// live in <linux/magic.h>.
#include <sys/stat.h>
