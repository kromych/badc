// Stack-protector runtime, provided on demand: the failure handler the
// canary epilogue branches to and the guard object its prologue reads. The
// native-link driver pulls this object in only when a unit left one of the
// symbols undefined, so an image built without -fstack-protector carries
// none of it -- and neither does it carry the glibc non-shared wrappers,
// which is why these live apart from `compiler_rt.c`.
//
// Both forward to the C library: the handler so its diagnostic and abort
// are libc's, and the guard so every unit in the image reads the object the
// loader binds, whose value libc randomizes at startup. Linux/x86-64 reads
// the canary from %fs:0x28 instead and reaches neither of them.

#ifdef __linux__

#pragma dylib(libc, "libc.so.6")
#pragma binding(libc::__c5_stack_chk_fail, "__stack_chk_fail")
extern void __c5_stack_chk_fail(void);
#pragma binding(data libc::__stack_chk_guard, "__stack_chk_guard")
extern unsigned long __stack_chk_guard;

void __stack_chk_fail(void) {
    // Naming the guard here is what routes it to the loader's copy for
    // every unit in the image; without a reference the binding is unused.
    (void)__stack_chk_guard;
    __c5_stack_chk_fail();
}

// Some toolchains call the local alias so position-independent code reaches
// the handler without a PLT hop; forward it to the same place.
void __stack_chk_fail_local(void) { __stack_chk_fail(); }

#elif defined(__APPLE__)

// libSystem exports both, spelled with the Mach-O leading underscore.
#pragma dylib(libc, "/usr/lib/libSystem.B.dylib")
#pragma binding(libc::__c5_stack_chk_fail, "___stack_chk_fail")
extern void __c5_stack_chk_fail(void);
#pragma binding(data libc::__stack_chk_guard, "___stack_chk_guard")
extern unsigned long __stack_chk_guard;

void __stack_chk_fail(void) {
    (void)__stack_chk_guard;
    __c5_stack_chk_fail();
}

#elif defined(_WIN32) && defined(__x86_64__)

// MSVC's `/GS`: a frame passes `__security_cookie` xor rsp in rcx to
// `__security_check_cookie` with its return value live, so the check touches
// rcx and the flags only; a mismatch is `__fastfail(2)`
// (FAST_FAIL_STACK_COOKIE_CHECK_FAILURE). The value is the C runtime's default.
unsigned long long __security_cookie = 0x00002B992DDFA232ULL;

__asm__(".text\n"
        ".globl __security_check_cookie\n"
        "__security_check_cookie:\n"
        "  cmpq __security_cookie(%rip), %rcx\n"
        "  jne 1f\n"
        "  ret\n"
        "1:\n"
        "  movl $2, %ecx\n"
        "  int $0x29\n");

#elif defined(_WIN32) && defined(__aarch64__)

// MSVC's arm64 `/GS`: `__security_push_cookie` reserves 16 bytes holding sp
// minus the cookie, `__security_pop_cookie` checks and releases them. Both run
// with the arguments or the return value live and use x16 and x17 only; a
// mismatch goes to `__security_check_cookie`.
unsigned long long __security_cookie = 0x00002B992DDFA232ULL;

__asm__(".text\n"
        ".globl __security_push_cookie\n"
        "__security_push_cookie:\n"
        "  sub sp, sp, #16\n"
        "  adrp x17, __security_cookie\n"
        "  ldr x17, [x17, :lo12:__security_cookie]\n"
        "  sub x17, sp, x17\n"
        "  str x17, [sp, #8]\n"
        "  ret\n"
        ".globl __security_pop_cookie\n"
        "__security_pop_cookie:\n"
        "  adrp x17, __security_cookie\n"
        "  ldr x16, [sp, #8]\n"
        "  ldr x17, [x17, :lo12:__security_cookie]\n"
        "  sub x16, sp, x16\n"
        "  cmp x16, x17\n"
        "  b.ne 1f\n"
        "  add sp, sp, #16\n"
        "  ret\n"
        "1:\n"
        "  mov x0, x16\n"
        "  b __security_check_cookie\n"
        ".globl __security_check_cookie\n"
        "__security_check_cookie:\n"
        "  adrp x17, __security_cookie\n"
        "  ldr x17, [x17, :lo12:__security_cookie]\n"
        "  cmp x0, x17\n"
        "  b.ne 2f\n"
        "  ret\n"
        "2:\n"
        "  mov w0, #2\n"
        "  brk #0xf003\n");

#endif // __linux__ / __APPLE__ / _WIN32
