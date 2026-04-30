// badc target umbrella: linux-x64.
//
// Auto-prepended to every source the compiler sees so legacy
// fixtures (no `#include` lines) still get the libc surface bound.
// New code should `#include` only what it uses.

#pragma once

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <dlfcn.h>
