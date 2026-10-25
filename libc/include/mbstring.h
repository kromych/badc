// mbstring.h -- the C runtime's multibyte-character string functions, as
// mingw-w64's mbstring.h and sec_api/mbstring_s.h declare them for
// msvcrt.dll, which exports each on both Windows targets. Under a
// double-byte code page (_setmbcp, <mbctype.h>) they step, count and
// compare by characters; the _mbsnb* forms count bytes.

#pragma once

#ifdef _WIN32

#include <corecrt.h>
#include <stddef.h>

#pragma dylib(msvcrt, "msvcrt.dll")

#ifndef _MBSTRING_DEFINED
#define _MBSTRING_DEFINED
#pragma binding(msvcrt::_mbsdup, "_mbsdup")
unsigned char *_mbsdup(const unsigned char *_Str);
#pragma binding(msvcrt::_mbbtombc, "_mbbtombc")
unsigned int _mbbtombc(unsigned int _Ch);
#pragma binding(msvcrt::_mbbtombc_l, "_mbbtombc_l")
unsigned int _mbbtombc_l(unsigned int _Ch, _locale_t _Locale);
#pragma binding(msvcrt::_mbbtype, "_mbbtype")
int _mbbtype(unsigned char _Ch, int _CType);
#pragma binding(msvcrt::_mbctombb, "_mbctombb")
unsigned int _mbctombb(unsigned int _Ch);
#pragma binding(msvcrt::_mbctombb_l, "_mbctombb_l")
unsigned int _mbctombb_l(unsigned int _Ch, _locale_t _Locale);
#pragma binding(msvcrt::_mbsbtype, "_mbsbtype")
int _mbsbtype(const unsigned char *_Str, size_t _Pos);
#pragma binding(msvcrt::_mbsbtype_l, "_mbsbtype_l")
int _mbsbtype_l(const unsigned char *_Str, size_t _Pos, _locale_t _Locale);
#pragma binding(msvcrt::_mbscat, "_mbscat")
unsigned char *_mbscat(unsigned char *_Dest, const unsigned char *_Source);
#pragma binding(msvcrt::_mbschr, "_mbschr")
unsigned char *_mbschr(const unsigned char *_Str, unsigned int _Ch);
#pragma binding(msvcrt::_mbschr_l, "_mbschr_l")
unsigned char *_mbschr_l(const unsigned char *_Str, unsigned int _Ch, _locale_t _Locale);
#pragma binding(msvcrt::_mbscmp, "_mbscmp")
int _mbscmp(const unsigned char *_Str1, const unsigned char *_Str2);
#pragma binding(msvcrt::_mbscmp_l, "_mbscmp_l")
int _mbscmp_l(const unsigned char *_Str1, const unsigned char *_Str2, _locale_t _Locale);
#pragma binding(msvcrt::_mbscoll, "_mbscoll")
int _mbscoll(const unsigned char *_Str1, const unsigned char *_Str2);
#pragma binding(msvcrt::_mbscoll_l, "_mbscoll_l")
int _mbscoll_l(const unsigned char *_Str1, const unsigned char *_Str2, _locale_t _Locale);
#pragma binding(msvcrt::_mbscpy, "_mbscpy")
unsigned char *_mbscpy(unsigned char *_Dest, const unsigned char *_Source);
#pragma binding(msvcrt::_mbscspn, "_mbscspn")
size_t _mbscspn(const unsigned char *_Str, const unsigned char *_Control);
#pragma binding(msvcrt::_mbscspn_l, "_mbscspn_l")
size_t _mbscspn_l(const unsigned char *_Str, const unsigned char *_Control, _locale_t _Locale);
#pragma binding(msvcrt::_mbsdec, "_mbsdec")
unsigned char *_mbsdec(const unsigned char *_Start, const unsigned char *_Pos);
#pragma binding(msvcrt::_mbsdec_l, "_mbsdec_l")
unsigned char *_mbsdec_l(const unsigned char *_Start, const unsigned char *_Pos, _locale_t _Locale);
#pragma binding(msvcrt::_mbsicmp, "_mbsicmp")
int _mbsicmp(const unsigned char *_Str1, const unsigned char *_Str2);
#pragma binding(msvcrt::_mbsicmp_l, "_mbsicmp_l")
int _mbsicmp_l(const unsigned char *_Str1, const unsigned char *_Str2, _locale_t _Locale);
#pragma binding(msvcrt::_mbsicoll, "_mbsicoll")
int _mbsicoll(const unsigned char *_Str1, const unsigned char *_Str2);
#pragma binding(msvcrt::_mbsicoll_l, "_mbsicoll_l")
int _mbsicoll_l(const unsigned char *_Str1, const unsigned char *_Str2, _locale_t _Locale);
#pragma binding(msvcrt::_mbsinc, "_mbsinc")
unsigned char *_mbsinc(const unsigned char *_Ptr);
#pragma binding(msvcrt::_mbsinc_l, "_mbsinc_l")
unsigned char *_mbsinc_l(const unsigned char *_Ptr, _locale_t _Locale);
#pragma binding(msvcrt::_mbslen, "_mbslen")
size_t _mbslen(const unsigned char *_Str);
#pragma binding(msvcrt::_mbslen_l, "_mbslen_l")
size_t _mbslen_l(const unsigned char *_Str, _locale_t _Locale);
// mingw-w64 declares _mbsnlen for msvcr80 and later, and maps tchar.h's
// _tcscnlen to it under _MBCS; msvcrt.dll exports it on both targets.
#pragma binding(msvcrt::_mbsnlen, "_mbsnlen")
size_t _mbsnlen(const unsigned char *_Str, size_t _MaxCount);
#pragma binding(msvcrt::_mbsnlen_l, "_mbsnlen_l")
size_t _mbsnlen_l(const unsigned char *_Str, size_t _MaxCount, _locale_t _Locale);
#pragma binding(msvcrt::_mbslwr, "_mbslwr")
unsigned char *_mbslwr(unsigned char *_String);
#pragma binding(msvcrt::_mbslwr_l, "_mbslwr_l")
unsigned char *_mbslwr_l(unsigned char *_String, _locale_t _Locale);
#pragma binding(msvcrt::_mbsnbcat, "_mbsnbcat")
unsigned char *_mbsnbcat(unsigned char *_Dest, const unsigned char *_Source, size_t _Count);
#pragma binding(msvcrt::_mbsnbcat_l, "_mbsnbcat_l")
unsigned char *_mbsnbcat_l(unsigned char *_Dest, const unsigned char *_Source, size_t _Count, _locale_t _Locale);
#pragma binding(msvcrt::_mbsnbcmp, "_mbsnbcmp")
int _mbsnbcmp(const unsigned char *_Str1, const unsigned char *_Str2, size_t _MaxCount);
#pragma binding(msvcrt::_mbsnbcmp_l, "_mbsnbcmp_l")
int _mbsnbcmp_l(const unsigned char *_Str1, const unsigned char *_Str2, size_t _MaxCount, _locale_t _Locale);
#pragma binding(msvcrt::_mbsnbcoll, "_mbsnbcoll")
int _mbsnbcoll(const unsigned char *_Str1, const unsigned char *_Str2, size_t _MaxCount);
#pragma binding(msvcrt::_mbsnbcoll_l, "_mbsnbcoll_l")
int _mbsnbcoll_l(const unsigned char *_Str1, const unsigned char *_Str2, size_t _MaxCount, _locale_t _Locale);
#pragma binding(msvcrt::_mbsnbcnt, "_mbsnbcnt")
size_t _mbsnbcnt(const unsigned char *_Str, size_t _MaxCount);
#pragma binding(msvcrt::_mbsnbcnt_l, "_mbsnbcnt_l")
size_t _mbsnbcnt_l(const unsigned char *_Str, size_t _MaxCount, _locale_t _Locale);
#pragma binding(msvcrt::_mbsnbcpy, "_mbsnbcpy")
unsigned char *_mbsnbcpy(unsigned char *_Dest, const unsigned char *_Source, size_t _Count);
#pragma binding(msvcrt::_mbsnbcpy_l, "_mbsnbcpy_l")
unsigned char *_mbsnbcpy_l(unsigned char *_Dest, const unsigned char *_Source, size_t _Count, _locale_t _Locale);
#pragma binding(msvcrt::_mbsnbicmp, "_mbsnbicmp")
int _mbsnbicmp(const unsigned char *_Str1, const unsigned char *_Str2, size_t _MaxCount);
#pragma binding(msvcrt::_mbsnbicmp_l, "_mbsnbicmp_l")
int _mbsnbicmp_l(const unsigned char *_Str1, const unsigned char *_Str2, size_t _MaxCount, _locale_t _Locale);
#pragma binding(msvcrt::_mbsnbicoll, "_mbsnbicoll")
int _mbsnbicoll(const unsigned char *_Str1, const unsigned char *_Str2, size_t _MaxCount);
#pragma binding(msvcrt::_mbsnbicoll_l, "_mbsnbicoll_l")
int _mbsnbicoll_l(const unsigned char *_Str1, const unsigned char *_Str2, size_t _MaxCount, _locale_t _Locale);
#pragma binding(msvcrt::_mbsnbset, "_mbsnbset")
unsigned char *_mbsnbset(unsigned char *_Str, unsigned int _Ch, size_t _MaxCount);
#pragma binding(msvcrt::_mbsnbset_l, "_mbsnbset_l")
unsigned char *_mbsnbset_l(unsigned char *_Str, unsigned int _Ch, size_t _MaxCount, _locale_t _Locale);
#pragma binding(msvcrt::_mbsncat, "_mbsncat")
unsigned char *_mbsncat(unsigned char *_Dest, const unsigned char *_Source, size_t _Count);
#pragma binding(msvcrt::_mbsncat_l, "_mbsncat_l")
unsigned char *_mbsncat_l(unsigned char *_Dest, const unsigned char *_Source, size_t _Count, _locale_t _Locale);
#pragma binding(msvcrt::_mbsnccnt, "_mbsnccnt")
size_t _mbsnccnt(const unsigned char *_Str, size_t _MaxCount);
#pragma binding(msvcrt::_mbsnccnt_l, "_mbsnccnt_l")
size_t _mbsnccnt_l(const unsigned char *_Str, size_t _MaxCount, _locale_t _Locale);
#pragma binding(msvcrt::_mbsncmp, "_mbsncmp")
int _mbsncmp(const unsigned char *_Str1, const unsigned char *_Str2, size_t _MaxCount);
#pragma binding(msvcrt::_mbsncmp_l, "_mbsncmp_l")
int _mbsncmp_l(const unsigned char *_Str1, const unsigned char *_Str2, size_t _MaxCount, _locale_t _Locale);
#pragma binding(msvcrt::_mbsncoll, "_mbsncoll")
int _mbsncoll(const unsigned char *_Str1, const unsigned char *_Str2, size_t _MaxCount);
#pragma binding(msvcrt::_mbsncoll_l, "_mbsncoll_l")
int _mbsncoll_l(const unsigned char *_Str1, const unsigned char *_Str2, size_t _MaxCount, _locale_t _Locale);
#pragma binding(msvcrt::_mbsncpy, "_mbsncpy")
unsigned char *_mbsncpy(unsigned char *_Dest, const unsigned char *_Source, size_t _Count);
#pragma binding(msvcrt::_mbsncpy_l, "_mbsncpy_l")
unsigned char *_mbsncpy_l(unsigned char *_Dest, const unsigned char *_Source, size_t _Count, _locale_t _Locale);
#pragma binding(msvcrt::_mbsnextc, "_mbsnextc")
unsigned int _mbsnextc(const unsigned char *_Str);
#pragma binding(msvcrt::_mbsnextc_l, "_mbsnextc_l")
unsigned int _mbsnextc_l(const unsigned char *_Str, _locale_t _Locale);
#pragma binding(msvcrt::_mbsnicmp, "_mbsnicmp")
int _mbsnicmp(const unsigned char *_Str1, const unsigned char *_Str2, size_t _MaxCount);
#pragma binding(msvcrt::_mbsnicmp_l, "_mbsnicmp_l")
int _mbsnicmp_l(const unsigned char *_Str1, const unsigned char *_Str2, size_t _MaxCount, _locale_t _Locale);
#pragma binding(msvcrt::_mbsnicoll, "_mbsnicoll")
int _mbsnicoll(const unsigned char *_Str1, const unsigned char *_Str2, size_t _MaxCount);
#pragma binding(msvcrt::_mbsnicoll_l, "_mbsnicoll_l")
int _mbsnicoll_l(const unsigned char *_Str1, const unsigned char *_Str2, size_t _MaxCount, _locale_t _Locale);
#pragma binding(msvcrt::_mbsninc, "_mbsninc")
unsigned char *_mbsninc(const unsigned char *_Str, size_t _Count);
#pragma binding(msvcrt::_mbsninc_l, "_mbsninc_l")
unsigned char *_mbsninc_l(const unsigned char *_Str, size_t _Count, _locale_t _Locale);
#pragma binding(msvcrt::_mbsnset, "_mbsnset")
unsigned char *_mbsnset(unsigned char *_Dst, unsigned int _Val, size_t _MaxCount);
#pragma binding(msvcrt::_mbsnset_l, "_mbsnset_l")
unsigned char *_mbsnset_l(unsigned char *_Dst, unsigned int _Val, size_t _MaxCount, _locale_t _Locale);
#pragma binding(msvcrt::_mbspbrk, "_mbspbrk")
unsigned char *_mbspbrk(const unsigned char *_Str, const unsigned char *_Control);
#pragma binding(msvcrt::_mbspbrk_l, "_mbspbrk_l")
unsigned char *_mbspbrk_l(const unsigned char *_Str, const unsigned char *_Control, _locale_t _Locale);
#pragma binding(msvcrt::_mbsrchr, "_mbsrchr")
unsigned char *_mbsrchr(const unsigned char *_Str, unsigned int _Ch);
#pragma binding(msvcrt::_mbsrchr_l, "_mbsrchr_l")
unsigned char *_mbsrchr_l(const unsigned char *_Str, unsigned int _Ch, _locale_t _Locale);
#pragma binding(msvcrt::_mbsrev, "_mbsrev")
unsigned char *_mbsrev(unsigned char *_Str);
#pragma binding(msvcrt::_mbsrev_l, "_mbsrev_l")
unsigned char *_mbsrev_l(unsigned char *_Str, _locale_t _Locale);
#pragma binding(msvcrt::_mbsset, "_mbsset")
unsigned char *_mbsset(unsigned char *_Str, unsigned int _Val);
#pragma binding(msvcrt::_mbsset_l, "_mbsset_l")
unsigned char *_mbsset_l(unsigned char *_Str, unsigned int _Val, _locale_t _Locale);
#pragma binding(msvcrt::_mbsspn, "_mbsspn")
size_t _mbsspn(const unsigned char *_Str, const unsigned char *_Control);
#pragma binding(msvcrt::_mbsspn_l, "_mbsspn_l")
size_t _mbsspn_l(const unsigned char *_Str, const unsigned char *_Control, _locale_t _Locale);
#pragma binding(msvcrt::_mbsspnp, "_mbsspnp")
unsigned char *_mbsspnp(const unsigned char *_Str1, const unsigned char *_Str2);
#pragma binding(msvcrt::_mbsspnp_l, "_mbsspnp_l")
unsigned char *_mbsspnp_l(const unsigned char *_Str1, const unsigned char *_Str2, _locale_t _Locale);
#pragma binding(msvcrt::_mbsstr, "_mbsstr")
unsigned char *_mbsstr(const unsigned char *_Str, const unsigned char *_Substr);
#pragma binding(msvcrt::_mbsstr_l, "_mbsstr_l")
unsigned char *_mbsstr_l(const unsigned char *_Str, const unsigned char *_Substr, _locale_t _Locale);
#pragma binding(msvcrt::_mbstok, "_mbstok")
unsigned char *_mbstok(unsigned char *_Str, const unsigned char *_Delim);
#pragma binding(msvcrt::_mbstok_l, "_mbstok_l")
unsigned char *_mbstok_l(unsigned char *_Str, const unsigned char *_Delim, _locale_t _Locale);
#pragma binding(msvcrt::_mbsupr, "_mbsupr")
unsigned char *_mbsupr(unsigned char *_String);
#pragma binding(msvcrt::_mbsupr_l, "_mbsupr_l")
unsigned char *_mbsupr_l(unsigned char *_String, _locale_t _Locale);
#pragma binding(msvcrt::_mbclen, "_mbclen")
size_t _mbclen(const unsigned char *_Str);
#pragma binding(msvcrt::_mbclen_l, "_mbclen_l")
size_t _mbclen_l(const unsigned char *_Str, _locale_t _Locale);
#pragma binding(msvcrt::_mbccpy, "_mbccpy")
void _mbccpy(unsigned char *_Dst, const unsigned char *_Src);
#pragma binding(msvcrt::_mbccpy_l, "_mbccpy_l")
void _mbccpy_l(unsigned char *_Dst, const unsigned char *_Src, _locale_t _Locale);
#define _mbccmp(_cpc1, _cpc2) _mbsncmp((_cpc1), (_cpc2), 1)

#pragma binding(msvcrt::_ismbcalnum, "_ismbcalnum")
int _ismbcalnum(unsigned int _Ch);
#pragma binding(msvcrt::_ismbcalnum_l, "_ismbcalnum_l")
int _ismbcalnum_l(unsigned int _Ch, _locale_t _Locale);
#pragma binding(msvcrt::_ismbcalpha, "_ismbcalpha")
int _ismbcalpha(unsigned int _Ch);
#pragma binding(msvcrt::_ismbcalpha_l, "_ismbcalpha_l")
int _ismbcalpha_l(unsigned int _Ch, _locale_t _Locale);
#pragma binding(msvcrt::_ismbcdigit, "_ismbcdigit")
int _ismbcdigit(unsigned int _Ch);
#pragma binding(msvcrt::_ismbcdigit_l, "_ismbcdigit_l")
int _ismbcdigit_l(unsigned int _Ch, _locale_t _Locale);
#pragma binding(msvcrt::_ismbcgraph, "_ismbcgraph")
int _ismbcgraph(unsigned int _Ch);
#pragma binding(msvcrt::_ismbcgraph_l, "_ismbcgraph_l")
int _ismbcgraph_l(unsigned int _Ch, _locale_t _Locale);
#pragma binding(msvcrt::_ismbclegal, "_ismbclegal")
int _ismbclegal(unsigned int _Ch);
#pragma binding(msvcrt::_ismbclegal_l, "_ismbclegal_l")
int _ismbclegal_l(unsigned int _Ch, _locale_t _Locale);
#pragma binding(msvcrt::_ismbclower, "_ismbclower")
int _ismbclower(unsigned int _Ch);
#pragma binding(msvcrt::_ismbclower_l, "_ismbclower_l")
int _ismbclower_l(unsigned int _Ch, _locale_t _Locale);
#pragma binding(msvcrt::_ismbcprint, "_ismbcprint")
int _ismbcprint(unsigned int _Ch);
#pragma binding(msvcrt::_ismbcprint_l, "_ismbcprint_l")
int _ismbcprint_l(unsigned int _Ch, _locale_t _Locale);
#pragma binding(msvcrt::_ismbcpunct, "_ismbcpunct")
int _ismbcpunct(unsigned int _Ch);
#pragma binding(msvcrt::_ismbcpunct_l, "_ismbcpunct_l")
int _ismbcpunct_l(unsigned int _Ch, _locale_t _Locale);
#pragma binding(msvcrt::_ismbcspace, "_ismbcspace")
int _ismbcspace(unsigned int _Ch);
#pragma binding(msvcrt::_ismbcspace_l, "_ismbcspace_l")
int _ismbcspace_l(unsigned int _Ch, _locale_t _Locale);
#pragma binding(msvcrt::_ismbcupper, "_ismbcupper")
int _ismbcupper(unsigned int _Ch);
#pragma binding(msvcrt::_ismbcupper_l, "_ismbcupper_l")
int _ismbcupper_l(unsigned int _Ch, _locale_t _Locale);
#pragma binding(msvcrt::_mbctolower, "_mbctolower")
unsigned int _mbctolower(unsigned int _Ch);
#pragma binding(msvcrt::_mbctolower_l, "_mbctolower_l")
unsigned int _mbctolower_l(unsigned int _Ch, _locale_t _Locale);
#pragma binding(msvcrt::_mbctoupper, "_mbctoupper")
unsigned int _mbctoupper(unsigned int _Ch);
#pragma binding(msvcrt::_mbctoupper_l, "_mbctoupper_l")
unsigned int _mbctoupper_l(unsigned int _Ch, _locale_t _Locale);
#endif

#ifndef _MBLEADTRAIL_DEFINED
#define _MBLEADTRAIL_DEFINED
#pragma binding(msvcrt::_ismbblead, "_ismbblead")
int _ismbblead(unsigned int _Ch);
#pragma binding(msvcrt::_ismbblead_l, "_ismbblead_l")
int _ismbblead_l(unsigned int _Ch, _locale_t _Locale);
#pragma binding(msvcrt::_ismbbtrail, "_ismbbtrail")
int _ismbbtrail(unsigned int _Ch);
#pragma binding(msvcrt::_ismbbtrail_l, "_ismbbtrail_l")
int _ismbbtrail_l(unsigned int _Ch, _locale_t _Locale);
#pragma binding(msvcrt::_ismbslead, "_ismbslead")
int _ismbslead(const unsigned char *_Str, const unsigned char *_Pos);
#pragma binding(msvcrt::_ismbslead_l, "_ismbslead_l")
int _ismbslead_l(const unsigned char *_Str, const unsigned char *_Pos, _locale_t _Locale);
#pragma binding(msvcrt::_ismbstrail, "_ismbstrail")
int _ismbstrail(const unsigned char *_Str, const unsigned char *_Pos);
#pragma binding(msvcrt::_ismbstrail_l, "_ismbstrail_l")
int _ismbstrail_l(const unsigned char *_Str, const unsigned char *_Pos, _locale_t _Locale);
#endif

#pragma binding(msvcrt::_ismbchira, "_ismbchira")
int _ismbchira(unsigned int _Ch);
#pragma binding(msvcrt::_ismbchira_l, "_ismbchira_l")
int _ismbchira_l(unsigned int _Ch, _locale_t _Locale);
#pragma binding(msvcrt::_ismbckata, "_ismbckata")
int _ismbckata(unsigned int _Ch);
#pragma binding(msvcrt::_ismbckata_l, "_ismbckata_l")
int _ismbckata_l(unsigned int _Ch, _locale_t _Locale);
#pragma binding(msvcrt::_ismbcsymbol, "_ismbcsymbol")
int _ismbcsymbol(unsigned int _Ch);
#pragma binding(msvcrt::_ismbcsymbol_l, "_ismbcsymbol_l")
int _ismbcsymbol_l(unsigned int _Ch, _locale_t _Locale);
#pragma binding(msvcrt::_ismbcl0, "_ismbcl0")
int _ismbcl0(unsigned int _Ch);
#pragma binding(msvcrt::_ismbcl0_l, "_ismbcl0_l")
int _ismbcl0_l(unsigned int _Ch, _locale_t _Locale);
#pragma binding(msvcrt::_ismbcl1, "_ismbcl1")
int _ismbcl1(unsigned int _Ch);
#pragma binding(msvcrt::_ismbcl1_l, "_ismbcl1_l")
int _ismbcl1_l(unsigned int _Ch, _locale_t _Locale);
#pragma binding(msvcrt::_ismbcl2, "_ismbcl2")
int _ismbcl2(unsigned int _Ch);
#pragma binding(msvcrt::_ismbcl2_l, "_ismbcl2_l")
int _ismbcl2_l(unsigned int _Ch, _locale_t _Locale);
#pragma binding(msvcrt::_mbcjistojms, "_mbcjistojms")
unsigned int _mbcjistojms(unsigned int _Ch);
#pragma binding(msvcrt::_mbcjistojms_l, "_mbcjistojms_l")
unsigned int _mbcjistojms_l(unsigned int _Ch, _locale_t _Locale);
#pragma binding(msvcrt::_mbcjmstojis, "_mbcjmstojis")
unsigned int _mbcjmstojis(unsigned int _Ch);
#pragma binding(msvcrt::_mbcjmstojis_l, "_mbcjmstojis_l")
unsigned int _mbcjmstojis_l(unsigned int _Ch, _locale_t _Locale);
#pragma binding(msvcrt::_mbctohira, "_mbctohira")
unsigned int _mbctohira(unsigned int _Ch);
#pragma binding(msvcrt::_mbctohira_l, "_mbctohira_l")
unsigned int _mbctohira_l(unsigned int _Ch, _locale_t _Locale);
#pragma binding(msvcrt::_mbctokata, "_mbctokata")
unsigned int _mbctokata(unsigned int _Ch);
#pragma binding(msvcrt::_mbctokata_l, "_mbctokata_l")
unsigned int _mbctokata_l(unsigned int _Ch, _locale_t _Locale);

#pragma binding(msvcrt::_mbscat_s, "_mbscat_s")
errno_t _mbscat_s(unsigned char *_Dst, size_t _SizeInBytes, const unsigned char *_Src);
#pragma binding(msvcrt::_mbscpy_s, "_mbscpy_s")
errno_t _mbscpy_s(unsigned char *_Dst, size_t _SizeInBytes, const unsigned char *_Src);
#pragma binding(msvcrt::_mbscpy_s_l, "_mbscpy_s_l")
errno_t _mbscpy_s_l(unsigned char *_Dst, size_t _DstSizeInBytes, const unsigned char *_Src, _locale_t _Locale);
#pragma binding(msvcrt::_mbslwr_s, "_mbslwr_s")
errno_t _mbslwr_s(unsigned char *_Str, size_t _SizeInBytes);
#pragma binding(msvcrt::_mbslwr_s_l, "_mbslwr_s_l")
errno_t _mbslwr_s_l(unsigned char *_Str, size_t _SizeInBytes, _locale_t _Locale);
#pragma binding(msvcrt::_mbsnbcat_s, "_mbsnbcat_s")
errno_t _mbsnbcat_s(unsigned char *_Dst, size_t _DstSizeInBytes, const unsigned char *_Src, size_t _MaxCount);
#pragma binding(msvcrt::_mbsnbcat_s_l, "_mbsnbcat_s_l")
errno_t _mbsnbcat_s_l(unsigned char *_Dst, size_t _DstSizeInBytes, const unsigned char *_Src, size_t _MaxCount, _locale_t _Locale);
#pragma binding(msvcrt::_mbsnbcpy_s, "_mbsnbcpy_s")
errno_t _mbsnbcpy_s(unsigned char *_Dst, size_t _DstSizeInBytes, const unsigned char *_Src, size_t _MaxCount);
#pragma binding(msvcrt::_mbsnbcpy_s_l, "_mbsnbcpy_s_l")
errno_t _mbsnbcpy_s_l(unsigned char *_Dst, size_t _DstSizeInBytes, const unsigned char *_Src, size_t _MaxCount, _locale_t _Locale);
#pragma binding(msvcrt::_mbsnbset_s, "_mbsnbset_s")
errno_t _mbsnbset_s(unsigned char *_Dst, size_t _DstSizeInBytes, unsigned int _Ch, size_t _MaxCount);
#pragma binding(msvcrt::_mbsnbset_s_l, "_mbsnbset_s_l")
errno_t _mbsnbset_s_l(unsigned char *_Dst, size_t _DstSizeInBytes, unsigned int _Ch, size_t _MaxCount, _locale_t _Locale);
#pragma binding(msvcrt::_mbsncat_s, "_mbsncat_s")
errno_t _mbsncat_s(unsigned char *_Dst, size_t _DstSizeInBytes, const unsigned char *_Src, size_t _MaxCount);
#pragma binding(msvcrt::_mbsncat_s_l, "_mbsncat_s_l")
errno_t _mbsncat_s_l(unsigned char *_Dst, size_t _DstSizeInBytes, const unsigned char *_Src, size_t _MaxCount, _locale_t _Locale);
#pragma binding(msvcrt::_mbsncpy_s, "_mbsncpy_s")
errno_t _mbsncpy_s(unsigned char *_Dst, size_t _DstSizeInBytes, const unsigned char *_Src, size_t _MaxCount);
#pragma binding(msvcrt::_mbsncpy_s_l, "_mbsncpy_s_l")
errno_t _mbsncpy_s_l(unsigned char *_Dst, size_t _DstSizeInBytes, const unsigned char *_Src, size_t _MaxCount, _locale_t _Locale);
#pragma binding(msvcrt::_mbsnset_s, "_mbsnset_s")
errno_t _mbsnset_s(unsigned char *_Dst, size_t _DstSizeInBytes, unsigned int _Val, size_t _MaxCount);
#pragma binding(msvcrt::_mbsnset_s_l, "_mbsnset_s_l")
errno_t _mbsnset_s_l(unsigned char *_Dst, size_t _DstSizeInBytes, unsigned int _Val, size_t _MaxCount, _locale_t _Locale);
#pragma binding(msvcrt::_mbsset_s, "_mbsset_s")
errno_t _mbsset_s(unsigned char *_Dst, size_t _DstSizeInBytes, unsigned int _Val);
#pragma binding(msvcrt::_mbsset_s_l, "_mbsset_s_l")
errno_t _mbsset_s_l(unsigned char *_Dst, size_t _DstSizeInBytes, unsigned int _Val, _locale_t _Locale);
#pragma binding(msvcrt::_mbstok_s, "_mbstok_s")
unsigned char *_mbstok_s(unsigned char *_Str, const unsigned char *_Delim, unsigned char **_Context);
#pragma binding(msvcrt::_mbstok_s_l, "_mbstok_s_l")
unsigned char *_mbstok_s_l(unsigned char *_Str, const unsigned char *_Delim, unsigned char **_Context, _locale_t _Locale);
#pragma binding(msvcrt::_mbsupr_s, "_mbsupr_s")
errno_t _mbsupr_s(unsigned char *_Str, size_t _SizeInBytes);
#pragma binding(msvcrt::_mbsupr_s_l, "_mbsupr_s_l")
errno_t _mbsupr_s_l(unsigned char *_Str, size_t _SizeInBytes, _locale_t _Locale);
#pragma binding(msvcrt::_mbccpy_s, "_mbccpy_s")
errno_t _mbccpy_s(unsigned char *_Dst, size_t _DstSizeInBytes, int *_PCopied, const unsigned char *_Src);
#pragma binding(msvcrt::_mbccpy_s_l, "_mbccpy_s_l")
errno_t _mbccpy_s_l(unsigned char *_Dst, size_t _DstSizeInBytes, int *_PCopied, const unsigned char *_Src, _locale_t _Locale);

#endif
