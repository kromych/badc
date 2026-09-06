//! The C library export set the bundled headers describe for a target.
//!
//! A hosted link resolves undefined references that name C library
//! entry points against this set. Such a reference carries no
//! `#pragma binding`: C99 7.1.4p2 lets a program declare a library
//! function itself instead of including its header, and an object from
//! another toolchain states no routing at all.
//!
//! Which names the library has is a property of the target, and the
//! bundled headers' binding set is badc's description of it -- already
//! what every declared call binds through. Reading the link host's own
//! shared object instead would make the image depend on the machine
//! that ran the compiler.
//!
//! Names are admitted on demand: `headers::headers_declaring` names
//! the headers that declare a symbol, each is preprocessed for the
//! target once, and their bindings decide the answer.
//!
//! A binding also states the symbol the library ships the name under,
//! not always the name itself -- `_puts` on Mach-O, `_write` on
//! msvcrt. 7.1.4p2 makes a self-declared call the call the header
//! would have made, so the import carries the binding's symbol.

#![cfg(feature = "std")]

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::string::{String, ToString};

use super::object::{NativeMachine, SharedLibrary};
use crate::c5::codegen::{BinaryFormat, Target};
use crate::c5::headers;
use crate::c5::preprocessor::Preprocessor;

/// The `#pragma dylib` name the bundled headers give the target's C
/// library. On PE that is `msvcrt`: every bundled header that declares
/// a C library entry point for Windows binds it there, and the
/// embedded startup runtime imports `exit`, `atexit` and
/// `__getmainargs` from the same `msvcrt.dll`. The `ucrtbase` handle a
/// few headers also name holds what msvcrt.dll does not export, the
/// place `libm` takes on the ELF side, and is no more implicit here
/// than `libm` is there.
fn c_library_dylib(target: Target) -> &'static str {
    match target.binary_format() {
        BinaryFormat::Elf | BinaryFormat::MachO => "libc",
        BinaryFormat::Pe => "msvcrt",
    }
}

fn target_machine(target: Target) -> NativeMachine {
    if target.is_x86_64() {
        NativeMachine::X86_64
    } else {
        NativeMachine::Aarch64
    }
}

/// The target's C library, materialized from the bundled headers as
/// names are queried.
pub struct TargetCLibrary {
    target: Target,
    dylib: &'static str,
    lib: SharedLibrary,
    /// Headers already preprocessed for this target.
    scanned: BTreeSet<&'static str>,
    /// Names already queried, so a repeated miss costs one lookup.
    queried: BTreeSet<String>,
}

impl TargetCLibrary {
    pub fn new(target: Target) -> Self {
        Self {
            target,
            dylib: c_library_dylib(target),
            lib: SharedLibrary {
                soname: String::new(),
                machine: target_machine(target),
                exports: BTreeSet::new(),
                data_exports: BTreeSet::new(),
                export_symbols: BTreeMap::new(),
                export_versions: BTreeMap::new(),
                from_image: false,
            },
            scanned: BTreeSet::new(),
            queried: BTreeSet::new(),
        }
    }

    /// Whether the target's C library exports `name`, admitting it to
    /// the export set when it does.
    pub fn admit(&mut self, name: &str) -> bool {
        if self.lib.exports.contains(name) {
            return true;
        }
        if !self.queried.insert(name.to_string()) {
            return false;
        }
        // A name can be bound to a different library in each header
        // declaring it, so every candidate is tried until one binds it
        // to the target's C library.
        for &header in headers::headers_declaring(name) {
            if self.scanned.insert(header) {
                self.scan(header);
            }
            if self.lib.exports.contains(name) {
                return true;
            }
        }
        false
    }

    /// The export set admitted so far, empty when no queried name
    /// belongs to the target's C library.
    pub fn library(&self) -> &SharedLibrary {
        &self.lib
    }

    /// Preprocess one bundled header for the target and fold its C
    /// library bindings into the export set. A header that does not
    /// stand alone on this target (a Windows header on an ELF target,
    /// say) contributes nothing, the same as one with no bindings.
    fn scan(&mut self, header: &str) {
        // `_GNU_SOURCE` widens a glibc header to the library's full
        // surface. Where it picks between two entry points the two
        // share one portable name, which is what this set is keyed by.
        let source = alloc::format!("#define _GNU_SOURCE 1\n#include <{header}>\n");
        let mut pp = Preprocessor::new(self.target.id_str(), self.target, "0");
        if pp.process(&source).is_err() {
            return;
        }
        for spec in &pp.dylibs {
            if spec.name != self.dylib {
                continue;
            }
            if self.lib.soname.is_empty() {
                self.lib.soname = spec.path.clone();
            }
            for b in &spec.bindings {
                // Keyed by the portable name: the spelling a reference
                // that never saw the header uses, and the one the
                // shared-object and `.tbd` readers produce. The
                // binding's symbol is what the loader resolves, so it
                // is recorded where the two differ; the first header
                // binding a name states it (`strerror_r` has two).
                self.lib.exports.insert(b.local_name.clone());
                if b.real_symbol != b.local_name {
                    self.lib
                        .export_symbols
                        .entry(b.local_name.clone())
                        .or_insert_with(|| b.real_symbol.clone());
                }
                if b.is_data {
                    self.lib.data_exports.insert(b.local_name.clone());
                }
            }
        }
    }
}

/// Every `(soname, symbol)` the bundled headers bind for `target`, in
/// sorted order. The link's description of the target's libraries: the
/// symbol-version manifest under `libc/versions/` is keyed by it, and
/// `--dump-bindings` prints it.
pub fn library_bindings(target: Target) -> alloc::vec::Vec<(String, String)> {
    let mut out = alloc::vec::Vec::new();
    for (name, _) in headers::embedded_headers() {
        let source = alloc::format!("#define _GNU_SOURCE 1\n#include <{name}>\n");
        let mut pp = Preprocessor::new(target.id_str(), target, "0");
        if pp.process(&source).is_err() {
            continue;
        }
        for spec in &pp.dylibs {
            for b in &spec.bindings {
                out.push((spec.path.clone(), b.real_symbol.clone()));
            }
        }
    }
    out.sort();
    out.dedup();
    out
}

#[cfg(test)]
mod tests {
    use super::*;
    use alloc::vec::Vec;

    /// The whole export set, from a walk over every bundled header.
    fn full_set(target: Target) -> TargetCLibrary {
        let mut lib = TargetCLibrary::new(target);
        for (name, _) in headers::embedded_headers() {
            if lib.scanned.insert(name) {
                lib.scan(name);
            }
        }
        lib
    }

    /// On-demand admission reaches every name the full walk finds: an
    /// index entry pointing at a header that does not bind the name
    /// would leave that entry point unresolvable at link time.
    #[test]
    fn on_demand_admission_matches_the_full_header_walk() {
        for target in [
            Target::LinuxX64,
            Target::LinuxAarch64,
            Target::MacOSAarch64,
            Target::WindowsX64,
            Target::WindowsAarch64,
        ] {
            let full = full_set(target);
            let mut lazy = TargetCLibrary::new(target);
            let missed: Vec<&String> = full.lib.exports.iter().filter(|n| !lazy.admit(n)).collect();
            assert!(
                missed.is_empty(),
                "{}: the header index does not reach {missed:?}",
                target.id_str()
            );
            assert_eq!(
                full.lib.soname,
                lazy.lib.soname,
                "{}: same C library",
                target.id_str()
            );
        }
    }

    /// Each target's C library has its own name and its own surface.
    #[test]
    fn each_target_names_its_own_c_library() {
        let linux = full_set(Target::LinuxX64);
        let macos = full_set(Target::MacOSAarch64);
        assert_eq!(linux.lib.soname, "libc.so.6");
        assert_eq!(macos.lib.soname, "/usr/lib/libSystem.B.dylib");
        // GNU entry points libSystem lacks; the bundled sources supply
        // them where the C library does not.
        for name in ["strchrnul", "memrchr", "explicit_bzero"] {
            assert!(linux.lib.exports.contains(name), "linux exports {name}");
            assert!(!macos.lib.exports.contains(name), "macos lacks {name}");
        }
        // The Linux C library keeps `atexit` in `libc_nonshared.a`, so
        // no shared object exports it.
        assert!(!linux.lib.exports.contains("atexit"));
        assert!(macos.lib.exports.contains("atexit"));
    }

    /// A declaration without a binding is unresolvable at link time, so
    /// the socket family's entry points have to be bound one for one.
    #[test]
    fn the_linux_socket_entry_points_are_bound() {
        let mut linux = TargetCLibrary::new(Target::LinuxX64);
        for name in [
            "socket",
            "bind",
            "connect",
            "accept",
            "accept4",
            "send",
            "recv",
            "sendto",
            "recvfrom",
            "sendmsg",
            "recvmsg",
            "sendmmsg",
            "recvmmsg",
            "socketpair",
            "shutdown",
        ] {
            assert!(linux.admit(name), "linux libc exports {name}");
        }
    }

    /// The Windows C library is msvcrt, which the bundled headers bind
    /// every C library entry point through.
    #[test]
    fn a_pe_target_names_msvcrt() {
        for target in [Target::WindowsX64, Target::WindowsAarch64] {
            let mut win = TargetCLibrary::new(target);
            assert!(
                win.admit("puts"),
                "{}: msvcrt exports puts",
                target.id_str()
            );
            assert_eq!(win.lib.soname, "msvcrt.dll");
            // Declared for Windows by the bundled headers, bound to no
            // Windows library: the bundled sources supply it, so
            // admitting it would import a name msvcrt does not export.
            assert!(!win.admit("memmem"));
        }
    }

    /// A name the library ships under another symbol carries that
    /// symbol, so the import resolves: an msvcrt renaming, and the
    /// Mach-O leading underscore.
    #[test]
    fn a_renamed_entry_point_carries_the_library_symbol() {
        let mut win = TargetCLibrary::new(Target::WindowsX64);
        for (name, symbol) in [("write", "_write"), ("strdup", "_strdup")] {
            assert!(win.admit(name));
            assert_eq!(
                win.lib.export_symbols.get(name).map(String::as_str),
                Some(symbol)
            );
        }
        // A name msvcrt exports verbatim states no other symbol.
        assert!(win.admit("puts"));
        assert!(!win.lib.export_symbols.contains_key("puts"));
        let mut macos = TargetCLibrary::new(Target::MacOSAarch64);
        assert!(macos.admit("puts"));
        assert_eq!(
            macos.lib.export_symbols.get("puts").map(String::as_str),
            Some("_puts")
        );
    }
}
