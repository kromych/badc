/* The Win32 hello window written against the Windows SDK: <windows.h> from
 * the installed Platform SDK declares the API, and the SDK's import
 * libraries (user32.lib, gdi32.lib, kernel32.lib) name the DLLs. The
 * subsystem follows from WinMain. smoke.py builds it with `--sdk`, and on a
 * Windows host of the same architecture runs it with `--smoke`. */
#include <windows.h>

static const char kClassName[] = "BadcGuiHelloSdk";
static const char kHello[] = "Hello from badc and the Windows SDK!";

static LRESULT CALLBACK WndProc(HWND hwnd, UINT msg, WPARAM wp, LPARAM lp) {
    switch (msg) {
    case WM_PAINT: {
        PAINTSTRUCT ps;
        HDC hdc = BeginPaint(hwnd, &ps);
        TextOutA(hdc, 24, 24, kHello, (int)(sizeof kHello - 1));
        EndPaint(hwnd, &ps);
        return 0;
    }
    case WM_DESTROY:
        PostQuitMessage(0);
        return 0;
    }
    return DefWindowProcA(hwnd, msg, wp, lp);
}

int WINAPI WinMain(HINSTANCE hinst, HINSTANCE prev, LPSTR cmdline, int show) {
    (void)prev;
    WNDCLASSA wc = { 0 };
    wc.lpfnWndProc = WndProc;
    wc.hInstance = hinst;
    wc.hCursor = LoadCursorA(NULL, (LPCSTR)IDC_ARROW);
    wc.hbrBackground = (HBRUSH)(COLOR_WINDOW + 1);
    wc.lpszClassName = kClassName;
    if (!RegisterClassA(&wc))
        return 1;
    HWND hwnd = CreateWindowExA(0, kClassName, "badc GUI hello (SDK)", WS_OVERLAPPEDWINDOW,
                                CW_USEDEFAULT, CW_USEDEFAULT, 480, 240, NULL, NULL, hinst, NULL);
    if (!hwnd)
        return 1;
    ShowWindow(hwnd, show);
    UpdateWindow(hwnd);
    // `--smoke` closes the window once it exists, so a run ends on its own.
    if (lstrcmpA(cmdline, "--smoke") == 0)
        PostMessageA(hwnd, WM_CLOSE, 0, 0);
    MSG msg;
    while (GetMessageA(&msg, NULL, 0, 0) > 0) {
        TranslateMessage(&msg);
        DispatchMessageA(&msg);
    }
    return (int)msg.wParam;
}
