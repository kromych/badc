// tchar.h -- generic-text routine mappings. c5 reaches for the ANSI (narrow)
// C runtime, so the _tcs* names resolve to the str* functions unless the
// program opts into UNICODE, where they would map to the wide wcs* forms.

#pragma once

#include <string.h>

#ifdef UNICODE
#include <wchar.h>
#define _tcscpy   wcscpy
#define _tcslen   wcslen
#define _tcscmp   wcscmp
#define _tcschr   wcschr
#define _tcsstr   wcsstr
#define _tcspbrk  wcspbrk
#else
#define _tcscpy   strcpy
#define _tcsncpy  strncpy
#define _tcscat   strcat
#define _tcslen   strlen
#define _tcscmp   strcmp
#define _tcsicmp  _stricmp
#define _tcschr   strchr
#define _tcsrchr  strrchr
#define _tcsstr   strstr
#define _tcspbrk  strpbrk
#define _tcstol   strtol
#endif
