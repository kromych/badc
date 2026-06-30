/* AudioUnit surface used by the miniaudio CoreAudio backend: the output
 * audio unit, its scopes and property IDs, and the render callback. Property
 * ID and component constant values reproduce the canonical AudioToolbox
 * headers; the OS matches them. */
#ifndef _AUDIO_UNIT_H
#define _AUDIO_UNIT_H

#include <CoreAudio/CoreAudioTypes.h>
#include <AudioToolbox/AudioComponent.h>

typedef AudioComponentInstance AudioUnit;

typedef UInt32 AudioUnitPropertyID;
typedef UInt32 AudioUnitScope;
typedef UInt32 AudioUnitElement;
typedef UInt32 AudioUnitParameterID;
typedef UInt32 AudioUnitRenderActionFlags;

/* Render callback */
typedef OSStatus (*AURenderCallback)(void *inRefCon,
                                     AudioUnitRenderActionFlags *ioActionFlags,
                                     const AudioTimeStamp *inTimeStamp,
                                     UInt32 inBusNumber, UInt32 inNumberFrames,
                                     AudioBufferList *ioData);

struct AURenderCallbackStruct {
    AURenderCallback inputProc;
    void            *inputProcRefCon;
};
typedef struct AURenderCallbackStruct AURenderCallbackStruct;

typedef OSStatus (*AudioUnitPropertyListenerProc)(void *inRefCon, AudioUnit inUnit,
                                                  AudioUnitPropertyID inID,
                                                  AudioUnitScope inScope,
                                                  AudioUnitElement inElement);

/* Component identification (FourCharCode) */
#define kAudioUnitType_Output           0x61756F75u  /* 'auou' */
#define kAudioUnitSubType_HALOutput     0x6168616Cu  /* 'ahal' */
#define kAudioUnitSubType_DefaultOutput 0x64656620u  /* 'def ' */
#define kAudioUnitSubType_RemoteIO      0x72696F63u  /* 'rioc' */
#define kAudioUnitManufacturer_Apple    0x6170706Cu  /* 'appl' */

/* AudioUnit scopes */
#define kAudioUnitScope_Global 0
#define kAudioUnitScope_Input  1
#define kAudioUnitScope_Output 2

/* AudioUnit property IDs */
#define kAudioUnitProperty_StreamFormat          8
#define kAudioUnitProperty_MaximumFramesPerSlice 14
#define kAudioUnitProperty_AudioChannelLayout    19
#define kAudioUnitProperty_SetRenderCallback     23

/* Output unit property IDs */
#define kAudioOutputUnitProperty_CurrentDevice    2000
#define kAudioOutputUnitProperty_IsRunning        2001
#define kAudioOutputUnitProperty_EnableIO         2003
#define kAudioOutputUnitProperty_SetInputCallback 2005

/* AudioUnit error codes (OSStatus) */
#define kAudioUnitErr_TooManyFramesToProcess (-10874)

OSStatus AudioUnitInitialize(AudioUnit inUnit);
OSStatus AudioUnitUninitialize(AudioUnit inUnit);
OSStatus AudioUnitSetProperty(AudioUnit inUnit, AudioUnitPropertyID inID,
                              AudioUnitScope inScope, AudioUnitElement inElement,
                              const void *inData, UInt32 inDataSize);
OSStatus AudioUnitGetProperty(AudioUnit inUnit, AudioUnitPropertyID inID,
                              AudioUnitScope inScope, AudioUnitElement inElement,
                              void *outData, UInt32 *ioDataSize);
OSStatus AudioUnitGetPropertyInfo(AudioUnit inUnit, AudioUnitPropertyID inID,
                                  AudioUnitScope inScope, AudioUnitElement inElement,
                                  UInt32 *outDataSize, Boolean *outWriteable);
OSStatus AudioUnitAddPropertyListener(AudioUnit inUnit, AudioUnitPropertyID inID,
                                      AudioUnitPropertyListenerProc inProc,
                                      void *inProcUserData);
OSStatus AudioUnitRender(AudioUnit inUnit, AudioUnitRenderActionFlags *ioActionFlags,
                         const AudioTimeStamp *inTimeStamp, UInt32 inOutputBusNumber,
                         UInt32 inNumberFrames, AudioBufferList *ioData);
OSStatus AudioOutputUnitStart(AudioUnit inUnit);
OSStatus AudioOutputUnitStop(AudioUnit inUnit);

#endif /* _AUDIO_UNIT_H */
