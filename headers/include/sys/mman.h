// sys/mman.h -- memory protection flags.
//
// Just the `PROT_*` bits, which line up across POSIX (used by
// `mprotect`) and Win32 (used as the flags arg to `VirtualProtect`
// once you mask through to PAGE_*). c4 never had `mprotect` as a
// first-class op, so anyone exercising memory protection reaches
// for `dlsym` and these flags.

#pragma once

#define PROT_NONE  0
#define PROT_READ  1
#define PROT_WRITE 2
#define PROT_EXEC  4
