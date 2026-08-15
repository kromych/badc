// mach/vm_region.h -- the region-info flavours mach_vm_region reports
// through. macOS only. Values and field layout match the macOS SDK
// header of the same name.
//
// Only the basic-info flavours are declared. The extended, top and
// submap flavours describe accounting the kernel exposes to memory
// profilers; nothing badc binds returns them.

#pragma once

#include <stdint.h>
#include <mach/mach.h>
#include <mach/vm_prot.h>

#ifdef __APPLE__
// The kernel lays these structures out with 4-byte packing; the count
// macros below, which size the MIG reply, depend on it.
#pragma pack(push, 4)

typedef unsigned int       vm_inherit_t;
typedef int                vm_behavior_t;
typedef int                boolean_t;
typedef unsigned long long memory_object_offset_t;

#define VM_REGION_INFO_MAX 1024
typedef int *vm_region_info_t;
typedef int *vm_region_info_64_t;
typedef int *vm_region_recurse_info_t;
typedef int *vm_region_recurse_info_64_t;
typedef int  vm_region_flavor_t;

#define VM_REGION_BASIC_INFO_64 9
struct vm_region_basic_info_64 {
    vm_prot_t              protection;
    vm_prot_t              max_protection;
    vm_inherit_t           inheritance;
    boolean_t              shared;
    boolean_t              reserved;
    memory_object_offset_t offset;
    vm_behavior_t          behavior;
    unsigned short         user_wired_count;
};
typedef struct vm_region_basic_info_64 *vm_region_basic_info_64_t;
typedef struct vm_region_basic_info_64  vm_region_basic_info_data_64_t;

#define VM_REGION_BASIC_INFO_COUNT_64 \
    ((mach_msg_type_number_t)(sizeof(vm_region_basic_info_data_64_t) / sizeof(int)))

// The legacy flavour: same shape with a 32-bit object offset. Passing it
// to vm_region_64 converts it to VM_REGION_BASIC_INFO_64.
#define VM_REGION_BASIC_INFO 10
struct vm_region_basic_info {
    vm_prot_t      protection;
    vm_prot_t      max_protection;
    vm_inherit_t   inheritance;
    boolean_t      shared;
    boolean_t      reserved;
    uint32_t       offset;
    vm_behavior_t  behavior;
    unsigned short user_wired_count;
};
typedef struct vm_region_basic_info *vm_region_basic_info_t;
typedef struct vm_region_basic_info  vm_region_basic_info_data_t;

#define VM_REGION_BASIC_INFO_COUNT \
    ((mach_msg_type_number_t)(sizeof(vm_region_basic_info_data_t) / sizeof(int)))

#pragma pack(pop)
#endif
