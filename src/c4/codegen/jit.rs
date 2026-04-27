//! In-process JIT runtime.
//!
//! Lowers the program with the same encoder + lowering pass the AOT
//! native backend uses, then loads the result into an mmap'd
//! executable page and calls into it. No `_start` stub: Rust calls
//! `main` directly with argc/argv in System V ABI registers, which
//! is exactly what the AOT `_start` stub would have set up.
//!
//! Gated to Linux for now -- the mmap / mprotect / munmap shape is
//! straightforward there. macOS arm64 enforces W^X in hardware via
//! `MAP_JIT` + `pthread_jit_write_protect_np` toggling and lands in
//! a follow-on milestone.
//!
//! ## Milestones in this file
//!
//! * **J2** (current): mmap + mprotect + transmute. Supports
//!   programs with no relocations -- arithmetic, control flow,
//!   recursion, multi-arg user calls. Programs that need libc /
//!   data / function-pointer fixups are rejected at JIT time.
//! * **J3**: data + function-pointer relocations.
//! * **J4**: libc binding via dlsym at JIT time + a writable "fake
//!   GOT" region.

use alloc::string::{String, ToString};

use super::super::error::C4Error;
use super::super::program::Program;
use super::Target;

/// Compile, lower, and run `program` in-process. Returns the exit
/// code as it would appear from a child process. `args` becomes the
/// hosted program's argv.
pub fn jit_run(program: &Program, args: &[String]) -> Result<i32, C4Error> {
    #[cfg(all(target_os = "linux", feature = "std"))]
    {
        linux_impl::jit_run(program, args)
    }
    #[cfg(not(all(target_os = "linux", feature = "std")))]
    {
        let _ = (program, args);
        Err(C4Error::Compile(
            "JIT: currently supported only on Linux with the `std` feature \
             (macOS arm64 W^X handling lands later)"
                .to_string(),
        ))
    }
}

/// Pick the target appropriate for the current host. JIT only knows
/// how to lower for the host arch -- there's no cross-arch JIT.
#[allow(dead_code)]
fn host_target() -> Result<Target, C4Error> {
    if cfg!(target_arch = "aarch64") {
        Ok(Target::LinuxAarch64)
    } else if cfg!(target_arch = "x86_64") {
        Ok(Target::LinuxX64)
    } else {
        Err(C4Error::Compile(
            "JIT: host arch unsupported (need aarch64 or x86_64)".to_string(),
        ))
    }
}

#[cfg(all(target_os = "linux", feature = "std"))]
mod linux_impl {
    use super::super::super::error::C4Error;
    use super::super::super::program::Program;
    use super::super::Target;
    use super::super::{Build, aarch64, x86_64};
    use super::host_target;
    use alloc::format;
    use alloc::string::{String, ToString};
    use alloc::vec::Vec;
    use std::ffi::CString;
    use std::os::raw::{c_int, c_void};

    pub fn jit_run(program: &Program, args: &[String]) -> Result<i32, C4Error> {
        let target = host_target()?;
        let build = lower_for_jit(program, target)?;

        // J3 limit: GOT (libc) fixups are still rejected -- those
        // need dlsym + a writable "fake GOT" region (J4). Data and
        // function-pointer fixups patch against the runtime mmap
        // addresses below.
        if !build.got_fixups.is_empty() {
            return Err(C4Error::Compile(format!(
                "JIT (J3): program needs {} GOT fixups; libc binding lands in J4",
                build.got_fixups.len()
            )));
        }

        // Allocate a writable data region, copy `build.data` in. The
        // page is RW (no exec permission); programs that try to
        // execute through it would fault, which is what we want.
        let data_region = if !build.data.is_empty() {
            Some(DataRegion::new(&build.data)?)
        } else {
            None
        };
        let data_vmaddr = data_region.as_ref().map(|r| r.as_ptr() as u64).unwrap_or(0);

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
        let mut argv_ptrs: Vec<*const u8> = argv_cstrings
            .iter()
            .map(|cs| cs.as_ptr() as *const u8)
            .collect();
        argv_ptrs.push(std::ptr::null());

        let entry_ptr = unsafe { region.as_ptr().add(build.entry_offset) };
        // SAFETY: the JIT'd main was lowered with extern "C" / System V
        // ABI conventions and reachable via a normal `call`-equivalent
        // (transmuting + invoking is the same as the call instruction
        // a parent function would make). main reads argc/argv from
        // the System V argument registers and returns its exit code
        // in rax / x0.
        let main_fn: extern "C" fn(c_int, *const *const u8) -> c_int =
            unsafe { std::mem::transmute(entry_ptr) };
        let exit_code = main_fn(args.len() as c_int, argv_ptrs.as_ptr());
        Ok(exit_code as i32)
    }

    fn lower_for_jit(program: &Program, target: Target) -> Result<Build, C4Error> {
        match target {
            Target::LinuxAarch64 => aarch64::lower(program, target),
            Target::LinuxX64 => x86_64::lower(program, target),
            // host_target only returns Linux variants, so this arm
            // is unreachable in practice; spell it out anyway.
            _ => Err(C4Error::Compile(
                "JIT: target not Linux/aarch64 or Linux/x86_64".to_string(),
            )),
        }
    }

    // ----------------------------------------------------------------
    // Memory allocation. We use raw mmap / mprotect / munmap because
    // pulling in `libc` or `region` as Cargo deps would change the
    // crate's no-deps story for one feature; the syscall surface here
    // is small and stable on Linux.
    // ----------------------------------------------------------------

    const PROT_READ: c_int = 1;
    const PROT_WRITE: c_int = 2;
    const PROT_EXEC: c_int = 4;
    const MAP_PRIVATE: c_int = 0x02;
    const MAP_ANONYMOUS: c_int = 0x20;

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
                    "JIT: mmap failed: {}",
                    std::io::Error::last_os_error()
                )));
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
            unsafe extern "C" {
                fn mprotect(addr: *mut c_void, len: usize, prot: c_int) -> c_int;
            }
            let r = unsafe { mprotect(self.ptr as *mut c_void, self.len, PROT_READ | PROT_EXEC) };
            if r != 0 {
                return Err(C4Error::Compile(format!(
                    "JIT: mprotect failed: {}",
                    std::io::Error::last_os_error()
                )));
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

    /// Patch the lowered code's data + function-pointer fixups
    /// against the runtime mmap addresses. The patch math mirrors
    /// the ELF writer's `patch_addr_load` / `patch_adrp_add` /
    /// `patch_lea_rip32` -- the difference is that here `code_vmaddr`
    /// is the mmap'd page's runtime address, not a fixed ELF
    /// vmaddr_base. (`build.entry_offset` is unaffected: there's no
    /// `_start` stub prepended in JIT, so byte offsets in `build.text`
    /// match runtime offsets exactly.)
    fn apply_jit_fixups(
        target: Target,
        code: &mut [u8],
        code_vmaddr: u64,
        data_vmaddr: u64,
        build: &Build,
    ) -> Result<(), C4Error> {
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
            Target::LinuxAarch64 => {
                patch_adrp_add(code, code_vmaddr, instr_offset, target_vmaddr, label)
            }
            Target::LinuxX64 => {
                patch_lea_rip32(code, code_vmaddr, instr_offset, target_vmaddr, label)
            }
            _ => Err(C4Error::Compile(format!(
                "JIT: {label} unsupported for target {target:?}"
            ))),
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

    #[cfg(target_arch = "aarch64")]
    fn flush_icache(ptr: *const u8, len: usize) {
        // ARM ARM allows D-cache and I-cache to have different line
        // sizes; the smallest possible per spec is 16 bytes. Using
        // 16 means more iterations than necessary on most cores
        // (typical line is 64) but is always correct.
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
