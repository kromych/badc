// <cpuid.h> executes CPUID as gcc's does: the vendor string and the highest
// basic and extended leaves it reports, the leaf-checked queries and their
// refusal past the highest leaf, and the feature bits, each against CPUID read
// through inline asm. Every x86-64 processor has SSE2 and long mode, and a
// known vendor's string is its signature constants. Elsewhere the header is
// not provided.

#ifdef __x86_64__
#include <cpuid.h>
#include <string.h>

static void reference(unsigned int leaf, unsigned int sub, unsigned int r[4]) {
    unsigned int a = leaf, b, c = sub, d;
    __asm__ __volatile__("cpuid" : "+a"(a), "=b"(b), "+c"(c), "=d"(d));
    r[0] = a;
    r[1] = b;
    r[2] = c;
    r[3] = d;
}

int main(void) {
    unsigned int ref[4], a, b, c, d, sig = 0;
    reference(0, 0, ref);
    unsigned int max = __get_cpuid_max(0, &sig);
    if (max == 0 || max != ref[0] || sig != ref[1])
        return 1;
    __cpuid(0, a, b, c, d);
    char vendor[13];
    memcpy(vendor, &b, 4);
    memcpy(vendor + 4, &d, 4);
    memcpy(vendor + 8, &c, 4);
    vendor[12] = 0;
    for (int i = 0; i < 12; i++)
        if (vendor[i] < 0x20 || vendor[i] > 0x7e)
            return 2;
    int intel = !strcmp(vendor, "GenuineIntel"), amd = !strcmp(vendor, "AuthenticAMD");
    if (intel && (b != signature_INTEL_ebx || c != signature_INTEL_ecx || d != signature_INTEL_edx))
        return 3;
    if (amd && (b != signature_AMD_ebx || c != signature_AMD_ecx || d != signature_AMD_edx))
        return 4;
    reference(0x80000000, 0, ref);
    unsigned int ext = __get_cpuid_max(0x80000000, 0);
    if (ext < 0x80000001 || ext != ref[0])
        return 5;
    reference(1, 0, ref);
    if (!__get_cpuid(1, &a, &b, &c, &d) || c != ref[2] || d != ref[3] || !(d & bit_SSE2))
        return 6;
    if (!__get_cpuid(0x80000001, &a, &b, &c, &d) || !(d & bit_LM))
        return 7;
    if (__get_cpuid(max + 1, &a, &b, &c, &d) || __get_cpuid(ext + 1, &a, &b, &c, &d))
        return 8;
    if (max >= 7) {
        int info[4];
        reference(7, 0, ref);
        if (!__get_cpuid_count(7, 0, &a, &b, &c, &d) || b != ref[1] || c != ref[2])
            return 9;
        __cpuidex(info, 7, 0);
        if ((unsigned int)info[1] != ref[1])
            return 10;
    }
    return 0;
}
#else
int main(void) {
    return 0;
}
#endif
