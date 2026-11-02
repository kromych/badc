//! The library function a builtin calls, with the prototype gcc and clang
//! give the builtin where no declaration is in scope.

use alloc::vec::Vec;

use super::super::preprocessor::builtins::library_prototype;
use super::super::token::{Token, Ty};
use super::Compiler;
use super::types::{
    LONG_DOUBLE_BIT, UNSIGNED_BIT, add_ptr_level, is_struct_value_ty, plain_char_ty,
    pointer_to_const, void_ty,
};
use crate::c5::symbol::FnParams;

impl Compiler {
    /// Whether the auto-include retry cannot declare library function `name`.
    pub(super) fn auto_include_unavailable(&self, name: &str) -> bool {
        self.nostdinc
            || self.preprocessed
            || self.library_name_is_opaque(name)
            || super::super::headers::header_declaring(name, self.target).is_none()
    }

    /// External function `name` with its builtin's prototype, in the slot
    /// `builtin_library_symbol` names, so the unit sees no declaration.
    pub(super) fn library_function_slot(&mut self, name: &str) -> Option<usize> {
        let proto = library_prototype(name)?;
        let slot = self.resolve_symbol_named(&alloc::format!("{name}.builtin"));
        if self.symbols[slot].class == 0 {
            let (ret, params, noreturn) = self.prototype_types(proto);
            let sym = &mut self.symbols[slot];
            sym.class = Token::Fun as i64;
            sym.type_ = ret;
            sym.set_fn_params(params);
            sym.is_noreturn = noreturn;
            sym.asm_name = Some(name.into());
            sym.linkage = crate::c5::symbol::Linkage::External;
            sym.defined_here = false;
        }
        Some(slot)
    }

    pub(super) fn library_param_types(&mut self, fn_name: &str) -> Vec<i64> {
        let proto = library_prototype(fn_name).expect("a builtin's library function");
        self.prototype_types(proto).1.types
    }

    /// The return type, parameters and `_Noreturn` of `size_t(const char *)`.
    fn prototype_types(&mut self, proto: &str) -> (i64, FnParams, bool) {
        let spaced = proto
            .replace('(', " ( ")
            .replace(')', " ) ")
            .replace(',', " , ")
            .replace('*', " * ");
        let words: Vec<&str> = spaced.split_whitespace().collect();
        let noreturn = words.first() == Some(&"_Noreturn");
        let words = &words[usize::from(noreturn)..];
        let open = words
            .iter()
            .position(|&w| w == "(")
            .expect("a parameter list");
        let ret = self.prototype_type(&words[..open]);
        let mut params = FnParams {
            prototyped: true,
            ..FnParams::default()
        };
        let list = &words[open + 1..words.len() - 1];
        for param in list.split(|&w| w == ",") {
            match param {
                ["..."] => params.variadic = true,
                ["void"] => {}
                _ => params.types.push(self.prototype_type(param)),
            }
        }
        (ret, params, noreturn)
    }

    /// A base type and its `*`s; a `const` qualifies what the next `*` points to.
    fn prototype_type(&mut self, words: &[&str]) -> i64 {
        let mut base = Vec::new();
        let mut ty = None;
        let mut pointee_const = false;
        for &w in words {
            match w {
                "const" => pointee_const = true,
                "*" => {
                    let t = match ty {
                        Some(t) => t,
                        None => self.prototype_base(&base),
                    };
                    ty = Some(if pointee_const {
                        pointer_to_const(t)
                    } else {
                        add_ptr_level(t)
                    });
                    pointee_const = false;
                }
                word => base.push(word),
            }
        }
        ty.unwrap_or_else(|| self.prototype_base(&base))
    }

    fn prototype_base(&mut self, words: &[&str]) -> i64 {
        match words.join(" ").as_str() {
            "void" | "FILE" | "struct tm" => void_ty(),
            "char" => plain_char_ty(self.lex.char_signed),
            "int" | "pid_t" => Ty::Int as i64,
            "long" => Ty::Long as i64,
            "long long" => Ty::LongLong as i64,
            "float" => Ty::Float as i64,
            "double" => Ty::Double as i64,
            "long double" => Ty::Double as i64 | LONG_DOUBLE_BIT,
            "size_t" => self.size_t_ty(),
            "intmax_t" => self.intmax_t_ty(),
            "wchar_t" => self
                .prefixed_char_ty(crate::c5::lexer::StrPrefix::Wide)
                .expect("wchar_t"),
            // The bundled <wchar.h>'s, and the Windows C runtime's.
            "wint_t" if self.target.is_windows() => Ty::Short as i64 | UNSIGNED_BIT,
            "wint_t" => Ty::Int as i64,
            "va_list" => self.va_list_param_ty(),
            other => unreachable!("no base type `{other}` in the builtin prototypes"),
        }
    }

    pub(super) fn intmax_t_ty(&self) -> i64 {
        if self.target.is_windows() {
            Ty::LongLong as i64
        } else {
            Ty::Long as i64
        }
    }

    /// `__builtin_va_list` adjusted as a parameter (C99 6.7.5.3p7), leaving
    /// the array noted for a declaration in progress.
    fn va_list_param_ty(&mut self) -> i64 {
        let p = &mut self.pending;
        let size = p.typedef_base_array_size;
        let dims = core::mem::take(&mut p.typedef_base_array_dims);
        let zero_len = p.typedef_base_zero_len;
        let tag = self.builtin_va_list_tag();
        self.pending.set_base_array(size, dims, zero_len);
        if is_struct_value_ty(tag) {
            add_ptr_level(tag)
        } else {
            tag
        }
    }
}
