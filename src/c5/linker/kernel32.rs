//! The functions kernel32.dll exports, which a Windows image that loads
//! the user-mode C runtime links by default: link.exe takes `kernel32.lib`
//! from the `/DEFAULTLIB` directive of the C runtime library cl names
//! (`libcmt.lib`, `msvcrt.lib`), and the MinGW driver passes `-lkernel32`.
//!
//! The names are read with `dumpbin /exports` from the System32 image of
//! Windows 11 build 26300 on x64 and on arm64, one per line, sorted;
//! `scripts/gen_kernel32_exports.py` regenerates the two lists from those
//! dumps. The arm64 image exports a subset of the x64 one's names.

/// The module the names are imported from, as the bundled headers spell it.
pub(crate) const DLL: &str = "kernel32.dll";

/// The names both machines' kernel32.dll export.
const BOTH: &str = include_str!("kernel32.exports");

/// The names only x64's kernel32.dll exports.
const X64: &str = include_str!("kernel32_x64.exports");

/// Whether kernel32.dll exports `name` on x64 (`x64`) or arm64.
pub(crate) fn exports(x64: bool, name: &str) -> bool {
    let listed = |list: &str| list.lines().any(|n| n == name);
    listed(BOTH) || x64 && listed(X64)
}

#[cfg(test)]
mod tests {
    use super::{BOTH, X64, exports};

    /// The lists are sorted and disjoint; each machine's names include the
    /// Win32 functions and exclude the C runtime's and user32's.
    #[test]
    fn each_machine_exports_its_listed_names() {
        for list in [BOTH, X64] {
            let names: alloc::vec::Vec<&str> = list.lines().collect();
            assert!(names.windows(2).all(|w| w[0] < w[1]), "{list}");
        }
        assert!(X64.lines().all(|n| !BOTH.lines().any(|b| b == n)));
        assert_eq!((BOTH.lines().count(), X64.lines().count()), (1692, 6));
        for x64 in [true, false] {
            for name in ["GetLastError", "GetModuleHandleA", "lstrlenA", "HeapAlloc"] {
                assert!(exports(x64, name), "{name}");
            }
            for name in ["strlen", "MessageBoxA", "lstrlen "] {
                assert!(!exports(x64, name), "{name}");
            }
        }
        assert!(exports(true, "__chkstk") && !exports(false, "__chkstk"));
    }
}
