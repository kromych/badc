//! The warning options other compilers define. A diagnostic pragma naming
//! one that badc does not implement asks for nothing badc reports; a name
//! no compiler defines is a misspelling.

use super::foreign_names::NAMES;

/// gcc defines the option.
pub(super) const GCC: u8 = 1;
/// clang defines the option.
pub(super) const CLANG: u8 = 2;

/// Whether gcc or clang defines the warning option `-W<name>`, as a
/// diagnostic pragma matches it: the whole name, or a name ending in `=`
/// followed by any value.
pub fn defined_elsewhere(name: &str) -> bool {
    let find = |key: &str| NAMES.binary_search_by(|(n, _)| n.cmp(&key)).is_ok();
    find(name) || name.find('=').is_some_and(|eq| find(&name[..=eq]))
}
