/* OS version-availability annotations. On a real SDK these expand to
 * __attribute__((availability(...))); for a from-scratch C build they
 * carry no semantics and expand to nothing. */
#ifndef _OS_AVAILABILITY_H
#define _OS_AVAILABILITY_H

#define API_AVAILABLE(...)
#define API_UNAVAILABLE(...)
#define API_DEPRECATED(...)
#define API_DEPRECATED_WITH_REPLACEMENT(...)
#define __API_AVAILABLE(...)
#define __API_UNAVAILABLE(...)
#define __API_DEPRECATED(...)
#define __API_DEPRECATED_WITH_REPLACEMENT(...)
#define NS_AVAILABLE(...)
#define NS_DEPRECATED(...)
#define NS_ENUM_AVAILABLE(...)

#endif /* _OS_AVAILABILITY_H */
