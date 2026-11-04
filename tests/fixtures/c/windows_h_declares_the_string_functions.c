/* <windows.h> alone declares the C runtime's string and memory functions,
   as the SDK's and mingw-w64's do through winnt.h's <string.h>, and with
   them the macros over them (ZeroMemory, CopyMemory, FillMemory,
   MoveMemory). The exit code is the line of the first mismatch. Elsewhere
   the program exits 0. */

#ifdef _WIN32
#include <windows.h>

#define CHECK(c)             \
    do {                     \
        if (!(c))            \
            return __LINE__; \
    } while (0)

int main(void)
{
    char a[16], b[16];
    memset(a, 'x', sizeof a);
    a[15] = 0;
    memcpy(b, a, sizeof a);
    CHECK(strlen(b) == 15 && memcmp(a, b, sizeof a) == 0);
    CHECK(strcmp(strcpy(b, "abc"), "abc") == 0 && strchr(b, 'c') == b + 2);
    wchar_t w[] = L"wide";
    CHECK(wcslen(w) == 4);
    ZeroMemory(a, 8);
    CHECK(a[0] == 0 && a[7] == 0 && a[8] == 'x');
    FillMemory(a, 4, 'y');
    CHECK(a[0] == 'y' && a[3] == 'y' && a[4] == 0);
    CopyMemory(b, "1234", 4);
    MoveMemory(b + 1, b, 3);
    CHECK(memcmp(b, "1123x", 5) == 0);
    return 0;
}
#else
int main(void)
{
    return 0;
}
#endif
