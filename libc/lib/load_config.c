/* The load-config directory of a PE image that claims Control Flow Guard
** (`--guard-cf`) where no library of the link defines one. The 320 bytes
** are IMAGE_LOAD_CONFIG_DIRECTORY64 (PE/COFF specification 6.11) as 8-byte
** fields: the size, the check and dispatch pointers, and the guard table's
** address, count and flags, which the linker fills. The loader replaces
** each pointer's value with the system's check when the process enforces
** the guard; until then a check passes. */
#if defined(_WIN32) && (defined(__x86_64__) || defined(__aarch64__))

extern char __guard_fids_table[], __guard_fids_count[], __guard_flags[];

#if defined(__x86_64__)
/* x64 checks the target in rcx; dispatch calls the target in rax. */
__asm__(".text\n"
        ".globl __badc_guard_check_icall_nop\n"
        "__badc_guard_check_icall_nop:\n"
        "  ret\n"
        ".globl __badc_guard_dispatch_icall_nop\n"
        "__badc_guard_dispatch_icall_nop:\n"
        "  jmp *%rax\n");
extern void __badc_guard_dispatch_icall_nop(void);
void (*const __guard_dispatch_icall_fptr)(void) = __badc_guard_dispatch_icall_nop;
#else
/* arm64 checks the target in x15. */
__asm__(".text\n"
        ".globl __badc_guard_check_icall_nop\n"
        "__badc_guard_check_icall_nop:\n"
        "  ret\n");
#endif
extern void __badc_guard_check_icall_nop(void);
void (*const __guard_check_icall_fptr)(void) = __badc_guard_check_icall_nop;

const unsigned long long _load_config_used[40] = {
    [0] = sizeof(unsigned long long[40]),
    [14] = (unsigned long long)&__guard_check_icall_fptr,
#if defined(__x86_64__)
    [15] = (unsigned long long)&__guard_dispatch_icall_fptr,
#endif
    [16] = (unsigned long long)__guard_fids_table,
    [17] = (unsigned long long)__guard_fids_count,
    [18] = (unsigned long long)__guard_flags,
};

#endif
