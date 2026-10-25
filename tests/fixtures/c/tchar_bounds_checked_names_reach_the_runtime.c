// The bounds-checked generic-text names of <tchar.h> (mingw-w64's
// sec_api/tchar_s.h) over msvcrt.dll's _s functions: copies and appends,
// a _TRUNCATE copy and print that report the truncation, formatting,
// tokenizing, integer and path conversions, case mapping, the environment
// and the time text; then the wide functions the same names take under
// _UNICODE.

#ifdef _WIN32
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <tchar.h>
#include <time.h>
#include <wchar.h>

static int narrow(void) {
    _TCHAR buf[16], drive[4], dir[16], name[16], ext[8], text[32];
    _TCHAR *ctx = NULL;
    size_t len = 0;
    struct tm tm = {0};
    if (_tcscpy_s(buf, 16, _T("ab")) || _tcscat_s(buf, 16, _T("cd")) || _tcscmp(buf, _T("abcd")))
        return 1;
    if (_tcsncpy_s(buf, 4, _T("abcdef"), _TRUNCATE) != STRUNCATE || _tcscmp(buf, _T("abc")))
        return 2;
    if (_stprintf_s(buf, 16, _T("%d-%s"), 7, _T("x")) != 3 || _tcscmp(buf, _T("7-x")))
        return 3;
    if (_sntprintf_s(buf, 4, _TRUNCATE, _T("%d"), 12345) != -1 || _tcscmp(buf, _T("123")))
        return 4;
    _tcscpy_s(buf, 16, _T("a,b"));
    if (_tcscmp(_tcstok_s(buf, _T(","), &ctx), _T("a")) || _tcscmp(_tcstok_s(NULL, _T(","), &ctx), _T("b")))
        return 5;
    if (_itot_s(255, buf, 16, 16) || _tcscmp(buf, _T("ff")))
        return 6;
    if (_tsplitpath_s(_T("c:\\d\\n.e"), drive, 4, dir, 16, name, 16, ext, 8) ||
        _tcscmp(drive, _T("c:")) || _tcscmp(dir, _T("\\d\\")) || _tcscmp(name, _T("n")) ||
        _tcscmp(ext, _T(".e")))
        return 7;
    _tcscpy_s(buf, 16, _T("MiX"));
    if (_tcslwr_s(buf, 16) || _tcscmp(buf, _T("mix")) || _tcsupr_s(buf, 16) || _tcscmp(buf, _T("MIX")))
        return 8;
    if (_tputenv_s(_T("TCHAR_S_PROBE"), _T("v1")) || _tgetenv_s(&len, buf, 16, _T("TCHAR_S_PROBE")) ||
        len != 3 || _tcscmp(buf, _T("v1")))
        return 9;
    tm.tm_year = 70;
    tm.tm_mday = 15;
    tm.tm_wday = 4;
    if (_tasctime_s(text, 32, &tm) || _tcsncmp(text, _T("Thu Jan 15"), 10))
        return 10;
    return 0;
}

static int wide(void) {
    wchar_t buf[16], drive[4], dir[16], name[16], ext[8], text[32];
    wchar_t *ctx = NULL;
    size_t len = 0;
    struct tm tm = {0};
    if (wcscpy_s(buf, 16, L"ab") || wcscat_s(buf, 16, L"cd") || wcscmp(buf, L"abcd"))
        return 21;
    if (wcsncpy_s(buf, 4, L"abcdef", _TRUNCATE) != STRUNCATE || wcscmp(buf, L"abc"))
        return 22;
    if (swprintf_s(buf, 16, L"%d-%ls", 7, L"x") != 3 || wcscmp(buf, L"7-x"))
        return 23;
    if (_snwprintf_s(buf, 4, _TRUNCATE, L"%d", 12345) != -1 || wcscmp(buf, L"123"))
        return 24;
    wcscpy_s(buf, 16, L"a,b");
    if (wcscmp(wcstok_s(buf, L",", &ctx), L"a") || wcscmp(wcstok_s(NULL, L",", &ctx), L"b"))
        return 25;
    if (_itow_s(255, buf, 16, 16) || wcscmp(buf, L"ff"))
        return 26;
    if (_wsplitpath_s(L"c:\\d\\n.e", drive, 4, dir, 16, name, 16, ext, 8) || wcscmp(drive, L"c:") ||
        wcscmp(dir, L"\\d\\") || wcscmp(name, L"n") || wcscmp(ext, L".e"))
        return 27;
    wcscpy_s(buf, 16, L"MiX");
    if (_wcslwr_s(buf, 16) || wcscmp(buf, L"mix") || _wcsupr_s(buf, 16) || wcscmp(buf, L"MIX"))
        return 28;
    if (_wgetenv_s(&len, buf, 16, L"TCHAR_S_PROBE") || len != 3 || wcscmp(buf, L"v1"))
        return 29;
    tm.tm_year = 70;
    tm.tm_mday = 15;
    tm.tm_wday = 4;
    if (_wasctime_s(text, 32, &tm) || wcsncmp(text, L"Thu Jan 15", 10))
        return 30;
    return 0;
}

int main(void) {
    int r;
    if ((r = narrow()) || (r = wide()))
        return r;
    return 0;
}
#else
int main(void) {
    return 0;
}
#endif
