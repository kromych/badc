/* XKB slice used by RGFW on X11: keyboard state plus the key-name table it
 * walks to remap X11 keycodes onto evdev names. The record layouts mirror
 * XKBstr.h exactly because libX11 fills them through XkbGetMap / XkbGetNames /
 * XkbGetKeyboardByName and RGFW reads fields back by offset. */
#ifndef _X11_XKBLIB_H_
#define _X11_XKBLIB_H_

#include <X11/Xlib.h>

#define XkbUseCoreKbd 0x0100
#define XkbKeyNameLength 4
#define XkbNumVirtualMods 16
#define XkbNumIndicators 32
#define XkbNumKbdGroups 4
#define XkbKeyNamesMask (1L << 10)
#define XkbGBN_KeyNamesMask (1L << 5)

typedef struct { char name[XkbKeyNameLength]; } XkbKeyNameRec, *XkbKeyNamePtr;
typedef struct {
    char real[XkbKeyNameLength];
    char alias[XkbKeyNameLength];
} XkbKeyAliasRec, *XkbKeyAliasPtr;

typedef struct _XkbNamesRec {
    Atom keycodes;
    Atom geometry;
    Atom symbols;
    Atom types;
    Atom compat;
    Atom vmods[XkbNumVirtualMods];
    Atom indicators[XkbNumIndicators];
    Atom groups[XkbNumKbdGroups];
    XkbKeyNamePtr keys;
    XkbKeyAliasPtr key_aliases;
    Atom *radio_groups;
    Atom phys_symbols;
    unsigned char num_keys;
    unsigned char num_key_aliases;
    unsigned short num_rg;
} XkbNamesRec, *XkbNamesPtr;

typedef struct _XkbDesc {
    struct _XDisplay *dpy;
    unsigned short flags;
    unsigned short device_spec;
    unsigned char min_key_code;
    unsigned char max_key_code;
    void *ctrls;
    void *server;
    void *map;
    void *indicators;
    XkbNamesPtr names;
    void *compat;
    void *geom;
} XkbDescRec, *XkbDescPtr;

typedef struct _XkbStateRec {
    unsigned char group;
    unsigned char locked_group;
    unsigned short base_group;
    unsigned short latched_group;
    unsigned char mods;
    unsigned char base_mods;
    unsigned char latched_mods;
    unsigned char locked_mods;
    unsigned char compat_state;
    unsigned char grab_mods;
    unsigned char compat_grab_mods;
    unsigned char lookup_mods;
    unsigned char compat_lookup_mods;
    unsigned short ptr_buttons;
} XkbStateRec, *XkbStatePtr;

typedef struct _XkbComponentNames {
    unsigned short flags;
    char *keymap;
    char *keycodes;
    char *types;
    char *compat;
    char *symbols;
    char *geometry;
} XkbComponentNamesRec, *XkbComponentNamesPtr;

Bool XkbGetState(Display *dpy, unsigned int device_spec, XkbStatePtr state);
XkbDescPtr XkbGetMap(Display *dpy, unsigned int which, unsigned int device_spec);
Status XkbGetNames(Display *dpy, unsigned int which, XkbDescPtr desc);
XkbDescPtr XkbGetKeyboardByName(Display *dpy, unsigned int device_spec,
                               XkbComponentNamesPtr names, unsigned int want,
                               unsigned int need, Bool load);
void XkbFreeKeyboard(XkbDescPtr desc, unsigned int which, Bool free_all);

#endif /* _X11_XKBLIB_H_ */
