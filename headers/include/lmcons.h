// lmcons.h -- LAN Manager name-length limits (character counts,
// excluding the terminator).

#pragma once

#ifdef _WIN32
#define CNLEN 15
#define DNLEN CNLEN
#define UNLEN 256
#define GNLEN UNLEN
#define PWLEN 256
#endif
