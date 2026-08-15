// mach/mach_vm.h -- the 64-bit Mach virtual memory routines. macOS only.
// Prototypes match the macOS SDK header of the same name.
//
// The address-space routines that need no further Mach types are
// declared. mach_vm_map / mach_vm_remap take a memory entry port,
// mach_vm_purgable_control and mach_vm_page_info take flavour enums
// declared in headers badc does not bundle; those are left out.

#pragma once

#include <stdint.h>
#include <mach/mach.h>
#include <mach/vm_prot.h>
#include <mach/vm_region.h>

#ifdef __APPLE__
// A task port viewed as an address space. Darwin distinguishes the read
// and inspect rights in the type only; all three are mach_port_t.
typedef mach_port_t vm_map_t;
typedef mach_port_t vm_map_read_t;
typedef mach_port_t vm_map_inspect_t;

#define VM_MAP_NULL         ((vm_map_t) 0)
#define VM_MAP_READ_NULL    ((vm_map_read_t) 0)
#define VM_MAP_INSPECT_NULL ((vm_map_inspect_t) 0)

// vm_offset_t is a type-neutral pointer in the caller's address space.
typedef uintptr_t vm_offset_t;
typedef uintptr_t vm_size_t;

#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::mach_vm_allocate,       "_mach_vm_allocate")
#pragma binding(libc::mach_vm_deallocate,     "_mach_vm_deallocate")
#pragma binding(libc::mach_vm_protect,        "_mach_vm_protect")
#pragma binding(libc::mach_vm_read,           "_mach_vm_read")
#pragma binding(libc::mach_vm_read_overwrite, "_mach_vm_read_overwrite")
#pragma binding(libc::mach_vm_write,          "_mach_vm_write")
#pragma binding(libc::mach_vm_copy,           "_mach_vm_copy")
#pragma binding(libc::mach_vm_region,         "_mach_vm_region")

kern_return_t mach_vm_allocate(vm_map_t target, mach_vm_address_t *address,
                               mach_vm_size_t size, int flags);
kern_return_t mach_vm_deallocate(vm_map_t target, mach_vm_address_t address,
                                 mach_vm_size_t size);
kern_return_t mach_vm_protect(vm_map_t target_task, mach_vm_address_t address,
                              mach_vm_size_t size, boolean_t set_maximum,
                              vm_prot_t new_protection);
// Returns the data out of line; the caller deallocates it.
kern_return_t mach_vm_read(vm_map_read_t target_task, mach_vm_address_t address,
                           mach_vm_size_t size, vm_offset_t *data,
                           mach_msg_type_number_t *dataCnt);
// Reads into a buffer the caller already owns.
kern_return_t mach_vm_read_overwrite(vm_map_read_t target_task,
                                     mach_vm_address_t address,
                                     mach_vm_size_t size,
                                     mach_vm_address_t data,
                                     mach_vm_size_t *outsize);
kern_return_t mach_vm_write(vm_map_t target_task, mach_vm_address_t address,
                            vm_offset_t data, mach_msg_type_number_t dataCnt);
kern_return_t mach_vm_copy(vm_map_t target_task, mach_vm_address_t source_address,
                           mach_vm_size_t size, mach_vm_address_t dest_address);
// Walks the map: `address` advances to the start of the region found at
// or after it, and `size` reports that region's extent.
kern_return_t mach_vm_region(vm_map_read_t target_task, mach_vm_address_t *address,
                             mach_vm_size_t *size, vm_region_flavor_t flavor,
                             vm_region_info_t info,
                             mach_msg_type_number_t *infoCnt,
                             mach_port_t *object_name);
#endif
