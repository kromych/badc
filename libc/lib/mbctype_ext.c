// <mbctype.h>'s __p__mbctype and __p__mbcasemap on the Windows targets, as
// libmsvcrt.a defines them: the addresses of the multibyte classification
// and case tables msvcrt.dll exports as data only. The file compiles to
// nothing elsewhere; the native-link driver offers it like an archive
// member.

#ifdef _WIN32

#pragma dylib(msvcrt, "msvcrt.dll")
#pragma binding(data msvcrt::__c5_mbctype, "_mbctype")
#pragma binding(data msvcrt::__c5_mbcasemap, "_mbcasemap")
extern unsigned char __c5_mbctype[];
extern unsigned char __c5_mbcasemap[];

unsigned char *__p__mbctype(void) {
    return __c5_mbctype;
}

unsigned char *__p__mbcasemap(void) {
    return __c5_mbcasemap;
}

#endif
