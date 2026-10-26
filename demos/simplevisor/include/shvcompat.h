/* MSVC/SAL spellings the SimpleVisor sources use that are not codegen
 * directives. Passed with -include so they are visible before the first
 * source line, mirroring the edk2 demo's -Dstatic_assert mapping.
 *
 *   __analysis_assume(e)  static-analysis hint, no runtime effect
 *   static_assert         C11 keyword is _Static_assert in C99 mode */
#pragma once
#define __analysis_assume(e) ((void)0)
#ifndef static_assert
#define static_assert _Static_assert
#endif
