/* AudioObject / AudioHardware surface used by the miniaudio CoreAudio
 * backend for device enumeration and property queries. Selectors are the
 * canonical FourCharCode values; the framework provides the function bodies
 * at link time (resolved through the AudioObject API). */
#ifndef _CORE_AUDIO_HARDWARE_H
#define _CORE_AUDIO_HARDWARE_H

#include <CoreAudio/CoreAudioTypes.h>

typedef UInt32 AudioObjectID;
typedef UInt32 AudioDeviceID;
typedef UInt32 AudioObjectPropertySelector;
typedef UInt32 AudioObjectPropertyScope;
typedef UInt32 AudioObjectPropertyElement;

struct AudioObjectPropertyAddress {
    AudioObjectPropertySelector mSelector;
    AudioObjectPropertyScope    mScope;
    AudioObjectPropertyElement  mElement;
};
typedef struct AudioObjectPropertyAddress AudioObjectPropertyAddress;

typedef OSStatus (*AudioObjectPropertyListenerProc)(
    AudioObjectID inObjectID, UInt32 inNumberAddresses,
    const AudioObjectPropertyAddress *inAddresses, void *inClientData);

/* Well-known objects, scopes and elements */
#define kAudioObjectSystemObject            1
#define kAudioObjectPropertyScopeGlobal     0x676C6F62u  /* 'glob' */
#define kAudioObjectPropertyScopeInput      0x696E7074u  /* 'inpt' */
#define kAudioObjectPropertyScopeOutput     0x6F757470u  /* 'outp' */
/* Pre-10.8 selector names; miniaudio remaps the modern scope constants onto
 * these when the SDK version is unknown. Same selector fourccs. */
#define kAudioDevicePropertyScopeInput      0x696E7074u  /* 'inpt' */
#define kAudioDevicePropertyScopeOutput     0x6F757470u  /* 'outp' */
#define kAudioObjectPropertyElementMain     0
#define kAudioObjectPropertyElementMaster   0
#define kAudioObjectPropertyElementWildcard 0xFFFFFFFFu

/* AudioObject property selectors */
#define kAudioObjectPropertyName 0x6C6E616Du  /* 'lnam' */

/* AudioSystemObject / AudioHardware property selectors */
#define kAudioHardwarePropertyDevices             0x64657623u  /* 'dev#' */
#define kAudioHardwarePropertyDefaultInputDevice  0x64496E20u  /* 'dIn ' */
#define kAudioHardwarePropertyDefaultOutputDevice 0x644F7574u  /* 'dOut' */

/* AudioDevice property selectors */
#define kAudioDevicePropertyDeviceUID                   0x75696420u  /* 'uid ' */
#define kAudioDevicePropertyDeviceNameCFString          kAudioObjectPropertyName
#define kAudioDevicePropertyStreamConfiguration         0x736C6179u  /* 'slay' */
#define kAudioDevicePropertyNominalSampleRate           0x6E737274u  /* 'nsrt' */
#define kAudioDevicePropertyAvailableNominalSampleRates 0x6E737223u  /* 'nsr#' */
#define kAudioDevicePropertyBufferFrameSize             0x6673697Au  /* 'fsiz' */
#define kAudioDevicePropertyBufferFrameSizeRange        0x66737A23u  /* 'fsz#' */
#define kAudioDevicePropertyPreferredChannelLayout      0x73726E64u  /* 'srnd' */

/* AudioStream property selectors */
#define kAudioStreamPropertyAvailablePhysicalFormats 0x70667461u  /* 'pfta' */
#define kAudioStreamPropertyAvailableVirtualFormats  0x73666D61u  /* 'sfma' */

/* AudioHardware error codes (OSStatus) */
#define kAudioHardwareNoError                   0
#define kAudioHardwareNotRunningError           0x73746F70u  /* 'stop' */
#define kAudioHardwareUnspecifiedError          0x77686174u  /* 'what' */
#define kAudioHardwareUnknownPropertyError      0x77686F3Fu  /* 'who?' */
#define kAudioHardwareBadPropertySizeError      0x2173697Au  /* '!siz' */
#define kAudioHardwareIllegalOperationError     0x6E6F7065u  /* 'nope' */
#define kAudioHardwareBadObjectError            0x216F626Au  /* '!obj' */
#define kAudioHardwareBadDeviceError            0x21646576u  /* '!dev' */
#define kAudioHardwareBadStreamError            0x21737472u  /* '!str' */
#define kAudioHardwareUnsupportedOperationError 0x756E6F70u  /* 'unop' */
#define kAudioDeviceUnsupportedFormatError      0x21646174u  /* '!dat' */
#define kAudioDevicePermissionsError            0x21686F67u  /* '!hog' */

OSStatus AudioObjectGetPropertyData(AudioObjectID inObjectID,
                                    const AudioObjectPropertyAddress *inAddress,
                                    UInt32 inQualifierDataSize,
                                    const void *inQualifierData,
                                    UInt32 *ioDataSize, void *outData);
OSStatus AudioObjectGetPropertyDataSize(AudioObjectID inObjectID,
                                        const AudioObjectPropertyAddress *inAddress,
                                        UInt32 inQualifierDataSize,
                                        const void *inQualifierData,
                                        UInt32 *outDataSize);
OSStatus AudioObjectSetPropertyData(AudioObjectID inObjectID,
                                    const AudioObjectPropertyAddress *inAddress,
                                    UInt32 inQualifierDataSize,
                                    const void *inQualifierData,
                                    UInt32 inDataSize, const void *inData);
OSStatus AudioObjectAddPropertyListener(AudioObjectID inObjectID,
                                        const AudioObjectPropertyAddress *inAddress,
                                        AudioObjectPropertyListenerProc inListener,
                                        void *inClientData);
OSStatus AudioObjectRemovePropertyListener(AudioObjectID inObjectID,
                                           const AudioObjectPropertyAddress *inAddress,
                                           AudioObjectPropertyListenerProc inListener,
                                           void *inClientData);

#endif /* _CORE_AUDIO_HARDWARE_H */
