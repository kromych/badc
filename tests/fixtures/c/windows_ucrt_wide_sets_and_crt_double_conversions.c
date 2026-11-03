// On Windows, the functions of the UCRT's corecrt_wstdlib.h, corecrt_wstdio.h,
// corecrt_wio.h, corecrt_wdirect.h, corecrt_wprocess.h, corecrt_wtime.h,
// corecrt_wconio.h and corecrt_wctype.h that msvcrt.dll exports: the image
// imports every one, so it starts only if msvcrt.dll has each. A sample of
// each set runs, with the wide _l conversions under a C and a German locale
// and the _atodbl family's results. Elsewhere the unit is empty. The exit
// code is the line of the first mismatch.

#ifdef _WIN32
#include <errno.h>
#include <io.h>
#include <locale.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <wchar.h>

#define CHECK(c)             \
    do {                     \
        if (!(c))            \
            return __LINE__; \
    } while (0)

typedef void (*fn)(void);
static fn const imported[] = {
    (fn)__pctype_func, (fn)__pwctype_func, (fn)_cgetws_s, (fn)_cputws, (fn)_cwprintf,
    (fn)_cwprintf_l, (fn)_cwprintf_p, (fn)_cwprintf_p_l, (fn)_cwprintf_s, (fn)_cwprintf_s_l,
    (fn)_cwscanf, (fn)_cwscanf_l, (fn)_cwscanf_s, (fn)_cwscanf_s_l, (fn)_fgetwchar,
    (fn)_fputwchar, (fn)_fwprintf_l, (fn)_fwprintf_p, (fn)_fwprintf_p_l, (fn)_fwprintf_s_l,
    (fn)_fwscanf_l, (fn)_fwscanf_s_l, (fn)_getwch, (fn)_getwche, (fn)_getws, (fn)_i64tow,
    (fn)_i64tow_s, (fn)_isleadbyte_l, (fn)_iswalnum_l, (fn)_iswalpha_l, (fn)_iswcntrl_l,
    (fn)_iswctype_l, (fn)_iswdigit_l, (fn)_iswgraph_l, (fn)_iswlower_l, (fn)_iswprint_l,
    (fn)_iswpunct_l, (fn)_iswspace_l, (fn)_iswupper_l, (fn)_iswxdigit_l, (fn)_itow,
    (fn)_itow_s, (fn)_ltow, (fn)_ltow_s, (fn)_putwch, (fn)_putws, (fn)_scwprintf,
    (fn)_scwprintf_l, (fn)_scwprintf_p_l, (fn)_snwprintf, (fn)_snwprintf_l,
    (fn)_snwprintf_s, (fn)_snwprintf_s_l, (fn)_snwscanf, (fn)_snwscanf_l, (fn)_snwscanf_s,
    (fn)_snwscanf_s_l, (fn)_swprintf, (fn)_swprintf_c, (fn)_swprintf_c_l, (fn)_swprintf_p_l,
    (fn)_swprintf_s_l, (fn)_swscanf_l, (fn)_swscanf_s_l, (fn)_towlower_l, (fn)_towupper_l,
    (fn)_ui64tow, (fn)_ui64tow_s, (fn)_ultow, (fn)_ultow_s, (fn)_ungetwch, (fn)_vcwprintf,
    (fn)_vcwprintf_l, (fn)_vcwprintf_p, (fn)_vcwprintf_p_l, (fn)_vcwprintf_s,
    (fn)_vcwprintf_s_l, (fn)_vfwprintf_l, (fn)_vfwprintf_p, (fn)_vfwprintf_p_l,
    (fn)_vfwprintf_s_l, (fn)_vscwprintf, (fn)_vscwprintf_l, (fn)_vscwprintf_p_l,
    (fn)_vsnwprintf, (fn)_vsnwprintf_l, (fn)_vsnwprintf_s, (fn)_vsnwprintf_s_l,
    (fn)_vswprintf, (fn)_vswprintf_c, (fn)_vswprintf_c_l, (fn)_vswprintf_l,
    (fn)_vswprintf_p_l, (fn)_vswprintf_s_l, (fn)_vwprintf_l, (fn)_vwprintf_p,
    (fn)_vwprintf_p_l, (fn)_vwprintf_s_l, (fn)_waccess, (fn)_waccess_s, (fn)_wasctime,
    (fn)_wasctime_s, (fn)_wchdir, (fn)_wchmod, (fn)_wcreat, (fn)_wcsftime_l, (fn)_wcstod_l,
    (fn)_wcstoi64, (fn)_wcstoi64_l, (fn)_wcstol_l, (fn)_wcstold_l, (fn)_wcstoll_l,
    (fn)_wcstoui64, (fn)_wcstoui64_l, (fn)_wcstoul_l, (fn)_wcstoull_l, (fn)_wctime,
    (fn)_wctime32, (fn)_wctime32_s, (fn)_wctime64, (fn)_wctime64_s, (fn)_wctime_s,
    (fn)_wexecl, (fn)_wexecle, (fn)_wexeclp, (fn)_wexeclpe, (fn)_wexecv, (fn)_wexecve,
    (fn)_wexecvp, (fn)_wexecvpe, (fn)_wfdopen, (fn)_wfindfirst, (fn)_wfindfirst64,
    (fn)_wfindnext, (fn)_wfindnext64, (fn)_wfopen, (fn)_wfopen_s, (fn)_wfreopen,
    (fn)_wfreopen_s, (fn)_wfsopen, (fn)_wfullpath, (fn)_wgetcwd, (fn)_wgetdcwd,
    (fn)_wgetenv, (fn)_wgetenv_s, (fn)_wmakepath, (fn)_wmakepath_s, (fn)_wmkdir,
    (fn)_wmktemp, (fn)_wmktemp_s, (fn)_wopen, (fn)_wperror, (fn)_wpopen, (fn)_wprintf_l,
    (fn)_wprintf_p, (fn)_wprintf_p_l, (fn)_wprintf_s_l, (fn)_wputenv, (fn)_wputenv_s,
    (fn)_wremove, (fn)_wrename, (fn)_wrmdir, (fn)_wscanf_l, (fn)_wscanf_s_l,
    (fn)_wsearchenv, (fn)_wsearchenv_s, (fn)_wsopen, (fn)_wsopen_s, (fn)_wspawnl,
    (fn)_wspawnle, (fn)_wspawnlp, (fn)_wspawnlpe, (fn)_wspawnv, (fn)_wspawnve,
    (fn)_wspawnvp, (fn)_wspawnvpe, (fn)_wsplitpath, (fn)_wsplitpath_s, (fn)_wstrdate,
    (fn)_wstrdate_s, (fn)_wstrtime, (fn)_wstrtime_s, (fn)_wsystem, (fn)_wtempnam,
    (fn)_wtmpnam, (fn)_wtmpnam_s, (fn)_wtof, (fn)_wtof_l, (fn)_wtoi, (fn)_wtoi64,
    (fn)_wtoi64_l, (fn)_wtoi_l, (fn)_wtol, (fn)_wtol_l, (fn)_wtoll, (fn)_wtoll_l,
    (fn)_wunlink, (fn)fgetwc, (fn)fgetws, (fn)fputwc, (fn)fputws, (fn)fwprintf_s,
    (fn)fwscanf_s, (fn)getwc, (fn)getwchar, (fn)is_wctype, (fn)isleadbyte, (fn)iswalnum,
    (fn)iswalpha, (fn)iswascii, (fn)iswblank, (fn)iswcntrl, (fn)iswctype, (fn)iswdigit,
    (fn)iswgraph, (fn)iswlower, (fn)iswprint, (fn)iswpunct, (fn)iswspace, (fn)iswupper,
    (fn)iswxdigit, (fn)putwc, (fn)putwchar, (fn)swprintf_s, (fn)swscanf_s, (fn)towlower,
    (fn)towupper, (fn)ungetwc, (fn)vfwprintf_s, (fn)vswprintf_s, (fn)vwprintf_s,
    (fn)wcsftime, (fn)wcstol, (fn)wcstoll, (fn)wcstoul, (fn)wcstoull, (fn)wprintf_s,
    (fn)wscanf_s, (fn)_wcstof_l, (fn)_atodbl, (fn)_atoldbl, (fn)_atodbl_l, (fn)_atoflt_l,
    (fn)_atoldbl_l};

static int same(const wchar_t *a, const wchar_t *b) {
    return wcscmp(a, b) == 0;
}

// The wide _l conversions, under the C locale and, where Windows has it,
// one with a decimal comma.
static int conversions(void) {
    _locale_t c = _create_locale(LC_ALL, "C");
    wchar_t *end;
    CHECK(_wcstod_l(L"2.5x", &end, c) == 2.5 && *end == L'x');
    CHECK(_wcstold_l(L"-0.25", &end, c) == -0.25L && !*end);
    CHECK(_wcstof_l(L"1.5", &end, c) == 1.5f && !*end);
    errno = 0;
    CHECK(_wcstof_l(L"1e39", 0, c) > 3.4e38f && errno == ERANGE);
    CHECK(_wcstol_l(L"-ff", &end, 16, c) == -255 && !*end);
    CHECK(_wcstoul_l(L"777", 0, 8, c) == 511ul);
    CHECK(_wcstoll_l(L"9000000000", 0, 10, c) == 9000000000LL);
    CHECK(_wcstoull_l(L"0x10", 0, 16, c) == 16);
    CHECK(_wcstoi64_l(L"-9000000000", 0, 10, c) == -9000000000LL);
    CHECK(_wcstoui64_l(L"18000000000000000000", 0, 10, c) == 18000000000000000000ULL);
    CHECK(_wtof_l(L"3.75", c) == 3.75 && _wtoi_l(L"-12", c) == -12 && _wtol_l(L"34", c) == 34);
    CHECK(_wtoll_l(L"6000000000", c) == 6000000000LL && _wtoi64_l(L"-5000000000", c) == -5000000000LL);
    CHECK(_wtoll(L"7000000000") == 7000000000LL && wcstoll(L"-1", 0, 10) == -1);
    _locale_t de = _create_locale(LC_NUMERIC, "German_Germany.1252");
    if (de) {
        CHECK(_wcstod_l(L"2,5", &end, de) == 2.5 && !*end && _wtof_l(L"0,5", de) == 0.5);
        CHECK(_wcstof_l(L"0,25", &end, de) == 0.25f && !*end);
        _free_locale(de);
    }
    _free_locale(c);
    return 0;
}

// _atodbl, _atoflt and _atoldbl: zero on success, and the value in the
// UCRT's result types; _LDOUBLE is the x87 80-bit encoding.
static int crt_doubles(void) {
    char s1[] = "1.5", s2[] = "2.25";
    _CRT_DOUBLE d;
    _CRT_FLOAT f;
    _LDOUBLE ld;
    CHECK(sizeof(_LDOUBLE) == 10 && sizeof(_CRT_DOUBLE) == 8 && sizeof(_CRT_FLOAT) == 4);
    CHECK(_atodbl(&d, s1) == 0 && d.x == 1.5);
    CHECK(_atoflt(&f, s2) == 0 && f.f == 2.25f);
    CHECK(_atoldbl(&ld, s1) == 0);
    static const unsigned char x87[10] = {0, 0, 0, 0, 0, 0, 0, 0xC0, 0xFF, 0x3F};
    for (int i = 0; i < 10; i++)
        CHECK(_PTR_LD(&ld)[i] == x87[i]);
    _locale_t c = _create_locale(LC_ALL, "C");
    CHECK(_atodbl_l(&d, s2, c) == 0 && d.x == 2.25);
    CHECK(_atoflt_l(&f, s1, c) == 0 && f.f == 1.5f);
    CHECK(_atoldbl_l(&ld, s2, c) == 0);
    _free_locale(c);
    return 0;
}

// A sample of each set: the integer and environment functions, the paths,
// the formatting, the files and directories, the time strings and the
// classification.
static int sets(void) {
    wchar_t b[64], dir[260], drive[8], name[64], ext[16];
    CHECK(same(_itow(-42, b, 10), L"-42") && same(_ui64tow(255, b, 16), L"ff"));
    CHECK(_i64tow_s(-7, b, 64, 10) == 0 && same(b, L"-7"));
    CHECK(_wputenv(L"BADC_W_SETS=yes") == 0 && same(_wgetenv(L"BADC_W_SETS"), L"yes"));
    size_t need = 0;
    CHECK(_wgetenv_s(&need, b, 64, L"BADC_W_SETS") == 0 && need == 4 && same(b, L"yes"));
    _wsplitpath(L"C:\\dir\\file.txt", drive, dir, name, ext);
    CHECK(same(drive, L"C:") && same(dir, L"\\dir\\") && same(name, L"file") && same(ext, L".txt"));
    _wmakepath(b, L"D", L"\\x\\", L"y", L"z");
    CHECK(same(b, L"D:\\x\\y.z"));
    CHECK(_snwprintf(b, 64, L"%d-%ls", 7, L"q") == 3 && same(b, L"7-q"));
    CHECK(_swprintf_c(b, 64, L"%03d", 5) == 3 && same(b, L"005"));
    CHECK(_scwprintf(L"%d", 12345) == 5);
    _locale_t c = _create_locale(LC_ALL, "C");
    CHECK(_swprintf_p_l(b, 64, L"%2$d %1$d", c, 1, 2) == 3 && same(b, L"2 1"));
    int n = 0;
    CHECK(_snwscanf_l(L"41 x", 4, L"%d", c, &n) == 1 && n == 41);
    CHECK(_iswalpha_l(L'a', c) && !_iswdigit_l(L'a', c) && _towupper_l(L'b', c) == L'B');
    CHECK(iswascii(L'a') && !iswascii(0x100) && is_wctype(L'5', 0x4));
    _free_locale(c);
    CHECK(_wgetcwd(dir, 260) && wcslen(dir) > 0);
    wchar_t tmp[260];
    CHECK(_wfullpath(tmp, L".", 260) && same(tmp, dir));
    CHECK(_wmkdir(L"badc_w_sets_dir") == 0 && _wchdir(L"badc_w_sets_dir") == 0);
    FILE *fp = _wfopen(L"a.txt", L"w");
    CHECK(fp != 0 && fputws(L"hi\n", fp) >= 0);
    fclose(fp);
    CHECK(_waccess(L"a.txt", 0) == 0 && _wrename(L"a.txt", L"b.txt") == 0);
    struct _wfinddata64_t fd;
    intptr_t h = _wfindfirst64(L"b.*", &fd);
    CHECK(h != -1 && same(fd.name, L"b.txt") && fd.size == 4);
    _findclose(h);
    CHECK(_wremove(L"b.txt") == 0 && _waccess(L"b.txt", 0) != 0);
    CHECK(_wchdir(L"..") == 0 && _wrmdir(L"badc_w_sets_dir") == 0);
    CHECK(_wstrdate(b) && wcslen(b) == 8 && _wstrtime(b) && wcslen(b) == 8);
    __time64_t t = 31536000;
    CHECK(_wctime64(&t) && wcslen(_wctime64(&t)) == 25);
    CHECK(_wtmpnam(tmp) != 0);
    return 0;
}

int main(void) {
    if (!imported[0])
        return 1;
    int line = conversions();
    if (!line)
        line = crt_doubles();
    if (!line)
        line = sets();
    return line;
}
#else
int main(void) {
    return 0;
}
#endif
