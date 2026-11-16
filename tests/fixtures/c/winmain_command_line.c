// The `lpCmdLine` a `WinMain` receives is the command line past the
// program name, as cl's CRT passes it: the tail of `GetCommandLineA()`,
// without the image's own name, whatever arguments the run was given.
#ifdef _WIN32
#include <string.h>
#include <windows.h>

int WINAPI WinMain(HINSTANCE instance, HINSTANCE prev, LPSTR cmd_line, int show) {
    (void)instance;
    (void)prev;
    (void)show;
    char self[MAX_PATH];
    if (!GetModuleFileNameA(NULL, self, MAX_PATH))
        return 2;
    const char *base = strrchr(self, '\\') ? strrchr(self, '\\') + 1 : self;
    const char *full = GetCommandLineA();
    size_t n = strlen(full), m = strlen(cmd_line);
    if (m > n || strcmp(full + n - m, cmd_line) != 0)
        return 3;
    return strstr(cmd_line, base) == NULL ? 0 : 1;
}
#else
int main(void) { return 0; }
#endif
