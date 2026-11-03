//! The C runtime a native-subsystem PE image can import. Such an image
//! cannot load msvcrt.dll or ucrtbase.dll: a kernel-mode driver takes the
//! C runtime from ntoskrnl.exe and an NT-native user-mode program from
//! ntdll.dll, each of which exports a part of it.
//!
//! The lists are the names each module exports that msvcrt.dll or
//! ucrtbase.dll also export, read with `dumpbin /exports` from the
//! System32 images of Windows 11 build 26300 on x64 and on arm64;
//! `scripts/gen_nt_crt_exports.py` regenerates them from those dumps. The
//! arm64 modules export a subset of the x64 ones' names.

/// The module a native-subsystem image takes the C runtime from: ntoskrnl.exe
/// for a driver, ntdll.dll for a native application.
pub(crate) fn module(driver: bool) -> &'static str {
    if driver { "ntoskrnl.exe" } else { "ntdll.dll" }
}

/// Whether [`module`]`(driver)` exports the C runtime function `name` on x64
/// (`x64`) or arm64.
pub(crate) fn exports(driver: bool, x64: bool, name: &str) -> bool {
    let (both, x64_only) = if driver {
        (NTOSKRNL, NTOSKRNL_X64)
    } else {
        (NTDLL, NTDLL_X64)
    };
    both.binary_search(&name).is_ok() || x64 && x64_only.binary_search(&name).is_ok()
}

#[rustfmt::skip]
const NTDLL: &[&str] = &[
    "__C_specific_handler", "__isascii", "__iscsym", "__iscsymf", "__toascii", "_atoi64",
    "_errno", "_i64toa", "_i64toa_s", "_i64tow", "_i64tow_s", "_itoa", "_itoa_s", "_itow",
    "_itow_s", "_lfind", "_local_unwind", "_ltoa", "_ltoa_s", "_ltow", "_ltow_s", "_makepath_s",
    "_memccpy", "_memicmp", "_setjmpex", "_snprintf", "_snprintf_s", "_snscanf_s", "_snwprintf",
    "_snwprintf_s", "_snwscanf_s", "_splitpath", "_splitpath_s", "_strcmpi", "_stricmp",
    "_strlwr", "_strlwr_s", "_strnicmp", "_strnset_s", "_strset_s", "_strupr", "_strupr_s",
    "_swprintf", "_ui64toa", "_ui64toa_s", "_ui64tow", "_ui64tow_s", "_ultoa", "_ultoa_s",
    "_ultow", "_ultow_s", "_vscprintf", "_vscwprintf", "_vsnprintf", "_vsnprintf_s",
    "_vsnwprintf", "_vsnwprintf_s", "_vswprintf", "_wcsicmp", "_wcslwr", "_wcslwr_s",
    "_wcsnicmp", "_wcsnset_s", "_wcsset_s", "_wcstoi64", "_wcstoui64", "_wcsupr", "_wcsupr_s",
    "_wmakepath_s", "_wsplitpath_s", "_wtoi", "_wtoi64", "_wtol", "abs", "atan", "atan2",
    "atoi", "atol", "bsearch", "bsearch_s", "ceil", "cos", "fabs", "floor", "isalnum",
    "isalpha", "iscntrl", "isdigit", "isgraph", "islower", "isprint", "ispunct", "isspace",
    "isupper", "iswalnum", "iswalpha", "iswascii", "iswctype", "iswdigit", "iswgraph",
    "iswlower", "iswprint", "iswspace", "iswxdigit", "isxdigit", "labs", "log", "longjmp",
    "mbstowcs", "memchr", "memcmp", "memcpy", "memcpy_s", "memmove", "memmove_s", "memset",
    "pow", "qsort", "qsort_s", "sin", "sprintf", "sprintf_s", "sqrt", "sscanf", "sscanf_s",
    "strcat", "strcat_s", "strchr", "strcmp", "strcpy", "strcpy_s", "strcspn", "strlen",
    "strncat", "strncat_s", "strncmp", "strncpy", "strncpy_s", "strnlen", "strpbrk", "strrchr",
    "strspn", "strstr", "strtok_s", "strtol", "strtoul", "swprintf", "swprintf_s", "swscanf_s",
    "tan", "tolower", "toupper", "towlower", "towupper", "vsprintf", "vsprintf_s",
    "vswprintf_s", "wcscat", "wcscat_s", "wcschr", "wcscmp", "wcscpy", "wcscpy_s", "wcscspn",
    "wcslen", "wcsncat", "wcsncat_s", "wcsncmp", "wcsncpy", "wcsncpy_s", "wcsnlen", "wcspbrk",
    "wcsrchr", "wcsspn", "wcsstr", "wcstok_s", "wcstol", "wcstombs", "wcstoul",
];

const NTDLL_X64: &[&str] = &["_setjmp"];

#[rustfmt::skip]
const NTOSKRNL: &[&str] = &[
    "__C_specific_handler", "_atoi64", "_finite", "_i64toa_s", "_i64tow_s", "_itoa", "_itoa_s",
    "_itow", "_itow_s", "_local_unwind", "_ltoa_s", "_ltow_s", "_makepath_s", "_purecall",
    "_setjmpex", "_snprintf", "_snprintf_s", "_snscanf_s", "_snwprintf", "_snwprintf_s",
    "_snwscanf_s", "_splitpath_s", "_stricmp", "_strlwr", "_strnicmp", "_strnset", "_strnset_s",
    "_strrev", "_strset", "_strset_s", "_strtoui64", "_strupr", "_swprintf", "_ui64toa_s",
    "_ui64tow_s", "_ultoa_s", "_ultow_s", "_vsnprintf", "_vsnprintf_s", "_vsnwprintf",
    "_vsnwprintf_s", "_vswprintf", "_wcsicmp", "_wcslwr", "_wcslwr_s", "_wcsnicmp", "_wcsnset",
    "_wcsnset_s", "_wcsrev", "_wcsset_s", "_wcsupr", "_wmakepath_s", "_wsplitpath_s", "_wtoi",
    "_wtol", "atoi", "atol", "bsearch", "bsearch_s", "isdigit", "islower", "isprint", "isspace",
    "isupper", "iswalnum", "iswdigit", "iswspace", "isxdigit", "longjmp", "mbstowcs", "mbtowc",
    "memchr", "memcmp", "memcpy", "memcpy_s", "memmove", "memmove_s", "memset", "qsort",
    "qsort_s", "rand", "sprintf", "sprintf_s", "srand", "sscanf_s", "strcat", "strcat_s",
    "strchr", "strcmp", "strcpy", "strcpy_s", "strlen", "strncat", "strncat_s", "strncmp",
    "strncpy", "strncpy_s", "strnlen", "strrchr", "strspn", "strstr", "strtok_s", "swprintf",
    "swprintf_s", "swscanf_s", "tolower", "toupper", "towlower", "towupper", "vsprintf",
    "vsprintf_s", "vswprintf_s", "wcscat", "wcscat_s", "wcschr", "wcscmp", "wcscpy", "wcscpy_s",
    "wcscspn", "wcslen", "wcsncat", "wcsncat_s", "wcsncmp", "wcsncpy", "wcsncpy_s", "wcsnlen",
    "wcsrchr", "wcsspn", "wcsstr", "wcstombs", "wcstoul", "wctomb",
];

const NTOSKRNL_X64: &[&str] = &["_setjmp", "sqrt", "sqrtf"];

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn the_lists_are_sorted_for_the_binary_search() {
        for list in [NTDLL, NTDLL_X64, NTOSKRNL, NTOSKRNL_X64] {
            assert!(list.windows(2).all(|w| w[0] < w[1]), "{list:?}");
        }
    }

    #[test]
    fn both_modules_export_the_language_handler_on_both_targets() {
        for (driver, x64) in [(true, true), (true, false), (false, true), (false, false)] {
            assert!(exports(driver, x64, "__C_specific_handler"));
            assert!(!exports(driver, x64, "malloc"));
        }
        assert!(exports(true, true, "sqrt") && !exports(true, false, "sqrt"));
        assert!(exports(false, false, "strtol") && !exports(true, true, "strtol"));
    }
}
