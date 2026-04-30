//! In-process JIT runtime.
//!
//! Lowers the program with the same encoder + lowering pass the AOT
//! native backend uses, then loads the result into an mmap'd
//! executable page and calls into it. No `_start` stub: Rust calls
//! `main` directly with argc/argv in System V / AAPCS64 ABI
//! registers, which is exactly what the AOT `_start` stub would have
//! set up.
//!
//! ## Supported hosts
//!
//! * **Linux/aarch64** -- mmap RW, mprotect to RX, dc cvau / ic ivau
//!   I-cache flush.
//! * **Linux/x86_64** -- mmap RW, mprotect to RX, no I-cache flush
//!   (x86 has coherent I-cache).
//! * **macOS/aarch64 (Apple Silicon)** -- mmap RWX with `MAP_JIT`,
//!   then toggle the per-thread W^X bit via `pthread_jit_write_protect_np`
//!   to enable writes during patching, again to enable execution
//!   before the call. `sys_icache_invalidate` flushes the I-cache.
//!
//! ## Milestones in this file
//!
//! * **J2**: mmap + mprotect + transmute. Supports programs with no
//!   relocations -- arithmetic, control flow, recursion, multi-arg
//!   user calls.
//! * **J3**: data + function-pointer relocations against the runtime
//!   mmap addresses.
//! * **J4**: libc binding via dlsym at JIT time. Allocates a writable
//!   "fake GOT" region (one `u64` slot per [`aarch64::IMPORTS`]
//!   entry), `dlopen(NULL)` + `dlsym(...)` to resolve each symbol,
//!   writes the resulting address into its slot, and patches the
//!   codegen's `got_fixups` against this region using the same
//!   instruction-encoding logic the ELF writer uses. There is no
//!   `_start` libc-exit fixup -- Rust catches `main`'s return value
//!   directly via the `extern "C"` transmute call.
//! * **J6** (current): macOS/aarch64 host. Lowers with
//!   [`Target::MacOSAarch64`] (so variadic printf packs args on the
//!   stack the way the platform ABI requires) and uses Apple's
//!   `MAP_JIT` + `pthread_jit_write_protect_np` toggle to satisfy
//!   the hardware-enforced W^X. Works with cargo's ad-hoc-signed
//!   binaries; a hardened-runtime binary would need
//!   `com.apple.security.cs.allow-jit`.

use alloc::string::{String, ToString};

use super::super::error::C4Error;
use super::super::program::Program;
use super::{NativeOptions, Target};

/// Compile, lower, and run `program` in-process. Returns the exit
/// code as it would appear from a child process. `args` becomes the
/// hosted program's argv.
pub fn jit_run(program: &Program, args: &[String]) -> Result<i32, C4Error> {
    jit_run_with_options(program, args, NativeOptions::default())
}

/// Variant of [`jit_run`] that accepts user-controllable optimization
/// knobs. Currently the only knob is [`NativeOptions::optimize`];
/// future ones will land here too.
pub fn jit_run_with_options(
    program: &Program,
    args: &[String],
    options: NativeOptions,
) -> Result<i32, C4Error> {
    #[cfg(all(
        feature = "std",
        any(target_os = "linux", all(target_os = "macos", target_arch = "aarch64"),),
    ))]
    {
        jit_impl::jit_run(program, args, options)
    }
    #[cfg(not(all(
        feature = "std",
        any(target_os = "linux", all(target_os = "macos", target_arch = "aarch64"),),
    )))]
    {
        let _ = (program, args, options);
        Err(C4Error::Compile(
            "JIT: requires the `std` feature on Linux (any arch) or macOS/aarch64".to_string(),
        ))
    }
}

/// Pick the target appropriate for the current host. JIT only knows
/// how to lower for the host arch -- there's no cross-arch JIT.
#[allow(dead_code)]
fn host_target() -> Result<Target, C4Error> {
    if cfg!(all(target_os = "macos", target_arch = "aarch64")) {
        Ok(Target::MacOSAarch64)
    } else if cfg!(all(target_os = "linux", target_arch = "aarch64")) {
        Ok(Target::LinuxAarch64)
    } else if cfg!(all(target_os = "linux", target_arch = "x86_64")) {
        Ok(Target::LinuxX64)
    } else {
        Err(C4Error::Compile(
            "JIT: host OS/arch unsupported (need Linux/aarch64, Linux/x86_64, or macOS/aarch64)"
                .to_string(),
        ))
    }
}

#[cfg(all(
    feature = "std",
    any(target_os = "linux", all(target_os = "macos", target_arch = "aarch64"),),
))]
mod jit_impl {
    use super::super::super::error::C4Error;
    use super::super::super::program::Program;
    use super::super::Target;
    use super::super::{Build, NativeOptions, ResolvedImports, aarch64, x86_64};
    use super::host_target;
    use alloc::format;
    use alloc::string::{String, ToString};
    use alloc::vec::Vec;
    use std::ffi::CString;
    use std::os::raw::{c_char, c_int, c_void};

    pub fn jit_run(
        program: &Program,
        args: &[String],
        options: NativeOptions,
    ) -> Result<i32, C4Error> {
        let target = host_target()?;
        let build = lower_for_jit(program, target, options)?;

        // Allocate a writable data region, copy `build.data` in. The
        // page is RW (no exec permission); programs that try to
        // execute through it would fault, which is what we want.
        let data_region = if !build.data.is_empty() {
            Some(DataRegion::new(&build.data)?)
        } else {
            None
        };
        let data_vmaddr = data_region.as_ref().map(|r| r.as_ptr() as u64).unwrap_or(0);

        // Allocate a "fake GOT" -- one u64 per resolved import, each
        // holding the runtime address of the corresponding libc
        // symbol resolved via dlsym. The codegen's adrp+ldr / call
        // qword [rip+disp32] sequences will read through this region
        // exactly the way the ELF loader's relocations would.
        let mut got_region = GotRegion::new(build.imports.imports.len())?;
        got_region.bind_imports(&build.imports)?;
        let got_vmaddr = got_region.as_ptr() as u64;

        // Allocate the code region. Patch fixups against the mmap'd
        // addresses *before* flipping to RX -- the writes need to
        // hit RW pages. Once exec is enabled the page is read-only
        // for the lifetime of the run.
        let region = JitRegion::new(&build.text)?;
        let code_vmaddr = region.as_ptr() as u64;
        apply_jit_fixups(
            target,
            unsafe { core::slice::from_raw_parts_mut(region.as_mut_ptr(), build.text.len()) },
            code_vmaddr,
            data_vmaddr,
            got_vmaddr,
            &build,
        )?;
        region.make_executable()?;
        flush_icache(region.as_ptr(), region.len());

        // Build a System V argv: a NULL-terminated array of `char *`
        // pointers. The CStrings live for the duration of the call;
        // the function pointer table only needs to outlive the
        // single `main_fn(...)` invocation.
        let argv_cstrings: Vec<CString> = args
            .iter()
            .map(|s| CString::new(s.as_str()).unwrap_or_default())
            .collect();
        let mut argv_ptrs: Vec<*const c_char> =
            argv_cstrings.iter().map(|cs| cs.as_ptr()).collect();
        argv_ptrs.push(std::ptr::null());

        let entry_ptr = unsafe { region.as_ptr().add(build.entry_offset) };
        // SAFETY: the JIT'd main was lowered with extern "C" / System V
        // ABI conventions and reachable via a normal `call`-equivalent
        // (transmuting + invoking is the same as the call instruction
        // a parent function would make). main reads argc/argv from
        // the System V argument registers and returns its exit code
        // in rax / x0.
        let main_fn: extern "C" fn(c_int, *const *const c_char) -> c_int =
            unsafe { std::mem::transmute(entry_ptr) };
        let exit_code = main_fn(args.len() as c_int, argv_ptrs.as_ptr());
        Ok(exit_code as i32)
    }

    fn lower_for_jit(
        program: &Program,
        target: Target,
        options: NativeOptions,
    ) -> Result<Build, C4Error> {
        // Same plumbing as `super::lower_for`: resolve once, lower
        // with that view, then stitch the imports back onto the
        // returned `Build` so the JIT loader can populate its
        // fake-GOT region from the same enumeration the lowering
        // saw.
        let imports = ResolvedImports::resolve(program)?;
        let mut build = match target {
            Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => {
                aarch64::lower(program, target, options, &imports)?
            }
            Target::LinuxX64 | Target::WindowsX64 => {
                x86_64::lower(program, target, options, &imports)?
            }
        };
        build.imports = imports;
        Ok(build)
    }

    // ----------------------------------------------------------------
    // Memory allocation. We use raw mmap / mprotect / munmap because
    // pulling in `libc` or `region` as Cargo deps would change the
    // crate's no-deps story for one feature; the intrinsic surface here
    // is small and stable on Linux + Darwin.
    // ----------------------------------------------------------------

    const PROT_READ: c_int = 1;
    const PROT_WRITE: c_int = 2;
    const PROT_EXEC: c_int = 4;
    const MAP_PRIVATE: c_int = 0x02;

    // Linux's MAP_ANONYMOUS = 0x20; Darwin's MAP_ANON = 0x1000. The
    // headers spell them differently but the runtime semantics --
    // "back the mapping with anonymous pages" -- are identical.
    #[cfg(target_os = "linux")]
    const MAP_ANONYMOUS: c_int = 0x20;
    #[cfg(target_os = "macos")]
    const MAP_ANONYMOUS: c_int = 0x1000;

    /// macOS-only `MAP_JIT`. Required for any region we want to be
    /// both writable and executable on Apple Silicon -- without it,
    /// asking for `PROT_EXEC` on a writable mapping is rejected by
    /// the kernel. The hardware-enforced W^X toggle that gates each
    /// access lives in `pthread_jit_write_protect_np`.
    #[cfg(target_os = "macos")]
    const MAP_JIT: c_int = 0x800;

    /// `(void *) -1` -- the sentinel mmap returns on failure.
    fn map_failed() -> *mut c_void {
        usize::MAX as *mut c_void
    }

    /// RAII wrapper around an executable mmap region. Drop calls
    /// `munmap` so even early-return paths don't leak the mapping.
    struct JitRegion {
        ptr: *mut u8,
        len: usize,
    }

    impl JitRegion {
        fn new(code: &[u8]) -> Result<Self, C4Error> {
            unsafe extern "C" {
                fn mmap(
                    addr: *mut c_void,
                    len: usize,
                    prot: c_int,
                    flags: c_int,
                    fd: c_int,
                    offset: i64,
                ) -> *mut c_void;
            }
            let len = round_up_to_page(code.len());

            // Linux: ask for RW now, mprotect to RX once we're
            // done writing. macOS arm64: ask for RWX with MAP_JIT,
            // then toggle the per-thread W^X bit to enable writes.
            // The two paths converge at "writable region holding
            // the JIT'd bytes" by the time we return.
            #[cfg(target_os = "linux")]
            let (prot, flags) = (PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS);
            #[cfg(target_os = "macos")]
            let (prot, flags) = (
                PROT_READ | PROT_WRITE | PROT_EXEC,
                MAP_PRIVATE | MAP_ANONYMOUS | MAP_JIT,
            );

            let ptr = unsafe { mmap(std::ptr::null_mut(), len, prot, flags, -1, 0) };
            if ptr == map_failed() {
                return Err(C4Error::Compile(format!(
                    "JIT: mmap failed: {}",
                    std::io::Error::last_os_error()
                )));
            }

            // macOS: a freshly mmap'd MAP_JIT region defaults to RX
            // for the executing thread. Flip the per-thread toggle to
            // enable writes before we copy the code in or apply
            // fixups; `make_executable` flips it back.
            #[cfg(target_os = "macos")]
            unsafe {
                jit_write_protect(false);
            }

            // SAFETY: `ptr` points at `len` writable bytes; `code`
            // fits since `len >= code.len()`. Both regions are
            // disjoint by construction (fresh mmap).
            unsafe {
                std::ptr::copy_nonoverlapping(code.as_ptr(), ptr as *mut u8, code.len());
            }
            Ok(JitRegion {
                ptr: ptr as *mut u8,
                len,
            })
        }

        fn make_executable(&self) -> Result<(), C4Error> {
            #[cfg(target_os = "linux")]
            {
                unsafe extern "C" {
                    fn mprotect(addr: *mut c_void, len: usize, prot: c_int) -> c_int;
                }
                let r =
                    unsafe { mprotect(self.ptr as *mut c_void, self.len, PROT_READ | PROT_EXEC) };
                if r != 0 {
                    return Err(C4Error::Compile(format!(
                        "JIT: mprotect failed: {}",
                        std::io::Error::last_os_error()
                    )));
                }
            }
            #[cfg(target_os = "macos")]
            unsafe {
                // Re-enable the W^X bit so the just-patched region is
                // executable. The mapping was already PROT_READ |
                // PROT_EXEC at the page-table level (MAP_JIT keeps
                // both bits set); the toggle is what the hardware
                // enforces per-access.
                jit_write_protect(true);
            }
            Ok(())
        }

        fn as_ptr(&self) -> *const u8 {
            self.ptr
        }

        fn as_mut_ptr(&self) -> *mut u8 {
            self.ptr
        }

        fn len(&self) -> usize {
            self.len
        }
    }

    /// Per-thread Apple Silicon W^X toggle. `enable_writes = true`
    /// makes every MAP_JIT region on this thread writable and
    /// non-executable; `false` makes them executable and read-only.
    /// Called only on macOS; the shim is what `pthread_jit_write_protect_np`
    /// expects (`int enabled` -- 1 means "write-protect on" =
    /// executable, 0 means "writable").
    #[cfg(target_os = "macos")]
    unsafe fn jit_write_protect(executable: bool) {
        unsafe extern "C" {
            fn pthread_jit_write_protect_np(enabled: c_int);
        }
        unsafe { pthread_jit_write_protect_np(if executable { 1 } else { 0 }) };
    }

    /// Read-write data region. Same mmap shape as `JitRegion` but
    /// stays RW for the lifetime of the run -- the JIT'd code reads
    /// strings + globals here through RIP-relative / ADRP+ADD
    /// loads patched by [`apply_jit_fixups`].
    struct DataRegion {
        ptr: *mut u8,
        len: usize,
    }

    impl DataRegion {
        fn new(data: &[u8]) -> Result<Self, C4Error> {
            unsafe extern "C" {
                fn mmap(
                    addr: *mut c_void,
                    len: usize,
                    prot: c_int,
                    flags: c_int,
                    fd: c_int,
                    offset: i64,
                ) -> *mut c_void;
            }
            let len = round_up_to_page(data.len());
            let ptr = unsafe {
                mmap(
                    std::ptr::null_mut(),
                    len,
                    PROT_READ | PROT_WRITE,
                    MAP_PRIVATE | MAP_ANONYMOUS,
                    -1,
                    0,
                )
            };
            if ptr == map_failed() {
                return Err(C4Error::Compile(format!(
                    "JIT: data mmap failed: {}",
                    std::io::Error::last_os_error()
                )));
            }
            unsafe {
                std::ptr::copy_nonoverlapping(data.as_ptr(), ptr as *mut u8, data.len());
            }
            Ok(DataRegion {
                ptr: ptr as *mut u8,
                len,
            })
        }

        fn as_ptr(&self) -> *const u8 {
            self.ptr
        }
    }

    impl Drop for DataRegion {
        fn drop(&mut self) {
            unsafe extern "C" {
                fn munmap(addr: *mut c_void, len: usize) -> c_int;
            }
            unsafe {
                munmap(self.ptr as *mut c_void, self.len);
            }
        }
    }

    // ----------------------------------------------------------------
    // "Fake GOT": a writable page of u64 slots, one per IMPORTS row.
    // The JIT'd code accesses libc symbols by loading through these
    // slots, exactly the way the ELF loader-resolved .got would be
    // accessed in the AOT path. Resolving is done at JIT time via
    // dlopen(NULL, RTLD_NOW) + dlsym -- failure to resolve a name
    // leaves a 0 in the slot, which will fault if (and only if) the
    // code tries to call it. This lets a program that imports
    // `dlopen` keep working even if `dlopen` itself isn't reachable
    // through the global handle -- as long as no codepath actually
    // invokes it.
    // ----------------------------------------------------------------

    /// `dlopen` flags. `RTLD_NOW` resolves all undefined symbols at
    /// load time; with `path = NULL` the returned handle searches
    /// every library already loaded into the process, which is what
    /// gives us libc + libdl + Rust's own deps in one shot.
    const RTLD_NOW: c_int = 2;

    /// Writable region holding one libc-symbol address per resolved
    /// import. RAII: `Drop` munmaps + dlcloses.
    struct GotRegion {
        ptr: *mut u8,
        len: usize,
        dl_handle: *mut c_void,
    }

    impl GotRegion {
        fn new(n_imports: usize) -> Result<Self, C4Error> {
            unsafe extern "C" {
                fn mmap(
                    addr: *mut c_void,
                    len: usize,
                    prot: c_int,
                    flags: c_int,
                    fd: c_int,
                    offset: i64,
                ) -> *mut c_void;
            }
            // mmap a full page even if we have only a handful of
            // imports. Keeps the address-load patching's 4 KiB-
            // alignment check trivially satisfied; an empty import
            // set still gets a single page rather than zero bytes
            // so the slot pointer is well-defined.
            let len = round_up_to_page(n_imports.max(1) * 8);
            let ptr = unsafe {
                mmap(
                    std::ptr::null_mut(),
                    len,
                    PROT_READ | PROT_WRITE,
                    MAP_PRIVATE | MAP_ANONYMOUS,
                    -1,
                    0,
                )
            };
            if ptr == map_failed() {
                return Err(C4Error::Compile(format!(
                    "JIT: GOT mmap failed: {}",
                    std::io::Error::last_os_error()
                )));
            }
            Ok(GotRegion {
                ptr: ptr as *mut u8,
                len,
                dl_handle: std::ptr::null_mut(),
            })
        }

        /// Resolve every binding in `imports` and write each resulting
        /// address into the slot at `8 * idx`. Slot order matches
        /// the lowering's view (it embedded `idx` into the GOT
        /// fixups), so the patcher's `import_index` indexes straight
        /// into this region. Symbols missing from the host's loaded
        /// scope leave a 0 slot rather than aborting -- the call
        /// will SIGSEGV when used, which is the right "this isn't
        /// in libc" failure mode for a JIT.
        fn bind_imports(&mut self, imports: &ResolvedImports) -> Result<(), C4Error> {
            unsafe extern "C" {
                fn dlopen(filename: *const c_char, flags: c_int) -> *mut c_void;
                fn dlsym(handle: *mut c_void, name: *const c_char) -> *mut c_void;
            }
            let handle = unsafe { dlopen(std::ptr::null(), RTLD_NOW) };
            if handle.is_null() {
                return Err(C4Error::Compile(
                    "JIT: dlopen(NULL, RTLD_NOW) returned null -- can't resolve libc symbols"
                        .to_string(),
                ));
            }
            self.dl_handle = handle;

            // Strip the leading underscore on macOS for `dlsym` --
            // the symbol stored in the binding is the Mach-O view
            // (`_printf`), but `dlsym` wants the C view (`printf`).
            // On Linux/Windows the binding is already underscoreless.
            for (i, imp) in imports.imports.iter().enumerate() {
                let lookup_name = if cfg!(target_os = "macos") {
                    imp.real_symbol.strip_prefix('_').unwrap_or(&imp.real_symbol)
                } else {
                    imp.real_symbol.as_str()
                };
                let cs = match CString::new(lookup_name) {
                    Ok(cs) => cs,
                    Err(_) => continue, // unreachable: symbol names are static ASCII
                };
                let addr = unsafe { dlsym(handle, cs.as_ptr()) } as u64;
                let slot_off = i * 8;
                unsafe {
                    let dst = self.ptr.add(slot_off) as *mut u64;
                    std::ptr::write_unaligned(dst, addr);
                }
            }
            Ok(())
        }

        fn as_ptr(&self) -> *const u8 {
            self.ptr
        }
    }

    impl Drop for GotRegion {
        fn drop(&mut self) {
            unsafe extern "C" {
                fn munmap(addr: *mut c_void, len: usize) -> c_int;
                fn dlclose(handle: *mut c_void) -> c_int;
            }
            if !self.dl_handle.is_null() {
                unsafe {
                    dlclose(self.dl_handle);
                }
            }
            unsafe {
                munmap(self.ptr as *mut c_void, self.len);
            }
        }
    }

    /// Patch the lowered code's GOT, data, and function-pointer
    /// fixups against the runtime mmap addresses. The patch math
    /// mirrors the ELF writer's `patch_got_call` / `patch_addr_load`
    /// helpers -- the difference is that here `code_vmaddr` /
    /// `data_vmaddr` / `got_vmaddr` are mmap'd page runtime
    /// addresses, not fixed ELF vmaddr_base values.
    /// (`build.entry_offset` is unaffected: there's no `_start` stub
    /// prepended in JIT, so byte offsets in `build.text` match
    /// runtime offsets exactly.)
    fn apply_jit_fixups(
        target: Target,
        code: &mut [u8],
        code_vmaddr: u64,
        data_vmaddr: u64,
        got_vmaddr: u64,
        build: &Build,
    ) -> Result<(), C4Error> {
        for fx in &build.got_fixups {
            patch_got_call(
                target,
                code,
                code_vmaddr,
                fx.adrp_offset as u64,
                got_vmaddr + (fx.import_index as u64) * 8,
                "GOT fixup",
            )?;
        }
        for fx in &build.data_fixups {
            patch_addr_load(
                target,
                code,
                code_vmaddr,
                fx.adrp_offset as u64,
                data_vmaddr + fx.data_offset,
                "data fixup",
            )?;
        }
        for fx in &build.func_fixups {
            patch_addr_load(
                target,
                code,
                code_vmaddr,
                fx.adrp_offset as u64,
                code_vmaddr + fx.target_native_offset as u64,
                "func fixup",
            )?;
        }
        Ok(())
    }

    /// Patch a "call libc through GOT slot" sequence. aarch64
    /// emits `adrp + ldr + blr` -- patch the adrp+ldr immediates so
    /// the loaded pointer is the GOT slot. x86_64 emits
    /// `call qword [rip + disp32]` -- patch the disp32.
    fn patch_got_call(
        target: Target,
        code: &mut [u8],
        code_vmaddr: u64,
        instr_offset: u64,
        target_vmaddr: u64,
        label: &str,
    ) -> Result<(), C4Error> {
        match target {
            Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => {
                patch_adrp_ldr(code, code_vmaddr, instr_offset, target_vmaddr, label)
            }
            Target::LinuxX64 | Target::WindowsX64 => {
                patch_call_qword_rip32(code, code_vmaddr, instr_offset, target_vmaddr, label)
            }
        }
    }

    /// aarch64 `adrp Xd, page; ldr Xd, [Xd, #imm12]` patcher. The
    /// loaded value at `target_vmaddr` is the GOT slot's stored
    /// libc address; the JIT'd `blr xd` then dispatches there.
    fn patch_adrp_ldr(
        code: &mut [u8],
        code_vmaddr: u64,
        instr_offset: u64,
        target_vmaddr: u64,
        label: &str,
    ) -> Result<(), C4Error> {
        let off = instr_offset as usize;
        let adrp_vmaddr = code_vmaddr + instr_offset;
        let adrp_page = adrp_vmaddr & !0xFFF;
        let target_page = target_vmaddr & !0xFFF;
        let page_diff = target_page as i64 - adrp_page as i64;
        if page_diff & 0xFFF != 0 {
            return Err(C4Error::Compile(format!(
                "JIT: {label} page diff {page_diff} not 4 KiB aligned"
            )));
        }
        let imm21 = (page_diff >> 12) as i32;
        let in_page = (target_vmaddr & 0xFFF) as u32;
        if !in_page.is_multiple_of(8) {
            return Err(C4Error::Compile(format!(
                "JIT: {label} slot offset {in_page:#x} not 8-aligned"
            )));
        }
        let adrp_word = super::super::aarch64::enc_adrp(super::super::aarch64::Reg::X16, imm21);
        let ldr_word = super::super::aarch64::enc_ldr_imm(
            super::super::aarch64::Reg::X16,
            super::super::aarch64::Reg::X16,
            in_page,
        );
        code[off..off + 4].copy_from_slice(&adrp_word.to_le_bytes());
        code[off + 4..off + 8].copy_from_slice(&ldr_word.to_le_bytes());
        Ok(())
    }

    /// x86_64 `call qword [rip + disp32]` patcher. disp32 is
    /// measured from the byte just past the call (i.e. from
    /// `instr_vmaddr + CALL_QWORD_RIP32_LEN`).
    fn patch_call_qword_rip32(
        code: &mut [u8],
        code_vmaddr: u64,
        instr_offset: u64,
        target_vmaddr: u64,
        label: &str,
    ) -> Result<(), C4Error> {
        const CALL_LEN: u64 = super::super::x86_64::CALL_QWORD_RIP32_LEN as u64;
        let instr_vmaddr = code_vmaddr + instr_offset;
        let after = instr_vmaddr + CALL_LEN;
        let delta = target_vmaddr as i64 - after as i64;
        if !(i32::MIN as i64..=i32::MAX as i64).contains(&delta) {
            return Err(C4Error::Compile(format!(
                "JIT: {label} disp {delta} doesn't fit in 32 bits"
            )));
        }
        let disp32 = delta as i32;
        let off = (instr_offset + CALL_LEN - 4) as usize;
        code[off..off + 4].copy_from_slice(&disp32.to_le_bytes());
        Ok(())
    }

    /// Patch a "load this address into the accumulator" sequence at
    /// `instr_offset` so the loaded value equals `target_vmaddr`.
    /// aarch64 uses an `adrp + add` pair; x86_64 uses a single
    /// `lea r13, [rip + disp32]`.
    fn patch_addr_load(
        target: Target,
        code: &mut [u8],
        code_vmaddr: u64,
        instr_offset: u64,
        target_vmaddr: u64,
        label: &str,
    ) -> Result<(), C4Error> {
        match target {
            Target::MacOSAarch64 | Target::LinuxAarch64 | Target::WindowsAarch64 => {
                patch_adrp_add(code, code_vmaddr, instr_offset, target_vmaddr, label)
            }
            Target::LinuxX64 | Target::WindowsX64 => {
                patch_lea_rip32(code, code_vmaddr, instr_offset, target_vmaddr, label)
            }
        }
    }

    fn patch_adrp_add(
        code: &mut [u8],
        code_vmaddr: u64,
        instr_offset: u64,
        target_vmaddr: u64,
        label: &str,
    ) -> Result<(), C4Error> {
        let off = instr_offset as usize;
        let adrp_vmaddr = code_vmaddr + instr_offset;
        let adrp_page = adrp_vmaddr & !0xFFF;
        let target_page = target_vmaddr & !0xFFF;
        let page_diff = target_page as i64 - adrp_page as i64;
        if page_diff & 0xFFF != 0 {
            return Err(C4Error::Compile(format!(
                "JIT: {label} page diff {page_diff} not 4 KiB aligned"
            )));
        }
        let imm21 = (page_diff >> 12) as i32;
        let in_page = (target_vmaddr & 0xFFF) as u32;

        let adrp_word = super::super::aarch64::enc_adrp(super::super::aarch64::Reg::X19, imm21);
        let add_word = super::super::aarch64::enc_add_imm(
            super::super::aarch64::Reg::X19,
            super::super::aarch64::Reg::X19,
            in_page,
        );
        code[off..off + 4].copy_from_slice(&adrp_word.to_le_bytes());
        code[off + 4..off + 8].copy_from_slice(&add_word.to_le_bytes());
        Ok(())
    }

    fn patch_lea_rip32(
        code: &mut [u8],
        code_vmaddr: u64,
        instr_offset: u64,
        target_vmaddr: u64,
        label: &str,
    ) -> Result<(), C4Error> {
        const LEA_LEN: u64 = super::super::x86_64::LEA_RIP32_LEN as u64;
        let instr_vmaddr = code_vmaddr + instr_offset;
        let after = instr_vmaddr + LEA_LEN;
        let delta = target_vmaddr as i64 - after as i64;
        if !(i32::MIN as i64..=i32::MAX as i64).contains(&delta) {
            return Err(C4Error::Compile(format!(
                "JIT: {label} disp {delta} doesn't fit in 32 bits"
            )));
        }
        let disp32 = delta as i32;
        let off = (instr_offset + LEA_LEN - 4) as usize;
        code[off..off + 4].copy_from_slice(&disp32.to_le_bytes());
        Ok(())
    }

    impl Drop for JitRegion {
        fn drop(&mut self) {
            unsafe extern "C" {
                fn munmap(addr: *mut c_void, len: usize) -> c_int;
            }
            unsafe {
                munmap(self.ptr as *mut c_void, self.len);
            }
        }
    }

    /// Round `n` up to a multiple of the host page size. mprotect
    /// requires page-aligned inputs; mmap returns a page-aligned
    /// pointer regardless of the requested length, but rounding the
    /// length here keeps the two consistent.
    fn round_up_to_page(n: usize) -> usize {
        let p = page_size();
        (n + p - 1) & !(p - 1)
    }

    fn page_size() -> usize {
        unsafe extern "C" {
            fn getpagesize() -> c_int;
        }
        let p = unsafe { getpagesize() };
        if p > 0 { p as usize } else { 4096 }
    }

    // ----------------------------------------------------------------
    // I-cache coherence after writing JIT code. x86_64 has a coherent
    // I-cache so the function is a no-op there; aarch64 needs an
    // explicit clean+invalidate dance per cache-line, capped with
    // dsb+isb to ensure the instruction stream sees the new bytes
    // before we branch into them.
    // ----------------------------------------------------------------

    #[cfg(target_arch = "x86_64")]
    fn flush_icache(_ptr: *const u8, _len: usize) {}

    /// macOS arm64: defer to Apple's published API. `sys_icache_invalidate`
    /// is in libSystem (always linked) and is the supported interface
    /// for JITs on Apple Silicon -- it does the dc cvau / ic ivau /
    /// dsb / isb dance with the right cache-line size for the host.
    #[cfg(all(target_os = "macos", target_arch = "aarch64"))]
    fn flush_icache(ptr: *const u8, len: usize) {
        unsafe extern "C" {
            fn sys_icache_invalidate(start: *mut c_void, len: usize);
        }
        unsafe { sys_icache_invalidate(ptr as *mut c_void, len) };
    }

    /// Linux aarch64: roll the dance by hand. ARM ARM allows D-cache
    /// and I-cache to have different line sizes; the smallest possible
    /// per spec is 16 bytes. Using 16 means more iterations than
    /// necessary on most cores (typical line is 64) but is always
    /// correct.
    #[cfg(all(target_os = "linux", target_arch = "aarch64"))]
    fn flush_icache(ptr: *const u8, len: usize) {
        let line: usize = 16;
        let start = ptr as usize;
        let end = start + len;

        // Clean D-cache to point of unification: writes the JIT'd
        // bytes from the D-cache out to memory.
        let mut p = start;
        while p < end {
            unsafe {
                core::arch::asm!(
                    "dc cvau, {x}",
                    x = in(reg) p,
                    options(nostack, preserves_flags)
                );
            }
            p += line;
        }
        unsafe {
            core::arch::asm!("dsb ish", options(nostack, preserves_flags));
        }

        // Invalidate I-cache to point of unification: the next
        // instruction fetch from the JIT'd region will reload from
        // memory.
        let mut p = start;
        while p < end {
            unsafe {
                core::arch::asm!(
                    "ic ivau, {x}",
                    x = in(reg) p,
                    options(nostack, preserves_flags)
                );
            }
            p += line;
        }
        unsafe {
            core::arch::asm!("dsb ish", options(nostack, preserves_flags));
            core::arch::asm!("isb", options(nostack, preserves_flags));
        }
    }
}
