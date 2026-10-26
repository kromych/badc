// The C runtime's multibyte-character string functions under a double-byte
// code page (Shift_JIS, 932, set by _setmbcp): a lead byte and its trail
// byte are one character to _mbslen, _mbsinc, _mbschr, _mbsncmp and the
// _ismbc* classes, while _mbsnb* count bytes. Under _MBCS the <tchar.h>
// generic-text names take the same meaning.

#ifdef _WIN32
#define _MBCS
#include <mbctype.h>
#include <mbstring.h>
#include <string.h>
#include <tchar.h>

// "a", HIRAGANA LETTER A (0x82 0xA0), "b": four bytes, three characters.
static const unsigned char text[] = "a\x82\xa0" "b";

static int mbstring_calls(void) {
    unsigned char buf[8];
    int copied = 0;
    if (_mbslen(text) != 3 || strlen((const char *)text) != 4)
        return 1;
    if (_mbsinc(text + 1) != text + 3 || _mbsdec(text, text + 3) != text + 1)
        return 2;
    if (_mbschr(text, 0x82A0) != text + 1 || _mbsnextc(text + 1) != 0x82A0)
        return 3;
    if (!_ismbblead(0x82) || _ismbblead('a') || !_ismbbtrail(0xA0))
        return 4;
    if (!_ismbslead(text, text + 1) || !_ismbstrail(text, text + 2))
        return 5;
    if (!_ismbchira(0x82A0) || _ismbckata(0x82A0) || _mbclen(text + 1) != 2)
        return 6;
    if (_mbsnccnt(text, 4) != 3 || _mbsnbcnt(text, 2) != 3)
        return 7;
    if (_mbsncmp(text, (const unsigned char *)"a\x82\xa1", 2) >= 0)
        return 8;
    if (_mbsnbcmp(text, (const unsigned char *)"a\x82\xa1", 2) != 0)
        return 9;
    if (_mbscpy_s(buf, sizeof buf, text) != 0 || _mbscmp(buf, text) != 0)
        return 10;
    if (_mbctoupper('q') != 'Q' || _mbsnlen(text, 8) != 3)
        return 11;
    if (_mbccpy_s(buf, sizeof buf, &copied, text + 1) != 0 || copied != 2)
        return 12;
    if (!(_mbctype[0x82 + 1] & _M1) || _getmbcp() != 932)
        return 13;
    return 0;
}

static int generic_text(void) {
    const char *s = (const char *)text;
    if (sizeof(_TXCHAR) != 1 || (_TINT)-1 < 0)
        return 20;
    if (_tcsclen(s) != 3 || _tcslen(s) != 4 || _tcscnlen(s, 8) != 3)
        return 21;
    if (_tcsinc(s + 1) != s + 3 || _tcsdec(s, s + 3) != s + 1)
        return 22;
    if (_tcsnextc(s + 1) != 0x82A0 || _tcschr(s, 0x82A0) != s + 1)
        return 23;
    if (_tcsncmp(s, "a\x82\xa1", 2) != 0 || _tcsnccmp(s, "a\x82\xa1", 2) >= 0)
        return 24;
    if (_tclen(s + 1) != 2 || !_istlead(0x82) || !_istalpha('a'))
        return 25;
    if (_tccmp(s + 1, "\x82\xa0") != 0 || _totupper('q') != 'Q')
        return 26;
    return 0;
}

int main(void) {
    int r;
    if (_setmbcp(932) != 0)
        return 30;
    if ((r = mbstring_calls()) != 0 || (r = generic_text()) != 0)
        return r;
    _setmbcp(_MB_CP_SBCS);
    if (_mbslen(text) != 4 || _ismbblead(0x82))
        return 31;
    return 0;
}
#else
int main(void) {
    return 0;
}
#endif
