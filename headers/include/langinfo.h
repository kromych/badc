// langinfo.h -- language information constants (POSIX 7.21). Only the CODESET
// query (the locale's character encoding) is provided; its item number differs
// per target.

#pragma once

typedef int nl_item;

#ifdef __APPLE__
#define CODESET 0
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::nl_langinfo, "_nl_langinfo")
#elif defined(__linux__)
#define CODESET 14
#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::nl_langinfo, "nl_langinfo")
#endif

char *nl_langinfo(nl_item item);

// nl_langinfo item numbers (POSIX 7.21). Per-target values; CODESET above.
#ifndef _DATE_FMT
#if defined(__linux__)
#define _DATE_FMT 131180
#endif
#endif
#ifndef ABDAY_1
#if defined(__APPLE__)
#define ABDAY_1 14
#else
#define ABDAY_1 131072
#endif
#endif
#ifndef ABDAY_2
#if defined(__APPLE__)
#define ABDAY_2 15
#else
#define ABDAY_2 131073
#endif
#endif
#ifndef ABDAY_3
#if defined(__APPLE__)
#define ABDAY_3 16
#else
#define ABDAY_3 131074
#endif
#endif
#ifndef ABDAY_4
#if defined(__APPLE__)
#define ABDAY_4 17
#else
#define ABDAY_4 131075
#endif
#endif
#ifndef ABDAY_5
#if defined(__APPLE__)
#define ABDAY_5 18
#else
#define ABDAY_5 131076
#endif
#endif
#ifndef ABDAY_6
#if defined(__APPLE__)
#define ABDAY_6 19
#else
#define ABDAY_6 131077
#endif
#endif
#ifndef ABDAY_7
#if defined(__APPLE__)
#define ABDAY_7 20
#else
#define ABDAY_7 131078
#endif
#endif
#ifndef ABMON_1
#if defined(__APPLE__)
#define ABMON_1 33
#else
#define ABMON_1 131086
#endif
#endif
#ifndef ABMON_10
#if defined(__APPLE__)
#define ABMON_10 42
#else
#define ABMON_10 131095
#endif
#endif
#ifndef ABMON_11
#if defined(__APPLE__)
#define ABMON_11 43
#else
#define ABMON_11 131096
#endif
#endif
#ifndef ABMON_12
#if defined(__APPLE__)
#define ABMON_12 44
#else
#define ABMON_12 131097
#endif
#endif
#ifndef ABMON_2
#if defined(__APPLE__)
#define ABMON_2 34
#else
#define ABMON_2 131087
#endif
#endif
#ifndef ABMON_3
#if defined(__APPLE__)
#define ABMON_3 35
#else
#define ABMON_3 131088
#endif
#endif
#ifndef ABMON_4
#if defined(__APPLE__)
#define ABMON_4 36
#else
#define ABMON_4 131089
#endif
#endif
#ifndef ABMON_5
#if defined(__APPLE__)
#define ABMON_5 37
#else
#define ABMON_5 131090
#endif
#endif
#ifndef ABMON_6
#if defined(__APPLE__)
#define ABMON_6 38
#else
#define ABMON_6 131091
#endif
#endif
#ifndef ABMON_7
#if defined(__APPLE__)
#define ABMON_7 39
#else
#define ABMON_7 131092
#endif
#endif
#ifndef ABMON_8
#if defined(__APPLE__)
#define ABMON_8 40
#else
#define ABMON_8 131093
#endif
#endif
#ifndef ABMON_9
#if defined(__APPLE__)
#define ABMON_9 41
#else
#define ABMON_9 131094
#endif
#endif
#ifndef ALT_DIGITS
#if defined(__APPLE__)
#define ALT_DIGITS 49
#else
#define ALT_DIGITS 131119
#endif
#endif
#ifndef AM_STR
#if defined(__APPLE__)
#define AM_STR 5
#else
#define AM_STR 131110
#endif
#endif
#ifndef CODESET
#if defined(__APPLE__)
#define CODESET 0
#else
#define CODESET 14
#endif
#endif
#ifndef CRNCYSTR
#if defined(__APPLE__)
#define CRNCYSTR 56
#else
#define CRNCYSTR 262159
#endif
#endif
#ifndef D_FMT
#if defined(__APPLE__)
#define D_FMT 2
#else
#define D_FMT 131113
#endif
#endif
#ifndef D_T_FMT
#if defined(__APPLE__)
#define D_T_FMT 1
#else
#define D_T_FMT 131112
#endif
#endif
#ifndef DAY_1
#if defined(__APPLE__)
#define DAY_1 7
#else
#define DAY_1 131079
#endif
#endif
#ifndef DAY_2
#if defined(__APPLE__)
#define DAY_2 8
#else
#define DAY_2 131080
#endif
#endif
#ifndef DAY_3
#if defined(__APPLE__)
#define DAY_3 9
#else
#define DAY_3 131081
#endif
#endif
#ifndef DAY_4
#if defined(__APPLE__)
#define DAY_4 10
#else
#define DAY_4 131082
#endif
#endif
#ifndef DAY_5
#if defined(__APPLE__)
#define DAY_5 11
#else
#define DAY_5 131083
#endif
#endif
#ifndef DAY_6
#if defined(__APPLE__)
#define DAY_6 12
#else
#define DAY_6 131084
#endif
#endif
#ifndef DAY_7
#if defined(__APPLE__)
#define DAY_7 13
#else
#define DAY_7 131085
#endif
#endif
#ifndef ERA
#if defined(__APPLE__)
#define ERA 45
#else
#define ERA 131116
#endif
#endif
#ifndef ERA_D_FMT
#if defined(__APPLE__)
#define ERA_D_FMT 46
#else
#define ERA_D_FMT 131118
#endif
#endif
#ifndef ERA_D_T_FMT
#if defined(__APPLE__)
#define ERA_D_T_FMT 47
#else
#define ERA_D_T_FMT 131120
#endif
#endif
#ifndef ERA_T_FMT
#if defined(__APPLE__)
#define ERA_T_FMT 48
#else
#define ERA_T_FMT 131121
#endif
#endif
#ifndef MON_1
#if defined(__APPLE__)
#define MON_1 21
#else
#define MON_1 131098
#endif
#endif
#ifndef MON_10
#if defined(__APPLE__)
#define MON_10 30
#else
#define MON_10 131107
#endif
#endif
#ifndef MON_11
#if defined(__APPLE__)
#define MON_11 31
#else
#define MON_11 131108
#endif
#endif
#ifndef MON_12
#if defined(__APPLE__)
#define MON_12 32
#else
#define MON_12 131109
#endif
#endif
#ifndef MON_2
#if defined(__APPLE__)
#define MON_2 22
#else
#define MON_2 131099
#endif
#endif
#ifndef MON_3
#if defined(__APPLE__)
#define MON_3 23
#else
#define MON_3 131100
#endif
#endif
#ifndef MON_4
#if defined(__APPLE__)
#define MON_4 24
#else
#define MON_4 131101
#endif
#endif
#ifndef MON_5
#if defined(__APPLE__)
#define MON_5 25
#else
#define MON_5 131102
#endif
#endif
#ifndef MON_6
#if defined(__APPLE__)
#define MON_6 26
#else
#define MON_6 131103
#endif
#endif
#ifndef MON_7
#if defined(__APPLE__)
#define MON_7 27
#else
#define MON_7 131104
#endif
#endif
#ifndef MON_8
#if defined(__APPLE__)
#define MON_8 28
#else
#define MON_8 131105
#endif
#endif
#ifndef MON_9
#if defined(__APPLE__)
#define MON_9 29
#else
#define MON_9 131106
#endif
#endif
#ifndef NOEXPR
#if defined(__APPLE__)
#define NOEXPR 53
#else
#define NOEXPR 327681
#endif
#endif
#ifndef NOSTR
#if defined(__APPLE__)
#define NOSTR 55
#endif
#endif
#ifndef PM_STR
#if defined(__APPLE__)
#define PM_STR 6
#else
#define PM_STR 131111
#endif
#endif
#ifndef RADIXCHAR
#if defined(__APPLE__)
#define RADIXCHAR 50
#else
#define RADIXCHAR 65536
#endif
#endif
#ifndef T_FMT
#if defined(__APPLE__)
#define T_FMT 3
#else
#define T_FMT 131114
#endif
#endif
#ifndef T_FMT_AMPM
#if defined(__APPLE__)
#define T_FMT_AMPM 4
#else
#define T_FMT_AMPM 131115
#endif
#endif
#ifndef THOUSEP
#if defined(__APPLE__)
#define THOUSEP 51
#else
#define THOUSEP 65537
#endif
#endif
#ifndef YESEXPR
#if defined(__APPLE__)
#define YESEXPR 52
#else
#define YESEXPR 327680
#endif
#endif
#ifndef YESSTR
#if defined(__APPLE__)
#define YESSTR 54
#endif
#endif
