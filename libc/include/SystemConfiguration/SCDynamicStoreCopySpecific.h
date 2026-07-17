/* Apple SystemConfiguration dynamic-store queries
** (<SystemConfiguration/SCDynamicStoreCopySpecific.h>). Declares the
** subset the bundled demos reach for; the framework supplies the code. */
#pragma once

#ifdef __APPLE__

#include <CoreFoundation/CoreFoundation.h>

typedef struct __SCDynamicStore *SCDynamicStoreRef;

#pragma dylib(systemconfiguration, "/System/Library/Frameworks/SystemConfiguration.framework/SystemConfiguration")
#pragma binding(systemconfiguration::SCDynamicStoreCopyProxies, "_SCDynamicStoreCopyProxies")

CFDictionaryRef SCDynamicStoreCopyProxies(SCDynamicStoreRef store);

#endif
