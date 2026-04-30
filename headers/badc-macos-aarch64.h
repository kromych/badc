// badc target umbrella: macos-aarch64.
//
// Auto-prepended to every source the compiler sees so legacy
// fixtures (no `#include` lines) still get the libc surface bound.
// New code should `#include` only what it uses; this umbrella will
// go away once the fixture sweep lands.

#pragma once

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <dlfcn.h>
