#!/usr/bin/env python3
"""Generate the badc AArch64 encoder catalog from an instruction-set database.

Reads a machine-readable A64 database (the asmjit `db/isa_aarch64.json` schema)
and emits `src/c5/codegen/aarch64/isa_a64_table.rs`: a `Form` per instruction
row as a base word plus the field list `super::table::encode` splices operands
into. The base words -- the encoding facts -- come from the database. The
operand-to-field mapping is derived by classifying each row's written operand
signature against the field model (register operands feeding named 5-bit fields
at bit positions read from the encoding, a base-register memory reference, plus
the immediate / shift-alias / condition field kinds). Rows the model cannot
express are skipped and bucketed; --residuals prints them ranked by row count
as the model-growth roadmap.

Differential sweeps proved several shipped database rows disagree with the
architecture (cbz carrying cbnz's opcode; ret, dsb, subps missing bits;
crc32x/crc32cx destination width; ldset's width-mismatched destination; the
word/doubleword compare-and-swap rows dropping bit 23) -- corrected in
DB_FIXES -- and that addg/subg write a 16-scaled immediate the raw-field model
would encode wrongly -- dropped in EXCLUDED_ROWS. This is why the encoder is
derived, not copied: the database is a strong starting point, not ground truth.

Usage:
    tools/gen_isa_a64.py --db /path/to/db/isa_aarch64.json \
        --out src/c5/codegen/aarch64/isa_a64_table.rs [--residuals]
"""
import argparse, collections, json, re, sys

# Rows whose shipped text disagrees with the architecture (verified vs the
# assembler): (inst, op-as-shipped) -> (corrected inst or None, corrected op
# or None).
DB_FIXES = {
    ("cbz Wn, #relS*4", "00110101|relS:19|Rn"): (None, "00110100|relS:19|Rn"),
    ("cbz Xn, #relS*4", "10110101|relS:19|Rn"): (None, "10110100|relS:19|Rn"),
    ("ret Xn", "11010100|010|11111|0|00000|Rn|00000"):
        (None, "11010110|010|11111|0|00000|Rn|00000"),
    ("dsb #barrier_op", "11010101|000|00|011|0011|CRm|101|11111"):
        (None, "11010101|000|00|011|0011|CRm|100|11111"),
    ("subps Xd, Xn|SP, Xm|SP", "10011010|110|Rm|0|00000|Rn|Rd"):
        (None, "10111010|110|Rm|0|00000|Rn|Rd"),
    ("crc32x Xd, Xn, Xm", "10011010|110|Rm|0|10011|Rn|Rd"):
        ("crc32x Wd, Wn, Xm", None),
    ("crc32cx Xd, Xn, Xm", "10011010|110|Rm|0|10111|Rn|Rd"):
        ("crc32cx Wd, Wn, Xm", None),
    # The scalar mvn alias (orn Rd, ZR, Rm, {sop #n}) is shipped with its
    # source spelled `Wn`/`Xn` and an encoding naming `Rn` for both the Rm
    # field and the zero register, so the row parses as a repeated field.
    ("mvn Wd, Wn, {sop #n}", "X0101010|sop|1|Rn|n:6|Rn|Rd"):
        ("mvn Wd, Wm, {sop #n}", "00101010|sop:2|1|Rm|n:6|11111|Rd"),
    ("mvn Xd, Xn, {sop #n}", "X0101010|sop|1|Rn|n:6|Rn|Rd"):
        ("mvn Xd, Xm, {sop #n}", "10101010|sop:2|1|Rm|n:6|11111|Rd"),
    # The ldset 64-bit forms are shipped with a 32-bit `Wd` destination; the
    # assembler rejects that width mix (the field is width-independent, so the
    # bytes are already correct -- only the spelling is wrong).
    ("ldset Xs, Wd, [Xn|SP]", "11111000|001|Rs|0|01100|Rn|Rd"):
        ("ldset Xs, Xd, [Xn|SP]", None),
    ("ldseta Xs, Wd, [Xn|SP]", "11111000|101|Rs|0|01100|Rn|Rd"):
        ("ldseta Xs, Xd, [Xn|SP]", None),
    ("ldsetl Xs, Wd, [Xn|SP]", "11111000|011|Rs|0|01100|Rn|Rd"):
        ("ldsetl Xs, Xd, [Xn|SP]", None),
    ("ldsetal Xs, Wd, [Xn|SP]", "11111000|111|Rs|0|01100|Rn|Rd"):
        ("ldsetal Xs, Xd, [Xn|SP]", None),
    # The word/doubleword compare-and-swap rows drop bit 23 (the byte/halfword
    # rows carry it); the assembler sets it, so the shipped bytes are wrong.
    ("cas Ws, Wd, [Xn|SP]", "10001000|001|Rs|0|11111|Rn|Rd"):
        (None, "10001000|101|Rs|0|11111|Rn|Rd"),
    ("casa Ws, Wd, [Xn|SP]", "10001000|011|Rs|0|11111|Rn|Rd"):
        (None, "10001000|111|Rs|0|11111|Rn|Rd"),
    ("casl Ws, Wd, [Xn|SP]", "10001000|001|Rs|1|11111|Rn|Rd"):
        (None, "10001000|101|Rs|1|11111|Rn|Rd"),
    ("casal Ws, Wd, [Xn|SP]", "10001000|011|Rs|1|11111|Rn|Rd"):
        (None, "10001000|111|Rs|1|11111|Rn|Rd"),
    ("cas Xs, Xd, [Xn|SP]", "11001000|001|Rs|0|11111|Rn|Rd"):
        (None, "11001000|101|Rs|0|11111|Rn|Rd"),
    ("casa Xs, Xd, [Xn|SP]", "11001000|011|Rs|0|11111|Rn|Rd"):
        (None, "11001000|111|Rs|0|11111|Rn|Rd"),
    ("casl Xs, Xd, [Xn|SP]", "11001000|001|Rs|1|11111|Rn|Rd"):
        (None, "11001000|101|Rs|1|11111|Rn|Rd"),
    ("casal Xs, Xd, [Xn|SP]", "11001000|011|Rs|1|11111|Rn|Rd"):
        (None, "11001000|111|Rs|1|11111|Rn|Rd"),
    # The unsigned halfword exclusive forms are shipped with 64-bit data
    # registers; the assembler takes W (the sub-word value zero-extends), and
    # only the mis-widened row exists, so a correct W spelling would not match.
    ("ldaxrh Xd, [Xn|SP]", "01001000|010|11111|1|11111|Rn|Rd"):
        ("ldaxrh Wd, [Xn|SP]", None),
    ("stlxrh Wd, Xs, [Xn|SP]", "01001000|000|Rd|1|11111|Rn|Rs"):
        ("stlxrh Wd, Ws, [Xn|SP]", None),
    ("stxrh Wd, Xs, [Xn|SP]", "01001000|000|Rd|0|11111|Rn|Rs"):
        ("stxrh Wd, Ws, [Xn|SP]", None),
    # The sign-extending byte/halfword unscaled + unprivileged loads carry the
    # opc[23:22] target-width bits inverted: the assembler encodes the 32-bit
    # (Wd) variant as opc=11 and the 64-bit (Xd) as opc=10, but the database
    # ships them the other way round. Swap the middle group (100<->110) so each
    # width gets its true opc. (ldtrsw/ldursw are 64-bit only, opc=10, correct.)
    ("ldtrsb Wd, [Xn|SP, #offS]", "00111000|100|offS:9|10|Rn|Rd"):
        (None, "00111000|110|offS:9|10|Rn|Rd"),
    ("ldtrsb Xd, [Xn|SP, #offS]", "00111000|110|offS:9|10|Rn|Rd"):
        (None, "00111000|100|offS:9|10|Rn|Rd"),
    ("ldtrsh Wd, [Xn|SP, #offS]", "01111000|100|offS:9|10|Rn|Rd"):
        (None, "01111000|110|offS:9|10|Rn|Rd"),
    ("ldtrsh Xd, [Xn|SP, #offS]", "01111000|110|offS:9|10|Rn|Rd"):
        (None, "01111000|100|offS:9|10|Rn|Rd"),
    ("ldursb Wd, [Xn|SP, #offS]", "00111000|100|offS:9|00|Rn|Rd"):
        (None, "00111000|110|offS:9|00|Rn|Rd"),
    ("ldursb Xd, [Xn|SP, #offS]", "00111000|110|offS:9|00|Rn|Rd"):
        (None, "00111000|100|offS:9|00|Rn|Rd"),
    ("ldursh Wd, [Xn|SP, #offS]", "01111000|100|offS:9|00|Rn|Rd"):
        (None, "01111000|110|offS:9|00|Rn|Rd"),
    ("ldursh Xd, [Xn|SP, #offS]", "01111000|110|offS:9|00|Rn|Rd"):
        (None, "01111000|100|offS:9|00|Rn|Rd"),
    # prfm's immediate offset is scaled by 8 like the doubleword loads; the
    # database ships the row without the multiplier.
    ("prfm #prf_op, [Xn|SP, #offZ]", "11111001|10|offZ:12|Rn|prf_op:5"):
        ("prfm #prf_op, [Xn|SP, #offZ*8]", None),
    # Register-31 role: the shipped `|SP` marks disagree with the assembler on
    # eleven rows. The flag-setting add/sub immediate and the flag-setting
    # logical forms write the zero register, not SP; the logical
    # shifted-register forms take a zero-register destination in every case
    # (only the immediate forms reach SP); and irg writes SP as well as reads
    # it.
    ("adds Wd|WSP, Wn|WSP, #immZ, {lsl #n=0|12}", "00110001|0|n:1|immZ:12|Rn|Rd"):
        ("adds Wd, Wn|WSP, #immZ, {lsl #n=0|12}", None),
    ("adds Xd|SP, Xn|SP, #immZ, {lsl #n=0|12}", "10110001|0|n:1|immZ:12|Rn|Rd"):
        ("adds Xd, Xn|SP, #immZ, {lsl #n=0|12}", None),
    ("subs Wd|WSP, Wn|WSP, #immZ, {lsl #n=0|12}", "01110001|0|n:1|immZ:12|Rn|Rd"):
        ("subs Wd, Wn|WSP, #immZ, {lsl #n=0|12}", None),
    ("subs Xd|SP, Xn|SP, #immZ, {lsl #n=0|12}", "11110001|0|n:1|immZ:12|Rn|Rd"):
        ("subs Xd, Xn|SP, #immZ, {lsl #n=0|12}", None),
    ("and Wd|WSP, Wn, Wm, {sop #n}", "00001010|sop|0|Rm|n:6|Rn|Rd"):
        ("and Wd, Wn, Wm, {sop #n}", None),
    ("and Xd|SP, Xn, Xm, {sop #n}", "10001010|sop|0|Rm|n:6|Rn|Rd"):
        ("and Xd, Xn, Xm, {sop #n}", None),
    ("ands Wd|WSP, Wn, Wm, {sop #n}", "01101010|sop|0|Rm|n:6|Rn|Rd"):
        ("ands Wd, Wn, Wm, {sop #n}", None),
    ("ands Xd|SP, Xn, Xm, {sop #n}", "11101010|sop|0|Rm|n:6|Rn|Rd"):
        ("ands Xd, Xn, Xm, {sop #n}", None),
    ("ands Wd|WSP, Wn, #imm", "01110010|0|imm:13|Rn|Rd"):
        ("ands Wd, Wn, #imm", None),
    ("ands Xd|SP, Xn, #imm", "11110010|0|imm:13|Rn|Rd"):
        ("ands Xd, Xn, #imm", None),
    ("irg Xd, Xn|SP, Xm", "10011010|110|Rm|000100|Rn|Rd"):
        ("irg Xd|SP, Xn|SP, Xm", None),
}

# The unsigned saturating 32-bit SVE element-count forms write one register,
# `uqincb Wdn{, pattern{, mul #imm}}`, whose result zero-extends; the database
# spells them with the signed forms' `Xdn, Wdn` pair, which the assembler
# rejects.
for _stem in ('uqinc', 'uqdec'):
    for _t, _sz in (('b', '00'), ('h', '01'), ('w', '10'), ('d', '11')):
        _op = '111101' if _stem == 'uqinc' else '111111'
        DB_FIXES[(f'{_stem}{_t} Xdn, Wdn, {{#pattern}}, {{mul #imm}}',
                  f'00000100|{_sz}|10|imm:4|{_op}|pattern:5|Rdn')] = (
            f'{_stem}{_t} Wdn, {{#pattern}}, {{mul #imm}}', None)

# The SVE rows whose operands are general-purpose registers and immediates:
# the vector-length arithmetic (rdvl, addvl, addpl) and the element-count
# family, whose predicate-constraint pattern and multiplier read no SVE
# register. The rest of the SVE group names Z and P registers.
SVE_SCALAR_ROW = re.compile(
    r'(rdvl|addvl|addpl|(cnt|inc|dec|sqinc|sqdec|uqinc|uqdec)[bhwd]) [XW]').match

# The store-form atomic aliases (ST<op> = LD<op> with the result discarded)
# are defined by the architecture only for the plain and release orderings;
# the acquire spellings ST<op>A / ST<op>AL do not exist (an acquire on a
# discarded load has no meaning) and the assembler rejects them.
UNDEFINED_ROW = re.compile(
    r'st(add|clr|eor|set|smax|smin|umax|umin)a[lbh]* ').match

# SVE rows the database spells with the wrong field names or sizes, checked
# against Apple clang 21.0.0's assembler: the X-register broadcast is
# doubleword-only, and mla/mls name the addend Zda and the multiplicand Zn.
for _m in ('dup', 'mov'):
    DB_FIXES[(f'{_m} Zd.t, Xn|SP', '00000101|11|100000001110|Rn|Zd')] = (
        f'{_m} Zd.D, Xn|SP', None)
for _m, _o in (('mla', '010'), ('mls', '011')):
    DB_FIXES[(f'{_m} Zda.t, Pg/M, Zn.t, Zm.t', f'00000100|sz|0|Zm|{_o}|Pg:3|Za|Zdn')] = (
        None, f'00000100|sz|0|Zm|{_o}|Pg:3|Zn|Zda')

# The predicated negations name the source Zm and the destination Zdn, and
# the floating reductions the source Zm and the scalar Zd; the exclusive-OR
# reduction spells each size's row with the generic `.t`; the AND reduction
# is one row of a generic `Vd`, a row per size below.
for _m in ('neg', 'fneg'):
    _o = '010111101' if _m == 'neg' else '011101101'
    DB_FIXES[(f'{_m} Zd.t, Pg/M, Zn.t', f'00000100|sz|{_o}|Pg:3|Zm|Zdn')] = (
        None, f'00000100|sz|{_o}|Pg:3|Zn|Zd')
for _m, _o in (('fmaxnmv', '000100001'), ('fminnmv', '000101001'),
               ('fmaxv', '000110001'), ('fminv', '000111001')):
    for _e, _sz in (('H', '01'), ('S', '10'), ('D', '11')):
        DB_FIXES[(f'{_m} {_e}d, Pg, Zn.{_e}', f'01100101|{_sz}|{_o}|Pg:3|Zm|Zd')] = (
            None, f'01100101|{_sz}|{_o}|Pg:3|Zn|Rd')
for _e, _sz in (('B', '00'), ('H', '01'), ('S', '10'), ('D', '11')):
    DB_FIXES[(f'eorv {_e}d, Pg, Zn.t', f'00000100|{_sz}|011001001|Pg:3|Zn|Rd')] = (
        f'eorv {_e}d, Pg, Zn.{_e}', None)

# Rows a differential sweep against that assembler finds wrong: base words
# (bic, bics, orr of predicates), a W form spelled as the X one (uqincp,
# uqdecp), a merging spelling of a zeroing-only form (brkas, brkbs), the
# element size of the saturating vector counts by halfword and word and the
# base word of the halfword ones, the unsigned immediates of the unsigned
# compares and umin, and the sizes of sqdmulh and uaddv.
DB_FIXES.update({
    ('bic Zdn.t, Pg/M, Zdn.t, Zm.t', '00000100|sz|011010000|Pg:3|Zm|Zdn'):
        (None, '00000100|sz|011011000|Pg:3|Zm|Zdn'),
    ('bics Pd.B, Pg/Z, Pn.B, Pm.B', '00100101|01|10|Pm|01|Pg|0|Pn|1|Pd'):
        (None, '00100101|01|00|Pm|01|Pg|0|Pn|1|Pd'),
    ('orr Pd.B, Pg/Z, Pn.B, Pm.B', '00100100|10|00|Pm|01|Pg|0|Pn|0|Pd'):
        (None, '00100101|10|00|Pm|01|Pg|0|Pn|0|Pd'),
    ('uqincp Xdn, Pm.t', '00100101|sz|1010011000100|Pm|Rdn'): ('uqincp Wdn, Pm.t', None),
    ('uqdecp Xdn, Pm.t', '00100101|sz|1010111000100|Pm|Rdn'): ('uqdecp Wdn, Pm.t', None),
    ('brkas Pd.B, Pg/M, Pn.B', '00100101|01|01000001|Pg|0|Pn|0|Pd'): ('brkas Pd.B, Pg/Z, Pn.B', None),
    ('brkbs Pd.B, Pg/M, Pn.B', '00100101|11|01000001|Pg|0|Pn|0|Pd'): ('brkbs Pd.B, Pg/Z, Pn.B', None),
    ('umin Zdn.t, Zdn.t, #immS', '00100101|sz|101011110|immS:8|Zdn'):
        ('umin Zdn.t, Zdn.t, #imm', '00100101|sz|101011110|imm:8|Zdn'),
})
for _m, _lt, _ne in (('cmphs', '0', '0'), ('cmphi', '0', '1'),
                     ('cmplo', '1', '0'), ('cmpls', '1', '1')):
    DB_FIXES[(f'{_m} Pd.t, Pg/Z, Zn.t, #immS',
              f'00100100|sz|1|immS:7|{_lt}|Pg:3|Zn|{_ne}|Pd')] = (
        f'{_m} Pd.t, Pg/Z, Zn.t, #imm', f'00100100|sz|1|imm:7|{_lt}|Pg:3|Zn|{_ne}|Pd')
for _stem, _op in (('sqinc', '110000'), ('uqinc', '110001'),
                   ('sqdec', '110010'), ('uqdec', '110011')):
    for _t, _e, _sz in (('h', 'H', '01|01'), ('w', 'S', '10|10')):
        DB_FIXES[(f'{_stem}{_t} Zdn.D, {{#pattern}}, {{mul #imm}}',
                  f'00000100|{_sz}|imm:4|{_op}|pattern:5|Zdn')] = (
            f'{_stem}{_t} Zdn.{_e}, {{#pattern}}, {{mul #imm}}',
            f'00000100|{_sz[:2]}|10|imm:4|{_op}|pattern:5|Zdn')
# Element-size masks the database gets wrong: (row) -> the mask.
SIZE_FIXES = {
    'sqdmulh Zd.t, Zn.t, Zm.t': 'BHSD',
    'uaddv Dd, Pg, Zn.t': 'BHSD',
}

# Rows whose written immediate is not the raw field value (addg/subg #imm1 is
# the field scaled by 16), which a raw UImm form would encode wrongly, and the
# generic row of the SVE AND reduction, which EXTRA_FORMS gives per size.
EXCLUDED_ROWS = {
    'addg Xd|SP, Xn|SP, #imm1, #imm2',
    'subg Xd|SP, Xn|SP, #imm1, #imm2',
    'andv Vd, Pg, Zn.t',
}

# Forms the instruction database does not carry as rows.
# `bic (immediate)` assembles as `and Rd, Rn, #~imm`; the LogicalImmNot field
# encodes the complement at the operand width. `bics (immediate)` is not
# accepted by GNU as, so only `bic` is added.
# `ldxp` is the non-acquire load-exclusive pair, identical to the database's
# `ldaxp` with the acquire `o0` bit (15) cleared; it is the load half of the
# pre-LSE cmpxchg128 loop. Keyed as the catalog is:
# (mnemonic, ops-tuple) -> (base, fields, source-comment).
EXTRA_FORMS = {
    ('bic', ('W', 'W', 'Imm')): (0x12000000, [
        'Reg { op: 0, shift: 0 }', 'Reg { op: 1, shift: 5 }',
        'LogicalImmNot { op: 2, is64: false }'], 'bic Wd|WSP, Wn, #imm', 0x01),
    ('bic', ('X', 'X', 'Imm')): (0x92000000, [
        'Reg { op: 0, shift: 0 }', 'Reg { op: 1, shift: 5 }',
        'LogicalImmNot { op: 2, is64: true }'], 'bic Xd|SP, Xn, #imm', 0x01),
    ('ldxp', ('W', 'W', 'Mem')): (0x887F0000, [
        'Reg { op: 0, shift: 0 }', 'Reg { op: 1, shift: 10 }',
        'Reg { op: 2, shift: 5 }'], 'ldxp Wd, Wd2, [Xn|SP]', 0x04),
    ('ldxp', ('X', 'X', 'Mem')): (0xC87F0000, [
        'Reg { op: 0, shift: 0 }', 'Reg { op: 1, shift: 10 }',
        'Reg { op: 2, shift: 5 }'], 'ldxp Xd, Xd2, [Xn|SP]', 0x04),
}

# The SVE AND reduction, one row per element size (the database's generic
# `Vd` row is excluded above): ANDV <V><d>, <Pg>, <Zn>.<T>.
for _e in range(4):
    EXTRA_FORMS[('andv', (f'Fpr({_e})', 'P', f'Zs({_e})'))] = (
        0x041A2000 | _e << 22, ['Reg { op: 0, shift: 0 }', 'PLow { op: 1, shift: 10 }',
                                'Reg { op: 2, shift: 5 }'],
        f'andv {"BHSD"[_e]}d, Pg, Zn.{"BHSD"[_e]}', 0x00)

# The FEAT_LSUI unprivileged atomics, absent from the database. Operand layout
# is the LSE one -- Rs at 16, Rt at 0, base register at 5 -- so only the base
# words differ. Acquire is bit 23, release bit 22, the 64-bit width bit 30; the
# no-order 32-bit word of each read-modify-write stem is below. Base words taken
# from GNU as under `.arch armv9.6-a+lsui`. The family has no exclusive-or form:
# the assembler rejects `ldteor`.
LSE_RMW_FIELDS = ['Reg { op: 0, shift: 16 }', 'Reg { op: 1, shift: 0 }',
                  'Reg { op: 2, shift: 5 }']
LSUI_RMW = {'ldtadd': 0x19200400, 'ldtclr': 0x19201400,
            'ldtset': 0x19203400, 'swpt': 0x19208400}
LSUI_ORDER = {'': 0, 'a': 1 << 23, 'l': 1 << 22, 'al': (1 << 23) | (1 << 22)}
# The LSUI compare-and-swap forms are 64-bit only; GNU as rejects a W register
# pair, so there is no 32-bit row to derive.
LSUI_CAS = {'cast': 0xC9807C00, 'casat': 0xC9C07C00,
            'caslt': 0xC980FC00, 'casalt': 0xC9C0FC00}

for _stem, _base in LSUI_RMW.items():
    for _suffix, _order in LSUI_ORDER.items():
        for _w, _sf in (('W', 0), ('X', 1 << 30)):
            EXTRA_FORMS[(_stem + _suffix, (_w, _w, 'Mem'))] = (
                _base | _order | _sf, LSE_RMW_FIELDS,
                f'{_stem}{_suffix} {_w}s, {_w}d, [Xn|SP]', 0x04)
# The SVE contiguous loads and stores of one register, absent from the
# database (Arm ARM C8.2: LD1B..LD1D, LD1SB..LD1SW, ST1B..ST1D). The memory
# and element sizes pick the 4-bit dtype (msz:size for a store) at bit 21; the
# address is a base and a signed 4-bit offset in vector lengths at bit 16, or
# a base and an index scaled by the memory size. Base words measured from
# Apple clang 21.0.0's assembler.
SVE_LD1 = {
    'ld1b': {0: 0, 1: 1, 2: 2, 3: 3}, 'ld1sw': {3: 4}, 'ld1h': {1: 5, 2: 6, 3: 7},
    'ld1sh': {3: 8, 2: 9}, 'ld1w': {2: 10, 3: 11}, 'ld1sb': {3: 12, 2: 13, 1: 14},
    'ld1d': {3: 15}, 'st1b': {0: 0, 1: 1, 2: 2, 3: 3}, 'st1h': {1: 5, 2: 6, 3: 7},
    'st1w': {2: 10, 3: 11}, 'st1d': {3: 15},
}
for _m, _sizes in SVE_LD1.items():
    _st = _m.startswith('st')
    _msz = 'bhwd'.index(_m[-1])
    for _e, _dt in _sizes.items():
        _pg, _t = ('P', 'Pg') if _st else ('PgZ', 'Pg/Z')
        _src = f'{_m} {{Zt.{"BHSD"[_e]}}}, {_t}, '
        _regs = ['Reg { op: 0, shift: 0 }', 'PLow { op: 1, shift: 10 }']
        EXTRA_FORMS[(_m, (f'ZList(1, {_e})', _pg, 'MemVl'))] = (
            (0xE400E000 if _st else 0xA400A000) | _dt << 21,
            _regs + ['SveMemVl { op: 2, shift: 16, scale: 1 }'],
            _src + '[Xn|SP, #imm, mul vl]', 0x04)
        EXTRA_FORMS[(_m, (f'ZList(1, {_e})', _pg, 'MemReg'))] = (
            (0xE4004000 if _st else 0xA4004000) | _dt << 21,
            _regs + [f'SveMemReg {{ op: 2, msz: {_msz}, xzr: false }}'],
            _src + f'[Xn|SP, Xm, lsl #{_msz}]', 0x04)
        if _st:
            continue
        # The first-faulting loads take the scalar-plus-scalar address with
        # bits 15:13 011 and an index that may be xzr, absent from `[Xn]`;
        # the non-faulting ones the scalar-plus-immediate one with bit 20 set;
        # the replicating ones a 6-bit unsigned offset scaled by the memory
        # size, the dtype split across bits 24:23 and 14:13.
        _ff, _nf, _r = 'ldff1' + _m[3:], 'ldnf1' + _m[3:], 'ld1r' + _m[3:]
        EXTRA_FORMS[(_ff, (f'ZList(1, {_e})', _pg, 'MemReg'))] = (
            0xA4006000 | _dt << 21,
            _regs + [f'SveMemReg {{ op: 2, msz: {_msz}, xzr: true }}'],
            f'{_ff} {{Zt.{"BHSD"[_e]}}}, Pg/Z, [Xn|SP, Xm, lsl #{_msz}]', 0x04)
        EXTRA_FORMS[(_ff, (f'ZList(1, {_e})', _pg, 'Mem'))] = (
            0xA41F6000 | _dt << 21, _regs + ['Reg { op: 2, shift: 5 }'],
            f'{_ff} {{Zt.{"BHSD"[_e]}}}, Pg/Z, [Xn|SP]', 0x04)
        EXTRA_FORMS[(_nf, (f'ZList(1, {_e})', _pg, 'MemVl'))] = (
            0xA410A000 | _dt << 21, _regs + ['SveMemVl { op: 2, shift: 16, scale: 1 }'],
            f'{_nf} {{Zt.{"BHSD"[_e]}}}, Pg/Z, [Xn|SP, #imm, mul vl]', 0x04)
        EXTRA_FORMS[(_r, (f'ZList(1, {_e})', _pg, 'Mem'))] = (
            0x84408000 | (_dt >> 2) << 23 | (_dt & 3) << 13,
            _regs + ['Reg { op: 2, shift: 5 }',
                     f'ScaledUImm {{ op: 2, shift: 16, width: 6, scale: {1 << _msz} }}'],
            f'{_r} {{Zt.{"BHSD"[_e]}}}, Pg/Z, [Xn|SP, #imm]', 0x04)
# The SVE structure loads and stores of one to four registers: LDNT1, LD2
# to LD4, STNT1 and ST2 to ST4, of the memory size, at bit 23, and the
# register count less one at bit 21. The address is a base with a signed
# 4-bit offset in multiples of the count of vector lengths, or a base with
# an index shifted by the memory size. LD1RQ replicates a quadword: its
# offset is a signed 4-bit multiple of 16 bytes.
for _n in (1, 2, 3, 4):
    for _msz, _t in enumerate('bhwd'):
        for _st in (False, True):
            _m = ('st' if _st else 'ld') + ('nt1' if _n == 1 else str(_n)) + _t
            _sel = _msz << 23 | (_n - 1) << 21
            _key = (f'ZList({_n}, {_msz})', 'P' if _st else 'PgZ')
            _regs = ['Reg { op: 0, shift: 0 }', 'PLow { op: 1, shift: 10 }']
            _src = f'{_m} {{Zt.{"BHSD"[_msz]}, ..}}, Pg, '
            EXTRA_FORMS[(_m, _key + ('MemVl',))] = (
                (0xE410E000 if _st else 0xA400E000) | _sel,
                _regs + [f'SveMemVl {{ op: 2, shift: 16, scale: {_n} }}'],
                _src + '[Xn|SP, #imm, mul vl]', 0x04)
            EXTRA_FORMS[(_m, _key + ('MemReg',))] = (
                (0xE4006000 if _st else 0xA400C000) | _sel,
                _regs + [f'SveMemReg {{ op: 2, msz: {_msz}, xzr: false }}'],
                _src + f'[Xn|SP, Xm, lsl #{_msz}]', 0x04)
for _msz, _t in enumerate('bhwd'):
    _m = 'ld1rq' + _t
    _regs = ['Reg { op: 0, shift: 0 }', 'PLow { op: 1, shift: 10 }']
    EXTRA_FORMS[(_m, (f'ZList(1, {_msz})', 'PgZ', 'Mem'))] = (
        0xA4002000 | _msz << 23,
        _regs + ['Reg { op: 2, shift: 5 }',
                 'ScaledSImm { op: 2, shift: 16, width: 4, scale: 16 }'],
        f'{_m} {{Zt}}, Pg/Z, [Xn|SP, #imm]', 0x04)
    EXTRA_FORMS[(_m, (f'ZList(1, {_msz})', 'PgZ', 'MemReg'))] = (
        0xA4000000 | _msz << 23,
        _regs + [f'SveMemReg {{ op: 2, msz: {_msz}, xzr: false }}'],
        f'{_m} {{Zt}}, Pg/Z, [Xn|SP, Xm, lsl #{_msz}]', 0x04)
# The SVE gathers and scatters (Arm ARM C8.2 encoding classes): the memory
# size at bit 23, the unsigned (U) bit 14 and first-faulting (ff) bit 13 of a
# load. An address is a vector base with a 5-bit unsigned offset scaled by
# the memory size, or a scalar base and a vector index: 64-bit, unscaled or
# shifted by the memory size, or 32-bit, zero- or sign-extended (the xs bit,
# 22 in a load, 14 in a store) and unscaled or scaled. A doubleword element
# takes its index unpacked from the low half of each lane.
SVE_GATHER = {
    'b': (0, 1), 'sb': (0, 0), 'h': (1, 1), 'sh': (1, 0), 'w': (2, 1), 'sw': (2, 0), 'd': (3, 1),
}
for _sfx, (_msz, _u) in SVE_GATHER.items():
    for _e in (2, 3):
        if _msz > _e or (_e == 2 and _sfx in ('sw',)):
            continue
        _t = 'BHSD'[_e]
        _regs = ['Reg { op: 0, shift: 0 }', 'PLow { op: 1, shift: 10 }']
        _top = 0x84000000 if _e == 2 else 0xC4000000
        # (address kind, load bits, store bits)
        _kinds = [
            (f'ZMem({_e})', 0x00208000, 0x0060A000 if _e == 2 else 0x0040A000),
            (f'ZMemReg({_e}, 2)', 0x00000000, 0x00408000 if _e == 2 else 0x00008000),
        ]
        if _msz > 0:
            _kinds.append((f'ZMemReg({_e}, 3)', 0x00200000,
                           0x00608000 if _e == 2 else 0x00208000))
        if _e == 3:
            _kinds.append((f'ZMemReg({_e}, 0)', 0x00408000, 0x0000A000))
            if _msz > 0:
                _kinds.append((f'ZMemReg({_e}, 1)', 0x00608000, 0x0020A000))
        for _kind, _ld, _stb in _kinds:
            _field = (f'SveZMem {{ op: 2, msz: {_msz} }}' if _kind.startswith('ZMem(')
                      else f'SveZMemReg {{ op: 2, msz: {_msz}, xs: {{xs}} }}')
            for _ff in (0, 1):
                _m = ('ldff1' if _ff else 'ld1') + _sfx
                EXTRA_FORMS[(_m, (f'ZList(1, {_e})', 'PgZ', _kind))] = (
                    _top | _msz << 23 | _ld | _u << 14 | _ff << 13,
                    _regs + [_field.replace('{xs}', '22')],
                    f'{_m} {{Zt.{_t}}}, Pg/Z, [{_kind}]', 0x04)
            if _u and _sfx != 'sw':
                _m = 'st1' + _sfx
                EXTRA_FORMS[(_m, (f'ZList(1, {_e})', 'P', _kind))] = (
                    0xE4000000 | _msz << 23 | _stb,
                    _regs + [_field.replace('{xs}', '14')],
                    f'{_m} {{Zt.{_t}}}, Pg, [{_kind}]', 0x04)
for _mnem, _base in LSUI_CAS.items():
    EXTRA_FORMS[(_mnem, ('X', 'X', 'Mem'))] = (
        _base, LSE_RMW_FIELDS, f'{_mnem} Xs, Xd, [Xn|SP]', 0x04)

# Bare op-string tokens whose bit width is not written inline (widths verified
# by the 32-bit row-sum constraint in the design spike).
BARE = {'Rm': 5, 'Rn': 5, 'Rd': 5, 'Ra': 5, 'Rt': 5, 'Rt2': 5, 'Rs': 5,
        'Rs2': 5, 'Rd2': 5, 'Rdn': 5, 'cond': 4, 'nzcv': 4, 'CRm': 4, 'CRn': 4,
        'sop': 2, 'option': 3}

# The SVE rows' bare tokens: the GP ones plus the Z and P register fields and
# the two-bit element size.
SVE_BARE = dict(BARE, sz=2, **{f'Z{r}': 5 for r in ('d', 'n', 'm', 'a', 'da', 'dn', 't', 'k')},
                **{f'P{r}': 4 for r in ('d', 'n', 'm', 'g', 'dn', 'dm', 't')})

# The by-element fmul rows spell the destination Zd and encode it as Zda.
for _sz, _idx in (('H', '0|idx:1|1|idx:2|Zm:3'), ('S', '10|1|idx:2|Zm:3'),
                  ('D', '11|1|idx:1|Zm:4')):
    DB_FIXES[(f'fmul Zd.{_sz}, Zn.{_sz}, Zm.{_sz}[#idx]',
              f'01100100|{_idx}|001000|Zn|Zda')] = (
        None, f'01100100|{_idx}|001000|Zn|Zd')

# The SVE shifts by an immediate that move left; the rest move right.
SVE_LEFT_SHIFTS = {'lsl', 'sqshl', 'uqshl', 'sqshlu', 'sli'}

# The constant pairs an SVE one-bit floating-point immediate chooses between,
# as VFP imm8 codes (0.5 = 0x60, 1.0 = 0x70, 2.0 = 0x00); 0xFF is 0.0.
SVE_FP_PAIRS = {
    'FpHalfOrOneImm(immF)': (0x60, 0x70),
    'FpHalfOrTwoImm(immF)': (0x60, 0x00),
    'FpZeroOrOneImm(immF)': (0xFF, 0x70),
}

# An SVE register operand: the field name, an element-size suffix, and a
# governing predicate's qualifier.
SVE_REG = re.compile(
    r'([ZP](?:da|dn|dm|[dnmgatk]))(?:\.(ta|tb|t|[BHSDQ]))?(\[#idx\])?(/MZ|/M|/Z)?')

# Aliases that store the inverted written condition (al/nv invalid there).
COND_INV = {'cset', 'csetm', 'cinc', 'cinv', 'cneg'}


def split_ops(rest):
    """Split an operand list on top-level commas; a memory operand carries its
    own comma (`[Xn|SP, #offS]`), so commas inside brackets do not split."""
    out, depth, start = [], 0, 0
    for i, c in enumerate(rest):
        if c == '[':
            depth += 1
        elif c == ']':
            depth -= 1
        elif c == ',' and depth == 0:
            out.append(rest[start:i].strip())
            start = i + 1
    tail = rest[start:].strip()
    if tail:
        out.append(tail)
    return out


def parse_op(op, sve=False):
    """'10001011|sop:2|0|Rm|...' -> (base, {name:(width,shift)}, {name:[shift]})
    or None. A repeated field name (cinc-style Rn twice) is not expressible in
    the GP rows; an SVE row's repeats (the register an alias writes into two
    fields, `mov Zd.D, Zn.D` = `orr Zd.D, Zn.D, Zn.D`) land in the third map.
    An SVE bit group may name one-bit fields inline (`01000M001`)."""
    base, fields, pos, dups = 0, {}, 0, {}
    bare = SVE_BARE if sve else BARE

    def field(name, width):
        nonlocal pos
        if name in fields:
            if not sve:
                return False
            dups.setdefault(name, []).append((width, pos))
        else:
            fields[name] = (width, pos)
        pos += width
        return True
    for tok in reversed(op.split('|')):
        tok = tok.strip()
        if re.fullmatch(r'[01]+', tok):
            base |= int(tok, 2) << pos
            pos += len(tok)
        elif (m := re.fullmatch(r'(\w+):(\d+)', tok)):
            if not field(m.group(1), int(m.group(2))):
                return None
        elif tok in bare:
            if not field(tok, bare[tok]):
                return None
        elif sve and re.fullmatch(r'[01MX]+', tok):
            for c in reversed(tok):
                if c in '01':
                    base |= int(c) << pos
                    pos += 1
                elif not field(c, 1):
                    return None
        else:
            return None
    return (base & 0xFFFFFFFF, fields, dups) if pos == 32 else None


# Register operand suffix -> the encoding field it feeds. The bit position is
# read from each row's encoding string, not fixed: the same field lands at
# different bits across instructions (e.g. Rs at bit 0 in stlr, bit 16 in cas).
REG_FIELD = {'d': 'Rd', 'n': 'Rn', 'm': 'Rm', 'a': 'Ra', 's': 'Rs',
             't': 'Rt', 't2': 'Rt2', 'd2': 'Rd2', 's2': 'Rs2', 'dn': 'Rdn'}


def classify(heads, toks, op, im, scaled_wb=False, meta=None):
    """Map one row's written operands onto the field model.
    -> ('ok', ops, fields, base, sp) or ('residual', reason). `sp` is the
    bitmask of operand slots whose register field reads 31 as the stack
    pointer (the row's `|SP` / `|WSP` marks); 31 is the zero register
    everywhere else. `meta` marks an SVE row and carries its element sizes."""
    meta = meta or {}
    sve = meta.get('sve', False)
    if 'mov' in heads and not (sve and not (len(toks) > 1 and toks[1].startswith('#'))):
        # mov's row set is an alias family whose member choice depends on the
        # operand values (wide/inverted/bitmask immediate, SP form); selecting
        # among them is the encoder caller's job. The SVE register aliases
        # differ in their operand kinds.
        return ('residual', 'mov alias selection is value-dependent')
    p = parse_op(op, sve)
    if p is None:
        return ('residual', 'op not field-expressible (repeated or unknown token)')
    base, fl, dups = p
    consumed, ops, fields = set(), [], []
    logm = re.match(r'(?:LogicalImm|ImmLogical)\((\w+), ([01])\)', im or '')
    widem = re.match(r'ImmWide(?:Inv)?\((\w+), (\w+), ([01])\)', im or '')
    # `ImmBFM(immr, imms)` tags the base bfm/ubfm/sbfm, whose two immediates are
    # the raw immr/imms fields (unlike the ImmBFX/ImmBFIZ aliases, whose written
    # lsb/width are value-transformed and stay unexpressible).
    bfmm = re.match(r'ImmBFM\(', im or '')
    i, rd_width, width, sp = 0, None, None, 0
    t_ops, tb_ops = [], []
    # The element size an immediate encodes, for a row without an sz field,
    # and whether the indexed dup's quadword element is one of them.
    size_in_imm, dup_q = False, False
    while i < len(toks):
        t = toks[i]
        t0 = t.split('|')[0]
        if sve and (m := SVE_REG.fullmatch(t)):
            # A Z or P register: its field, the element size (`.t` the form's
            # sz, or fixed), and a governing predicate's /M, /Z or /MZ.
            kind, size, indexed, qual = m.group(1)[0], m.group(2), m.group(3), m.group(4)
            fname = m.group(1)
            fv = fl.get(fname)
            # An indexed vector's register field may be 3 or 4 bits wide.
            widths = (3, 4, 5) if indexed else (5,) if kind == 'Z' else (3, 4)
            if fv is None or fv[0] not in widths:
                return ('residual', f'register field {fname} not a register field')
            if fname in consumed:
                first = next(re.search(r'op: (\d+)', f).group(1) for f in fields
                             if f.startswith(('Reg', 'PLow'))
                             and f.endswith(f'shift: {fv[1]} }}'))
                fields.append(f'SameReg {{ op: {i}, first: {first} }}')
            elif kind == 'Z' and fv[0] < 5:
                consumed.add(fname)
                fields.append(f'ZLow {{ op: {i}, shift: {fv[1]}, width: {fv[0]} }}')
            else:
                consumed.add(fname)
                reg = 'PLow' if fv[0] == 3 else 'Reg'
                fields.append(f'{reg} {{ op: {i}, shift: {fv[1]} }}')
                if any(w != fv[0] for w, _ in dups.get(fname, ())):
                    return ('residual', f'register field {fname} split')
                fields += [f'Reg {{ op: {i}, shift: {d} }}' for _, d in dups.get(fname, ())]
            if indexed:
                # The element index: `idx` in one or two fields, or the
                # imm2:tsz of the indexed dup, which also encodes the size.
                if im.startswith('SveDupImm') and size == 't':
                    if fl.get('imm', (0,))[0] != 5 or [w for w, _ in dups.get('imm', ())] != [2]:
                        return ('residual', 'indexed dup not imm5 + imm2')
                    consumed.add('imm')
                    fields.append(f'SveDupIndex {{ op: {i}, lo: {fl["imm"][1]}, '
                                  f'hi: {dups["imm"][0][1]} }}')
                    size_in_imm, dup_q = True, True
                elif 'idx' in fl and size not in (None, 't', 'ta', 'tb'):
                    consumed.add('idx')
                    lo_w, lo = fl['idx']
                    hi_w, hi = dups['idx'][0] if 'idx' in dups else (0, 0)
                    if len(dups.get('idx', ())) > 1:
                        return ('residual', 'index in three fields')
                    fields.append(f'SveIndex {{ op: {i}, lo: {lo}, lo_w: {lo_w}, '
                                  f'hi: {hi}, hi_w: {hi_w} }}')
                else:
                    return ('residual', 'index without an index field')
                if size == 't':
                    ops.append('ZtElem')
                    t_ops.append(i)
                else:
                    ops.append(f'ZElem({"BHSDQ".index(size)})')
                i += 1
                continue
            if qual:
                if size:
                    return ('residual', 'qualified predicate with an element size')
                ops.append({'/M': 'PgM', '/Z': 'PgZ', '/MZ': 'PgMZ'}[qual])
                if qual == '/MZ':
                    if fl.get('M', (0,))[0] != 1:
                        return ('residual', '/MZ without an M bit')
                    consumed.add('M')
                    fields.append(f'PredMerge {{ op: {i}, shift: {fl["M"][1]} }}')
            elif size in ('t', 'ta', 'tb'):
                # A widening form's `.ta` and `.tb` sizes move together.
                ops.append(kind + 't')
                (tb_ops if size == 'tb' else t_ops).append(i)
            elif size:
                ops.append(f'{kind}s({"BHSDQ".index(size)})')
            else:
                ops.append(kind)
            i += 1
            continue
        if sve and (m := re.fullmatch(r'([BHSD])([dnm])', t)):
            # A scalar SIMD&FP register (the reductions' destination).
            fname = REG_FIELD[m.group(2)]
            fv = fl.get(fname)
            if fv is None or fv[0] != 5 or fname in consumed:
                return ('residual', f'scalar register field {fname} not a 5-bit field')
            consumed.add(fname)
            ops.append(f'Fpr({"BHSD".index(m.group(1))})')
            fields.append(f'Reg {{ op: {i}, shift: {fv[1]} }}')
            i += 1
            continue
        if sve and t == '#imm' and im.startswith('SveShiftImm7') and t_ops:
            # tsz:imm3, the high two bits apart: the element size and the
            # shift, `2 * esize - shift` right, `esize + shift` left.
            if fl.get('imm', (0,))[0] != 5 or [w for w, _ in dups.get('imm', ())] != [2]:
                return ('residual', 'shift immediate not imm5 + imm2')
            consumed.add('imm')
            ops.append('Imm')
            left = 'true' if heads[0] in SVE_LEFT_SHIFTS else 'false'
            fields.append(f'SveShiftImm {{ op: {i}, zop: {t_ops[0]}, left: {left}, '
                          f'lo: {fl["imm"][1]}, hi: {dups["imm"][0][1]} }}')
            size_in_imm = True
            i += 1
            continue
        if sve and t == '#imm' and im.startswith(('SveLogicalImm', 'SveDupmImm')) and t_ops:
            # N:immr:imms of the value replicated across the element size.
            if fl.get('imm') != (13, 5):
                return ('residual', 'logical immediate not imm13@5')
            consumed.add('imm')
            ops.append('Imm')
            invert = 'true' if im.startswith('SveLogicalImm(imm, 1') else 'false'
            fields.append(f'SveLogicalImm {{ op: {i}, zop: {t_ops[0]}, invert: {invert} }}')
            size_in_imm = True
            i += 1
            continue
        if sve and t == '#immF' and im in SVE_FP_PAIRS:
            # One bit choosing between two constants.
            if fl.get('imm', (0,))[0] != 1:
                return ('residual', 'floating-point pair not a one-bit field')
            consumed.add('imm')
            ops.append('FImm')
            zero, one = SVE_FP_PAIRS[im]
            fields.append(f'SveFpPair {{ op: {i}, shift: {fl["imm"][1]}, '
                          f'zero: 0x{zero:02X}, one: 0x{one:02X} }}')
            i += 1
            continue
        if sve and t == '#immVFP' and im.startswith('VecVFPImm'):
            if fl.get('imm') != (8, 5):
                return ('residual', 'VFP immediate not imm8@5')
            consumed.add('imm')
            ops.append('FImm8')
            fields.append(f'VfpImm8 {{ op: {i}, shift: 5 }}')
            i += 1
            continue
        if sve and t == '#zero':
            ops.append('Zero')
            i += 1
            continue
        if sve and (m := re.fullmatch(r'#(\w+)', t)) and i + 1 < len(toks) \
                and toks[i + 1] == '{lsl #n}':
            # The SVE 8-bit immediate with an optional `lsl #8`; signed in
            # dup and cpy, unsigned in the add/sub family.
            if fl.get(m.group(1)) != (8, 5) or fl.get('n') != (1, 13) or not t_ops:
                return ('residual', 'SVE imm8 fields not imm8@5 + n1@13')
            consumed.update((m.group(1), 'n'))
            ops += ['Imm', 'OptLsl']
            signed = 'true' if heads[0] in ('dup', 'cpy', 'mov', 'fmov') else 'false'
            fields.append(f'SveImm8 {{ op: {i}, shift_op: {i + 1}, signed: {signed}, '
                          f'zop: {t_ops[0]} }}')
            i += 2
            continue
        if (m := re.fullmatch(r'([XW])(d2|s2|t2|dn|[dnmast])(\|W?SP)?', t)):
            # A register operand feeds a named 5-bit field; its bit position is
            # read from the encoding, so any operand order is expressible.
            w, fname = m.group(1), REG_FIELD[m.group(2)]
            fv = fl.get(fname)
            if fv is None or fv[0] != 5:
                return ('residual', f'register field {fname} not a 5-bit field')
            ops.append(w)
            if fname in consumed:
                # A second spelling of a register already written (the signed
                # saturating `Xdn, Wdn` pair) names the same register.
                first = next(re.search(r'op: (\d+)', f).group(1) for f in fields
                             if f.endswith(f'shift: {fv[1]} }}') and f.startswith('Reg'))
                fields.append(f'SameReg {{ op: {i}, first: {first} }}')
                i += 1
                continue
            consumed.add(fname)
            fields.append(f'Reg {{ op: {i}, shift: {fv[1]} }}')
            if m.group(3):
                sp |= 1 << i
            if m.group(2) == 'd':
                rd_width = w
            width = width or w
            i += 1
            continue
        if t == 'Rm':
            # The extended-register second source: its width follows the
            # written extend (W for the byte/halfword/word extends, X for
            # uxtx/sxtx), so the slot takes either.
            fv = fl.get('Rm')
            if fv is None or fv[0] != 5:
                return ('residual', 'register field Rm not a 5-bit field')
            consumed.add('Rm')
            ops.append('RegAny')
            fields.append(f'Reg {{ op: {i}, shift: {fv[1]} }}')
            i += 1
            continue
        if (mm := re.fullmatch(
                r'\[Xn(\|SP)?(?:, #(\w+)(?:\*(\d+))?)?\]([!@]?)', t)):
            # A memory reference: the base feeds Rn, an optional immediate
            # offset feeds its named field. `#offS` is a two's-complement
            # offset, `#offZ` unsigned; a `*N` multiplier scales the written
            # byte offset. A `!` suffix is the pre-index writeback form; `@`
            # the post-index form, whose offset is a trailing written operand.
            fv = fl.get('Rn')
            if fv is None or fv[0] != 5:
                return ('residual', 'memory base field Rn not a 5-bit field')
            mode = mm.group(4)
            consumed.add('Rn')
            ops.append('MemPre' if mode == '!' else 'Mem')
            fields.append(f'Reg {{ op: {i}, shift: {fv[1]} }}')
            if mm.group(1):
                sp |= 1 << i
            offname = mm.group(2)
            if mode and offname is None:
                return ('residual', 'writeback form without an offset field')
            if mode == '@' and i != len(toks) - 1:
                return ('residual', 'post-index memory operand not last')
            if offname is not None:
                ov = fl.get(offname)
                if ov is None:
                    return ('residual', f'memory offset #{offname} has no field')
                consumed.add(offname)
                scale = int(mm.group(3) or 1)
                if mode and not scaled_wb:
                    # The one-row-per-mode pre/post loads write the offset
                    # with the access-size multiplier, but the imm9 field
                    # holds the raw byte offset (assembler-verified). The
                    # `{@}{!}`-expanded pair/tag rows scale in every mode.
                    scale = 1
                opi = i + 1 if mode == '@' else i
                signed = offname.endswith('S')
                if scale > 1:
                    kind = 'ScaledSImm' if signed else 'ScaledUImm'
                    fields.append(
                        f'{kind} {{ op: {opi}, shift: {ov[1]}, '
                        f'width: {ov[0]}, scale: {scale} }}')
                else:
                    kind = 'SImm' if signed else 'UImm'
                    fields.append(
                        f'{kind} {{ op: {opi}, shift: {ov[1]}, width: {ov[0]} }}')
            if mode == '@':
                ops.append('Imm')
                i += 1
            i += 1
            continue
        if (mr := re.fullmatch(r'\[Xn(\|SP)?, Rm, '
                               r'\{uxtw\|lsl\|sxtw\|sxtx #n(?:\*\d+)?\}\]', t)):
            # A register-offset memory reference: Rm/option/S at the class
            # positions; the S bit's valid shift amount is the access-size
            # log2, which this encoding class carries in bits 31:30.
            sname = 's' if 's' in fl else 'n'
            if (fl.get('Rn') != (5, 5) or fl.get('Rm') != (5, 16)
                    or fl.get('option') != (3, 13) or fl.get(sname) != (1, 12)):
                return ('residual', 'register-offset fields not at the class positions')
            consumed.update(('Rn', 'Rm', 'option', sname))
            ops.append('MemReg')
            fields.append(f'Reg {{ op: {i}, shift: 5 }}')
            fields.append(f'MemRegIdx {{ op: {i}, sl2: {(base >> 30) & 3} }}')
            if mr.group(1):
                sp |= 1 << i
            i += 1
            continue
        if t0 == '#sysreg':
            return ('residual', 'system-register operand (bespoke mrs/msr path)')
        if t0 == '#cond':
            if fl.get('cond') != (4, 12):
                return ('residual', 'cond field not at bit 12')
            consumed.add('cond')
            ops.append('A64Op::Cond')
            inv = 'true' if heads[0] in COND_INV else 'false'
            fields.append(f'Field::Cond {{ op: {i}, inv: {inv} }}')
            i += 1
            continue
        if logm and t0 == '#' + logm.group(1):
            # The 13-bit N:immr:imms field at 10; its name may differ from the
            # encoder's argument name (orr's `#log_imm` fills `imm`).
            fname = next((n for n, v in fl.items() if v == (13, 10)), None)
            if fname is None:
                return ('residual', 'logical-imm field not 13 bits at 10')
            consumed.add(fname)
            ops.append('Imm')
            is64 = 'true' if logm.group(2) == '1' else 'false'
            fields.append(f'LogicalImm {{ op: {i}, is64: {is64} }}')
            i += 1
            continue
        if widem and t0 == '#' + widem.group(1):
            if fl.get(widem.group(1)) != (16, 5) or fl.get('hw') != (2, 21):
                return ('residual', 'move-wide fields not imm16@5 + hw2@21')
            if i + 1 >= len(toks) or not toks[i + 1].startswith('{lsl'):
                return ('residual', 'move-wide without a lsl group')
            consumed.update((widem.group(1), 'hw'))
            ops += ['Imm', 'OptLsl']
            fields += [f'MovImm {{ op: {i} }}', f'MovHw {{ op: {i + 1} }}']
            i += 2
            continue
        if t0 == '#n' and not im:
            # ubfm/sbfm shift aliases: both immr+imms computed = lsl; immr
            # with imms baked = lsr/asr.
            if fl.get('immr') == (6, 16) and fl.get('imms') == (6, 10):
                consumed.update(('immr', 'imms'))
                ops.append('Imm')
                is64 = 'true' if rd_width == 'X' else 'false'
                fields.append(f'LslAlias {{ op: {i}, is64: {is64} }}')
                i += 1
                continue
            if fl.get('immr') == (6, 16) and 'imms' not in fl:
                consumed.add('immr')
                ops.append('Imm')
                fields.append(f'ShrAlias {{ op: {i} }}')
                i += 1
                continue
            return ('residual', 'shift-alias fields not immr/imms shaped')
        # The add/sub-immediate value group: a 12-bit field plus the `sh` bit
        # selecting a left shift of 12. One field, because without a written
        # shift the encoder picks it from the value.
        if (m := re.fullmatch(r'#(\w+)', t0)) and i + 1 < len(toks) \
                and toks[i + 1] == '{lsl #n=0|12}':
            if fl.get(m.group(1)) != (12, 10) or fl.get('n') != (1, 22):
                return ('residual', 'add/sub-imm fields not imm12@10 + n1@22')
            consumed.update((m.group(1), 'n'))
            ops += ['Imm', 'OptLsl']
            fields.append(f'AddSubImm {{ op: {i}, shift_op: {i + 1} }}')
            i += 2
            continue
        # ImmPRF tags prfm's prefetch-op slot, a raw 5-bit code.
        if (m := re.fullmatch(r'#(\w+)', t0)) and (
                not im or bfmm or im.startswith('ImmPRF')) and t0 != '#pattern':
            name = m.group(1)
            if name not in fl:
                return ('residual', f'immediate token {t0} has no matching field')
            w, pos = fl[name]
            consumed.add(name)
            ops.append('Imm')
            # Trailing-S names (immS) are two's-complement signed; the rest
            # are raw unsigned fields.
            # An SVE row's `immSa` / `immSb` pair is signed as well.
            kind = 'SImm' if re.fullmatch(r'\w*S[ab]?', name) else 'UImm'
            if name in dups:
                # A field split in two: the part nearer bit 0 is the low one.
                if kind == 'SImm' or len(dups[name]) != 1:
                    return ('residual', f'split immediate {t0}')
                hw, hpos = dups[name][0]
                fields.append(f'SplitImm {{ op: {i}, lo: {pos}, lo_w: {w}, hi: {hpos}, hi_w: {hw} }}')
            else:
                fields.append(f'{kind} {{ op: {i}, shift: {pos}, width: {w} }}')
            i += 1
            continue
        if (im.startswith('SvePatternImm') or sve) and t in ('{#pattern}', '{mul #imm}'):
            # The SVE element count: an optional predicate-constraint pattern
            # (absent = ALL) and an optional multiplier (absent = 1) behind it.
            name, width, kind, slot = (('pattern', 5, 'SvePattern', 'OptPattern')
                                       if t == '{#pattern}' else
                                       ('imm', 4, 'SveMul', 'OptMul'))
            fv = fl.get(name)
            if fv is None or fv[0] != width:
                return ('residual', f'SVE {name} field not {width} bits')
            consumed.add(name)
            ops.append(slot)
            fields.append(f'{kind} {{ op: {i}, shift: {fv[1]} }}')
            i += 1
            continue
        if t.startswith('{'):
            # The register-operand shift and extend groups are optional written
            # operands: `sop`/`n` for the shifted-register forms, `option`/`n`
            # for the extended-register ones. An absent shift is LSL #0 (the
            # zero encoding); an absent extend is UXTX/UXTW #0, which is not.
            if t == '{sop #n}' or t.startswith('{lsl|lsr|asr'):
                if fl.get('sop') != (2, 22) or fl.get('n') != (6, 10):
                    return ('residual', 'shift group fields not sop2@22 + n6@10')
                consumed.update(('sop', 'n'))
                ops.append('OptShift')
                ror = 'true' if t == '{sop #n}' else 'false'
                is64 = 'true' if width == 'X' else 'false'
                fields.append(f'Shift {{ op: {i}, is64: {is64}, ror: {ror} }}')
                i += 1
                continue
            if t == '{extend #n}':
                if fl.get('option') != (3, 13) or fl.get('n') != (3, 10):
                    return ('residual', 'extend group fields not option3@13 + n3@10')
                if i == 0 or ops[i - 1] not in ('W', 'RegAny'):
                    return ('residual', 'extend group does not follow its register')
                consumed.update(('option', 'n'))
                ops.append('OptExt')
                is64 = 'true' if width == 'X' else 'false'
                fields.append(f'Extend {{ op: {i}, rm: {i - 1}, is64: {is64} }}')
                i += 1
                continue
            # Optional shift groups whose absent form is all-zero field bits
            # are dropped; extend/index groups are not (their default is not
            # the zero encoding).
            if re.match(r'\{(lsl|sop)[ |]', t) or t.startswith('{lsl|lsr|asr'):
                i += 1
                continue
            return ('residual', f'group {t} not droppable')
        return ('residual', f'operand token {t}')
    if 'sz' in fl and sve:
        # The element size: per sz value, the size of the `.t` (or `.ta`)
        # operands and of the `.tb` ones, as the row's masks list them.
        amask = meta.get('ta') if tb_ops else meta.get('t')
        bmask = meta.get('tb') or '~~~~' if tb_ops else 'BBBB'
        amask = amask or ('BHSD' if not tb_ops else None)
        if fl['sz'][0] != 2 or not t_ops or amask is None or (
                any('.t,' in t + ',' for t in toks) and any('.ta' in t for t in toks)):
            return ('residual', 'element sizes not an sz field')
        consumed.add('sz')
        sizes = ['0xFF' if '~' in (ca, cb) else
                 f'0x{"BHSDQ".index(cb) << 4 | "BHSDQ".index(ca):02X}'
                 for ca, cb in zip(amask, bmask)]
        fields.append(f'SveSize {{ a: 0b{sum(1 << k for k in t_ops):b}, '
                      f'b: 0b{sum(1 << k for k in tb_ops):b}, shift: {fl["sz"][1]}, '
                      f'sizes: [{", ".join(sizes)}] }}')
    elif size_in_imm and not tb_ops:
        # The immediate encodes the size: the `.t` operands agree on it.
        mask = meta.get('t') or ('BHSDQ' if dup_q else 'BHSD')
        fields.append(f'SveSizeAgree {{ a: 0b{sum(1 << k for k in t_ops):b}, '
                      f'sizes: 0b{sum(1 << k for k, c in enumerate(mask) if c != "~"):04b} }}')
    elif t_ops or tb_ops:
        return ('residual', 'a .t operand without an sz field')
    left = set(fl) - consumed - {'n', 'sop'}
    if left:
        return ('residual', 'unmapped fields: ' + ','.join(sorted(left)))
    return ('ok', ops, fields, base, sp)


def expand_wb(inst, op):
    """A `]{@}{!}` row covers the offset, pre-, and post-index modes in one
    entry, with the mode in the `!post` / `W` encoding tokens; concretize each
    mode. Unlike the one-row-per-mode loads, these rows (the pairs and the tag
    stores) scale the written offset in every mode -> scaled_wb."""
    if '{@}{!}' not in inst:
        yield inst, op, False
        return
    for suffix, post, w in (('', '1', '0'), ('!', '1', '1'), ('@', '0', '1')):
        yield (inst.replace('{@}{!}', suffix),
               op.replace('!post', post).replace('|W|', f'|{w}|'), True)


def expand_width(inst, op):
    """An SVE `Rn, Rm` row takes both register widths, selected by the `X`
    bit of its encoding (whilelt and the other while forms); concretize each."""
    if 'Rn, Rm' not in inst or 'X' not in op.replace('X|', ''):
        yield inst, op
        return
    for w, bit in (('W', '0'), ('X', '1')):
        yield (inst.replace('Rn, Rm', f'{w}n, {w}m'),
               '|'.join(re.sub('X', bit, t) if re.fullmatch(r'[01X]+', t) else t
                        for t in op.split('|')))


def fix_long_indexed(inst, op):
    """The SVE2 widening by-element forms as the architecture has them: a
    doubleword result from word elements takes a 1+1-bit index and z0 to z15
    (the database gives it the 2+1-bit index and z0 to z7 of the word
    result), and sqdmullb/sqdmullt read elements of half the result's size."""
    if re.search(r'\.D, Zn\.S, Zm\.S\[#idx\]', inst):
        op = op.replace('|11|1|idx:2|Zm:3|', '|11|1|idx:1|Zm:4|')
    if inst.startswith(('sqdmullb ', 'sqdmullt ')):
        inst = (inst.replace('Zd.S, Zn.S, Zm.S', 'Zd.S, Zn.H, Zm.H')
                .replace('Zd.D, Zn.D, Zm.D', 'Zd.D, Zn.S, Zm.S'))
    return inst, op


def load_rows(db):
    rows = []
    for g in json.load(open(db))['instructions']:
        gp = 'GP' in g['category']
        if not gp and not g['category'].startswith('SVE'):
            continue
        for it in g['data']:
            inst, op = it['inst'], it['op']
            # The vector-length and element-count rows read the GP model.
            sve = not gp and not SVE_SCALAR_ROW(inst)
            meta = {'sve': sve, 't': SIZE_FIXES.get(inst) or it.get('t') or it.get('T'),
                    'ta': it.get('ta'), 'tb': it.get('tb')}
            if inst in EXCLUDED_ROWS or UNDEFINED_ROW(inst):
                continue
            fi, fo = DB_FIXES.get((inst, op), (None, None))
            fi, fo = fix_long_indexed(fi or inst, fo or op)
            for winst, wop in expand_width(fi, fo):
                for einst, eop, scaled_wb in expand_wb(winst, wop):
                    rows.append((einst, eop, it.get('imm', ''), scaled_wb, meta))
    return rows


def catalog(rows, residuals=None):
    """Classify every row; -> {(mnemonic, ops-tuple): (base, fields, inst, sp)}."""
    forms = {}
    for inst, op, im, scaled_wb, meta in rows:
        headpart, _, rest = inst.partition(' ')
        toks = tuple(split_ops(rest)) if rest else ()
        heads = headpart.split('|')
        r = classify(heads, toks, op, im, scaled_wb, meta)
        if r[0] == 'residual':
            if residuals is not None:
                sig = ' '.join(t.split('|')[0] if not t.startswith('{') else t
                               for t in toks) or '(no operands)'
                residuals[(sig, r[1])].append(inst)
            continue
        _, ops, fields, base, sp = r
        for head in heads:
            # A row names every alias spelling (`asr|asrv`); each gets a form.
            # Keep the first row per (mnemonic, operand pattern).
            forms.setdefault((head, tuple(ops)), (base, fields, inst, sp))
    return forms


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--db', required=True)
    ap.add_argument('--out', required=True)
    ap.add_argument('--residuals', action='store_true',
                    help='print the ranked unexpressed-row classes')
    a = ap.parse_args()
    rows = load_rows(a.db)
    residuals = collections.defaultdict(list)
    forms = catalog(rows, residuals)
    for key, val in EXTRA_FORMS.items():
        forms.setdefault(key, val)
    # Sort by mnemonic so the consumer can binary-search the catalog; stable
    # to keep each mnemonic's rows in database order.
    out = sorted(forms.items(), key=lambda kv: kv[0][0])
    lines = [
        '// @generated by tools/gen_isa_a64.py from an external instruction-set',
        '// database. Do not edit by hand; re-run the generator to update.',
        '//',
        '// The A64 GP and SVE catalog interpreted by `super::table::encode`:',
        '// every database row whose written-operand signature maps onto the',
        '// field model. Some database rows are corrected and some dropped',
        '// before parsing (see tools/gen_isa_a64.py DB_FIXES / EXCLUDED_ROWS).',
        '',
        'use super::table::{A64Op, A64Op::*, Field, Field::*, Form};',
        '',
        '#[rustfmt::skip]',
        'pub(crate) static FORMS: &[Form] = &[',
    ]
    for (mnem, ops), (base, fields, src, sp) in out:
        lines.append(
            f'    Form {{ mnemonic: "{mnem}", ops: &[{", ".join(ops)}], '
            f'base: 0x{base:08X}, sp: 0x{sp:02X}, '
            f'fields: &[{", ".join(fields)}] }},  // {src}')
    lines.append('];')
    lines.append('')
    open(a.out, 'w').write('\n'.join(lines))
    nres = sum(len(v) for v in residuals.values())
    print(f'wrote {len(out)} A64 forms to {a.out} '
          f'({nres} rows not expressible in the field model)', file=sys.stderr)
    if a.residuals:
        ranked = sorted(residuals.items(), key=lambda kv: -len(kv[1]))
        print('\nresidual classes (signature | reason | rows | example):',
              file=sys.stderr)
        for (sig, reason), insts in ranked:
            print(f'{len(insts):4d}  {sig}  -- {reason}  e.g. `{insts[0]}`',
                  file=sys.stderr)


if __name__ == '__main__':
    main()
