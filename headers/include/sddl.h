// sddl.h -- security-descriptor string format (advapi32). TODO: the
// SID string conversions.

#pragma once

#ifdef _WIN32
#include <windows.h>

#define SDDL_REVISION_1 1
#define SDDL_REVISION SDDL_REVISION_1

#pragma dylib(advapi32, "advapi32.dll")
#pragma binding(advapi32::ConvertStringSecurityDescriptorToSecurityDescriptorW, "ConvertStringSecurityDescriptorToSecurityDescriptorW")

BOOL ConvertStringSecurityDescriptorToSecurityDescriptorW(
    LPCWSTR StringSecurityDescriptor, DWORD StringSDRevision,
    void **SecurityDescriptor, ULONG *SecurityDescriptorSize);
#endif
