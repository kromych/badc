// memory.h -- legacy alias for <string.h>.
//
// Predates POSIX's consolidation of mem*/str* under <string.h>. Some
// older code (c4.c included) still pulls memory.h in by name. We
// just forward.

#pragma once
#include <string.h>
