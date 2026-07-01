/* Win32 dynamic-link bindings for the RGFW desktop backend (demo-local).
 * Force-included into rcore.c so badc emits the dynamic imports against the
 * system DLLs. The type/prototype surface comes from <windows.h> and the
 * demo-local SDK shims; only the dylib-to-symbol mapping lives here. */
#ifndef RGFW_WIN32_LINK_H
#define RGFW_WIN32_LINK_H

/* raylib's external/win32_clipboard.h ships its own minimal Win32 surface
 * (BITMAPINFOHEADER, RGBQUAD, BI_* flags, clipboard/global heap prototypes)
 * guarded by these SDK include markers. <windows.h> already provides that
 * surface, so assert the markers to keep the vendored copy from redefining
 * it. The header is force-included before the vendored sources are reached. */
#define _WINGDI_
#define WINGDI_ALREADY_INCLUDED
#define _WINUSER_
#define WINUSER_ALREADY_INCLUDED
#define _WINBASE_
#define WINBASE_ALREADY_INCLUDED

#pragma dylib(opengl32, "opengl32.dll")
#pragma binding(opengl32::wglCreateContext,      "wglCreateContext")
#pragma binding(opengl32::wglDeleteContext,      "wglDeleteContext")
#pragma binding(opengl32::wglMakeCurrent,        "wglMakeCurrent")
#pragma binding(opengl32::wglGetProcAddress,     "wglGetProcAddress")
#pragma binding(opengl32::wglGetCurrentDC,       "wglGetCurrentDC")
#pragma binding(opengl32::wglGetCurrentContext,  "wglGetCurrentContext")
#pragma binding(opengl32::wglShareLists,         "wglShareLists")

#pragma dylib(gdi32, "gdi32.dll")
#pragma binding(gdi32::ChoosePixelFormat,        "ChoosePixelFormat")
#pragma binding(gdi32::SetPixelFormat,           "SetPixelFormat")
#pragma binding(gdi32::DescribePixelFormat,      "DescribePixelFormat")
#pragma binding(gdi32::SwapBuffers,              "SwapBuffers")
#pragma binding(gdi32::GetDeviceCaps,            "GetDeviceCaps")
#pragma binding(gdi32::CreateBitmap,             "CreateBitmap")
#pragma binding(gdi32::CreateDIBSection,         "CreateDIBSection")
#pragma binding(gdi32::CreateCompatibleDC,       "CreateCompatibleDC")
#pragma binding(gdi32::DeleteDC,                 "DeleteDC")
#pragma binding(gdi32::DeleteObject,             "DeleteObject")
#pragma binding(gdi32::SelectObject,             "SelectObject")

#pragma dylib(user32, "user32.dll")
#pragma binding(user32::GetRawInputDeviceList,   "GetRawInputDeviceList")
#pragma binding(user32::GetRawInputDeviceInfoA,  "GetRawInputDeviceInfoA")
#pragma binding(user32::GetRawInputDeviceInfoW,  "GetRawInputDeviceInfoW")
#pragma binding(user32::CreateWindowExA,         "CreateWindowExA")
#pragma binding(user32::CreateWindowExW,         "CreateWindowExW")
#pragma binding(user32::RegisterClassA,          "RegisterClassA")
#pragma binding(user32::RegisterClassW,          "RegisterClassW")
#pragma binding(user32::DefWindowProcA,          "DefWindowProcA")
#pragma binding(user32::DefWindowProcW,          "DefWindowProcW")
#pragma binding(user32::GetPropW,                "GetPropW")
#pragma binding(user32::SetPropW,                "SetPropW")
#pragma binding(user32::RemovePropW,             "RemovePropW")
#pragma binding(user32::ShowWindow,              "ShowWindow")
#pragma binding(user32::GetDC,                   "GetDC")
#pragma binding(user32::ReleaseDC,               "ReleaseDC")
#pragma binding(user32::GetWindowRect,           "GetWindowRect")
#pragma binding(user32::GetClientRect,           "GetClientRect")
#pragma binding(user32::DestroyWindow,           "DestroyWindow")
#pragma binding(user32::PeekMessageA,            "PeekMessageA")
#pragma binding(user32::TranslateMessage,        "TranslateMessage")
#pragma binding(user32::DispatchMessageA,        "DispatchMessageA")
#pragma binding(user32::PostMessageW,            "PostMessageW")
#pragma binding(user32::MsgWaitForMultipleObjects, "MsgWaitForMultipleObjects")
#pragma binding(user32::LoadCursorA,             "LoadCursorA")
#pragma binding(user32::GetKeyState,             "GetKeyState")
#pragma binding(user32::GetKeyNameTextA,         "GetKeyNameTextA")
#pragma binding(user32::MapVirtualKeyA,          "MapVirtualKeyA")
#pragma binding(user32::ToAscii,                 "ToAscii")
#pragma binding(user32::GetRawInputData,         "GetRawInputData")
#pragma binding(user32::RegisterRawInputDevices, "RegisterRawInputDevices")
#pragma binding(user32::ClipCursor,              "ClipCursor")
#pragma binding(user32::GetCursorPos,            "GetCursorPos")
#pragma binding(user32::SetCursorPos,            "SetCursorPos")
#pragma binding(user32::ClientToScreen,          "ClientToScreen")
#pragma binding(user32::ScreenToClient,          "ScreenToClient")
#pragma binding(user32::IsWindow,                "IsWindow")
#pragma binding(user32::IsWindowVisible,         "IsWindowVisible")
#pragma binding(user32::GetWindowPlacement,      "GetWindowPlacement")
#pragma binding(user32::SetClassLongPtrA,        "SetClassLongPtrA")
#pragma binding(user32::SetCursor,               "SetCursor")
#pragma binding(user32::DestroyCursor,           "DestroyCursor")
#pragma binding(user32::CreateIconIndirect,      "CreateIconIndirect")
#pragma binding(user32::DestroyIcon,             "DestroyIcon")
#pragma binding(user32::SetWindowPos,            "SetWindowPos")
#pragma binding(user32::SetWindowTextA,          "SetWindowTextA")
#pragma binding(user32::GetWindowLongA,          "GetWindowLongA")
#pragma binding(user32::SetWindowLongA,          "SetWindowLongA")
#pragma binding(user32::GetWindowLongW,          "GetWindowLongW")
#pragma binding(user32::SetWindowLongW,          "SetWindowLongW")
#pragma binding(user32::GetLayeredWindowAttributes, "GetLayeredWindowAttributes")
#pragma binding(user32::SetLayeredWindowAttributes, "SetLayeredWindowAttributes")
#pragma binding(user32::GetSystemMetrics,        "GetSystemMetrics")
#pragma binding(user32::MonitorFromPoint,        "MonitorFromPoint")
#pragma binding(user32::MonitorFromWindow,       "MonitorFromWindow")
#pragma binding(user32::EnumDisplayMonitors,     "EnumDisplayMonitors")
#pragma binding(user32::EnumDisplayDevicesA,     "EnumDisplayDevicesA")
#pragma binding(user32::GetMonitorInfoA,         "GetMonitorInfoA")
#pragma binding(user32::SetProcessDPIAware,      "SetProcessDPIAware")
#pragma binding(user32::GetForegroundWindow,     "GetForegroundWindow")
#pragma binding(user32::OpenClipboard,           "OpenClipboard")
#pragma binding(user32::CloseClipboard,          "CloseClipboard")
#pragma binding(user32::GetClipboardData,        "GetClipboardData")
#pragma binding(user32::EmptyClipboard,          "EmptyClipboard")
#pragma binding(user32::SetClipboardData,        "SetClipboardData")
#pragma binding(user32::CharLowerBuffA,          "CharLowerBuffA")

#pragma dylib(shell32, "shell32.dll")
#pragma binding(shell32::DragAcceptFiles,        "DragAcceptFiles")
#pragma binding(shell32::DragQueryFileW,         "DragQueryFileW")
#pragma binding(shell32::DragQueryPoint,         "DragQueryPoint")
#pragma binding(shell32::DragFinish,             "DragFinish")

#pragma dylib(winmm, "winmm.dll")
#pragma binding(winmm::timeBeginPeriod,          "timeBeginPeriod")

#pragma dylib(advapi32, "advapi32.dll")
#pragma binding(advapi32::RegGetValueW,          "RegGetValueW")

#endif /* RGFW_WIN32_LINK_H */
