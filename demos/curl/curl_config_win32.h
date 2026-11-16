/* curl_config_win32.h -- libcurl build configuration for badc on Windows.
 *
 * curl's own lib/config-win32.h serves MSVC 2010-2013 only. This file states
 * the values curl's CMake build takes for mingw-w64 from
 * CMake/win32-cache.cmake, which badc's Windows headers and import bindings
 * back, for the 64-bit targets badc supports, with the features curl_config.h
 * enables on POSIX: the threaded resolver, IPv6 and Unix sockets.
 *
 * curl_config.h includes it on _WIN32. The CURL_DISABLE_* protocol trim and
 * USE_*TLS are passed on the command line.
 */

#ifndef BADC_CURL_CONFIG_WIN32_H
#define BADC_CURL_CONFIG_WIN32_H

#define CURL_OS "badc-windows"

/* ---- headers ---- */
#define HAVE_FCNTL_H 1
#define HAVE_IO_H 1
#define HAVE_LIBGEN_H 1
#define HAVE_LOCALE_H 1
#define HAVE_STDATOMIC_H 1
#define HAVE_STDBOOL_H 1
#define HAVE_STDINT_H 1
#define HAVE_STRINGS_H 1
#define HAVE_SYS_PARAM_H 1
#define HAVE_SYS_TYPES_H 1
#define HAVE_SYS_UTIME_H 1
#define HAVE_UNISTD_H 1
#define HAVE_UTIME_H 1

/* ---- functions ---- */
#define HAVE_BASENAME 1
#define HAVE_CLOSESOCKET 1
#define HAVE_FREEADDRINFO 1
#define HAVE_GETADDRINFO 1
#define HAVE_GETADDRINFO_THREADSAFE 1
#define HAVE_GETHOSTNAME 1
#define HAVE_GETPEERNAME 1
#define HAVE_GETSOCKNAME 1
#define HAVE_IOCTLSOCKET 1
#define HAVE_IOCTLSOCKET_FIONBIO 1
#define HAVE_RECV 1
#define HAVE_SEND 1
#define HAVE_SETLOCALE 1
#define HAVE_SIGNAL 1
#define HAVE_SOCKET 1
#define HAVE_UTIME 1

/* ---- types and sizes (LLP64) ---- */
#define HAVE_BOOL_T 1
#define HAVE_SOCKADDR_IN6_SIN6_SCOPE_ID 1
#define HAVE_STRUCT_SOCKADDR_STORAGE 1
#define HAVE_STRUCT_TIMEVAL 1
#define SIZEOF_INT 4
#define SIZEOF_LONG 4
#define SIZEOF_SIZE_T 8
#define SIZEOF_SSIZE_T 8
#define SIZEOF_CURL_OFF_T 8
#define SIZEOF_CURL_SOCKET_T 8
#define SIZEOF_OFF_T 8
#define SIZEOF_TIME_T 8
#define _FILE_OFFSET_BITS 64

/* ---- features ---- */
#define USE_RESOLV_THREADED 1
#define USE_IPV6 1
#define USE_UNIX_SOCKETS 1
#define USE_WIN32_CRYPTO 1

#endif /* BADC_CURL_CONFIG_WIN32_H */
