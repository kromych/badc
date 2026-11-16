#pragma once

// sys/reboot.h -- reboot or halt the system (Linux).

#ifdef __linux__
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::reboot, "reboot")
#endif

// Command values for the glibc single-argument reboot(2); the SDK's
// RB_AUTOBOOT is 0, the absence of every option flag.
#ifdef __APPLE__
#define RB_AUTOBOOT    0
#else
#define RB_AUTOBOOT    0x01234567
#endif
#define RB_HALT_SYSTEM 0xcdef0123
#define RB_ENABLE_CAD  0x89abcdef
#define RB_DISABLE_CAD 0
#define RB_POWER_OFF   0x4321fedc
#define RB_SW_SUSPEND  0xd000fce2
#define RB_KEXEC       0x45584543

#ifdef __linux__
int reboot(int howto);
#endif
