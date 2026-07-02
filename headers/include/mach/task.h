// mach/task.h -- task introspection: the task_info() flavor consumers
// reach for. Layouts and flavor values from the SDK's
// <mach/task_info.h>. TODO: the remaining flavors.

#pragma once

#ifdef __APPLE__
#include <mach/mach.h>
#include <stdint.h>

typedef natural_t task_flavor_t;
typedef integer_t *task_info_t;

#define TASK_VM_INFO 22

// Mach info structs are 4-byte packed; the count encodes the struct
// revision in natural_t units.
#pragma pack(push, 4)
struct task_vm_info {
    mach_vm_size_t virtual_size;
    integer_t region_count;
    integer_t page_size;
    mach_vm_size_t resident_size;
    mach_vm_size_t resident_size_peak;
    mach_vm_size_t device;
    mach_vm_size_t device_peak;
    mach_vm_size_t internal;
    mach_vm_size_t internal_peak;
    mach_vm_size_t external;
    mach_vm_size_t external_peak;
    mach_vm_size_t reusable;
    mach_vm_size_t reusable_peak;
    mach_vm_size_t purgeable_volatile_pmap;
    mach_vm_size_t purgeable_volatile_resident;
    mach_vm_size_t purgeable_volatile_virtual;
    mach_vm_size_t compressed;
    mach_vm_size_t compressed_peak;
    mach_vm_size_t compressed_lifetime;
    // rev1
    mach_vm_size_t phys_footprint;
    // rev2
    mach_vm_address_t min_address;
    mach_vm_address_t max_address;
    // rev3
    int64_t ledger_phys_footprint_peak;
    int64_t ledger_purgeable_nonvolatile;
    int64_t ledger_purgeable_novolatile_compressed;
    int64_t ledger_purgeable_volatile;
    int64_t ledger_purgeable_volatile_compressed;
    int64_t ledger_tag_network_nonvolatile;
    int64_t ledger_tag_network_nonvolatile_compressed;
    int64_t ledger_tag_network_volatile;
    int64_t ledger_tag_network_volatile_compressed;
    int64_t ledger_tag_media_footprint;
    int64_t ledger_tag_media_footprint_compressed;
    int64_t ledger_tag_media_nofootprint;
    int64_t ledger_tag_media_nofootprint_compressed;
    int64_t ledger_tag_graphics_footprint;
    int64_t ledger_tag_graphics_footprint_compressed;
    int64_t ledger_tag_graphics_nofootprint;
    int64_t ledger_tag_graphics_nofootprint_compressed;
    int64_t ledger_tag_neural_footprint;
    int64_t ledger_tag_neural_footprint_compressed;
    int64_t ledger_tag_neural_nofootprint;
    int64_t ledger_tag_neural_nofootprint_compressed;
    // rev4
    uint64_t limit_bytes_remaining;
    // rev5
    integer_t decompressions;
    // rev6
    int64_t ledger_swapins;
    // rev7
    int64_t ledger_tag_neural_nofootprint_total;
    int64_t ledger_tag_neural_nofootprint_peak;
};
#pragma pack(pop)

typedef struct task_vm_info task_vm_info_data_t;
typedef struct task_vm_info *task_vm_info_t;

#define TASK_VM_INFO_COUNT \
    ((mach_msg_type_number_t)(sizeof(task_vm_info_data_t) / sizeof(natural_t)))

#pragma binding(libc::task_info, "_task_info")

kern_return_t task_info(task_t task, task_flavor_t flavor, task_info_t info,
                        mach_msg_type_number_t *count);
#endif
