/* Minimal Win32 GUI "Hello, world!" demo.
 *
 * Demonstrates the new c5 surface that landed alongside this
 * demo:
 *   * `#pragma subsystem(windows)` -- PE optional-header
 *      Subsystem becomes IMAGE_SUBSYSTEM_WINDOWS_GUI (2), so
 *      the loader doesn't auto-attach a console window when
 *      the user double-clicks the .exe.
 *   * `#pragma entrypoint(WinMain)` -- the loader resolves the
 *      entry symbol to `WinMain` instead of the canonical
 *      `main`.
 *
 * Only links what an average GUI app uses: kernel32 (for
 * `ExitProcess`), user32 (for the window class / message
 * loop), gdi32 (for `BeginPaint` / `TextOutA` / `EndPaint`).
 * No Common Controls, no comdlg32, no theming.
 *
 * Build (cross-compile from any host):
 *
 *     badc --target=windows-x64 demos/gui_hello/hello_win32.c -o hello.exe
 *     wine hello.exe         # or run on Windows directly
 *
 * The demo intentionally avoids the bundled `<windows.h>`'s
 * Win32 surface because that header doesn't ship the GUI
 * subset (WNDCLASSA, MSG, ...). We declare the minimum
 * inline so the demo is self-contained; once a second GUI
 * demo lands, we can hoist the shared types into a
 * `<win32_gui.h>` header. */

#pragma subsystem(windows)
#pragma entrypoint(WinMain)

/* --- Win32 GUI surface (minimum to draw a window) --- */
#pragma dylib(user32, "user32.dll")
#pragma dylib(gdi32,  "gdi32.dll")
#pragma dylib(kernel32, "kernel32.dll")

typedef void *HINSTANCE;
typedef void *HWND;
typedef void *HMENU;
typedef void *HBRUSH;
typedef void *HICON;
typedef void *HCURSOR;
typedef void *HDC;
typedef int   BOOL;
typedef unsigned int UINT;
typedef long long LRESULT;
typedef long long WPARAM;
typedef long long LPARAM;
typedef long long ATOM;

/* WNDCLASSA: the Win32 ANSI window-class registration shape.
 * We declare it in declared-field order so `RegisterClassA`
 * reads the 64-bit-aligned slots correctly. The padding
 * between cbWndExtra and hInstance comes from MSVC's natural
 * alignment of the pointer fields; c5 mirrors the same
 * layout because the integer-then-pointer member sequence
 * lines up. */
struct WNDCLASSA {
    UINT      style;
    long long lpfnWndProc;     /* WNDPROC -- function pointer */
    int       cbClsExtra;
    int       cbWndExtra;
    HINSTANCE hInstance;
    HICON     hIcon;
    HCURSOR   hCursor;
    HBRUSH    hbrBackground;
    char     *lpszMenuName;
    char     *lpszClassName;
};

struct POINT { long x; long y; };
struct MSG {
    HWND          hwnd;
    UINT          message;
    WPARAM        wParam;
    LPARAM        lParam;
    unsigned int  time;
    struct POINT  pt;
    unsigned int  lPrivate;
};

struct PAINTSTRUCT {
    HDC  hdc;
    BOOL fErase;
    /* Inline RECT { left, top, right, bottom } -- four LONGs. */
    long left;
    long top;
    long right;
    long bottom;
    BOOL fRestore;
    BOOL fIncUpdate;
    /* rgbReserved[32] padding kept implicit -- the API only
     * touches the public fields above. */
    char rgbReserved[32];
};

#define WM_DESTROY 0x0002
#define WM_PAINT   0x000F
#define WS_OVERLAPPEDWINDOW 0x00CF0000
#define SW_SHOWDEFAULT 10
#define CW_USEDEFAULT  ((int)0x80000000)
#define IDC_ARROW      32512

#pragma binding(user32::RegisterClassA,    "RegisterClassA")
#pragma binding(user32::CreateWindowExA,   "CreateWindowExA")
#pragma binding(user32::ShowWindow,        "ShowWindow")
#pragma binding(user32::UpdateWindow,      "UpdateWindow")
#pragma binding(user32::DefWindowProcA,    "DefWindowProcA")
#pragma binding(user32::GetMessageA,       "GetMessageA")
#pragma binding(user32::TranslateMessage,  "TranslateMessage")
#pragma binding(user32::DispatchMessageA,  "DispatchMessageA")
#pragma binding(user32::PostQuitMessage,   "PostQuitMessage")
#pragma binding(user32::LoadCursorA,       "LoadCursorA")
#pragma binding(user32::BeginPaint,        "BeginPaint")
#pragma binding(user32::EndPaint,          "EndPaint")
#pragma binding(gdi32::TextOutA,           "TextOutA")
#pragma binding(kernel32::GetModuleHandleA, "GetModuleHandleA")

ATOM      RegisterClassA(struct WNDCLASSA *cls);
HWND      CreateWindowExA(unsigned int ex_style, char *cls, char *title,
                          unsigned int style, int x, int y, int w, int h,
                          HWND parent, HMENU menu, HINSTANCE inst,
                          void *param);
BOOL      ShowWindow(HWND h, int cmd);
BOOL      UpdateWindow(HWND h);
LRESULT   DefWindowProcA(HWND h, UINT msg, WPARAM w, LPARAM l);
BOOL      GetMessageA(struct MSG *msg, HWND h, UINT minf, UINT maxf);
BOOL      TranslateMessage(struct MSG *msg);
LRESULT   DispatchMessageA(struct MSG *msg);
int       PostQuitMessage(int code);
HCURSOR   LoadCursorA(HINSTANCE inst, char *name);
HDC       BeginPaint(HWND h, struct PAINTSTRUCT *ps);
BOOL      EndPaint(HWND h, struct PAINTSTRUCT *ps);
BOOL      TextOutA(HDC hdc, int x, int y, char *str, int n);
HINSTANCE GetModuleHandleA(char *name);

/* --- demo body --- */

static char *kClassName = "BadcGuiHello";
static char *kTitle     = "badc GUI hello";
static char *kHello     = "Hello from badc!";

LRESULT WndProc(HWND h, UINT msg, WPARAM wp, LPARAM lp) {
    if (msg == WM_DESTROY) {
        PostQuitMessage(0);
        return 0;
    }
    if (msg == WM_PAINT) {
        struct PAINTSTRUCT ps;
        HDC hdc = BeginPaint(h, &ps);
        TextOutA(hdc, 24, 24, kHello, 16);
        EndPaint(h, &ps);
        return 0;
    }
    return DefWindowProcA(h, msg, wp, lp);
}

int WinMain(HINSTANCE hinst, HINSTANCE prev, char *cmdline, int show) {
    (void)prev; (void)cmdline;
    /* Win32 expects WNDCLASSA::lpfnWndProc to hold a code
     * address; c5 stores function-pointer rvalues as
     * pointer-typed integers in the same slot. The cast is
     * a no-op at the bit level but keeps the type checker
     * happy. */
    struct WNDCLASSA wc;
    wc.style = 0;
    wc.lpfnWndProc = (long long)&WndProc;
    wc.cbClsExtra = 0;
    wc.cbWndExtra = 0;
    wc.hInstance = hinst;
    wc.hIcon = (HICON)0;
    wc.hCursor = LoadCursorA((HINSTANCE)0, (char *)IDC_ARROW);
    wc.hbrBackground = (HBRUSH)6; /* COLOR_WINDOW + 1 */
    wc.lpszMenuName = (char *)0;
    wc.lpszClassName = kClassName;
    if (!RegisterClassA(&wc)) {
        return 1;
    }
    HWND hwnd = CreateWindowExA(
        0, kClassName, kTitle,
        WS_OVERLAPPEDWINDOW,
        CW_USEDEFAULT, CW_USEDEFAULT, 480, 240,
        (HWND)0, (HMENU)0, hinst, (void *)0);
    if (!hwnd) return 1;
    ShowWindow(hwnd, show);
    UpdateWindow(hwnd);

    struct MSG msg;
    while (GetMessageA(&msg, (HWND)0, 0, 0)) {
        TranslateMessage(&msg);
        DispatchMessageA(&msg);
    }
    return (int)msg.wParam;
}
