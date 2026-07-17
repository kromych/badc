/* AudioComponent surface used by the miniaudio CoreAudio backend to locate
 * and instantiate the output audio unit. Opaque component handles are
 * pointers; AudioComponentDescription matches the canonical layout. */
#ifndef _AUDIO_TOOLBOX_AUDIO_COMPONENT_H
#define _AUDIO_TOOLBOX_AUDIO_COMPONENT_H

#include <CoreAudio/CoreAudioTypes.h>

typedef struct OpaqueAudioComponent         *AudioComponent;
typedef struct OpaqueAudioComponentInstance *AudioComponentInstance;

typedef struct AudioComponentDescription {
    OSType componentType;
    OSType componentSubType;
    OSType componentManufacturer;
    UInt32 componentFlags;
    UInt32 componentFlagsMask;
} AudioComponentDescription;

AudioComponent AudioComponentFindNext(AudioComponent inComponent,
                                      const AudioComponentDescription *inDesc);
OSStatus AudioComponentInstanceNew(AudioComponent inComponent,
                                   AudioComponentInstance *outInstance);
OSStatus AudioComponentInstanceDispose(AudioComponentInstance inInstance);
OSStatus AudioComponentGetDescription(AudioComponent inComponent,
                                      AudioComponentDescription *outDesc);

#endif /* _AUDIO_TOOLBOX_AUDIO_COMPONENT_H */
