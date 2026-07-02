// mach/mach.h -- the subset of the Darwin Mach task/thread surface badc
// programs reach for. macOS only.

#pragma once

#ifdef __APPLE__
// Mach kernel scalar types (32-bit on Darwin; the mach_vm_* pair is
// 64-bit).
typedef unsigned int mach_port_t;
typedef mach_port_t  task_t;
typedef mach_port_t  thread_t;
typedef int          kern_return_t;
typedef unsigned int mach_msg_type_number_t;
typedef unsigned int natural_t;
typedef int          integer_t;
typedef unsigned long long mach_vm_size_t;
typedef unsigned long long mach_vm_address_t;
// An out-of-line array of thread ports returned by task_threads().
typedef thread_t    *thread_array_t;

#define KERN_SUCCESS 0

#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::mach_task_self, "_mach_task_self")
#pragma binding(libc::task_for_pid,   "_task_for_pid")
#pragma binding(libc::task_threads,   "_task_threads")

// The calling task's port. Darwin also exposes this as the macro
// mach_task_self(); the bound function entry has the same effect.
mach_port_t mach_task_self(void);
// Look up another process's task port by pid (requires privilege).
kern_return_t task_for_pid(mach_port_t target, int pid, mach_port_t *task);
// Enumerate a task's threads into a kernel-allocated array.
kern_return_t task_threads(task_t task, thread_array_t *threads,
                           mach_msg_type_number_t *count);
#endif
