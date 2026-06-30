/* Demo-local <windowsx.h>. Provides the message-parameter coordinate
 * extraction macros RGFW uses; the underlying types come from <windows.h>. */
#ifndef RGFW_DEMO_WINDOWSX_H
#define RGFW_DEMO_WINDOWSX_H

#include <windows.h>

#define GET_X_LPARAM(lp) ((int)(short)LOWORD(lp))
#define GET_Y_LPARAM(lp) ((int)(short)HIWORD(lp))

#endif /* RGFW_DEMO_WINDOWSX_H */
