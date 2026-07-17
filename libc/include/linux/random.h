#pragma once

// linux/random.h -- getrandom() flag bits (the kernel UAPI header that
// CPython reaches for; the same values <sys/random.h> exposes).

#define GRND_NONBLOCK 0x0001
#define GRND_RANDOM   0x0002
#define GRND_INSECURE 0x0004
