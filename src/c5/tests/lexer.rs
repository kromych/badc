//! Token-stream tests that exercise `Lexer::next` in isolation.

use super::{LexHarness, Tok, Token};

#[test]
fn empty_source_yields_eof() {
    let mut h = LexHarness::new("");
    assert_eq!(h.next(), Tok::EOF);
}

#[test]
fn whitespace_only_yields_eof() {
    let mut h = LexHarness::new("   \t\n   ");
    assert_eq!(h.next(), Tok::EOF);
}

#[test]
fn integer_literal() {
    let mut h = LexHarness::new("42");
    assert_eq!(h.next(), Token::Num);
    assert_eq!(h.ival(), 42);
    assert_eq!(h.next(), Tok::EOF);
}

#[test]
fn hex_literal_lower_and_upper() {
    let mut h = LexHarness::new("0xff 0xABCD");
    assert_eq!(h.next(), Token::Num);
    assert_eq!(h.ival(), 0xff);
    assert_eq!(h.next(), Token::Num);
    assert_eq!(h.ival(), 0xABCD);
}

#[test]
fn keywords_resolve_to_their_tokens() {
    let mut h = LexHarness::new("int char if else while return sizeof");
    let expected = [
        Token::Int,
        Token::Char,
        Token::If,
        Token::Else,
        Token::While,
        Token::Return,
        Token::Sizeof,
    ];
    for tok in expected {
        assert_eq!(h.next(), tok);
    }
    assert_eq!(h.next(), Tok::EOF);
}

#[test]
fn identifier_interned_in_symbol_table() {
    let mut h = LexHarness::new("foo bar foo");
    assert_eq!(h.next(), Token::Id);
    assert_eq!(h.name(), "foo");
    let foo_idx = h.symbols.len() - 1;

    assert_eq!(h.next(), Token::Id);
    assert_eq!(h.name(), "bar");
    assert_ne!(h.symbols.len() - 1, foo_idx);

    // The second `foo` reuses the existing symbol.
    let prev_len = h.symbols.len();
    assert_eq!(h.next(), Token::Id);
    assert_eq!(h.name(), "foo");
    assert_eq!(h.symbols.len(), prev_len);
}

#[test]
fn string_literal_lands_in_data_segment() {
    // The lexer alone leaves the trailing NUL off so adjacent string
    // literals can concatenate; the parser adds it back. So in raw
    // lexer output we only see the bytes themselves.
    let mut h = LexHarness::new(r#""abc""#);
    assert_eq!(h.next(), '"');
    let addr = h.ival() as usize;
    assert_eq!(&h.data[addr..addr + 3], b"abc");
}

#[test]
fn string_literal_escape_sequences() {
    // Lexer alone -- no trailing NUL (parser adds it).
    let mut h = LexHarness::new(r#""a\nb""#);
    assert_eq!(h.next(), '"');
    let addr = h.ival() as usize;
    assert_eq!(&h.data[addr..addr + 3], b"a\nb");
}

#[test]
fn char_literal_returns_num_token() {
    let mut h = LexHarness::new("'A'");
    assert_eq!(h.next(), Token::Num);
    assert_eq!(h.ival(), 'A' as i64);
}

#[test]
fn char_literal_newline_escape() {
    let mut h = LexHarness::new(r"'\n'");
    assert_eq!(h.next(), Token::Num);
    assert_eq!(h.ival(), '\n' as i64);
}

#[test]
fn standalone_bang_is_not_eof() {
    // Regression: `!` used to be lexed as `tk=0` (EOF) when not followed
    // by `=`, which broke unary NOT and made `!1` look like an empty
    // expression to the parser.
    let mut h = LexHarness::new("!1");
    assert_eq!(h.next(), '!');
    assert_eq!(h.next(), Token::Num);
    assert_eq!(h.ival(), 1);
}

#[test]
fn compound_operators_disambiguated() {
    let mut h = LexHarness::new("== != <= >= && || << >> ++ --");
    let expected = [
        Token::EqOp,
        Token::NeOp,
        Token::LeOp,
        Token::GeOp,
        Token::Lan,
        Token::Lor,
        Token::ShlOp,
        Token::ShrOp,
        Token::Inc,
        Token::Dec,
    ];
    for tok in expected {
        assert_eq!(h.next(), tok);
    }
}

#[test]
fn single_char_operators() {
    let mut h = LexHarness::new("+ - * / % = < > & | ^");
    let expected = [
        Token::AddOp,
        Token::SubOp,
        Token::MulOp,
        Token::DivOp,
        Token::ModOp,
        Token::Assign,
        Token::LtOp,
        Token::GtOp,
        Token::AndOp,
        Token::OrOp,
        Token::XorOp,
    ];
    for tok in expected {
        assert_eq!(h.next(), tok);
    }
}

#[test]
fn punctuation_tokens_are_their_byte_values() {
    // `[` is special-cased to Token::Brak; everything in this set comes
    // back as its raw byte value.
    let mut h = LexHarness::new("(){};,:]");
    for c in "(){};,:]".chars() {
        assert_eq!(h.next(), c);
    }
}

#[test]
fn open_bracket_maps_to_brak_token() {
    let mut h = LexHarness::new("[");
    assert_eq!(h.next(), Token::Brak);
}

#[test]
fn line_comments_are_skipped() {
    let mut h = LexHarness::new("1 // ignored\n 2");
    assert_eq!(h.next(), Token::Num);
    assert_eq!(h.ival(), 1);
    assert_eq!(h.next(), Token::Num);
    assert_eq!(h.ival(), 2);
}

#[test]
fn preprocessor_lines_are_skipped() {
    let mut h = LexHarness::new("#include <stdio.h>\n42");
    assert_eq!(h.next(), Token::Num);
    assert_eq!(h.ival(), 42);
}

#[test]
fn shebang_line_is_skipped_and_line_counter_advances() {
    // The first character of a shebang is `#`, which the lexer treats
    // the same as a `#include` directive -- gobble to end-of-line. The
    // following newline still bumps the line counter so error messages
    // point at the right line in the user's source.
    let mut h = LexHarness::new("#!/usr/bin/env badc\n42");
    assert_eq!(h.next(), Token::Num);
    assert_eq!(h.ival(), 42);
    assert_eq!(h.line(), 2);
}

#[test]
fn line_counter_advances_with_newlines() {
    let mut h = LexHarness::new("1\n\n2\n3");
    assert_eq!(h.line(), 1);
    assert_eq!(h.next(), Token::Num);
    assert_eq!(h.line(), 1);
    assert_eq!(h.next(), Token::Num);
    assert_eq!(h.line(), 3);
    assert_eq!(h.next(), Token::Num);
    assert_eq!(h.line(), 4);
}

#[test]
fn binding_names_seed_token_sys_when_dylibs_provided() {
    // `init_symbols` no longer carries a fixed list of libc names;
    // it walks the dylibs the preprocessor parsed and seeds each
    // binding's `local_name` as a `Token::Sys` symbol with `val` set
    // to the binding's flat-index. A program reaching for
    // `malloc(...)` then lowers via `Inst::CallExt` with
    // binding_idx 0 (or whichever index `malloc` ended up at).
    use crate::c5::lexer::{Lexer, SymbolIndex, init_symbols};
    use crate::c5::preprocessor::{Binding, DylibSpec};

    let dylibs = vec![DylibSpec {
        name: "libc".into(),
        path: "libc.so.6".into(),
        bindings: vec![Binding {
            is_variadic: false,
            fixed_args: 1,
            return_type_tag: 0,
            returns_long_double: false,
            param_types: Vec::new(),
            local_name: "malloc".into(),
            real_symbol: "malloc".into(),
            is_data: false,
        }],
    }];
    let mut symbols = Vec::new();
    let mut symbol_index = SymbolIndex::new();
    init_symbols(&mut symbols, &mut symbol_index, &dylibs);

    let mut lex = Lexer::new("malloc".to_string());
    let mut data = Vec::new();
    lex.next(&mut symbols, &mut symbol_index, &mut data)
        .expect("lex");
    assert_eq!(lex.tk, Token::Id);

    let sym = symbols
        .iter()
        .find(|s| s.name == "malloc")
        .expect("malloc should be seeded from the dylibs list");
    assert_eq!(sym.class, Token::Sys as i64);
    assert_eq!(sym.val, 0, "first binding gets flat-index 0");
}
