/* Windows CNG (<bcrypt.h>). The bound surface lives in the bundled
** <windows.h>; this header resolves the SDK's include split. */
#pragma once
#ifdef _WIN32
#include <windows.h>
#endif
