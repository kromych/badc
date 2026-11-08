// A UCRT entry point called through the program's own prototype, as an
// object compiled against the UCRT's headers calls it: the link resolves
// it to ucrtbase.dll, which the bundled headers bind it to. Exits 0 when
// the formatter wrote "42"; elsewhere the unit checks nothing.

#ifdef _WIN32
#include <stdarg.h>
#include <stddef.h>
#include <wchar.h>

int __stdio_common_vsnwprintf_s(unsigned long long options, wchar_t *buffer, size_t count,
                                size_t max_count, const wchar_t *format, void *locale,
                                va_list args);

static int format(wchar_t *buffer, size_t count, const wchar_t *f, ...) {
    va_list args;
    va_start(args, f);
    int n = __stdio_common_vsnwprintf_s(0, buffer, count, (size_t)-1, f, 0, args);
    va_end(args);
    return n;
}

int main(void) {
    wchar_t b[16];
    return format(b, 16, L"%d", 42) == 2 && wcscmp(b, L"42") == 0 ? 0 : 1;
}
#else
int main(void) { return 0; }
#endif
