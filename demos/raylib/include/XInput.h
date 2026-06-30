/* Demo-local <XInput.h> for the RGFW desktop backend. On real Windows this
 * header transitively pulls in <windows.h> for the Win32 base types; do the
 * same here, then declare the XInput gamepad surface RGFW reads. Field order
 * and widths match the XInput ABI (xinput.h). */
#ifndef RGFW_DEMO_XINPUT_H
#define RGFW_DEMO_XINPUT_H

#include <windows.h>

typedef struct _XINPUT_GAMEPAD {
    WORD  wButtons;
    BYTE  bLeftTrigger;
    BYTE  bRightTrigger;
    SHORT sThumbLX;
    SHORT sThumbLY;
    SHORT sThumbRX;
    SHORT sThumbRY;
} XINPUT_GAMEPAD;

typedef struct _XINPUT_STATE {
    DWORD          dwPacketNumber;
    XINPUT_GAMEPAD Gamepad;
} XINPUT_STATE;

typedef struct _XINPUT_KEYSTROKE {
    WORD  VirtualKey;
    WCHAR Unicode;
    WORD  Flags;
    BYTE  UserIndex;
    BYTE  HidCode;
} XINPUT_KEYSTROKE;
typedef XINPUT_KEYSTROKE *PXINPUT_KEYSTROKE;

#define XINPUT_KEYSTROKE_KEYDOWN 0x0001
#define XINPUT_KEYSTROKE_KEYUP   0x0002
#define XINPUT_KEYSTROKE_REPEAT  0x0004

/* Highest XInput virtual key RGFW maps through its lookup table. */
#define VK_PAD_BACK 0x5815

#endif /* RGFW_DEMO_XINPUT_H */
