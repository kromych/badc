/* Compatibility shim for building the logic harness for a non-Windows
 * host target. badc's bundled msvc_compat.h no-ops the MSVC/SAL
 * decorators only under _WIN32; off Windows the harness supplies the
 * same no-ops itself so the SimpleVisor headers parse. On a Windows
 * host target msvc_compat.h already covers these, so this does nothing. */
#pragma once
#ifdef _WIN32
#include <msvc_compat.h>
#else
#define __declspec(x)
#define __forceinline inline
#define __cdecl
#define _In_
#define _In_opt_
#define _Out_
#define _Out_opt_
#ifndef static_assert
#define static_assert _Static_assert
#endif
#endif
