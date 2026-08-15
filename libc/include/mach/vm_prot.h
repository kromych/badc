// mach/vm_prot.h -- Mach virtual memory protection bits. Values match
// the macOS SDK header of the same name. The bits appear in Mach-O
// segment headers as well as in live mappings, so they are usable on any
// host.

#pragma once

typedef int vm_prot_t;

#define VM_PROT_NONE    ((vm_prot_t) 0x00)
#define VM_PROT_READ    ((vm_prot_t) 0x01)
#define VM_PROT_WRITE   ((vm_prot_t) 0x02)
#define VM_PROT_EXECUTE ((vm_prot_t) 0x04)
#define VM_PROT_DEFAULT (VM_PROT_READ | VM_PROT_WRITE)
#define VM_PROT_ALL     (VM_PROT_READ | VM_PROT_WRITE | VM_PROT_EXECUTE)

// Not a protection bit: a request modifier on vm_map / vm_protect.
#define VM_PROT_NO_CHANGE_LEGACY ((vm_prot_t) 0x08)
#define VM_PROT_NO_CHANGE        ((vm_prot_t) 0x01000000)
#define VM_PROT_COPY             ((vm_prot_t) 0x10)
#define VM_PROT_WANTS_COPY       ((vm_prot_t) 0x10)
#define VM_PROT_IS_MASK          ((vm_prot_t) 0x40)
#define VM_PROT_STRIP_READ       ((vm_prot_t) 0x80)
#define VM_PROT_EXECUTE_ONLY     (VM_PROT_EXECUTE | VM_PROT_STRIP_READ)
#define VM_PROT_TPRO             ((vm_prot_t) 0x200)
