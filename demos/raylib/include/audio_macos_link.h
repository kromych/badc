/* macOS framework bindings for the miniaudio CoreAudio backend. Force-included
 * into raudio.c (the only translation unit that reaches the Core Audio calls)
 * so badc emits the LC_LOAD_DYLIB commands for the audio frameworks. raudio is
 * a separate translation unit from rcore, so CoreFoundation is declared here
 * too. miniaudio resolves the audio entry points through dlopen/dlsym at run
 * time by default; the dylib pragmas load the frameworks so otool -L lists
 * them, and the bindings cover the direct-link path. */
#ifndef AUDIO_MACOS_LINK_H
#define AUDIO_MACOS_LINK_H

/* badc targets aarch64/x86-64 but ships no <arm_neon.h> / <emmintrin.h>, so
 * the bundled FLAC decoder's NEON and SSE paths do not compile. Select its
 * scalar path, mirroring the image decoder's -DSTBIR_NO_SIMD. The MP3 decoder
 * is SIMD-only with no scalar fallback and is instead disabled at the format
 * level (SUPPORT_FILEFORMAT_MP3 left undefined). */
#define DRFLAC_NO_NEON
#define DRFLAC_NO_SSE2
#define DRFLAC_NO_SSE41

#pragma dylib(corefoundation, "/System/Library/Frameworks/CoreFoundation.framework/CoreFoundation")
#pragma binding(corefoundation::CFRelease, "_CFRelease")
#pragma binding(corefoundation::CFStringGetCString, "_CFStringGetCString")
#pragma binding(corefoundation::CFStringGetLength, "_CFStringGetLength")

#pragma dylib(coreaudio, "/System/Library/Frameworks/CoreAudio.framework/CoreAudio")
#pragma binding(coreaudio::AudioObjectGetPropertyData, "_AudioObjectGetPropertyData")
#pragma binding(coreaudio::AudioObjectGetPropertyDataSize, "_AudioObjectGetPropertyDataSize")
#pragma binding(coreaudio::AudioObjectSetPropertyData, "_AudioObjectSetPropertyData")
#pragma binding(coreaudio::AudioObjectAddPropertyListener, "_AudioObjectAddPropertyListener")
#pragma binding(coreaudio::AudioObjectRemovePropertyListener, "_AudioObjectRemovePropertyListener")

#pragma dylib(audiotoolbox, "/System/Library/Frameworks/AudioToolbox.framework/AudioToolbox")
#pragma binding(audiotoolbox::AudioComponentFindNext, "_AudioComponentFindNext")
#pragma binding(audiotoolbox::AudioComponentInstanceNew, "_AudioComponentInstanceNew")
#pragma binding(audiotoolbox::AudioComponentInstanceDispose, "_AudioComponentInstanceDispose")
#pragma binding(audiotoolbox::AudioComponentGetDescription, "_AudioComponentGetDescription")
#pragma binding(audiotoolbox::AudioUnitInitialize, "_AudioUnitInitialize")
#pragma binding(audiotoolbox::AudioUnitUninitialize, "_AudioUnitUninitialize")
#pragma binding(audiotoolbox::AudioUnitSetProperty, "_AudioUnitSetProperty")
#pragma binding(audiotoolbox::AudioUnitGetProperty, "_AudioUnitGetProperty")
#pragma binding(audiotoolbox::AudioUnitGetPropertyInfo, "_AudioUnitGetPropertyInfo")
#pragma binding(audiotoolbox::AudioUnitAddPropertyListener, "_AudioUnitAddPropertyListener")
#pragma binding(audiotoolbox::AudioUnitRender, "_AudioUnitRender")
#pragma binding(audiotoolbox::AudioOutputUnitStart, "_AudioOutputUnitStart")
#pragma binding(audiotoolbox::AudioOutputUnitStop, "_AudioOutputUnitStop")

/* Loaded so the output audio unit's symbols resolve; the AudioUnit framework
 * re-exports the AudioToolbox audio unit API. */
#pragma dylib(audiounit, "/System/Library/Frameworks/AudioUnit.framework/AudioUnit")

#endif /* AUDIO_MACOS_LINK_H */
