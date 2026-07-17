/* HID usage constants used by RGFW's minigamepad backend on macOS: the
 * Generic Desktop and Button usage pages the gamepad element walk matches.
 * Values are from the USB HID Usage Tables. */
#ifndef _IOKIT_HID_IOHIDUSAGETABLES_H
#define _IOKIT_HID_IOHIDUSAGETABLES_H

#define kHIDPage_GenericDesktop 0x01
#define kHIDPage_Button         0x09

#define kHIDUsage_GD_Joystick            0x04
#define kHIDUsage_GD_GamePad             0x05
#define kHIDUsage_GD_MultiAxisController 0x08

#define kHIDUsage_GD_X  0x30
#define kHIDUsage_GD_Y  0x31
#define kHIDUsage_GD_Z  0x32
#define kHIDUsage_GD_Rx 0x33
#define kHIDUsage_GD_Ry 0x34
#define kHIDUsage_GD_Rz 0x35

#define kHIDUsage_GD_Start          0x3D
#define kHIDUsage_GD_Select         0x3E
#define kHIDUsage_GD_SystemMainMenu 0x86
#define kHIDUsage_GD_DPadUp         0x90
#define kHIDUsage_GD_DPadDown       0x91
#define kHIDUsage_GD_DPadRight      0x92
#define kHIDUsage_GD_DPadLeft       0x93

#define kHIDUsage_Button_1 0x01
#define kHIDUsage_Button_2 0x02
#define kHIDUsage_Button_3 0x03
#define kHIDUsage_Button_4 0x04
#define kHIDUsage_Button_5 0x05
#define kHIDUsage_Button_6 0x06
#define kHIDUsage_Button_7 0x07
#define kHIDUsage_Button_8 0x08
#define kHIDUsage_Button_9 0x09
#define kHIDUsage_Button_10 0x0A

#endif /* _IOKIT_HID_IOHIDUSAGETABLES_H */
