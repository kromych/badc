/* X keysym values used by RGFW's keycode-to-character mapping
 * (demo-local). Latin-1 keysyms equal their ASCII codepoints. */
#ifndef _X11_KEYSYMDEF_H_
#define _X11_KEYSYMDEF_H_

#define XK_0 0x0030
#define XK_1 0x0031
#define XK_a 0x0061
#define XK_z 0x007a

/* Navigation, editing and lock keys. */
#define XK_Home 0xff50
#define XK_Left 0xff51
#define XK_Up 0xff52
#define XK_Right 0xff53
#define XK_Down 0xff54
#define XK_Page_Up 0xff55
#define XK_Page_Down 0xff56
#define XK_End 0xff57
#define XK_Print 0xff61
#define XK_Insert 0xff63
#define XK_Menu 0xff67
#define XK_Pause 0xff13
#define XK_Scroll_Lock 0xff14
#define XK_Num_Lock 0xff7f
#define XK_Delete 0xffff

/* Keypad. */
#define XK_KP_Enter 0xff8d
#define XK_KP_Multiply 0xffaa
#define XK_KP_Add 0xffab
#define XK_KP_Subtract 0xffad
#define XK_KP_Decimal 0xffae
#define XK_KP_Divide 0xffaf
#define XK_KP_Equal 0xffbd
#define XK_KP_0 0xffb0
#define XK_KP_1 0xffb1
#define XK_KP_2 0xffb2
#define XK_KP_3 0xffb3
#define XK_KP_4 0xffb4
#define XK_KP_5 0xffb5
#define XK_KP_6 0xffb6
#define XK_KP_7 0xffb7
#define XK_KP_8 0xffb8
#define XK_KP_9 0xffb9

/* Function keys. */
#define XK_F1 0xffbe
#define XK_F2 0xffbf
#define XK_F3 0xffc0
#define XK_F4 0xffc1
#define XK_F5 0xffc2
#define XK_F6 0xffc3
#define XK_F7 0xffc4
#define XK_F8 0xffc5
#define XK_F9 0xffc6
#define XK_F10 0xffc7
#define XK_F11 0xffc8
#define XK_F12 0xffc9
#define XK_F13 0xffca
#define XK_F14 0xffcb
#define XK_F15 0xffcc
#define XK_F16 0xffcd
#define XK_F17 0xffce
#define XK_F18 0xffcf
#define XK_F19 0xffd0
#define XK_F20 0xffd1
#define XK_F21 0xffd2
#define XK_F22 0xffd3
#define XK_F23 0xffd4
#define XK_F24 0xffd5
#define XK_F25 0xffd6

/* Modifiers. */
#define XK_Shift_L 0xffe1
#define XK_Shift_R 0xffe2
#define XK_Control_L 0xffe3
#define XK_Control_R 0xffe4
#define XK_Caps_Lock 0xffe5
#define XK_Meta_L 0xffe7
#define XK_Meta_R 0xffe8
#define XK_Alt_L 0xffe9
#define XK_Alt_R 0xffea
#define XK_Super_L 0xffeb
#define XK_Super_R 0xffec

#endif /* _X11_KEYSYMDEF_H_ */
