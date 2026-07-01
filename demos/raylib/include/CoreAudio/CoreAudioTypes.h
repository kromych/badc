/* CoreAudio base types used by the miniaudio CoreAudio backend. Layouts
 * reproduce <CoreAudioTypes/CoreAudioBaseTypes.h> exactly: the OS reads and
 * writes these structures, so field order and width are ABI-load-bearing.
 * FourCharCode constants are spelled as their integer values. */
#ifndef _CORE_AUDIO_TYPES_H
#define _CORE_AUDIO_TYPES_H

#include <CoreFoundation/CoreFoundation.h>

/* MacTypes integer and float aliases CoreAudio APIs are spelled in. */
typedef unsigned char       UInt8;
typedef signed char         SInt8;
typedef unsigned short      UInt16;
typedef signed short        SInt16;
typedef unsigned int        UInt32;
typedef signed int          SInt32;
typedef unsigned long long  UInt64;
typedef signed long long    SInt64;
typedef float               Float32;
typedef double              Float64;
typedef SInt32              OSStatus;
typedef UInt32              FourCharCode;
typedef FourCharCode        OSType;

typedef UInt32 AudioFormatID;
typedef UInt32 AudioFormatFlags;

#define noErr 0

/* AudioStreamBasicDescription */
struct AudioStreamBasicDescription {
    Float64          mSampleRate;
    AudioFormatID    mFormatID;
    AudioFormatFlags mFormatFlags;
    UInt32           mBytesPerPacket;
    UInt32           mFramesPerPacket;
    UInt32           mBytesPerFrame;
    UInt32           mChannelsPerFrame;
    UInt32           mBitsPerChannel;
    UInt32           mReserved;
};
typedef struct AudioStreamBasicDescription AudioStreamBasicDescription;

/* AudioFormatID values */
#define kAudioFormatLinearPCM 0x6C70636Du  /* 'lpcm' */

/* AudioFormatFlags / LinearPCM flags */
#define kAudioFormatFlagIsFloat              (1u << 0)
#define kAudioFormatFlagIsBigEndian          (1u << 1)
#define kAudioFormatFlagIsSignedInteger      (1u << 2)
#define kAudioFormatFlagIsPacked             (1u << 3)
#define kAudioFormatFlagIsAlignedHigh        (1u << 4)
#define kAudioFormatFlagIsNonInterleaved     (1u << 5)
#define kAudioFormatFlagIsNonMixable         (1u << 6)
#define kLinearPCMFormatFlagIsFloat          kAudioFormatFlagIsFloat
#define kLinearPCMFormatFlagIsBigEndian      kAudioFormatFlagIsBigEndian
#define kLinearPCMFormatFlagIsSignedInteger  kAudioFormatFlagIsSignedInteger
#define kLinearPCMFormatFlagIsPacked         kAudioFormatFlagIsPacked
#define kLinearPCMFormatFlagIsAlignedHigh    kAudioFormatFlagIsAlignedHigh
#define kLinearPCMFormatFlagIsNonInterleaved kAudioFormatFlagIsNonInterleaved
#define kLinearPCMFormatFlagIsNonMixable     kAudioFormatFlagIsNonMixable

/* AudioBuffer / AudioBufferList */
struct AudioBuffer {
    UInt32 mNumberChannels;
    UInt32 mDataByteSize;
    void  *mData;
};
typedef struct AudioBuffer AudioBuffer;

struct AudioBufferList {
    UInt32      mNumberBuffers;
    AudioBuffer mBuffers[1];
};
typedef struct AudioBufferList AudioBufferList;

/* SMPTETime / AudioTimeStamp */
typedef UInt32 SMPTETimeType;
typedef UInt32 SMPTETimeFlags;
typedef UInt32 AudioTimeStampFlags;

struct SMPTETime {
    SInt16         mSubframes;
    SInt16         mSubframeDivisor;
    UInt32         mCounter;
    SMPTETimeType  mType;
    SMPTETimeFlags mFlags;
    SInt16         mHours;
    SInt16         mMinutes;
    SInt16         mSeconds;
    SInt16         mFrames;
};
typedef struct SMPTETime SMPTETime;

struct AudioTimeStamp {
    Float64             mSampleTime;
    UInt64              mHostTime;
    Float64             mRateScalar;
    UInt64              mWordClockTime;
    SMPTETime           mSMPTETime;
    AudioTimeStampFlags mFlags;
    UInt32              mReserved;
};
typedef struct AudioTimeStamp AudioTimeStamp;

/* AudioValueRange / AudioStreamRangedDescription */
struct AudioValueRange {
    Float64 mMinimum;
    Float64 mMaximum;
};
typedef struct AudioValueRange AudioValueRange;

struct AudioStreamRangedDescription {
    AudioStreamBasicDescription mFormat;
    AudioValueRange             mSampleRateRange;
};
typedef struct AudioStreamRangedDescription AudioStreamRangedDescription;

/* Channel layout */
typedef UInt32 AudioChannelLabel;
typedef UInt32 AudioChannelLayoutTag;
typedef UInt32 AudioChannelBitmap;
typedef UInt32 AudioChannelFlags;

struct AudioChannelDescription {
    AudioChannelLabel mChannelLabel;
    AudioChannelFlags mChannelFlags;
    Float32           mCoordinates[3];
};
typedef struct AudioChannelDescription AudioChannelDescription;

struct AudioChannelLayout {
    AudioChannelLayoutTag   mChannelLayoutTag;
    AudioChannelBitmap      mChannelBitmap;
    UInt32                  mNumberChannelDescriptions;
    AudioChannelDescription mChannelDescriptions[1];
};
typedef struct AudioChannelLayout AudioChannelLayout;

/* AudioChannelLabel values */
#define kAudioChannelLabel_Unknown              0xFFFFFFFFu
#define kAudioChannelLabel_Unused               0
#define kAudioChannelLabel_UseCoordinates       100
#define kAudioChannelLabel_Left                 1
#define kAudioChannelLabel_Right                2
#define kAudioChannelLabel_Center               3
#define kAudioChannelLabel_LFEScreen            4
#define kAudioChannelLabel_LeftSurround         5
#define kAudioChannelLabel_RightSurround        6
#define kAudioChannelLabel_LeftCenter           7
#define kAudioChannelLabel_RightCenter          8
#define kAudioChannelLabel_CenterSurround       9
#define kAudioChannelLabel_LeftSurroundDirect   10
#define kAudioChannelLabel_RightSurroundDirect  11
#define kAudioChannelLabel_TopCenterSurround    12
#define kAudioChannelLabel_VerticalHeightLeft   13
#define kAudioChannelLabel_VerticalHeightCenter 14
#define kAudioChannelLabel_VerticalHeightRight  15
#define kAudioChannelLabel_TopBackLeft          16
#define kAudioChannelLabel_TopBackCenter        17
#define kAudioChannelLabel_TopBackRight         18
#define kAudioChannelLabel_RearSurroundLeft     33
#define kAudioChannelLabel_RearSurroundRight    34
#define kAudioChannelLabel_LeftWide             35
#define kAudioChannelLabel_RightWide            36
#define kAudioChannelLabel_LFE2                 37
#define kAudioChannelLabel_LeftTotal            38
#define kAudioChannelLabel_RightTotal           39
#define kAudioChannelLabel_HearingImpaired      40
#define kAudioChannelLabel_Narration            41
#define kAudioChannelLabel_Mono                 42
#define kAudioChannelLabel_DialogCentricMix     43
#define kAudioChannelLabel_CenterSurroundDirect 44
#define kAudioChannelLabel_Haptic               45
#define kAudioChannelLabel_Ambisonic_W          200
#define kAudioChannelLabel_Ambisonic_X          201
#define kAudioChannelLabel_Ambisonic_Y          202
#define kAudioChannelLabel_Ambisonic_Z          203
#define kAudioChannelLabel_MS_Mid               204
#define kAudioChannelLabel_MS_Side              205
#define kAudioChannelLabel_XY_X                 206
#define kAudioChannelLabel_XY_Y                 207
#define kAudioChannelLabel_HeadphonesLeft       301
#define kAudioChannelLabel_HeadphonesRight      302
#define kAudioChannelLabel_ClickTrack           304
#define kAudioChannelLabel_ForeignLanguage      305
#define kAudioChannelLabel_Discrete             400
#define kAudioChannelLabel_Discrete_0           ((1u << 16) | 0)
#define kAudioChannelLabel_Discrete_1           ((1u << 16) | 1)
#define kAudioChannelLabel_Discrete_2           ((1u << 16) | 2)
#define kAudioChannelLabel_Discrete_3           ((1u << 16) | 3)
#define kAudioChannelLabel_Discrete_4           ((1u << 16) | 4)
#define kAudioChannelLabel_Discrete_5           ((1u << 16) | 5)
#define kAudioChannelLabel_Discrete_6           ((1u << 16) | 6)
#define kAudioChannelLabel_Discrete_7           ((1u << 16) | 7)
#define kAudioChannelLabel_Discrete_8           ((1u << 16) | 8)
#define kAudioChannelLabel_Discrete_9           ((1u << 16) | 9)
#define kAudioChannelLabel_Discrete_10          ((1u << 16) | 10)
#define kAudioChannelLabel_Discrete_11          ((1u << 16) | 11)
#define kAudioChannelLabel_Discrete_12          ((1u << 16) | 12)
#define kAudioChannelLabel_Discrete_13          ((1u << 16) | 13)
#define kAudioChannelLabel_Discrete_14          ((1u << 16) | 14)
#define kAudioChannelLabel_Discrete_15          ((1u << 16) | 15)
#define kAudioChannelLabel_Discrete_65535       ((1u << 16) | 65535)
#define kAudioChannelLabel_HOA_ACN              500
#define kAudioChannelLabel_HOA_ACN_0            ((2u << 16) | 0)
#define kAudioChannelLabel_HOA_ACN_1            ((2u << 16) | 1)
#define kAudioChannelLabel_HOA_ACN_2            ((2u << 16) | 2)
#define kAudioChannelLabel_HOA_ACN_3            ((2u << 16) | 3)
#define kAudioChannelLabel_HOA_ACN_4            ((2u << 16) | 4)
#define kAudioChannelLabel_HOA_ACN_5            ((2u << 16) | 5)
#define kAudioChannelLabel_HOA_ACN_6            ((2u << 16) | 6)
#define kAudioChannelLabel_HOA_ACN_7            ((2u << 16) | 7)
#define kAudioChannelLabel_HOA_ACN_8            ((2u << 16) | 8)
#define kAudioChannelLabel_HOA_ACN_9            ((2u << 16) | 9)
#define kAudioChannelLabel_HOA_ACN_10           ((2u << 16) | 10)
#define kAudioChannelLabel_HOA_ACN_11           ((2u << 16) | 11)
#define kAudioChannelLabel_HOA_ACN_12           ((2u << 16) | 12)
#define kAudioChannelLabel_HOA_ACN_13           ((2u << 16) | 13)
#define kAudioChannelLabel_HOA_ACN_14           ((2u << 16) | 14)
#define kAudioChannelLabel_HOA_ACN_15           ((2u << 16) | 15)
#define kAudioChannelLabel_HOA_ACN_65024        ((2u << 16) | 65024)

/* AudioChannelBitmap bit positions */
#define kAudioChannelBit_Left                  (1u << 0)
#define kAudioChannelBit_Right                 (1u << 1)
#define kAudioChannelBit_Center                (1u << 2)
#define kAudioChannelBit_LFEScreen             (1u << 3)
#define kAudioChannelBit_LeftSurround          (1u << 4)
#define kAudioChannelBit_RightSurround         (1u << 5)
#define kAudioChannelBit_LeftCenter            (1u << 6)
#define kAudioChannelBit_RightCenter           (1u << 7)
#define kAudioChannelBit_CenterSurround        (1u << 8)
#define kAudioChannelBit_LeftSurroundDirect    (1u << 9)
#define kAudioChannelBit_RightSurroundDirect   (1u << 10)
#define kAudioChannelBit_TopCenterSurround     (1u << 11)
#define kAudioChannelBit_VerticalHeightLeft    (1u << 12)
#define kAudioChannelBit_VerticalHeightCenter  (1u << 13)
#define kAudioChannelBit_VerticalHeightRight   (1u << 14)
#define kAudioChannelBit_TopBackLeft           (1u << 15)
#define kAudioChannelBit_TopBackCenter         (1u << 16)
#define kAudioChannelBit_TopBackRight          (1u << 17)

/* AudioChannelLayoutTag values: (descriptor << 16) | channel count */
#define kAudioChannelLayoutTag_UseChannelDescriptions ((0u << 16) | 0)
#define kAudioChannelLayoutTag_UseChannelBitmap       ((1u << 16) | 0)
#define kAudioChannelLayoutTag_Mono                   ((100u << 16) | 1)
#define kAudioChannelLayoutTag_Stereo                 ((101u << 16) | 2)
#define kAudioChannelLayoutTag_StereoHeadphones       ((102u << 16) | 2)
#define kAudioChannelLayoutTag_MatrixStereo           ((103u << 16) | 2)
#define kAudioChannelLayoutTag_MidSide                ((104u << 16) | 2)
#define kAudioChannelLayoutTag_XY                     ((105u << 16) | 2)
#define kAudioChannelLayoutTag_Binaural               ((106u << 16) | 2)
#define kAudioChannelLayoutTag_Ambisonic_B_Format     ((107u << 16) | 4)
#define kAudioChannelLayoutTag_Quadraphonic           ((108u << 16) | 4)
#define kAudioChannelLayoutTag_Pentagonal             ((109u << 16) | 5)
#define kAudioChannelLayoutTag_Hexagonal              ((110u << 16) | 6)
#define kAudioChannelLayoutTag_Octagonal              ((111u << 16) | 8)

/* The low 16 bits of a layout tag hold the channel count. */
static UInt32 AudioChannelLayoutTag_GetNumberOfChannels(AudioChannelLayoutTag inLayoutTag) {
    return (UInt32)(inLayoutTag & 0x0000FFFFu);
}

#endif /* _CORE_AUDIO_TYPES_H */
