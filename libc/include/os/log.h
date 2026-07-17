// os/log.h -- unified logging. The SDK macro compiles the format via
// __builtin_os_log_format; badc routes through _os_log_internal, the
// exported variadic entry point older deployment targets use. Its
// first argument must be an address inside the calling image (sender
// attribution); a NULL faults in libtrace, so each including unit
// carries a static anchor byte.

#pragma once

#ifdef __APPLE__
#include <stdint.h>

typedef struct os_log_s *os_log_t;
typedef uint8_t os_log_type_t;

#define OS_LOG_TYPE_DEFAULT 0x00
#define OS_LOG_TYPE_INFO 0x01
#define OS_LOG_TYPE_DEBUG 0x02
#define OS_LOG_TYPE_ERROR 0x10
#define OS_LOG_TYPE_FAULT 0x11

#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::os_log_create, "_os_log_create")
#pragma binding(libc::_os_log_internal, "__os_log_internal")
#pragma binding(data libc::_os_log_default, "__os_log_default")

extern struct os_log_s _os_log_default;
#define OS_LOG_DEFAULT (&_os_log_default)

os_log_t os_log_create(const char *subsystem, const char *category);
void _os_log_internal(void *dso, os_log_t log, os_log_type_t type, const char *message, ...);

static char __badc_os_log_anchor;

#define os_log_with_type(log, type, ...) \
    _os_log_internal(&__badc_os_log_anchor, (log), (type), __VA_ARGS__)
#define os_log(log, ...) os_log_with_type((log), OS_LOG_TYPE_DEFAULT, __VA_ARGS__)
#define os_log_info(log, ...) os_log_with_type((log), OS_LOG_TYPE_INFO, __VA_ARGS__)
#define os_log_debug(log, ...) os_log_with_type((log), OS_LOG_TYPE_DEBUG, __VA_ARGS__)
#define os_log_error(log, ...) os_log_with_type((log), OS_LOG_TYPE_ERROR, __VA_ARGS__)
#define os_log_fault(log, ...) os_log_with_type((log), OS_LOG_TYPE_FAULT, __VA_ARGS__)
#endif
