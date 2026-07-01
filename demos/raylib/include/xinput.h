/* Demo-local <xinput.h> for the RGFW desktop backend. On real Windows this
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

typedef struct _XINPUT_VIBRATION {
    WORD wLeftMotorSpeed;
    WORD wRightMotorSpeed;
} XINPUT_VIBRATION;

typedef struct _XINPUT_CAPABILITIES {
    BYTE             Type;
    BYTE             SubType;
    WORD             Flags;
    XINPUT_GAMEPAD   Gamepad;
    XINPUT_VIBRATION Vibration;
} XINPUT_CAPABILITIES;

#define XUSER_MAX_COUNT 4
#define XINPUT_CAPS_WIRELESS 0x0004

/* Controller subtypes reported in XINPUT_CAPABILITIES.SubType. */
#define XINPUT_DEVSUBTYPE_GAMEPAD      0x01
#define XINPUT_DEVSUBTYPE_WHEEL        0x02
#define XINPUT_DEVSUBTYPE_ARCADE_STICK 0x03
#define XINPUT_DEVSUBTYPE_FLIGHT_STICK 0x04
#define XINPUT_DEVSUBTYPE_DANCE_PAD    0x05
#define XINPUT_DEVSUBTYPE_GUITAR       0x06
#define XINPUT_DEVSUBTYPE_DRUM_KIT     0x08

/* XINPUT_GAMEPAD.wButtons masks. */
#define XINPUT_GAMEPAD_DPAD_UP        0x0001
#define XINPUT_GAMEPAD_DPAD_DOWN      0x0002
#define XINPUT_GAMEPAD_DPAD_LEFT      0x0004
#define XINPUT_GAMEPAD_DPAD_RIGHT     0x0008
#define XINPUT_GAMEPAD_START          0x0010
#define XINPUT_GAMEPAD_BACK           0x0020
#define XINPUT_GAMEPAD_LEFT_THUMB     0x0040
#define XINPUT_GAMEPAD_RIGHT_THUMB    0x0080
#define XINPUT_GAMEPAD_LEFT_SHOULDER  0x0100
#define XINPUT_GAMEPAD_RIGHT_SHOULDER 0x0200
#define XINPUT_GAMEPAD_A              0x1000
#define XINPUT_GAMEPAD_B              0x2000
#define XINPUT_GAMEPAD_X              0x4000
#define XINPUT_GAMEPAD_Y              0x8000

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
