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

#endif // __linux__ / __APPLE__
