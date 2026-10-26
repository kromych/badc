/* MSVC compiler intrinsics (<intrin.h>). The byte-swap family binds its
** UCRT export; the compiler lowers every other call declared here at the
** call site, whatever declares it, as MSVC does. On x86-64 the header
** also carries the vector intrinsics, as MSVC's includes <immintrin.h>.
** TODO: the 256-bit vector types and their intrinsics. */
#pragma once

#ifdef _WIN32

#if defined(__x86_64__)
#include <immintrin.h>
#endif

/* The byte-swap trio lives in the UCRT, not legacy msvcrt.dll
** (probed on both Windows boxes). */
#pragma dylib(ucrtbase, "ucrtbase.dll")
#pragma binding(ucrtbase::_byteswap_ushort, "_byteswap_ushort")
#pragma binding(ucrtbase::_byteswap_ulong,  "_byteswap_ulong")
#pragma binding(ucrtbase::_byteswap_uint64, "_byteswap_uint64")

unsigned short     _byteswap_ushort(unsigned short value);
unsigned long      _byteswap_ulong(unsigned long value);
unsigned long long _byteswap_uint64(unsigned long long value);

void _ReadWriteBarrier(void);
void _ReadBarrier(void);
void _WriteBarrier(void);
void *_ReturnAddress(void);
void *_AddressOfReturnAddress(void);

void __debugbreak(void);
__declspec(noreturn) void __fastfail(unsigned int code);
void __nop(void);

unsigned char _BitScanForward(unsigned long *index, unsigned long mask);
unsigned char _BitScanReverse(unsigned long *index, unsigned long mask);
unsigned char _BitScanForward64(unsigned long *index, unsigned long long mask);
unsigned char _BitScanReverse64(unsigned long *index, unsigned long long mask);

unsigned char _bittest(long const *base, long bit);
unsigned char _bittestandcomplement(long *base, long bit);
unsigned char _bittestandreset(long *base, long bit);
unsigned char _bittestandset(long *base, long bit);
unsigned char _bittest64(long long const *base, long long bit);
unsigned char _bittestandcomplement64(long long *base, long long bit);
unsigned char _bittestandreset64(long long *base, long long bit);
unsigned char _bittestandset64(long long *base, long long bit);
unsigned char _interlockedbittestandreset(long volatile *base, long bit);
unsigned char _interlockedbittestandset(long volatile *base, long bit);
unsigned char _interlockedbittestandreset64(long long volatile *base, long long bit);
unsigned char _interlockedbittestandset64(long long volatile *base, long long bit);

/* <x86intrin.h> spells these as macros of its own inline functions. */
#ifndef _rotl
unsigned int _rotl(unsigned int value, int shift);
unsigned int _rotr(unsigned int value, int shift);
unsigned long _lrotl(unsigned long value, int shift);
unsigned long _lrotr(unsigned long value, int shift);
#endif
unsigned char _rotl8(unsigned char value, unsigned char shift);
unsigned short _rotl16(unsigned short value, unsigned char shift);
unsigned long long _rotl64(unsigned long long value, int shift);
unsigned char _rotr8(unsigned char value, unsigned char shift);
unsigned short _rotr16(unsigned short value, unsigned char shift);
unsigned long long _rotr64(unsigned long long value, int shift);

unsigned short __popcnt16(unsigned short value);
unsigned int __popcnt(unsigned int value);
unsigned long long __popcnt64(unsigned long long value);
unsigned long long __umulh(unsigned long long a, unsigned long long b);
long long __mulh(long long a, long long b);

char __iso_volatile_load8(const volatile char *p);
short __iso_volatile_load16(const volatile short *p);
int __iso_volatile_load32(const volatile int *p);
long long __iso_volatile_load64(const volatile long long *p);
void __iso_volatile_store8(volatile char *p, char v);
void __iso_volatile_store16(volatile short *p, short v);
void __iso_volatile_store32(volatile int *p, int v);
void __iso_volatile_store64(volatile long long *p, long long v);

long _InterlockedIncrement(long volatile *addend);
short _InterlockedIncrement16(short volatile *addend);
long long _InterlockedIncrement64(long long volatile *addend);
long _InterlockedDecrement(long volatile *addend);
short _InterlockedDecrement16(short volatile *addend);
long long _InterlockedDecrement64(long long volatile *addend);
long _InterlockedExchange(long volatile *target, long value);
char _InterlockedExchange8(char volatile *target, char value);
short _InterlockedExchange16(short volatile *target, short value);
long long _InterlockedExchange64(long long volatile *target, long long value);
long _InterlockedExchangeAdd(long volatile *addend, long value);
char _InterlockedExchangeAdd8(char volatile *addend, char value);
short _InterlockedExchangeAdd16(short volatile *addend, short value);
long long _InterlockedExchangeAdd64(long long volatile *addend, long long value);
long _InterlockedAnd(long volatile *value, long mask);
char _InterlockedAnd8(char volatile *value, char mask);
short _InterlockedAnd16(short volatile *value, short mask);
long long _InterlockedAnd64(long long volatile *value, long long mask);
long _InterlockedOr(long volatile *value, long mask);
char _InterlockedOr8(char volatile *value, char mask);
short _InterlockedOr16(short volatile *value, short mask);
long long _InterlockedOr64(long long volatile *value, long long mask);
long _InterlockedXor(long volatile *value, long mask);
char _InterlockedXor8(char volatile *value, char mask);
short _InterlockedXor16(short volatile *value, short mask);
long long _InterlockedXor64(long long volatile *value, long long mask);
long _InterlockedCompareExchange(long volatile *dest, long exchange, long comparand);
char _InterlockedCompareExchange8(char volatile *dest, char exchange, char comparand);
short _InterlockedCompareExchange16(short volatile *dest, short exchange, short comparand);
long long _InterlockedCompareExchange64(long long volatile *dest, long long exchange,
                                        long long comparand);
unsigned char _InterlockedCompareExchange128(long long volatile *dest, long long high,
                                             long long low, long long *comparand);
void *_InterlockedExchangePointer(void *volatile *target, void *value);
void *_InterlockedCompareExchangePointer(void *volatile *dest, void *exchange,
                                         void *comparand);

#if defined(__x86_64__)
/* `__rdtsc` and `_mm_pause` stay undeclared: <x86intrin.h> and
** <xmmintrin.h> define them, and the compiler lowers either call.
** gcc's <cpuid.h> spells `__cpuid` as a five-operand macro. */
#ifndef __cpuid
void __cpuid(int info[4], int leaf);
#endif
void __cpuidex(int info[4], int leaf, int subleaf);
void __halt(void);
unsigned short __lzcnt16(unsigned short value);
unsigned int __lzcnt(unsigned int value);
unsigned long long __lzcnt64(unsigned long long value);
unsigned char __readgsbyte(unsigned long offset);
unsigned short __readgsword(unsigned long offset);
unsigned long __readgsdword(unsigned long offset);
unsigned long long __readgsqword(unsigned long offset);
void __writegsbyte(unsigned long offset, unsigned char value);
void __writegsword(unsigned long offset, unsigned short value);
void __writegsdword(unsigned long offset, unsigned long value);
void __writegsqword(unsigned long offset, unsigned long long value);
unsigned long long _umul128(unsigned long long a, unsigned long long b,
                            unsigned long long *high);
long long _mul128(long long a, long long b, long long *high);
unsigned long long __shiftleft128(unsigned long long low, unsigned long long high,
                                  unsigned char shift);
unsigned long long __shiftright128(unsigned long long low, unsigned long long high,
                                   unsigned char shift);
#endif

#if defined(__aarch64__)
#define ARM64_SYSREG(op0, op1, crn, crm, op2)                                  \
    ((((op0) & 1) << 14) | (((op1) & 7) << 11) | (((crn) & 15) << 7) |       \
     (((crm) & 15) << 3) | ((op2) & 7))

typedef enum _tag_ARM64INTR_BARRIER_TYPE {
    _ARM64_BARRIER_SY = 0xF,
    _ARM64_BARRIER_ST = 0xE,
    _ARM64_BARRIER_LD = 0xD,
    _ARM64_BARRIER_ISH = 0xB,
    _ARM64_BARRIER_ISHST = 0xA,
    _ARM64_BARRIER_ISHLD = 0x9,
    _ARM64_BARRIER_NSH = 0x7,
    _ARM64_BARRIER_NSHST = 0x6,
    _ARM64_BARRIER_NSHLD = 0x5,
    _ARM64_BARRIER_OSH = 0x3,
    _ARM64_BARRIER_OSHST = 0x2,
    _ARM64_BARRIER_OSHLD = 0x1
} _ARM64INTR_BARRIER_TYPE;

void __dmb(unsigned int type);
void __dsb(unsigned int type);
void __isb(unsigned int type);
void __yield(void);
void __wfe(void);
void __wfi(void);
void __sev(void);
void __sevl(void);

unsigned int _CountLeadingZeros(unsigned long value);
unsigned int _CountLeadingZeros64(unsigned long long value);
unsigned int _CountTrailingZeros(unsigned long value);
unsigned int _CountTrailingZeros64(unsigned long long value);
unsigned int _CountLeadingOnes(unsigned long value);
unsigned int _CountLeadingOnes64(unsigned long long value);
unsigned int _CountLeadingSigns(long value);
unsigned int _CountLeadingSigns64(long long value);
unsigned int _CountOneBits(unsigned long value);
unsigned int _CountOneBits64(unsigned long long value);

unsigned char __ldar8(const volatile unsigned char *p);
unsigned short __ldar16(const volatile unsigned short *p);
unsigned int __ldar32(const volatile unsigned int *p);
unsigned long long __ldar64(const volatile unsigned long long *p);
void __stlr8(volatile unsigned char *p, unsigned char v);
void __stlr16(volatile unsigned short *p, unsigned short v);
void __stlr32(volatile unsigned int *p, unsigned int v);
void __stlr64(volatile unsigned long long *p, unsigned long long v);

unsigned char __readx18byte(unsigned long offset);
unsigned short __readx18word(unsigned long offset);
unsigned long __readx18dword(unsigned long offset);
unsigned long long __readx18qword(unsigned long offset);
void __writex18byte(unsigned long offset, unsigned char value);
void __writex18word(unsigned long offset, unsigned short value);
void __writex18dword(unsigned long offset, unsigned long value);
void __writex18qword(unsigned long offset, unsigned long long value);
unsigned long long __getReg(int reg);
long long _ReadStatusReg(int reg);
void _WriteStatusReg(int reg, long long value);

unsigned int __crc32b(unsigned int crc, unsigned int data);
unsigned int __crc32h(unsigned int crc, unsigned int data);
unsigned int __crc32w(unsigned int crc, unsigned int data);
unsigned int __crc32d(unsigned int crc, unsigned long long data);
unsigned int __crc32cb(unsigned int crc, unsigned int data);
unsigned int __crc32ch(unsigned int crc, unsigned int data);
unsigned int __crc32cw(unsigned int crc, unsigned int data);
unsigned int __crc32cd(unsigned int crc, unsigned long long data);

long _InterlockedAdd(long volatile *addend, long value);
long long _InterlockedAdd64(long long volatile *addend, long long value);
#endif

#endif
