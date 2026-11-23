//! The x87 instruction set in AT&T syntax: each mnemonic's memory forms by
//! operand width, its stack-register forms and its operand-free form.
//!
//! A memory form's width is the suffix's: `s` / `l` / `t` a 32-, 64- or
//! 80-bit float, and on the integer operations (`fi...`) `s` / `l` /
//! `ll` (`q`) a 16-, 32- or 64-bit integer. Unsuffixed, a memory operand
//! takes the narrowest width, the `s` form, which AT&T source written
//! without a suffix means. The register forms follow the AT&T operand
//! order, in which `fsub %st, %st(i)` is Intel's `fsubr`.

use alloc::string::String;
use alloc::vec::Vec;

/// One mnemonic of the x87 set.
#[derive(Debug, PartialEq, Eq)]
pub(crate) struct X87 {
    pub name: &'static str,
    /// `(width in bytes, opcode bytes, ModRM reg)`, narrowest first.
    mem: &'static [(u8, &'static [u8], u8)],
    /// Whether a suffix names an integer width.
    int: bool,
    /// `%st(i)` or `%st(i), %st`: opcode and the ModRM byte for `st(0)`.
    one: Option<(u8, u8)>,
    /// `%st, %st(i)`.
    to: Option<(u8, u8)>,
    /// The operand-free form.
    bare: Option<&'static [u8]>,
    /// The form whose operand is `%ax`.
    ax: Option<&'static [u8]>,
}

const fn x87(name: &'static str) -> X87 {
    X87 {
        name,
        mem: &[],
        int: false,
        one: None,
        to: None,
        bare: None,
        ax: None,
    }
}

const fn float_op(name: &'static str, reg: u8) -> X87 {
    X87 {
        mem: match reg {
            0 => &[(4, &[0xD8], 0), (8, &[0xDC], 0)],
            1 => &[(4, &[0xD8], 1), (8, &[0xDC], 1)],
            2 => &[(4, &[0xD8], 2), (8, &[0xDC], 2)],
            3 => &[(4, &[0xD8], 3), (8, &[0xDC], 3)],
            4 => &[(4, &[0xD8], 4), (8, &[0xDC], 4)],
            5 => &[(4, &[0xD8], 5), (8, &[0xDC], 5)],
            6 => &[(4, &[0xD8], 6), (8, &[0xDC], 6)],
            _ => &[(4, &[0xD8], 7), (8, &[0xDC], 7)],
        },
        one: Some((0xD8, 0xC0 + reg * 8)),
        ..x87(name)
    }
}

const fn int_op(name: &'static str, reg: u8) -> X87 {
    X87 {
        mem: match reg {
            0 => &[(2, &[0xDE], 0), (4, &[0xDA], 0)],
            1 => &[(2, &[0xDE], 1), (4, &[0xDA], 1)],
            2 => &[(2, &[0xDE], 2), (4, &[0xDA], 2)],
            3 => &[(2, &[0xDE], 3), (4, &[0xDA], 3)],
            4 => &[(2, &[0xDE], 4), (4, &[0xDA], 4)],
            5 => &[(2, &[0xDE], 5), (4, &[0xDA], 5)],
            6 => &[(2, &[0xDE], 6), (4, &[0xDA], 6)],
            _ => &[(2, &[0xDE], 7), (4, &[0xDA], 7)],
        },
        int: true,
        ..x87(name)
    }
}

/// An arithmetic operation's `%st, %st(i)` form, and the popping form.
const fn arith(name: &'static str, reg: u8) -> X87 {
    X87 {
        to: Some((0xDC, 0xC0 + reg * 8)),
        ..float_op(name, reg)
    }
}

const fn pop(name: &'static str, reg: u8) -> X87 {
    X87 {
        one: Some((0xDE, 0xC0 + reg * 8)),
        to: Some((0xDE, 0xC0 + reg * 8)),
        bare: Some(match reg {
            0 => &[0xDE, 0xC1],
            1 => &[0xDE, 0xC9],
            4 => &[0xDE, 0xE1],
            5 => &[0xDE, 0xE9],
            6 => &[0xDE, 0xF1],
            _ => &[0xDE, 0xF9],
        }),
        ..x87(name)
    }
}

const fn stack(name: &'static str, opcode: u8, modrm: u8) -> X87 {
    X87 {
        one: Some((opcode, modrm)),
        ..x87(name)
    }
}

const fn fixed(name: &'static str, bytes: &'static [u8]) -> X87 {
    X87 {
        bare: Some(bytes),
        ..x87(name)
    }
}

const fn mem(name: &'static str, mem: &'static [(u8, &'static [u8], u8)]) -> X87 {
    X87 { mem, ..x87(name) }
}

#[rustfmt::skip]
static SET: &[X87] = &[
    arith("fadd", 0), arith("fmul", 1),
    arith("fsub", 4), arith("fsubr", 5), arith("fdiv", 6), arith("fdivr", 7),
    pop("faddp", 0), pop("fmulp", 1), pop("fsubp", 4), pop("fsubrp", 5),
    pop("fdivp", 6), pop("fdivrp", 7),
    int_op("fiadd", 0), int_op("fimul", 1), int_op("ficom", 2), int_op("ficomp", 3),
    int_op("fisub", 4), int_op("fisubr", 5), int_op("fidiv", 6), int_op("fidivr", 7),
    X87 { mem: &[(4, &[0xD9], 0), (8, &[0xDD], 0), (10, &[0xDB], 5)], one: Some((0xD9, 0xC0)), ..x87("fld") },
    X87 { mem: &[(4, &[0xD9], 2), (8, &[0xDD], 2)], one: Some((0xDD, 0xD0)), ..x87("fst") },
    X87 { mem: &[(4, &[0xD9], 3), (8, &[0xDD], 3), (10, &[0xDB], 7)], one: Some((0xDD, 0xD8)), ..x87("fstp") },
    X87 { mem: &[(2, &[0xDF], 0), (4, &[0xDB], 0), (8, &[0xDF], 5)], int: true, ..x87("fild") },
    X87 { mem: &[(2, &[0xDF], 2), (4, &[0xDB], 2)], int: true, ..x87("fist") },
    X87 { mem: &[(2, &[0xDF], 3), (4, &[0xDB], 3), (8, &[0xDF], 7)], int: true, ..x87("fistp") },
    X87 { mem: &[(2, &[0xDF], 1), (4, &[0xDB], 1), (8, &[0xDD], 1)], int: true, ..x87("fisttp") },
    mem("fbld", &[(10, &[0xDF], 4)]), mem("fbstp", &[(10, &[0xDF], 6)]),
    mem("fldcw", &[(2, &[0xD9], 5)]), mem("fnstcw", &[(2, &[0xD9], 7)]),
    mem("fstcw", &[(2, &[0x9B, 0xD9], 7)]),
    mem("fldenv", &[(28, &[0xD9], 4)]), mem("fnstenv", &[(28, &[0xD9], 6)]),
    mem("fstenv", &[(28, &[0x9B, 0xD9], 6)]),
    mem("frstor", &[(108, &[0xDD], 4)]), mem("fnsave", &[(108, &[0xDD], 6)]),
    mem("fsave", &[(108, &[0x9B, 0xDD], 6)]),
    X87 { mem: &[(2, &[0xDD], 7)], ax: Some(&[0xDF, 0xE0]), ..x87("fnstsw") },
    X87 { mem: &[(2, &[0x9B, 0xDD], 7)], ax: Some(&[0x9B, 0xDF, 0xE0]), ..x87("fstsw") },
    X87 { bare: Some(&[0xD8, 0xD1]), ..float_op("fcom", 2) },
    X87 { bare: Some(&[0xD8, 0xD9]), ..float_op("fcomp", 3) },
    X87 { bare: Some(&[0xDD, 0xE1]), ..stack("fucom", 0xDD, 0xE0) },
    X87 { bare: Some(&[0xDD, 0xE9]), ..stack("fucomp", 0xDD, 0xE8) },
    X87 { bare: Some(&[0xD9, 0xC9]), ..stack("fxch", 0xD9, 0xC8) },
    stack("fcomi", 0xDB, 0xF0), stack("fcomip", 0xDF, 0xF0), stack("fcompi", 0xDF, 0xF0),
    stack("fucomi", 0xDB, 0xE8), stack("fucomip", 0xDF, 0xE8), stack("fucompi", 0xDF, 0xE8),
    stack("ffree", 0xDD, 0xC0), stack("ffreep", 0xDF, 0xC0),
    stack("fcmovb", 0xDA, 0xC0), stack("fcmove", 0xDA, 0xC8), stack("fcmovbe", 0xDA, 0xD0),
    stack("fcmovu", 0xDA, 0xD8), stack("fcmovnb", 0xDB, 0xC0), stack("fcmovne", 0xDB, 0xC8),
    stack("fcmovnbe", 0xDB, 0xD0), stack("fcmovnu", 0xDB, 0xD8),
    fixed("fcompp", &[0xDE, 0xD9]), fixed("fucompp", &[0xDA, 0xE9]),
    fixed("fchs", &[0xD9, 0xE0]), fixed("fabs", &[0xD9, 0xE1]), fixed("ftst", &[0xD9, 0xE4]),
    fixed("fxam", &[0xD9, 0xE5]), fixed("fld1", &[0xD9, 0xE8]), fixed("fldl2t", &[0xD9, 0xE9]),
    fixed("fldl2e", &[0xD9, 0xEA]), fixed("fldpi", &[0xD9, 0xEB]), fixed("fldlg2", &[0xD9, 0xEC]),
    fixed("fldln2", &[0xD9, 0xED]), fixed("fldz", &[0xD9, 0xEE]), fixed("f2xm1", &[0xD9, 0xF0]),
    fixed("fyl2x", &[0xD9, 0xF1]), fixed("fptan", &[0xD9, 0xF2]), fixed("fpatan", &[0xD9, 0xF3]),
    fixed("fxtract", &[0xD9, 0xF4]), fixed("fprem1", &[0xD9, 0xF5]), fixed("fdecstp", &[0xD9, 0xF6]),
    fixed("fincstp", &[0xD9, 0xF7]), fixed("fprem", &[0xD9, 0xF8]), fixed("fyl2xp1", &[0xD9, 0xF9]),
    fixed("fsqrt", &[0xD9, 0xFA]), fixed("fsincos", &[0xD9, 0xFB]), fixed("frndint", &[0xD9, 0xFC]),
    fixed("fscale", &[0xD9, 0xFD]), fixed("fsin", &[0xD9, 0xFE]), fixed("fcos", &[0xD9, 0xFF]),
    fixed("fnop", &[0xD9, 0xD0]), fixed("fnclex", &[0xDB, 0xE2]), fixed("fclex", &[0x9B, 0xDB, 0xE2]),
    fixed("fninit", &[0xDB, 0xE3]), fixed("finit", &[0x9B, 0xDB, 0xE3]),
    fixed("fwait", &[0x9B]), fixed("wait", &[0x9B]),
];

/// The x87 mnemonic `name` spells, and the memory width its suffix names:
/// the whole name first, so `fldl2t` and `fstsw` are not read as suffixed.
pub(crate) fn lookup(name: &str) -> Option<(&'static X87, Option<u8>)> {
    let find = |n: &str| SET.iter().find(|x| x.name == n);
    if let Some(x) = find(name) {
        return Some((x, None));
    }
    for (suffix, float, int) in [
        ("ll", 0, 8),
        ("q", 0, 8),
        ("s", 4, 2),
        ("l", 8, 4),
        ("t", 10, 0),
    ] {
        let Some(x) = name.strip_suffix(suffix).and_then(find) else {
            continue;
        };
        let width = if x.int { int } else { float };
        if width != 0 && x.mem.iter().any(|m| m.0 == width) {
            return Some((x, Some(width)));
        }
    }
    None
}

/// The AT&T suffix of the memory width `bytes` on `name`, for a spelling
/// that states the width apart from the mnemonic (Intel's `ptr` size).
pub(crate) fn suffix(name: &str, bytes: u32) -> Option<&'static str> {
    let x = SET.iter().find(|x| x.name == name && !x.mem.is_empty())?;
    let suffix = match (x.int, bytes) {
        (false, 4) | (true, 2) => "s",
        (false, 8) | (true, 4) => "l",
        (false, 10) => "t",
        (true, 8) => "ll",
        _ => return None,
    };
    (x.mem.len() > 1).then_some(suffix)
}

/// The operation AT&T names `name`'s register form into `st(i)` by: the
/// subtractions and divisions, reversed.
pub(crate) fn reversed(name: &str) -> Option<&'static str> {
    Some(match name {
        "fsub" => "fsubr",
        "fsubr" => "fsub",
        "fsubp" => "fsubrp",
        "fsubrp" => "fsubp",
        "fdiv" => "fdivr",
        "fdivr" => "fdiv",
        "fdivp" => "fdivrp",
        "fdivrp" => "fdivp",
        _ => return None,
    })
}

/// An operand of an x87 form, resolved: a stack register by index, `%ax`,
/// or a memory reference the caller encodes.
pub(crate) enum Operand {
    St(u8),
    Ax,
    Memory,
}

/// The bytes of `x` with `operands`, and for a memory form its opcode bytes
/// and ModRM reg, which the caller completes with the reference.
pub(crate) enum Encoding {
    Bytes(Vec<u8>),
    Memory(&'static [u8], u8),
}

pub(crate) fn encode(x: &X87, width: Option<u8>, operands: &[Operand]) -> Result<Encoding, String> {
    let bad = || alloc::format!("inline asm: `{}` does not take these operands", x.name);
    let with = |(opcode, modrm): (u8, u8), i: u8| Encoding::Bytes(alloc::vec![opcode, modrm + i]);
    match operands {
        [] => x.bare.map(|b| Encoding::Bytes(b.to_vec())).ok_or_else(bad),
        [Operand::Memory] => {
            let form = match width {
                Some(w) => x.mem.iter().find(|m| m.0 == w),
                None => x.mem.first(),
            };
            form.map(|&(_, opcode, reg)| Encoding::Memory(opcode, reg))
                .ok_or_else(bad)
        }
        [Operand::Ax] => x.ax.map(|b| Encoding::Bytes(b.to_vec())).ok_or_else(bad),
        [Operand::St(i)] | [Operand::St(i), Operand::St(0)] => {
            x.one.map(|f| with(f, *i)).ok_or_else(bad)
        }
        [Operand::St(0), Operand::St(i)] => x.to.map(|f| with(f, *i)).ok_or_else(bad),
        _ => Err(bad()),
    }
}
