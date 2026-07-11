/* Hypervisor/Hypervisor.h -- macOS Hypervisor.framework (Apple Silicon).
   Minimal self-contained subset for the arch-generic accelerator code:
   the VM memory-mapping calls, the vCPU lifecycle, and the return / memory-
   flag / exit types. Definitions match the framework's ARM64 headers
   (hv_error.h, hv_vm.h, hv_vcpu.h, hv_vcpu_types.h). */
#ifndef _HYPERVISOR_HYPERVISOR_H
#define _HYPERVISOR_HYPERVISOR_H

#include <stdint.h>
#include <stddef.h>

/* hv_error.h: return codes (mach_error_t-compatible). */
typedef int hv_return_t;
enum {
    HV_SUCCESS      = 0,
    HV_ERROR        = 0xfae94001,
    HV_BUSY         = 0xfae94002,
    HV_BAD_ARGUMENT = 0xfae94003,
    HV_NO_RESOURCES = 0xfae94005,
    HV_NO_DEVICE    = 0xfae94006,
    HV_DENIED       = 0xfae94007,
    HV_UNSUPPORTED  = 0xfae9400f
};

/* hv_vm_types.h: guest physical address + region permissions. */
typedef uint64_t hv_ipa_t;
typedef uint64_t hv_memory_flags_t;
enum {
    HV_MEMORY_READ  = (1ull << 0),
    HV_MEMORY_WRITE = (1ull << 1),
    HV_MEMORY_EXEC  = (1ull << 2)
};

/* hv_vcpu_types.h: vCPU handle, config, and exit information. */
typedef uint64_t hv_vcpu_t;
typedef uint32_t hv_vcpuid_t;
typedef struct hv_vcpu_config_s *hv_vcpu_config_t;
typedef uint32_t hv_exit_reason_t;
enum { HV_EXIT_REASON_CANCELED = 0, HV_EXIT_REASON_EXCEPTION, HV_EXIT_REASON_VTIMER_ACTIVATED,
       HV_EXIT_REASON_UNKNOWN };
typedef uint64_t hv_exception_syndrome_t;
typedef uint64_t hv_exception_address_t;
typedef struct {
    hv_exception_syndrome_t syndrome;
    hv_exception_address_t virtual_address;
    hv_ipa_t physical_address;
} hv_vcpu_exit_exception_t;
typedef struct {
    hv_exit_reason_t reason;
    hv_vcpu_exit_exception_t exception;
} hv_vcpu_exit_t;
#define HV_VCPU_DEFAULT ((hv_vcpu_config_t)0)

/* hv_vm.h: guest physical memory mapping. */
hv_return_t hv_vm_map(void *addr, hv_ipa_t ipa, size_t size, hv_memory_flags_t flags);
hv_return_t hv_vm_unmap(hv_ipa_t ipa, size_t size);
hv_return_t hv_vm_protect(hv_ipa_t ipa, size_t size, hv_memory_flags_t flags);

/* hv_vcpu.h: vCPU lifecycle. */
hv_return_t hv_vcpu_create(hv_vcpu_t *vcpu, hv_vcpu_exit_t **exit, hv_vcpu_config_t config);
hv_return_t hv_vcpu_destroy(hv_vcpu_t vcpu);
hv_return_t hv_vcpu_get_exec_time(hv_vcpu_t vcpu, uint64_t *time);

#endif
