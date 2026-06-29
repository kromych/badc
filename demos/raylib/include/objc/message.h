/* objc_msgSend family. Callers cast these to the concrete method
 * signature before invoking, so the declared prototype only needs to
 * name the symbol. On arm64 there is no separate fp-return variant; the
 * struct-return variant takes the result address as its first argument. */
#ifndef _OBJC_MESSAGE_H
#define _OBJC_MESSAGE_H

#include <objc/runtime.h>

id objc_msgSend(id self, SEL op, ...);
void objc_msgSend_stret(void *stret_addr, id self, SEL op, ...);
double objc_msgSend_fpret(id self, SEL op, ...);

#endif /* _OBJC_MESSAGE_H */
