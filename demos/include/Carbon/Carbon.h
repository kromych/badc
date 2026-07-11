/* Carbon slice used by RGFW on macOS: the Text Input Source + Unicode
 * key-translation types RGFW reads to map key codes to characters. RGFW
 * loads the TIS* accessors at runtime through CFBundle, so only their types
 * are declared here; UCKeyTranslate is called directly and bound at link. */
#ifndef _CARBON_CARBON_H
#define _CARBON_CARBON_H

#include <stdint.h>
#include <CoreFoundation/CoreFoundation.h>

typedef uint32_t UInt32;
typedef struct __TISInputSource *TISInputSourceRef;
typedef struct UCKeyboardLayout UCKeyboardLayout;
typedef uint16_t UniChar;
typedef unsigned long UniCharCount;
typedef int32_t OSStatus;
typedef uint32_t OptionBits;

#define kUCKeyActionDown 0
#define kUCKeyTranslateNoDeadKeysBit 0
#define noErr 0

OSStatus UCKeyTranslate(const UCKeyboardLayout *keyLayoutPtr,
                        uint16_t virtualKeyCode, uint16_t keyAction,
                        uint32_t modifierKeyState, uint32_t keyboardType,
                        OptionBits keyTranslateOptions, uint32_t *deadKeyState,
                        UniCharCount maxStringLength,
                        UniCharCount *actualStringLength, UniChar *unicodeString);

#endif /* _CARBON_CARBON_H */
