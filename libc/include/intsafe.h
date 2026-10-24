// intsafe.h -- mingw-w64's overflow-checked integer conversions and
// arithmetic over the Windows integer types, and the limits of those types.
// Each function stores the converted value or the result and returns S_OK,
// or stores the error value (0 for UCHAR, all bits set otherwise) and returns
// INTSAFE_E_ARITHMETIC_OVERFLOW when the value does not fit the result type.

#pragma once

#ifdef _WIN32

#include <windows.h>

// The limits <limits.h> and <stdint.h> also define keep their definitions.
#ifndef INT8_MIN
#define INT8_MIN (-128)
#endif
#ifndef INT8_MAX
#define INT8_MAX 127
#endif
#ifndef UINT8_MAX
#define UINT8_MAX 255
#endif
#define BYTE_MAX 255
#ifndef INT16_MIN
#define INT16_MIN (-32768)
#endif
#ifndef INT16_MAX
#define INT16_MAX 32767
#endif
#define SHORT_MIN (-32768)
#define SHORT_MAX 32767
#ifndef UINT16_MAX
#define UINT16_MAX 65535
#endif
#define USHORT_MAX 65535
#define WORD_MAX 65535
#ifndef INT32_MIN
#define INT32_MIN (-0x7fffffff - 1)
#endif
#ifndef INT32_MAX
#define INT32_MAX 0x7fffffff
#endif
#ifndef INT_MIN
#define INT_MIN (-0x7fffffff - 1)
#endif
#ifndef INT_MAX
#define INT_MAX 0x7fffffff
#endif
#ifndef UINT32_MAX
#define UINT32_MAX 0xffffffffu
#endif
#ifndef UINT_MAX
#define UINT_MAX 0xffffffffu
#endif
#define DWORD_MAX 0xfffffffful
#ifndef INT64_MIN
#define INT64_MIN (-0x7fffffffffffffff - 1)
#endif
#ifndef INT64_MAX
#define INT64_MAX 0x7fffffffffffffff
#endif
#define LONGLONG_MIN (-0x7fffffffffffffffll - 1)
#define LONG64_MIN (-0x7fffffffffffffffll - 1)
#define LONGLONG_MAX 0x7fffffffffffffffll
#define LONG64_MAX 0x7fffffffffffffffll
#ifndef UINT64_MAX
#define UINT64_MAX 0xffffffffffffffffu
#endif
#define ULONGLONG_MAX 0xffffffffffffffffull
#define ULONG64_MAX 0xffffffffffffffffull
#define DWORDLONG_MAX 0xffffffffffffffffull
#define DWORD64_MAX 0xffffffffffffffffull
#ifndef LONG_MIN
#define LONG_MIN (-0x7fffffffl - 1)
#endif
#ifndef LONG_MAX
#define LONG_MAX 0x7fffffffl
#endif
#ifndef ULONG_MAX
#define ULONG_MAX 0xfffffffful
#endif
#ifdef _WIN64
#define PTRDIFF_T_MIN (-0x7fffffffffffffff - 1)
#define PTRDIFF_T_MAX 0x7fffffffffffffff
#define SIZE_T_MAX 0xffffffffffffffffu
#define INT_PTR_MIN (-0x7fffffffffffffffll - 1)
#define INT_PTR_MAX 0x7fffffffffffffffll
#define UINT_PTR_MAX 0xffffffffffffffffull
#define LONG_PTR_MIN (-0x7fffffffffffffffll - 1)
#define LONG_PTR_MAX 0x7fffffffffffffffll
#define ULONG_PTR_MAX 0xffffffffffffffffull
#else
#define PTRDIFF_T_MIN (-0x7fffffff - 1)
#define PTRDIFF_T_MAX 0x7fffffff
#define SIZE_T_MAX 0xffffffffu
#define INT_PTR_MIN (-0x7fffffff - 1)
#define INT_PTR_MAX 0x7fffffff
#define UINT_PTR_MAX 0xffffffffu
#define LONG_PTR_MIN (-0x7fffffffl - 1)
#define LONG_PTR_MAX 0x7fffffffl
#define ULONG_PTR_MAX 0xfffffffful
#endif
#define SSIZE_T_MIN LONG_PTR_MIN
#define SSIZE_T_MAX LONG_PTR_MAX
#define _SIZE_T_MAX ULONG_PTR_MAX
#define DWORD_PTR_MAX ULONG_PTR_MAX

#define INTSAFE_E_ARITHMETIC_OVERFLOW ((HRESULT)0x80070216)
#ifndef S_OK
#define S_OK ((HRESULT)0)
#endif

// A conversion fits when converting back gives the operand and keeps its sign.
#define __badc_intsafe_conv(name, src, dst, error)                                   \
    static inline HRESULT name(src operand, dst *result)                             \
    {                                                                                \
        if ((src)(dst)operand != operand || ((dst)operand < (dst)0) != (operand < (src)0)) { \
            *result = (dst)(error);                                                  \
            return INTSAFE_E_ARITHMETIC_OVERFLOW;                                    \
        }                                                                            \
        *result = (dst)operand;                                                      \
        return S_OK;                                                                 \
    }
#define __badc_intsafe_math(name, type, operation)                                   \
    static inline HRESULT name(type x, type y, type *result)                         \
    {                                                                                \
        if (__builtin_##operation##_overflow(x, y, result)) {                        \
            *result = (type)~0;                                                      \
            return INTSAFE_E_ARITHMETIC_OVERFLOW;                                    \
        }                                                                            \
        return S_OK;                                                                 \
    }
#ifdef __CHAR_UNSIGNED__
#define __badc_intsafe_char_error 0
#else
#define __badc_intsafe_char_error ~0
#endif

__badc_intsafe_conv(UInt8ToInt8, UINT8, INT8, ~0)
__badc_intsafe_conv(UInt8ToChar, UINT8, CHAR, __badc_intsafe_char_error)
__badc_intsafe_conv(ByteToInt8, BYTE, INT8, ~0)
__badc_intsafe_conv(ByteToChar, BYTE, CHAR, __badc_intsafe_char_error)
__badc_intsafe_conv(Int8ToUChar, INT8, UCHAR, 0)
__badc_intsafe_conv(Int8ToUInt8, INT8, UINT8, ~0)
__badc_intsafe_conv(Int8ToUShort, INT8, USHORT, ~0)
__badc_intsafe_conv(Int8ToUInt, INT8, UINT, ~0)
__badc_intsafe_conv(Int8ToULong, INT8, ULONG, ~0)
__badc_intsafe_conv(Int8ToUIntPtr, INT8, UINT_PTR, ~0)
__badc_intsafe_conv(Int8ToULongPtr, INT8, ULONG_PTR, ~0)
__badc_intsafe_conv(Int8ToULongLong, INT8, ULONGLONG, ~0)
__badc_intsafe_conv(UShortToUChar, USHORT, UCHAR, 0)
__badc_intsafe_conv(UShortToUInt8, USHORT, UINT8, ~0)
__badc_intsafe_conv(UShortToByte, USHORT, BYTE, ~0)
__badc_intsafe_conv(UShortToInt8, USHORT, INT8, ~0)
__badc_intsafe_conv(UShortToShort, USHORT, SHORT, ~0)
__badc_intsafe_conv(UShortToChar, USHORT, CHAR, __badc_intsafe_char_error)
__badc_intsafe_conv(WordToUChar, WORD, UCHAR, 0)
__badc_intsafe_conv(WordToByte, WORD, BYTE, ~0)
__badc_intsafe_conv(WordToShort, WORD, SHORT, ~0)
__badc_intsafe_conv(WordToChar, WORD, CHAR, __badc_intsafe_char_error)
__badc_intsafe_conv(ShortToUChar, SHORT, UCHAR, 0)
__badc_intsafe_conv(ShortToUInt8, SHORT, UINT8, ~0)
__badc_intsafe_conv(ShortToByte, SHORT, BYTE, ~0)
__badc_intsafe_conv(ShortToInt8, SHORT, INT8, ~0)
__badc_intsafe_conv(ShortToUShort, SHORT, USHORT, ~0)
__badc_intsafe_conv(ShortToWord, SHORT, WORD, ~0)
__badc_intsafe_conv(ShortToUInt, SHORT, UINT, ~0)
__badc_intsafe_conv(ShortToULong, SHORT, ULONG, ~0)
__badc_intsafe_conv(ShortToUIntPtr, SHORT, UINT_PTR, ~0)
__badc_intsafe_conv(ShortToULongPtr, SHORT, ULONG_PTR, ~0)
__badc_intsafe_conv(ShortToDWordPtr, SHORT, DWORD_PTR, ~0)
__badc_intsafe_conv(ShortToULongLong, SHORT, ULONGLONG, ~0)
__badc_intsafe_conv(ShortToChar, SHORT, CHAR, __badc_intsafe_char_error)
__badc_intsafe_conv(UIntToUChar, UINT, UCHAR, 0)
__badc_intsafe_conv(UIntToUInt8, UINT, UINT8, ~0)
__badc_intsafe_conv(UIntToByte, UINT, BYTE, ~0)
__badc_intsafe_conv(UIntToInt8, UINT, INT8, ~0)
__badc_intsafe_conv(UIntToUShort, UINT, USHORT, ~0)
__badc_intsafe_conv(UIntToWord, UINT, WORD, ~0)
__badc_intsafe_conv(UIntToShort, UINT, SHORT, ~0)
__badc_intsafe_conv(UIntToLong, UINT, LONG, ~0)
__badc_intsafe_conv(UIntToInt, UINT, INT, ~0)
__badc_intsafe_conv(UIntToIntPtr, UINT, INT_PTR, ~0)
__badc_intsafe_conv(UIntToPtrdiffT, UINT, ptrdiff_t, ~0)
__badc_intsafe_conv(UIntToLongPtr, UINT, LONG_PTR, ~0)
__badc_intsafe_conv(UIntToSSIZET, UINT, SSIZE_T, ~0)
__badc_intsafe_conv(UIntToChar, UINT, CHAR, __badc_intsafe_char_error)
__badc_intsafe_conv(ULongToUChar, ULONG, UCHAR, 0)
__badc_intsafe_conv(ULongToUInt8, ULONG, UINT8, ~0)
__badc_intsafe_conv(ULongToByte, ULONG, BYTE, ~0)
__badc_intsafe_conv(ULongToInt8, ULONG, INT8, ~0)
__badc_intsafe_conv(ULongToUShort, ULONG, USHORT, ~0)
__badc_intsafe_conv(ULongToWord, ULONG, WORD, ~0)
__badc_intsafe_conv(ULongToShort, ULONG, SHORT, ~0)
__badc_intsafe_conv(ULongToUInt, ULONG, UINT, ~0)
__badc_intsafe_conv(ULongToLong, ULONG, LONG, ~0)
__badc_intsafe_conv(ULongToInt, ULONG, INT, ~0)
__badc_intsafe_conv(ULongToUIntPtr, ULONG, UINT_PTR, ~0)
__badc_intsafe_conv(ULongToIntPtr, ULONG, INT_PTR, ~0)
__badc_intsafe_conv(ULongToPtrdiffT, ULONG, ptrdiff_t, ~0)
__badc_intsafe_conv(ULongToLongPtr, ULONG, LONG_PTR, ~0)
__badc_intsafe_conv(ULongToSSIZET, ULONG, SSIZE_T, ~0)
__badc_intsafe_conv(ULongToChar, ULONG, CHAR, __badc_intsafe_char_error)
__badc_intsafe_conv(DWordToUChar, DWORD, UCHAR, 0)
__badc_intsafe_conv(DWordToByte, DWORD, BYTE, ~0)
__badc_intsafe_conv(DWordToUShort, DWORD, USHORT, ~0)
__badc_intsafe_conv(DWordToWord, DWORD, WORD, ~0)
__badc_intsafe_conv(DWordToShort, DWORD, SHORT, ~0)
__badc_intsafe_conv(DWordToUInt, DWORD, UINT, ~0)
__badc_intsafe_conv(DWordToLong, DWORD, LONG, ~0)
__badc_intsafe_conv(DWordToInt, DWORD, INT, ~0)
__badc_intsafe_conv(DWordToUIntPtr, DWORD, UINT_PTR, ~0)
__badc_intsafe_conv(DWordToIntPtr, DWORD, INT_PTR, ~0)
__badc_intsafe_conv(DWordToPtrdiffT, DWORD, ptrdiff_t, ~0)
__badc_intsafe_conv(DWordToLongPtr, DWORD, LONG_PTR, ~0)
__badc_intsafe_conv(DWordToSSIZET, DWORD, SSIZE_T, ~0)
__badc_intsafe_conv(DWordToChar, DWORD, CHAR, __badc_intsafe_char_error)
__badc_intsafe_conv(LongToUChar, LONG, UCHAR, 0)
__badc_intsafe_conv(LongToUInt8, LONG, UINT8, ~0)
__badc_intsafe_conv(LongToByte, LONG, BYTE, ~0)
__badc_intsafe_conv(LongToInt8, LONG, INT8, ~0)
__badc_intsafe_conv(LongToUShort, LONG, USHORT, ~0)
__badc_intsafe_conv(LongToWord, LONG, WORD, ~0)
__badc_intsafe_conv(LongToShort, LONG, SHORT, ~0)
__badc_intsafe_conv(LongToUInt, LONG, UINT, ~0)
__badc_intsafe_conv(LongToULong, LONG, ULONG, ~0)
__badc_intsafe_conv(LongToDWord, LONG, DWORD, ~0)
__badc_intsafe_conv(LongToInt, LONG, INT, ~0)
__badc_intsafe_conv(LongToUIntPtr, LONG, UINT_PTR, ~0)
__badc_intsafe_conv(LongToSizeT, LONG, size_t, ~0)
__badc_intsafe_conv(LongToULongPtr, LONG, ULONG_PTR, ~0)
__badc_intsafe_conv(LongToDWordPtr, LONG, DWORD_PTR, ~0)
__badc_intsafe_conv(LongToIntPtr, LONG, INT_PTR, ~0)
__badc_intsafe_conv(LongToPtrdiffT, LONG, ptrdiff_t, ~0)
__badc_intsafe_conv(LongToULongLong, LONG, ULONGLONG, ~0)
__badc_intsafe_conv(LongToChar, LONG, CHAR, __badc_intsafe_char_error)
__badc_intsafe_conv(IntToUChar, INT, UCHAR, 0)
__badc_intsafe_conv(IntToUInt8, INT, UINT8, ~0)
__badc_intsafe_conv(IntToByte, INT, BYTE, ~0)
__badc_intsafe_conv(IntToInt8, INT, INT8, ~0)
__badc_intsafe_conv(IntToUShort, INT, USHORT, ~0)
__badc_intsafe_conv(IntToWord, INT, WORD, ~0)
__badc_intsafe_conv(IntToShort, INT, SHORT, ~0)
__badc_intsafe_conv(IntToUInt, INT, UINT, ~0)
__badc_intsafe_conv(IntToULong, INT, ULONG, ~0)
__badc_intsafe_conv(IntToDWord, INT, DWORD, ~0)
__badc_intsafe_conv(IntToUIntPtr, INT, UINT_PTR, ~0)
__badc_intsafe_conv(IntToSizeT, INT, size_t, ~0)
__badc_intsafe_conv(IntToULongPtr, INT, ULONG_PTR, ~0)
__badc_intsafe_conv(IntToDWordPtr, INT, DWORD_PTR, ~0)
__badc_intsafe_conv(IntToULongLong, INT, ULONGLONG, ~0)
__badc_intsafe_conv(IntToChar, INT, CHAR, __badc_intsafe_char_error)
__badc_intsafe_conv(UIntPtrToUChar, UINT_PTR, UCHAR, 0)
__badc_intsafe_conv(UIntPtrToUInt8, UINT_PTR, UINT8, ~0)
__badc_intsafe_conv(UIntPtrToInt8, UINT_PTR, INT8, ~0)
__badc_intsafe_conv(UIntPtrToUInt16, UINT_PTR, UINT16, ~0)
__badc_intsafe_conv(UIntPtrToUShort, UINT_PTR, USHORT, ~0)
__badc_intsafe_conv(UIntPtrToInt16, UINT_PTR, INT16, ~0)
__badc_intsafe_conv(UIntPtrToShort, UINT_PTR, SHORT, ~0)
__badc_intsafe_conv(UIntPtrToUInt, UINT_PTR, UINT, ~0)
__badc_intsafe_conv(UIntPtrToULong, UINT_PTR, ULONG, ~0)
__badc_intsafe_conv(UIntPtrToDWord, UINT_PTR, DWORD, ~0)
__badc_intsafe_conv(UIntPtrToLong, UINT_PTR, LONG, ~0)
__badc_intsafe_conv(UIntPtrToInt, UINT_PTR, INT, ~0)
__badc_intsafe_conv(UIntPtrToIntPtr, UINT_PTR, INT_PTR, ~0)
__badc_intsafe_conv(UIntPtrToLongPtr, UINT_PTR, LONG_PTR, ~0)
__badc_intsafe_conv(UIntPtrToSSIZET, UINT_PTR, SSIZE_T, ~0)
__badc_intsafe_conv(UIntPtrToInt64, UINT_PTR, INT64, ~0)
__badc_intsafe_conv(UIntPtrToLongLong, UINT_PTR, LONGLONG, ~0)
__badc_intsafe_conv(UIntPtrToChar, UINT_PTR, CHAR, __badc_intsafe_char_error)
__badc_intsafe_conv(SizeTToUInt, size_t, UINT, ~0)
__badc_intsafe_conv(SizeTToULong, size_t, ULONG, ~0)
__badc_intsafe_conv(SizeTToDWord, size_t, DWORD, ~0)
__badc_intsafe_conv(SizeTToLong, size_t, LONG, ~0)
__badc_intsafe_conv(SizeTToInt, size_t, INT, ~0)
__badc_intsafe_conv(SizeTToIntPtr, size_t, INT_PTR, ~0)
__badc_intsafe_conv(SizeTToPtrdiffT, size_t, ptrdiff_t, ~0)
__badc_intsafe_conv(SizeTToLongPtr, size_t, LONG_PTR, ~0)
__badc_intsafe_conv(SizeTToSSIZET, size_t, SSIZE_T, ~0)
__badc_intsafe_conv(SizeTToInt64, size_t, INT64, ~0)
__badc_intsafe_conv(SizeTToUInt32, size_t, UINT32, ~0)
__badc_intsafe_conv(ULongPtrToUChar, ULONG_PTR, UCHAR, 0)
__badc_intsafe_conv(ULongPtrToUInt8, ULONG_PTR, UINT8, ~0)
__badc_intsafe_conv(ULongPtrToInt8, ULONG_PTR, INT8, ~0)
__badc_intsafe_conv(ULongPtrToUShort, ULONG_PTR, USHORT, ~0)
__badc_intsafe_conv(ULongPtrToShort, ULONG_PTR, SHORT, ~0)
__badc_intsafe_conv(ULongPtrToUInt, ULONG_PTR, UINT, ~0)
__badc_intsafe_conv(ULongPtrToULong, ULONG_PTR, ULONG, ~0)
__badc_intsafe_conv(ULongPtrToDWord, ULONG_PTR, DWORD, ~0)
__badc_intsafe_conv(ULongPtrToLong, ULONG_PTR, LONG, ~0)
__badc_intsafe_conv(ULongPtrToInt, ULONG_PTR, INT, ~0)
__badc_intsafe_conv(ULongPtrToUIntPtr, ULONG_PTR, UINT_PTR, ~0)
__badc_intsafe_conv(ULongPtrToIntPtr, ULONG_PTR, INT_PTR, ~0)
__badc_intsafe_conv(ULongPtrToPtrdiffT, ULONG_PTR, ptrdiff_t, ~0)
__badc_intsafe_conv(ULongPtrToLongPtr, ULONG_PTR, LONG_PTR, ~0)
__badc_intsafe_conv(ULongPtrToSSIZET, ULONG_PTR, SSIZE_T, ~0)
__badc_intsafe_conv(ULongPtrToInt64, ULONG_PTR, INT64, ~0)
__badc_intsafe_conv(ULongPtrToLongLong, ULONG_PTR, LONGLONG, ~0)
__badc_intsafe_conv(ULongPtrToChar, ULONG_PTR, CHAR, __badc_intsafe_char_error)
__badc_intsafe_conv(DWordPtrToUInt, DWORD_PTR, UINT, ~0)
__badc_intsafe_conv(DWordPtrToULong, DWORD_PTR, ULONG, ~0)
__badc_intsafe_conv(DWordPtrToDWord, DWORD_PTR, DWORD, ~0)
__badc_intsafe_conv(DWordPtrToLong, DWORD_PTR, LONG, ~0)
__badc_intsafe_conv(DWordPtrToInt, DWORD_PTR, INT, ~0)
__badc_intsafe_conv(DWordPtrToUIntPtr, DWORD_PTR, UINT_PTR, ~0)
__badc_intsafe_conv(DWordPtrToIntPtr, DWORD_PTR, INT_PTR, ~0)
__badc_intsafe_conv(DWordPtrToPtrdiffT, DWORD_PTR, ptrdiff_t, ~0)
__badc_intsafe_conv(DWordPtrToLongPtr, DWORD_PTR, LONG_PTR, ~0)
__badc_intsafe_conv(DWordPtrToSSIZET, DWORD_PTR, SSIZE_T, ~0)
__badc_intsafe_conv(DWordPtrToInt64, DWORD_PTR, INT64, ~0)
__badc_intsafe_conv(IntPtrToUChar, INT_PTR, UCHAR, 0)
__badc_intsafe_conv(IntPtrToUInt8, INT_PTR, UINT8, ~0)
__badc_intsafe_conv(IntPtrToInt8, INT_PTR, INT8, ~0)
__badc_intsafe_conv(IntPtrToUShort, INT_PTR, USHORT, ~0)
__badc_intsafe_conv(IntPtrToShort, INT_PTR, SHORT, ~0)
__badc_intsafe_conv(IntPtrToUInt, INT_PTR, UINT, ~0)
__badc_intsafe_conv(IntPtrToULong, INT_PTR, ULONG, ~0)
__badc_intsafe_conv(IntPtrToDWord, INT_PTR, DWORD, ~0)
__badc_intsafe_conv(IntPtrToLong, INT_PTR, LONG, ~0)
__badc_intsafe_conv(IntPtrToInt, INT_PTR, INT, ~0)
__badc_intsafe_conv(IntPtrToUIntPtr, INT_PTR, UINT_PTR, ~0)
__badc_intsafe_conv(IntPtrToSizeT, INT_PTR, size_t, ~0)
__badc_intsafe_conv(IntPtrToULongPtr, INT_PTR, ULONG_PTR, ~0)
__badc_intsafe_conv(IntPtrToDWordPtr, INT_PTR, DWORD_PTR, ~0)
__badc_intsafe_conv(IntPtrToLongPtr, INT_PTR, LONG_PTR, ~0)
__badc_intsafe_conv(IntPtrToULongLong, INT_PTR, ULONGLONG, ~0)
__badc_intsafe_conv(IntPtrToChar, INT_PTR, CHAR, __badc_intsafe_char_error)
__badc_intsafe_conv(PtrdiffTToUInt, ptrdiff_t, UINT, ~0)
__badc_intsafe_conv(PtrdiffTToULong, ptrdiff_t, ULONG, ~0)
__badc_intsafe_conv(PtrdiffTToDWord, ptrdiff_t, DWORD, ~0)
__badc_intsafe_conv(PtrdiffTToLong, ptrdiff_t, LONG, ~0)
__badc_intsafe_conv(PtrdiffTToInt, ptrdiff_t, INT, ~0)
__badc_intsafe_conv(PtrdiffTToUIntPtr, ptrdiff_t, UINT_PTR, ~0)
__badc_intsafe_conv(PtrdiffTToSizeT, ptrdiff_t, size_t, ~0)
__badc_intsafe_conv(PtrdiffTToULongPtr, ptrdiff_t, ULONG_PTR, ~0)
__badc_intsafe_conv(PtrdiffTToDWordPtr, ptrdiff_t, DWORD_PTR, ~0)
__badc_intsafe_conv(LongPtrToUChar, LONG_PTR, UCHAR, 0)
__badc_intsafe_conv(LongPtrToUInt8, LONG_PTR, UINT8, ~0)
__badc_intsafe_conv(LongPtrToInt8, LONG_PTR, INT8, ~0)
__badc_intsafe_conv(LongPtrToUShort, LONG_PTR, USHORT, ~0)
__badc_intsafe_conv(LongPtrToShort, LONG_PTR, SHORT, ~0)
__badc_intsafe_conv(LongPtrToUInt, LONG_PTR, UINT, ~0)
__badc_intsafe_conv(LongPtrToULong, LONG_PTR, ULONG, ~0)
__badc_intsafe_conv(LongPtrToDWord, LONG_PTR, DWORD, ~0)
__badc_intsafe_conv(LongPtrToLong, LONG_PTR, LONG, ~0)
__badc_intsafe_conv(LongPtrToInt, LONG_PTR, INT, ~0)
__badc_intsafe_conv(LongPtrToUIntPtr, LONG_PTR, UINT_PTR, ~0)
__badc_intsafe_conv(LongPtrToSizeT, LONG_PTR, size_t, ~0)
__badc_intsafe_conv(LongPtrToULongPtr, LONG_PTR, ULONG_PTR, ~0)
__badc_intsafe_conv(LongPtrToDWordPtr, LONG_PTR, DWORD_PTR, ~0)
__badc_intsafe_conv(LongPtrToIntPtr, LONG_PTR, INT_PTR, ~0)
__badc_intsafe_conv(LongPtrToULongLong, LONG_PTR, ULONGLONG, ~0)
__badc_intsafe_conv(LongPtrToChar, LONG_PTR, CHAR, __badc_intsafe_char_error)
__badc_intsafe_conv(SSIZETToUInt, SSIZE_T, UINT, ~0)
__badc_intsafe_conv(SSIZETToULong, SSIZE_T, ULONG, ~0)
__badc_intsafe_conv(SSIZETToDWord, SSIZE_T, DWORD, ~0)
__badc_intsafe_conv(SSIZETToLong, SSIZE_T, LONG, ~0)
__badc_intsafe_conv(SSIZETToInt, SSIZE_T, INT, ~0)
__badc_intsafe_conv(SSIZETToUIntPtr, SSIZE_T, UINT_PTR, ~0)
__badc_intsafe_conv(SSIZETToSizeT, SSIZE_T, size_t, ~0)
__badc_intsafe_conv(SSIZETToULongPtr, SSIZE_T, ULONG_PTR, ~0)
__badc_intsafe_conv(SSIZETToDWordPtr, SSIZE_T, DWORD_PTR, ~0)
__badc_intsafe_conv(SSIZETToIntPtr, SSIZE_T, INT_PTR, ~0)
__badc_intsafe_conv(ULongLongToUChar, ULONGLONG, UCHAR, 0)
__badc_intsafe_conv(ULongLongToUInt8, ULONGLONG, UINT8, ~0)
__badc_intsafe_conv(ULongLongToInt8, ULONGLONG, INT8, ~0)
__badc_intsafe_conv(ULongLongToUShort, ULONGLONG, USHORT, ~0)
__badc_intsafe_conv(ULongLongToShort, ULONGLONG, SHORT, ~0)
__badc_intsafe_conv(ULongLongToUInt, ULONGLONG, UINT, ~0)
__badc_intsafe_conv(ULongLongToULong, ULONGLONG, ULONG, ~0)
__badc_intsafe_conv(ULongLongToDWord, ULONGLONG, DWORD, ~0)
__badc_intsafe_conv(ULongLongToLong, ULONGLONG, LONG, ~0)
__badc_intsafe_conv(ULongLongToInt, ULONGLONG, INT, ~0)
__badc_intsafe_conv(ULongLongToUIntPtr, ULONGLONG, UINT_PTR, ~0)
__badc_intsafe_conv(ULongLongToSizeT, ULONGLONG, size_t, ~0)
__badc_intsafe_conv(ULongLongToULongPtr, ULONGLONG, ULONG_PTR, ~0)
__badc_intsafe_conv(ULongLongToDWordPtr, ULONGLONG, DWORD_PTR, ~0)
__badc_intsafe_conv(ULongLongToIntPtr, ULONGLONG, INT_PTR, ~0)
__badc_intsafe_conv(ULongLongToPtrdiffT, ULONGLONG, ptrdiff_t, ~0)
__badc_intsafe_conv(ULongLongToLongPtr, ULONGLONG, LONG_PTR, ~0)
__badc_intsafe_conv(ULongLongToSSIZET, ULONGLONG, SSIZE_T, ~0)
__badc_intsafe_conv(ULongLongToInt64, ULONGLONG, INT64, ~0)
__badc_intsafe_conv(ULongLongToLongLong, ULONGLONG, LONGLONG, ~0)
__badc_intsafe_conv(ULongLongToChar, ULONGLONG, CHAR, __badc_intsafe_char_error)
__badc_intsafe_conv(Int64ToUInt, INT64, UINT, ~0)
__badc_intsafe_conv(Int64ToULong, INT64, ULONG, ~0)
__badc_intsafe_conv(Int64ToDWord, INT64, DWORD, ~0)
__badc_intsafe_conv(Int64ToLong, INT64, LONG, ~0)
__badc_intsafe_conv(Int64ToInt, INT64, INT, ~0)
__badc_intsafe_conv(Int64ToUIntPtr, INT64, UINT_PTR, ~0)
__badc_intsafe_conv(Int64ToSizeT, INT64, size_t, ~0)
__badc_intsafe_conv(Int64ToULongPtr, INT64, ULONG_PTR, ~0)
__badc_intsafe_conv(Int64ToDWordPtr, INT64, DWORD_PTR, ~0)
__badc_intsafe_conv(Int64ToIntPtr, INT64, INT_PTR, ~0)
__badc_intsafe_conv(Int64ToPtrdiffT, INT64, ptrdiff_t, ~0)
__badc_intsafe_conv(Int64ToLongPtr, INT64, LONG_PTR, ~0)
__badc_intsafe_conv(Int64ToSSIZET, INT64, SSIZE_T, ~0)
__badc_intsafe_conv(Int64ToULongLong, INT64, ULONGLONG, ~0)
__badc_intsafe_conv(LongLongToUChar, LONGLONG, UCHAR, 0)
__badc_intsafe_conv(LongLongToUInt8, LONGLONG, UINT8, ~0)
__badc_intsafe_conv(LongLongToInt8, LONGLONG, INT8, ~0)
__badc_intsafe_conv(LongLongToUShort, LONGLONG, USHORT, ~0)
__badc_intsafe_conv(LongLongToShort, LONGLONG, SHORT, ~0)
__badc_intsafe_conv(LongLongToUInt, LONGLONG, UINT, ~0)
__badc_intsafe_conv(LongLongToULong, LONGLONG, ULONG, ~0)
__badc_intsafe_conv(LongLongToLong, LONGLONG, LONG, ~0)
__badc_intsafe_conv(LongLongToInt, LONGLONG, INT, ~0)
__badc_intsafe_conv(LongLongToIntPtr, LONGLONG, INT_PTR, ~0)
__badc_intsafe_conv(LongLongToLongPtr, LONGLONG, LONG_PTR, ~0)
__badc_intsafe_conv(LongLongToULongLong, LONGLONG, ULONGLONG, ~0)
__badc_intsafe_conv(LongLongToChar, LONGLONG, CHAR, __badc_intsafe_char_error)

__badc_intsafe_math(UInt8Add, UINT8, add)
__badc_intsafe_math(Int8Add, INT8, add)
__badc_intsafe_math(UShortAdd, USHORT, add)
__badc_intsafe_math(WordAdd, WORD, add)
__badc_intsafe_math(ShortAdd, SHORT, add)
__badc_intsafe_math(UIntAdd, UINT, add)
__badc_intsafe_math(ULongAdd, ULONG, add)
__badc_intsafe_math(DWordAdd, DWORD, add)
__badc_intsafe_math(LongAdd, LONG, add)
__badc_intsafe_math(IntAdd, INT, add)
__badc_intsafe_math(UIntPtrAdd, UINT_PTR, add)
__badc_intsafe_math(SizeTAdd, size_t, add)
__badc_intsafe_math(ULongPtrAdd, ULONG_PTR, add)
__badc_intsafe_math(DWordPtrAdd, DWORD_PTR, add)
__badc_intsafe_math(IntPtrAdd, INT_PTR, add)
__badc_intsafe_math(PtrdiffTAdd, ptrdiff_t, add)
__badc_intsafe_math(LongPtrAdd, LONG_PTR, add)
__badc_intsafe_math(SIZETAdd, SIZE_T, add)
__badc_intsafe_math(SSIZETAdd, SSIZE_T, add)
__badc_intsafe_math(ULongLongAdd, ULONGLONG, add)
__badc_intsafe_math(LongLongAdd, LONGLONG, add)

__badc_intsafe_math(UInt8Sub, UINT8, sub)
__badc_intsafe_math(Int8Sub, INT8, sub)
__badc_intsafe_math(UShortSub, USHORT, sub)
__badc_intsafe_math(WordSub, WORD, sub)
__badc_intsafe_math(ShortSub, SHORT, sub)
__badc_intsafe_math(UIntSub, UINT, sub)
__badc_intsafe_math(ULongSub, ULONG, sub)
__badc_intsafe_math(DWordSub, DWORD, sub)
__badc_intsafe_math(LongSub, LONG, sub)
__badc_intsafe_math(IntSub, INT, sub)
__badc_intsafe_math(UIntPtrSub, UINT_PTR, sub)
__badc_intsafe_math(SizeTSub, size_t, sub)
__badc_intsafe_math(ULongPtrSub, ULONG_PTR, sub)
__badc_intsafe_math(DWordPtrSub, DWORD_PTR, sub)
__badc_intsafe_math(IntPtrSub, INT_PTR, sub)
__badc_intsafe_math(PtrdiffTSub, ptrdiff_t, sub)
__badc_intsafe_math(LongPtrSub, LONG_PTR, sub)
__badc_intsafe_math(SIZETSub, SIZE_T, sub)
__badc_intsafe_math(SSIZETSub, SSIZE_T, sub)
__badc_intsafe_math(ULongLongSub, ULONGLONG, sub)
__badc_intsafe_math(LongLongSub, LONGLONG, sub)

__badc_intsafe_math(UInt8Mult, UINT8, mul)
__badc_intsafe_math(Int8Mult, INT8, mul)
__badc_intsafe_math(UShortMult, USHORT, mul)
__badc_intsafe_math(WordMult, WORD, mul)
__badc_intsafe_math(ShortMult, SHORT, mul)
__badc_intsafe_math(UIntMult, UINT, mul)
__badc_intsafe_math(ULongMult, ULONG, mul)
__badc_intsafe_math(DWordMult, DWORD, mul)
__badc_intsafe_math(LongMult, LONG, mul)
__badc_intsafe_math(IntMult, INT, mul)
__badc_intsafe_math(UIntPtrMult, UINT_PTR, mul)
__badc_intsafe_math(SizeTMult, size_t, mul)
__badc_intsafe_math(ULongPtrMult, ULONG_PTR, mul)
__badc_intsafe_math(DWordPtrMult, DWORD_PTR, mul)
__badc_intsafe_math(IntPtrMult, INT_PTR, mul)
__badc_intsafe_math(PtrdiffTMult, ptrdiff_t, mul)
__badc_intsafe_math(LongPtrMult, LONG_PTR, mul)
__badc_intsafe_math(SIZETMult, SIZE_T, mul)
__badc_intsafe_math(SSIZETMult, SSIZE_T, mul)
__badc_intsafe_math(ULongLongMult, ULONGLONG, mul)
__badc_intsafe_math(LongLongMult, LONGLONG, mul)

#define Int8ToByte Int8ToUInt8
#define Int8ToUInt16 Int8ToUShort
#define Int8ToWord Int8ToUShort
#define Int8ToUInt32 Int8ToUInt
#define Int8ToDWord Int8ToULong
#define Int8ToDWordPtr Int8ToULongPtr
#define Int8ToDWordLong Int8ToULongLong
#define Int8ToULong64 Int8ToULongLong
#define Int8ToDWord64 Int8ToULongLong
#define Int8ToUInt64 Int8ToULongLong
__badc_intsafe_conv(Int8ToSizeT, INT8, size_t, ~0)
#define Int8ToSIZET Int8ToULongPtr
#define ShortToUInt16 ShortToUShort
#define ShortToUInt32 ShortToUInt
#define ShortToDWord ShortToULong
#define ShortToDWordLong ShortToULongLong
#define ShortToULong64 ShortToULongLong
#define ShortToDWord64 ShortToULongLong
#define ShortToUInt64 ShortToULongLong
__badc_intsafe_conv(ShortToSizeT, SHORT, size_t, ~0)
#define ShortToSIZET ShortToULongPtr
#define Int16ToChar ShortToChar
#define Int16ToInt8 ShortToInt8
#define Int16ToUChar ShortToUChar
#define Int16ToUInt8 ShortToUInt8
#define Int16ToByte ShortToUInt8
#define Int16ToUShort ShortToUShort
#define Int16ToUInt16 ShortToUShort
#define Int16ToWord ShortToUShort
#define Int16ToUInt ShortToUInt
#define Int16ToUInt32 ShortToUInt
#define Int16ToUIntPtr ShortToUIntPtr
#define Int16ToULong ShortToULong
#define Int16ToULongPtr ShortToULongPtr
#define Int16ToDWord ShortToULong
#define Int16ToDWordPtr ShortToULongPtr
#define Int16ToULongLong ShortToULongLong
#define Int16ToDWordLong ShortToULongLong
#define Int16ToULong64 ShortToULongLong
#define Int16ToDWord64 ShortToULongLong
#define Int16ToUInt64 ShortToULongLong
__badc_intsafe_conv(Int16ToSizeT, INT16, size_t, ~0)
#define Int16ToSIZET ShortToULongPtr
#define UShortToInt16 UShortToShort
#define UInt16ToChar UShortToChar
#define UInt16ToInt8 UShortToInt8
#define UInt16ToUChar UShortToUChar
#define UInt16ToUInt8 UShortToUInt8
#define UInt16ToByte UShortToUInt8
#define UInt16ToShort UShortToShort
#define UInt16ToInt16 UShortToShort
#define WordToInt8 UShortToInt8
#define WordToUInt8 UShortToUInt8
#define WordToInt16 UShortToShort
#define IntToInt16 IntToShort
#define IntToUInt16 IntToUShort
#define IntToDWordLong IntToULongLong
#define IntToULong64 IntToULongLong
#define IntToDWord64 IntToULongLong
#define IntToUInt64 IntToULongLong
#define IntToSIZET IntToULongPtr
#define Int32ToChar IntToChar
#define Int32ToInt8 IntToInt8
#define Int32ToUChar IntToUChar
#define Int32ToByte IntToUInt8
#define Int32ToUInt8 IntToUInt8
#define Int32ToShort IntToShort
#define Int32ToInt16 IntToShort
#define Int32ToUShort IntToUShort
#define Int32ToUInt16 IntToUShort
#define Int32ToWord IntToUShort
#define Int32ToUInt IntToUInt
#define Int32ToUInt32 IntToUInt
#define Int32ToUIntPtr IntToUIntPtr
#define Int32ToULong IntToULong
#define Int32ToULongPtr IntToULongPtr
#define Int32ToDWord IntToULong
#define Int32ToDWordPtr IntToULongPtr
#define Int32ToULongLong IntToULongLong
#define Int32ToDWordLong IntToULongLong
#define Int32ToULong64 IntToULongLong
#define Int32ToDWord64 IntToULongLong
#define Int32ToUInt64 IntToULongLong
__badc_intsafe_conv(Int32ToSizeT, INT32, size_t, ~0)
#define Int32ToSIZET IntToULongPtr
#define IntPtrToByte IntPtrToUInt8
#define IntPtrToInt16 IntPtrToShort
#define IntPtrToUInt16 IntPtrToUShort
#define IntPtrToWord IntPtrToUShort
#define IntPtrToInt32 IntPtrToInt
#define IntPtrToUInt32 IntPtrToUInt
#define IntPtrToDWordLong IntPtrToULongLong
#define IntPtrToULong64 IntPtrToULongLong
#define IntPtrToDWord64 IntPtrToULongLong
#define IntPtrToUInt64 IntPtrToULongLong
#define IntPtrToSIZET IntPtrToULongPtr
#define UIntToInt16 UIntToShort
#define UIntToUInt16 UIntToUShort
#define UIntToInt32 UIntToInt
#define UInt32ToChar UIntToChar
#define UInt32ToInt8 UIntToInt8
#define UInt32ToUChar UIntToUChar
#define UInt32ToUInt8 UIntToUInt8
#define UInt32ToByte UInt32ToUInt8
#define UInt32ToShort UIntToShort
#define UInt32ToInt16 UIntToShort
#define UInt32ToUShort UIntToUShort
#define UInt32ToUInt16 UIntToUShort
#define UInt32ToWord UIntToUShort
#define UInt32ToInt UIntToInt
#define UInt32ToIntPtr UIntToIntPtr
#define UInt32ToInt32 UIntToInt
#define UInt32ToLong UIntToLong
#define UInt32ToLongPtr UIntToLongPtr
#define UInt32ToPtrdiffT UIntToPtrdiffT
#define UInt32ToSSIZET UIntToSSIZET
#define UIntPtrToByte UIntPtrToUInt8
#define UIntPtrToWord UIntPtrToUShort
#define UIntPtrToInt32 UIntPtrToInt
#define UIntPtrToUInt32 UIntPtrToUInt
#define UIntPtrToLong64 UIntPtrToLongLong
__badc_intsafe_conv(UIntPtrToPtrdiffT, UINT_PTR, ptrdiff_t, ~0)
#define LongToInt16 LongToShort
#define LongToUInt16 LongToUShort
#define LongToInt32 LongToInt
#define LongToUInt32 LongToUInt
#define LongToDWordLong LongToULongLong
#define LongToULong64 LongToULongLong
#define LongToDWord64 LongToULongLong
#define LongToUInt64 LongToULongLong
#define LongToSIZET LongToULongPtr
#define LongPtrToByte LongPtrToUInt8
#define LongPtrToInt16 LongPtrToShort
#define LongPtrToUInt16 LongPtrToUShort
#define LongPtrToWord LongPtrToUShort
#define LongPtrToInt32 LongPtrToInt
#define LongPtrToUInt32 LongPtrToUInt
#define LongPtrToDWordLong LongPtrToULongLong
#define LongPtrToULong64 LongPtrToULongLong
#define LongPtrToDWord64 LongPtrToULongLong
#define LongPtrToUInt64 LongPtrToULongLong
#define LongPtrToSIZET LongPtrToULongPtr
#define ULongToInt16 ULongToShort
#define ULongToUInt16 ULongToUShort
#define ULongToInt32 ULongToInt
#define ULongToUInt32 ULongToUInt
#define ULongPtrToByte ULongPtrToUInt8
#define ULongPtrToInt16 ULongPtrToShort
#define ULongPtrToUInt16 ULongPtrToUShort
#define ULongPtrToWord ULongPtrToUShort
#define ULongPtrToInt32 ULongPtrToInt
#define ULongPtrToUInt32 ULongPtrToUInt
#define ULongPtrToLong64 ULongPtrToLongLong
#define DWordToInt8 ULongToInt8
#define DWordToUInt8 ULongToUInt8
#define DWordToInt16 ULongToShort
#define DWordToUInt16 ULongToUShort
#define DWordToInt32 ULongToInt
#define DWordToUInt32 ULongToUInt
#define DWordPtrToInt8 ULongPtrToInt8
#define DWordPtrToUChar ULongPtrToUChar
#define DWordPtrToChar ULongPtrToChar
#define DWordPtrToUInt8 ULongPtrToUInt8
#define DWordPtrToByte ULongPtrToUInt8
#define DWordPtrToShort ULongPtrToShort
#define DWordPtrToInt16 ULongPtrToShort
#define DWordPtrToUShort ULongPtrToUShort
#define DWordPtrToUInt16 ULongPtrToUShort
#define DWordPtrToWord ULongPtrToUShort
#define DWordPtrToInt32 ULongPtrToInt
#define DWordPtrToUInt32 ULongPtrToUInt
#define DWordPtrToLongLong ULongPtrToLongLong
#define DWordPtrToLong64 ULongPtrToLongLong
#define LongLongToByte LongLongToUInt8
#define LongLongToInt16 LongLongToShort
#define LongLongToUInt16 LongLongToUShort
#define LongLongToWord LongLongToUShort
#define LongLongToInt32 LongLongToInt
#define LongLongToUInt32 LongLongToUInt
#define LongLongToUIntPtr Int64ToUIntPtr
#define LongLongToULongPtr Int64ToULongPtr
#define LongLongToDWord LongLongToULong
#define LongLongToDWordPtr LongLongToULongPtr
#define LongLongToDWordLong LongLongToULongLong
#define LongLongToULong64 LongLongToULongLong
#define LongLongToDWord64 LongLongToULongLong
#define LongLongToUInt64 LongLongToULongLong
__badc_intsafe_conv(LongLongToPtrdiffT, LONGLONG, ptrdiff_t, ~0)
__badc_intsafe_conv(LongLongToSizeT, LONGLONG, size_t, ~0)
#define LongLongToSSIZET LongLongToLongPtr
#define LongLongToSIZET LongLongToULongPtr
#define Long64ToChar LongLongToChar
#define Long64ToInt8 LongLongToInt8
#define Long64ToUChar LongLongToUChar
#define Long64ToUInt8 LongLongToUInt8
#define Long64ToByte LongLongToUInt8
#define Long64ToShort LongLongToShort
#define Long64ToInt16 LongLongToShort
#define Long64ToUShort LongLongToUShort
#define Long64ToUInt16 LongLongToUShort
#define Long64ToWord LongLongToUShort
#define Long64ToInt LongLongToInt
#define Long64ToInt32 LongLongToInt
#define Long64ToIntPtr LongLongToIntPtr
#define Long64ToUInt LongLongToUInt
#define Long64ToUInt32 LongLongToUInt
#define Long64ToUIntPtr LongLongToUIntPtr
#define Long64ToLong LongLongToLong
#define Long64ToLongPtr LongLongToLongPtr
#define Long64ToULong LongLongToULong
#define Long64ToULongPtr LongLongToULongPtr
#define Long64ToDWord LongLongToULong
#define Long64ToDWordPtr LongLongToULongPtr
#define Long64ToULongLong LongLongToULongLong
__badc_intsafe_conv(Long64ToPtrdiffT, LONG64, ptrdiff_t, ~0)
__badc_intsafe_conv(Long64ToSizeT, LONG64, size_t, ~0)
#define Long64ToSSIZET LongLongToLongPtr
#define Long64ToSIZET LongLongToULongPtr
#define Int64ToChar LongLongToChar
#define Int64ToInt8 LongLongToInt8
#define Int64ToUChar LongLongToUChar
#define Int64ToUInt8 LongLongToUInt8
#define Int64ToByte LongLongToUInt8
#define Int64ToShort LongLongToShort
#define Int64ToInt16 LongLongToShort
#define Int64ToUShort LongLongToUShort
#define Int64ToUInt16 LongLongToUShort
#define Int64ToWord LongLongToUShort
#define Int64ToInt32 LongLongToInt
#define Int64ToUInt32 LongLongToUInt
#define Int64ToDWordLong LongLongToULongLong
#define Int64ToULong64 LongLongToULongLong
#define Int64ToDWord64 LongLongToULongLong
#define Int64ToUInt64 LongLongToULongLong
#define Int64ToSIZET LongLongToULongPtr
#define ULongLongToByte ULongLongToUInt8
#define ULongLongToInt16 ULongLongToShort
#define ULongLongToUInt16 ULongLongToUShort
#define ULongLongToWord ULongLongToUShort
#define ULongLongToInt32 ULongLongToInt
#define ULongLongToUInt32 ULongLongToUInt
#define ULongLongToLong64 ULongLongToLongLong
#define ULongLongToSIZET ULongLongToULongPtr
#define DWordLongToChar ULongLongToChar
#define DWordLongToInt8 ULongLongToInt8
#define DWordLongToUChar ULongLongToUChar
#define DWordLongToUInt8 ULongLongToUInt8
#define DWordLongToByte ULongLongToUInt8
#define DWordLongToShort ULongLongToShort
#define DWordLongToInt16 ULongLongToShort
#define DWordLongToUShort ULongLongToUShort
#define DWordLongToUInt16 ULongLongToUShort
#define DWordLongToWord ULongLongToUShort
#define DWordLongToInt ULongLongToInt
#define DWordLongToInt32 ULongLongToInt
#define DWordLongToIntPtr ULongLongToIntPtr
#define DWordLongToUInt ULongLongToUInt
#define DWordLongToUInt32 ULongLongToUInt
#define DWordLongToUIntPtr ULongLongToUIntPtr
#define DWordLongToLong ULongLongToLong
#define DWordLongToLongPtr ULongLongToLongPtr
#define DWordLongToULong ULongLongToULong
#define DWordLongToULongPtr ULongLongToULongPtr
#define DWordLongToDWord ULongLongToULong
#define DWordLongToDWordPtr ULongLongToULongPtr
#define DWordLongToLongLong ULongLongToLongLong
#define DWordLongToLong64 ULongLongToLongLong
#define DWordLongToInt64 ULongLongToLongLong
__badc_intsafe_conv(DWordLongToPtrdiffT, DWORDLONG, ptrdiff_t, ~0)
__badc_intsafe_conv(DWordLongToSizeT, DWORDLONG, size_t, ~0)
#define DWordLongToSSIZET ULongLongToLongPtr
#define DWordLongToSIZET ULongLongToULongPtr
#define ULong64ToChar ULongLongToChar
#define ULong64ToInt8 ULongLongToInt8
#define ULong64ToUChar ULongLongToUChar
#define ULong64ToUInt8 ULongLongToUInt8
#define ULong64ToByte ULongLongToUInt8
#define ULong64ToShort ULongLongToShort
#define ULong64ToInt16 ULongLongToShort
#define ULong64ToUShort ULongLongToUShort
#define ULong64ToUInt16 ULongLongToUShort
#define ULong64ToWord ULongLongToUShort
#define ULong64ToInt ULongLongToInt
#define ULong64ToInt32 ULongLongToInt
#define ULong64ToIntPtr ULongLongToIntPtr
#define ULong64ToUInt ULongLongToUInt
#define ULong64ToUInt32 ULongLongToUInt
#define ULong64ToUIntPtr ULongLongToUIntPtr
#define ULong64ToLong ULongLongToLong
#define ULong64ToLongPtr ULongLongToLongPtr
#define ULong64ToULong ULongLongToULong
#define ULong64ToULongPtr ULongLongToULongPtr
#define ULong64ToDWord ULongLongToULong
#define ULong64ToDWordPtr ULongLongToULongPtr
#define ULong64ToLongLong ULongLongToLongLong
#define ULong64ToLong64 ULongLongToLongLong
#define ULong64ToInt64 ULongLongToLongLong
__badc_intsafe_conv(ULong64ToPtrdiffT, ULONG64, ptrdiff_t, ~0)
__badc_intsafe_conv(ULong64ToSizeT, ULONG64, size_t, ~0)
#define ULong64ToSSIZET ULongLongToLongPtr
#define ULong64ToSIZET ULongLongToULongPtr
#define DWord64ToChar ULongLongToChar
#define DWord64ToInt8 ULongLongToInt8
#define DWord64ToUChar ULongLongToUChar
#define DWord64ToUInt8 ULongLongToUInt8
#define DWord64ToByte ULongLongToUInt8
#define DWord64ToShort ULongLongToShort
#define DWord64ToInt16 ULongLongToShort
#define DWord64ToUShort ULongLongToUShort
#define DWord64ToUInt16 ULongLongToUShort
#define DWord64ToWord ULongLongToUShort
#define DWord64ToInt ULongLongToInt
#define DWord64ToInt32 ULongLongToInt
#define DWord64ToIntPtr ULongLongToIntPtr
#define DWord64ToUInt ULongLongToUInt
#define DWord64ToUInt32 ULongLongToUInt
#define DWord64ToUIntPtr ULongLongToUIntPtr
#define DWord64ToLong ULongLongToLong
#define DWord64ToLongPtr ULongLongToLongPtr
#define DWord64ToULong ULongLongToULong
#define DWord64ToULongPtr ULongLongToULongPtr
#define DWord64ToDWord ULongLongToULong
#define DWord64ToDWordPtr ULongLongToULongPtr
#define DWord64ToLongLong ULongLongToLongLong
#define DWord64ToLong64 ULongLongToLongLong
#define DWord64ToInt64 ULongLongToLongLong
__badc_intsafe_conv(DWord64ToPtrdiffT, DWORD64, ptrdiff_t, ~0)
__badc_intsafe_conv(DWord64ToSizeT, DWORD64, size_t, ~0)
#define DWord64ToSSIZET ULongLongToLongPtr
#define DWord64ToSIZET ULongLongToULongPtr
#define UInt64ToChar ULongLongToChar
#define UInt64ToInt8 ULongLongToInt8
#define UInt64ToUChar ULongLongToUChar
#define UInt64ToUInt8 ULongLongToUInt8
#define UInt64ToByte ULongLongToUInt8
#define UInt64ToShort ULongLongToShort
#define UInt64ToInt16 ULongLongToShort
#define UInt64ToUShort ULongLongToUShort
#define UInt64ToUInt16 ULongLongToUShort
#define UInt64ToWord ULongLongToUShort
#define UInt64ToInt ULongLongToInt
#define UInt64ToInt32 ULongLongToInt
#define UInt64ToIntPtr ULongLongToIntPtr
#define UInt64ToUInt ULongLongToUInt
#define UInt64ToUInt32 ULongLongToUInt
#define UInt64ToUIntPtr ULongLongToUIntPtr
#define UInt64ToLong ULongLongToLong
#define UInt64ToLongPtr ULongLongToLongPtr
#define UInt64ToULong ULongLongToULong
#define UInt64ToULongPtr ULongLongToULongPtr
#define UInt64ToDWord ULongLongToULong
#define UInt64ToDWordPtr ULongLongToULongPtr
#define UInt64ToLongLong ULongLongToLongLong
#define UInt64ToLong64 ULongLongToLongLong
#define UInt64ToInt64 ULongLongToLongLong
__badc_intsafe_conv(UInt64ToPtrdiffT, UINT64, ptrdiff_t, ~0)
__badc_intsafe_conv(UInt64ToSizeT, UINT64, size_t, ~0)
#define UInt64ToSSIZET ULongLongToLongPtr
#define UInt64ToSIZET ULongLongToULongPtr
__badc_intsafe_conv(PtrdiffTToChar, ptrdiff_t, CHAR, __badc_intsafe_char_error)
__badc_intsafe_conv(PtrdiffTToUChar, ptrdiff_t, UCHAR, 0)
__badc_intsafe_conv(PtrdiffTToInt8, ptrdiff_t, INT8, ~0)
__badc_intsafe_conv(PtrdiffTToUInt8, ptrdiff_t, UINT8, ~0)
#define PtrdiffTToByte PtrdiffTToUInt8
__badc_intsafe_conv(PtrdiffTToInt16, ptrdiff_t, INT16, ~0)
#define PtrdiffTToShort PtrdiffTToInt16
__badc_intsafe_conv(PtrdiffTToUInt16, ptrdiff_t, UINT16, ~0)
#define PtrdiffTToUShort PtrdiffTToUInt16
#define PtrdiffTToWord PtrdiffTToUInt16
__badc_intsafe_conv(PtrdiffTToInt32, ptrdiff_t, INT32, ~0)
__badc_intsafe_conv(PtrdiffTToUInt32, ptrdiff_t, UINT32, ~0)
__badc_intsafe_conv(PtrdiffTToLongPtr, ptrdiff_t, LONG_PTR, ~0)
__badc_intsafe_conv(PtrdiffTToULongLong, ptrdiff_t, ULONGLONG, ~0)
__badc_intsafe_conv(PtrdiffTToDWordLong, ptrdiff_t, DWORDLONG, ~0)
__badc_intsafe_conv(PtrdiffTToULong64, ptrdiff_t, ULONG64, ~0)
__badc_intsafe_conv(PtrdiffTToDWord64, ptrdiff_t, DWORD64, ~0)
__badc_intsafe_conv(PtrdiffTToUInt64, ptrdiff_t, UINT64, ~0)
__badc_intsafe_conv(PtrdiffTToSIZET, ptrdiff_t, SIZE_T, ~0)
__badc_intsafe_conv(SizeTToChar, size_t, CHAR, __badc_intsafe_char_error)
__badc_intsafe_conv(SizeTToUChar, size_t, UCHAR, 0)
__badc_intsafe_conv(SizeTToInt8, size_t, INT8, ~0)
__badc_intsafe_conv(SizeTToUInt8, size_t, UINT8, ~0)
#define SizeTToByte SizeTToUInt8
__badc_intsafe_conv(SizeTToInt16, size_t, INT16, ~0)
#define SizeTToShort SizeTToInt16
__badc_intsafe_conv(SizeTToUInt16, size_t, UINT16, ~0)
#define SizeTToUShort SizeTToUInt16
#define SizeTToWord SizeTToUInt16
__badc_intsafe_conv(SizeTToInt32, size_t, INT32, ~0)
__badc_intsafe_conv(SizeTToLongLong, size_t, LONGLONG, ~0)
#define SizeTToLong64 SizeTToLongLong
#define SSIZETToInt8 LongPtrToInt8
#define SSIZETToUChar LongPtrToUChar
#define SSIZETToChar LongPtrToChar
#define SSIZETToUInt8 LongPtrToUInt8
#define SSIZETToByte LongPtrToUInt8
#define SSIZETToShort LongPtrToShort
#define SSIZETToInt16 LongPtrToShort
#define SSIZETToUShort LongPtrToUShort
#define SSIZETToUInt16 LongPtrToUShort
#define SSIZETToWord LongPtrToUShort
#define SSIZETToInt32 LongPtrToInt
#define SSIZETToUInt32 LongPtrToUInt
#define SSIZETToULongLong LongPtrToULongLong
#define SSIZETToDWordLong LongPtrToULongLong
#define SSIZETToULong64 LongPtrToULongLong
#define SSIZETToDWord64 LongPtrToULongLong
#define SSIZETToUInt64 LongPtrToULongLong
#define SSIZETToSIZET LongPtrToULongPtr
#define SIZETToInt8 ULongPtrToInt8
#define SIZETToUChar ULongPtrToUChar
#define SIZETToChar ULongPtrToChar
#define SIZETToUInt8 ULongPtrToUInt8
#define SIZETToByte ULongPtrToUInt8
#define SIZETToShort ULongPtrToShort
#define SIZETToInt16 ULongPtrToShort
#define SIZETToUShort ULongPtrToUShort
#define SIZETToUInt16 ULongPtrToUShort
#define SIZETToWord ULongPtrToUShort
#define SIZETToInt ULongPtrToInt
#define SIZETToInt32 ULongPtrToInt
#define SIZETToIntPtr ULongPtrToIntPtr
#define SIZETToUInt ULongPtrToUInt
#define SIZETToUInt32 ULongPtrToUInt
#define SIZETToUIntPtr ULongPtrToUIntPtr
#define SIZETToLong ULongPtrToLong
#define SIZETToLongPtr ULongPtrToLongPtr
#define SIZETToULong ULongPtrToULong
#define SIZETToDWord ULongPtrToULong
#define SIZETToLongLong ULongPtrToLongLong
#define SIZETToLong64 ULongPtrToLongLong
#define SIZETToInt64 ULongPtrToLongLong
__badc_intsafe_conv(SIZETToPtrdiffT, SIZE_T, ptrdiff_t, ~0)
#define SIZETToSSIZET ULongPtrToLongPtr

#define UInt16Add UShortAdd
#define UInt32Add UIntAdd
#define DWordLongAdd ULongLongAdd
#define ULong64Add ULongLongAdd
#define DWord64Add ULongLongAdd
#define UInt64Add ULongLongAdd
#define UInt16Sub UShortSub
#define UInt32Sub UIntSub
#define DWordLongSub ULongLongSub
#define ULong64Sub ULongLongSub
#define DWord64Sub ULongLongSub
#define UInt64Sub ULongLongSub
#define UInt16Mult UShortMult
#define UInt32Mult UIntMult
#define DWordLongMult ULongLongMult
#define ULong64Mult ULongLongMult
#define DWord64Mult ULongLongMult
#define UInt64Mult ULongLongMult
#define Int16Add ShortAdd
#define Int32Add IntAdd
#define Long32Add IntAdd
#define Long64Add LongLongAdd
#define Int64Add LongLongAdd
#define Int16Sub ShortSub
#define Int32Sub IntSub
#define Long32Sub IntSub
#define Long64Sub LongLongSub
#define Int64Sub LongLongSub
#define Int16Mult ShortMult
#define Int32Mult IntMult
#define Long32Mult IntMult
#define Long64Mult LongLongMult
#define Int64Mult LongLongMult

#endif
