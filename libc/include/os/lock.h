/* Apple <os/lock.h>: the os_unfair_lock primitive. Opaque one-word
** lock; libSystem provides the operations. */
#pragma once

#ifdef __APPLE__

typedef struct os_unfair_lock_s {
    unsigned int _os_unfair_lock_opaque;
} os_unfair_lock, *os_unfair_lock_t;

#define OS_UNFAIR_LOCK_INIT \
    ((os_unfair_lock){0})

#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::os_unfair_lock_lock,    "_os_unfair_lock_lock")
#pragma binding(libc::os_unfair_lock_unlock,  "_os_unfair_lock_unlock")
#pragma binding(libc::os_unfair_lock_trylock, "_os_unfair_lock_trylock")

void os_unfair_lock_lock(os_unfair_lock_t lock);
void os_unfair_lock_unlock(os_unfair_lock_t lock);
int os_unfair_lock_trylock(os_unfair_lock_t lock);

#endif
