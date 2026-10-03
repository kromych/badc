//! GNU ld's `-z` keywords, each read as the request it makes of a link,
//! so every front end refuses or honors the same set.

use alloc::format;
use alloc::string::String;

/// A `-z` keyword; a pair's `bool` is whether the positive spelling
/// (`execstack`, `relro`, `now`, `text`, `defs`, ...) was given.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum ZKeyword {
    ExecStack(bool),
    Relro(bool),
    Now(bool),
    Text(bool),
    Defs(bool),
    Muldefs,
    PackRelativeRelocs(bool),
    SeparateCode(bool),
    MaxPageSize(u64),
    CommonPageSize(u64),
    /// A loader policy recorded in `DT_FLAGS_1`.
    LoaderFlag(&'static str),
}

pub(crate) const LOADER_FLAGS: [&str; 9] = [
    "nodefaultlib",
    "nodelete",
    "nodlopen",
    "nodump",
    "origin",
    "global",
    "initfirst",
    "interpose",
    "loadfltr",
];

/// What a link does with a `-z` keyword.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum ZSupport {
    /// The link carries the request out.
    Applies,
    /// The image is what the keyword asks for whatever is given.
    Holds,
    /// The link cannot honor the request, for the reason given.
    Refused(&'static str),
}

impl ZKeyword {
    /// Whether `other` sets what `self` sets, so the later one stands.
    fn same_kind(self, other: ZKeyword) -> bool {
        match (self, other) {
            (ZKeyword::LoaderFlag(a), ZKeyword::LoaderFlag(b)) => a == b,
            _ => core::mem::discriminant(&self) == core::mem::discriminant(&other),
        }
    }

    /// The answer of the script engine: the `-T` link and the `--ld`
    /// persona's final link.
    pub fn in_script_link(self) -> ZSupport {
        match self {
            ZKeyword::Relro(false)
            | ZKeyword::Text(false)
            | ZKeyword::Defs(true)
            | ZKeyword::SeparateCode(false) => ZSupport::Holds,
            ZKeyword::Relro(true) => ZSupport::Refused("the link writes no PT_GNU_RELRO"),
            ZKeyword::Now(false) => {
                ZSupport::Refused("every import binds when the image is loaded")
            }
            ZKeyword::Defs(false) => ZSupport::Refused("an unresolved reference is an error"),
            ZKeyword::SeparateCode(true) => {
                ZSupport::Refused("code shares its load with the read-only data on its pages")
            }
            _ => ZSupport::Applies,
        }
    }

    /// The answer of the link without -T, which writes the image itself;
    /// `shared` is a `--shared` link.
    pub fn in_hosted_link(self, shared: bool) -> ZSupport {
        match self {
            ZKeyword::ExecStack(_) | ZKeyword::PackRelativeRelocs(_) => ZSupport::Applies,
            ZKeyword::Defs(true) if shared => ZSupport::Applies,
            ZKeyword::Defs(false) if !shared => {
                ZSupport::Refused("an executable's unresolved reference is an error")
            }
            ZKeyword::Relro(true) | ZKeyword::Now(true) | ZKeyword::Text(_) | ZKeyword::Defs(_) => {
                ZSupport::Holds
            }
            ZKeyword::Relro(false) => ZSupport::Refused(
                "the image's relocated read-only data is read-only once relocated",
            ),
            ZKeyword::Now(false) => {
                ZSupport::Refused("every import binds when the image is loaded")
            }
            ZKeyword::Muldefs => ZSupport::Refused("a symbol defined twice is an error"),
            ZKeyword::MaxPageSize(n) if n <= 0x40_0000 => ZSupport::Applies,
            ZKeyword::MaxPageSize(_) => ZSupport::Refused(
                "the image's first load sits at 0x400000, which a larger page does not divide",
            ),
            ZKeyword::SeparateCode(_) | ZKeyword::CommonPageSize(_) | ZKeyword::LoaderFlag(_) => {
                ZSupport::Refused("it is not implemented")
            }
        }
    }

    /// The keyword as the command line spells it, less a size's value.
    pub fn name(self) -> &'static str {
        let pick = |on: bool, yes: &'static str, no: &'static str| if on { yes } else { no };
        match self {
            ZKeyword::ExecStack(on) => pick(on, "execstack", "noexecstack"),
            ZKeyword::Relro(on) => pick(on, "relro", "norelro"),
            ZKeyword::Now(on) => pick(on, "now", "lazy"),
            ZKeyword::Text(on) => pick(on, "text", "notext"),
            ZKeyword::Defs(on) => pick(on, "defs", "undefs"),
            ZKeyword::Muldefs => "muldefs",
            ZKeyword::PackRelativeRelocs(on) => {
                pick(on, "pack-relative-relocs", "nopack-relative-relocs")
            }
            ZKeyword::SeparateCode(on) => pick(on, "separate-code", "noseparate-code"),
            ZKeyword::MaxPageSize(_) => "max-page-size",
            ZKeyword::CommonPageSize(_) => "common-page-size",
            ZKeyword::LoaderFlag(name) => name,
        }
    }
}

/// The `-z` keywords a link takes: the last one of each kind given, as
/// GNU ld applies them.
#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub struct ZKeywords(alloc::vec::Vec<ZKeyword>);

impl ZKeywords {
    /// Take `kw`, which replaces an earlier keyword of its kind.
    pub fn push(&mut self, kw: ZKeyword) {
        self.0.retain(|k| !k.same_kind(kw));
        self.0.push(kw);
    }

    pub fn iter(&self) -> impl Iterator<Item = ZKeyword> + '_ {
        self.0.iter().copied()
    }

    /// The first keyword `answer` refuses, with the reason.
    pub fn refusal(
        &self,
        answer: impl Fn(ZKeyword) -> ZSupport,
    ) -> Option<(ZKeyword, &'static str)> {
        self.iter().find_map(|kw| match answer(kw) {
            ZSupport::Refused(why) => Some((kw, why)),
            _ => None,
        })
    }

    /// The value the kind `pick` reads was given, if one was.
    pub fn get<T>(&self, pick: impl Fn(ZKeyword) -> Option<T>) -> Option<T> {
        self.iter().find_map(pick)
    }

    pub fn exec_stack(&self) -> Option<bool> {
        self.get(|kw| match kw {
            ZKeyword::ExecStack(on) => Some(on),
            _ => None,
        })
    }

    pub fn defs(&self) -> Option<bool> {
        self.get(|kw| match kw {
            ZKeyword::Defs(on) => Some(on),
            _ => None,
        })
    }

    pub fn max_page_size(&self) -> Option<u64> {
        self.get(|kw| match kw {
            ZKeyword::MaxPageSize(n) => Some(n),
            _ => None,
        })
    }

    pub fn pack_relative_relocs(&self) -> bool {
        self.iter()
            .any(|kw| kw == ZKeyword::PackRelativeRelocs(true))
    }

    pub fn muldefs(&self) -> bool {
        self.iter().any(|kw| kw == ZKeyword::Muldefs)
    }
}

/// A page size as `-z max-page-size=` / `common-page-size=` take one:
/// decimal or `0x` hexadecimal, a power of two.
pub(crate) fn parse_page_size(body: &str) -> Option<u64> {
    let n = match body.strip_prefix("0x").or_else(|| body.strip_prefix("0X")) {
        Some(hex) => u64::from_str_radix(hex, 16).ok()?,
        None => body.parse::<u64>().ok()?,
    };
    n.is_power_of_two().then_some(n)
}

/// Read a `-z` keyword; the error names what is wrong with it.
pub fn parse_z_keyword(kw: &str) -> Result<ZKeyword, String> {
    let size = |prefix: &str, body: &str| {
        parse_page_size(body).ok_or_else(|| format!("-z {prefix} requires a power of two"))
    };
    Ok(match kw {
        "execstack" | "noexecstack" => ZKeyword::ExecStack(kw == "execstack"),
        "relro" | "norelro" => ZKeyword::Relro(kw == "relro"),
        "now" | "lazy" => ZKeyword::Now(kw == "now"),
        "text" | "notext" => ZKeyword::Text(kw == "text"),
        "defs" | "undefs" => ZKeyword::Defs(kw == "defs"),
        "muldefs" => ZKeyword::Muldefs,
        "pack-relative-relocs" | "nopack-relative-relocs" => {
            ZKeyword::PackRelativeRelocs(kw == "pack-relative-relocs")
        }
        "separate-code" | "noseparate-code" => ZKeyword::SeparateCode(kw == "separate-code"),
        _ if kw.starts_with("max-page-size=") => {
            ZKeyword::MaxPageSize(size("max-page-size", &kw["max-page-size=".len()..])?)
        }
        _ if kw.starts_with("common-page-size=") => {
            ZKeyword::CommonPageSize(size("common-page-size", &kw["common-page-size=".len()..])?)
        }
        _ => match LOADER_FLAGS.iter().find(|&&f| f == kw) {
            Some(&f) => ZKeyword::LoaderFlag(f),
            None => return Err(format!("unsupported -z keyword `{kw}`")),
        },
    })
}

/// Whether an image's stack is executable, and the warning bfd gives with
/// it. `requested` is the last of `-z execstack` / `noexecstack`; without
/// one, an input whose `.note.GNU-stack` is executable (`asked_by`, the
/// first) makes the stack executable. `warn` is the last of
/// `--warn-execstack` / `--no-warn-execstack`: the default reports an
/// input's request only.
pub fn resolve_exec_stack(
    requested: Option<bool>,
    asked_by: Option<&str>,
    warn: Option<bool>,
) -> (bool, Option<String>) {
    match (requested, asked_by) {
        (Some(on), _) => (
            on,
            (on && warn == Some(true)).then(|| {
                String::from(
                    "enabling an executable stack because of -z execstack command line option",
                )
            }),
        ),
        (None, Some(input)) => (
            true,
            (warn != Some(false)).then(|| {
                format!(
                    "{input}: requires executable stack (because the .note.GNU-stack section \
                     is executable)"
                )
            }),
        ),
        (None, None) => (false, None),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn every_keyword_reads_back_as_its_spelling() {
        for kw in [
            "execstack",
            "noexecstack",
            "relro",
            "norelro",
            "now",
            "lazy",
            "text",
            "notext",
            "defs",
            "undefs",
            "muldefs",
            "pack-relative-relocs",
            "nopack-relative-relocs",
            "separate-code",
            "noseparate-code",
            "nodelete",
        ] {
            assert_eq!(parse_z_keyword(kw).map(ZKeyword::name), Ok(kw));
        }
        assert_eq!(
            parse_z_keyword("max-page-size=0x10000"),
            Ok(ZKeyword::MaxPageSize(0x10000))
        );
        assert_eq!(
            parse_z_keyword("common-page-size=4096"),
            Ok(ZKeyword::CommonPageSize(4096))
        );
        assert_eq!(
            parse_z_keyword("max-page-size=3"),
            Err(String::from("-z max-page-size requires a power of two"))
        );
        assert_eq!(
            parse_z_keyword("nodefault"),
            Err(String::from("unsupported -z keyword `nodefault`"))
        );
    }

    /// bfd's rule: `-z execstack` / `noexecstack` decide; without one an
    /// input's executable note does, with a warning `--no-warn-execstack`
    /// withholds and `--warn-execstack` extends to `-z execstack`.
    #[test]
    fn the_stack_follows_the_keyword_then_the_inputs() {
        let x = Some("x.o");
        let by_input = "x.o: requires executable stack (because the .note.GNU-stack section \
                        is executable)";
        let by_option = "enabling an executable stack because of -z execstack command line option";
        for (requested, asked_by, warn, stack, warning) in [
            (None, None, None, false, None),
            (None, x, None, true, Some(by_input)),
            (None, x, Some(true), true, Some(by_input)),
            (None, x, Some(false), true, None),
            (Some(false), x, None, false, None),
            (Some(false), x, Some(true), false, None),
            (Some(true), None, None, true, None),
            (Some(true), x, None, true, None),
            (Some(true), None, Some(true), true, Some(by_option)),
            (Some(true), x, Some(false), true, None),
        ] {
            assert_eq!(
                resolve_exec_stack(requested, asked_by, warn),
                (stack, warning.map(String::from)),
                "{requested:?} {asked_by:?} {warn:?}"
            );
        }
    }

    /// Each link's answer to every keyword: the engine behind -T and the
    /// `--ld` persona, and the link without -T for an executable and for
    /// a shared library. `A` applies, `H` holds, `R` is refused.
    #[test]
    fn the_table_answers_every_keyword_for_each_link() {
        let code = |s: ZSupport| match s {
            ZSupport::Applies => 'A',
            ZSupport::Holds => 'H',
            ZSupport::Refused(_) => 'R',
        };
        for (spelling, script, exe, shared) in [
            ("execstack", 'A', 'A', 'A'),
            ("noexecstack", 'A', 'A', 'A'),
            ("relro", 'R', 'H', 'H'),
            ("norelro", 'H', 'R', 'R'),
            ("now", 'A', 'H', 'H'),
            ("lazy", 'R', 'R', 'R'),
            ("text", 'A', 'H', 'H'),
            ("notext", 'H', 'H', 'H'),
            ("defs", 'H', 'H', 'A'),
            ("undefs", 'R', 'R', 'H'),
            ("muldefs", 'A', 'R', 'R'),
            ("pack-relative-relocs", 'A', 'A', 'A'),
            ("nopack-relative-relocs", 'A', 'A', 'A'),
            ("separate-code", 'R', 'R', 'R'),
            ("noseparate-code", 'H', 'R', 'R'),
            ("max-page-size=0x10000", 'A', 'A', 'A'),
            ("max-page-size=0x800000", 'A', 'R', 'R'),
            ("common-page-size=4096", 'A', 'R', 'R'),
        ]
        .into_iter()
        .chain(LOADER_FLAGS.iter().map(|&f| (f, 'A', 'R', 'R')))
        {
            let kw = parse_z_keyword(spelling).expect("GNU ld has it");
            let got = (
                code(kw.in_script_link()),
                code(kw.in_hosted_link(false)),
                code(kw.in_hosted_link(true)),
            );
            assert_eq!(got, (script, exe, shared), "-z {spelling}");
        }
    }

    /// The last keyword of a kind stands, as GNU ld applies them; each
    /// loader flag is a kind of its own.
    #[test]
    fn the_last_keyword_of_a_kind_stands() {
        let mut z = ZKeywords::default();
        for kw in [
            "lazy",
            "now",
            "max-page-size=4096",
            "max-page-size=0x10000",
            "nodelete",
            "origin",
            "execstack",
            "noexecstack",
        ] {
            z.push(parse_z_keyword(kw).unwrap());
        }
        assert_eq!(
            z.iter().collect::<alloc::vec::Vec<_>>(),
            [
                ZKeyword::Now(true),
                ZKeyword::MaxPageSize(0x10000),
                ZKeyword::LoaderFlag("nodelete"),
                ZKeyword::LoaderFlag("origin"),
                ZKeyword::ExecStack(false),
            ]
        );
        assert_eq!(
            z.refusal(ZKeyword::in_script_link),
            None,
            "now replaced lazy"
        );
        z.push(ZKeyword::Now(false));
        assert_eq!(
            z.refusal(ZKeyword::in_script_link),
            Some((
                ZKeyword::Now(false),
                "every import binds when the image is loaded"
            ))
        );
    }
}
