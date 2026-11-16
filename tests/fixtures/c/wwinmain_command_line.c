// The `lpCmdLine` a `wWinMain` receives is the command line past the
// program name, as cl's CRT passes it: the tail of `GetCommandLineW()`,
// without the image's own name, whatever arguments the run was given.
#ifdef _WIN32
#include <wchar.h>
#include <windows.h>

int WINAPI wWinMain(HINSTANCE instance, HINSTANCE prev, LPWSTR cmd_line, int show) {
    (void)instance;
    (void)prev;
    (void)show;
    wchar_t self[MAX_PATH];
    if (!GetModuleFileNameW(NULL, self, MAX_PATH))
        return 2;
    const wchar_t *base = wcsrchr(self, L'\\') ? wcsrchr(self, L'\\') + 1 : self;
    const wchar_t *full = GetCommandLineW();
    size_t n = wcslen(full), m = wcslen(cmd_line);
    if (m > n || wcscmp(full + n - m, cmd_line) != 0)
        return 3;
    return wcsstr(cmd_line, base) == NULL ? 0 : 1;
}
#else
int main(void) { return 0; }
#endif
