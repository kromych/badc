/* Demo-local <shellapi.h>. Drag-and-drop entry points RGFW calls (shell32.dll);
 * HDROP and the base types come from <windows.h>. */
#ifndef RGFW_DEMO_SHELLAPI_H
#define RGFW_DEMO_SHELLAPI_H

#include <windows.h>

void DragAcceptFiles(HWND hWnd, BOOL fAccept);
UINT DragQueryFileW(HDROP hDrop, UINT iFile, LPWSTR lpszFile, UINT cch);
BOOL DragQueryPoint(HDROP hDrop, LPPOINT ppt);
void DragFinish(HDROP hDrop);

#endif /* RGFW_DEMO_SHELLAPI_H */
