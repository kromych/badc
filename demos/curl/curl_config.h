/* curl_config.h -- hand-written libcurl build configuration for badc.
 *
 * curl normally generates this from configure/CMake against the host libc.
 * badc ships a curated POSIX header surface, so this file is authored to
 * describe exactly what badc backs on macOS (aarch64) and Linux
 * (x86_64/aarch64): HTTP + file:// + WebSocket, threaded resolver, IPv6, no
 * external dependencies. HTTPS is provided by BearSSL when USE_BEARSSL is set
 * on the command line (see the demo smoke). Windows builds do not use this
 * file: curl_setup.h pulls curl's own lib/config-win32.h when HAVE_CONFIG_H is
 * undefined.
 *
 * Selected by -DHAVE_CONFIG_H. The CURL_DISABLE_* protocol trim is passed on
 * the command line (honoured after this include) so the same config header
 * serves every lane.
 */

#ifndef BADC_CURL_CONFIG_H
#define BADC_CURL_CONFIG_H

/* ---- platform identity ---- */
#define CURL_OS "badc"
#define STDC_HEADERS 1
#define HAVE_BOOL_T 1
#define HAVE_LONGLONG 1
#define HAVE_VARIADIC_MACROS_C99 1

/* ---- sizes (LP64 on every POSIX target badc supports) ---- */
#define SIZEOF_INT 4
#define SIZEOF_LONG 8
#define SIZEOF_LONG_LONG 8
#define SIZEOF_SHORT 2
#define SIZEOF_OFF_T 8
#define SIZEOF_CURL_OFF_T 8
#define SIZEOF_SIZE_T 8
#define SIZEOF_TIME_T 8
#define SIZEOF_CURL_SOCKET_T 4

/* ---- headers badc ships ---- */
#define HAVE_SYS_TYPES_H 1
#define HAVE_SYS_SOCKET_H 1
#define HAVE_SYS_SELECT_H 1
#define HAVE_SYS_IOCTL_H 1
#define HAVE_SYS_STAT_H 1
#define HAVE_SYS_TIME_H 1
#define HAVE_SYS_PARAM_H 1
#define HAVE_SYS_UN_H 1
#define HAVE_SYS_RESOURCE_H 1
#define HAVE_NETINET_IN_H 1
#define HAVE_NETINET_TCP_H 1
#define HAVE_NETDB_H 1
#define HAVE_ARPA_INET_H 1
#define HAVE_NET_IF_H 1
#define HAVE_POLL_H 1
#define HAVE_FCNTL_H 1
#define HAVE_UNISTD_H 1
#define HAVE_SIGNAL_H 1
#define HAVE_STRINGS_H 1
#define HAVE_STRING_H 1
#define HAVE_STDBOOL_H 1
#define HAVE_STDINT_H 1
#define HAVE_STDATOMIC_H 1
#define HAVE_LOCALE_H 1
#define HAVE_LIBGEN_H 1
#define HAVE_UTIME_H 1
#define HAVE_PWD_H 1
#define HAVE_DIRENT_H 1
#define HAVE_TERMIOS_H 1

/* ---- functions badc backs ---- */
#define HAVE_SOCKET 1
#define HAVE_SOCKETPAIR 1
#define HAVE_RECV 1
#define HAVE_SEND 1
#define HAVE_SELECT 1
#define HAVE_POLL 1
#define HAVE_POLL_FINE 1
#define HAVE_GETADDRINFO 1
#define HAVE_GETADDRINFO_THREADSAFE 1
#define HAVE_FREEADDRINFO 1
#define HAVE_GETNAMEINFO 1
#define HAVE_GETHOSTNAME 1
#define HAVE_GETPEERNAME 1
#define HAVE_GETSOCKNAME 1
#define HAVE_IF_NAMETOINDEX 1
#define HAVE_INET_NTOP 1
#define HAVE_INET_PTON 1
#define HAVE_FCNTL 1
#define HAVE_FCNTL_O_NONBLOCK 1
#define HAVE_IOCTL 1
#define HAVE_IOCTL_FIONBIO 1
#define HAVE_GETTIMEOFDAY 1
#define HAVE_GMTIME_R 1
#define HAVE_LOCALTIME_R 1
#define HAVE_STRTOK_R 1
#define HAVE_STRDUP 1
#define HAVE_STRCASECMP 1
#define HAVE_STRNCASECMP 1
#define HAVE_SIGNAL 1
#define HAVE_SIGACTION 1
#define HAVE_SIGSETJMP 1
#define HAVE_SIGINTERRUPT 1
#define HAVE_ALARM 1
#define HAVE_FTRUNCATE 1
#define HAVE_UTIME 1
#define HAVE_UTIMES 1
#define HAVE_GETPPID 1
#define HAVE_GETEUID 1
#define HAVE_GETPWUID 1
#define HAVE_GETRLIMIT 1
#define HAVE_SETRLIMIT 1
#define HAVE_PIPE 1
#define HAVE_SNPRINTF 1
#define HAVE_BASENAME 1
#define HAVE_FSEEKO 1
#define HAVE_STRTOLL 1
#define HAVE_SETLOCALE 1

/* ---- structs / types ---- */
#define HAVE_STRUCT_SOCKADDR_STORAGE 1
#define HAVE_STRUCT_TIMEVAL 1
#define HAVE_SA_FAMILY_T 1
#define HAVE_SOCKADDR_IN6_SIN6_SCOPE_ID 1
#define HAVE_SUSECONDS_T 1

/* ---- features ---- */
#define USE_THREADS_POSIX 1
#define HAVE_PTHREAD_H 1
#define USE_UNIX_SOCKETS 1
#define USE_IPV6 1
#define ENABLE_IPV6 1

/* ---- per-OS deltas ---- */
#ifdef __linux__
#define HAVE_MSG_NOSIGNAL 1
#define HAVE_CLOCK_GETTIME_MONOTONIC 1
#define HAVE_CLOCK_GETTIME_MONOTONIC_RAW 1
#define GETHOSTNAME_TYPE_ARG2 size_t
#endif

#ifdef __APPLE__
#define HAVE_MACH_ABSOLUTE_TIME 1
#define HAVE_SO_NOSIGPIPE 1
#define GETHOSTNAME_TYPE_ARG2 size_t
#endif

/* The RETSIGTYPE / signal-handler return type. */
#define RETSIGTYPE void

/* CURL_DISABLE_* for the trimmed protocol set and USE_*SSL are passed on the
 * command line so this header stays platform-only. */

#endif /* BADC_CURL_CONFIG_H */
