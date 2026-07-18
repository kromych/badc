#!/usr/bin/env python3
"""Generate the badc AArch64 encoder catalogue from an instruction-set database.

Reads a machine-readable A64 database (the asmjit `db/isa_aarch64.json` schema)
and emits `src/c5/codegen/aarch64/isa_a64_table.rs`: a `Form` per instruction
row as a base word plus the field list `super::table::encode` splices operands
into. The base words -- the encoding facts -- come from the database; the
operand-to-field mapping is architectural regularity supplied per
instruction class below.

A differential sweep proved four shipped database rows disagree with the
architecture (cbz carrying cbnz's opcode, ret and dsb wrong bits); those are
corrected in DB_FIXES before parsing. This is why the encoder is derived, not
copied: the database is a strong starting point, not ground truth.

Usage:
    tools/gen_isa_a64.py --db /path/to/db/isa_aarch64.json \
        --out src/c5/codegen/aarch64/isa_a64_table.rs
"""
import argparse, json, re, sys

# Rows whose literal bits disagree with the architecture (verified vs the
# assembler): (inst, op-as-shipped) -> corrected op.
DB_FIXES = {
    ("cbz Wn, #relS*4", "00110101|relS:19|Rn"): "00110100|relS:19|Rn",
    ("cbz Xn, #relS*4", "10110101|relS:19|Rn"): "10110100|relS:19|Rn",
    ("ret Xn", "11010100|010|11111|0|00000|Rn|00000"):
        "11010110|010|11111|0|00000|Rn|00000",
    ("dsb #barrier_op", "11010101|000|00|011|0011|CRm|101|11111"):
        "11010101|000|00|011|0011|CRm|100|11111",
}

# Bare op-string tokens whose bit width is not written inline (widths verified
# by the 32-bit row-sum constraint in the design spike).
BARE = {'Rm': 5, 'Rn': 5, 'Rd': 5, 'Ra': 5, 'Rt': 5, 'Rt2': 5, 'Rs': 5,
        'Rd2': 5, 'cond': 4, 'CRm': 4, 'CRn': 4, 'sop': 2, 'option': 3}


def parse_op(op):
    """'10001011|sop:2|0|Rm|...' -> (base, {name:(width,shift)}) or None."""
    base, fields, pos = 0, {}, 0
    for tok in reversed(op.split('|')):
        tok = tok.strip()
        if re.fullmatch(r'[01]+', tok):
            base |= int(tok, 2) << pos
            pos += len(tok)
        elif (m := re.fullmatch(r'(\w+):(\d+)', tok)):
            fields[m.group(1)] = (int(m.group(2)), pos)
            pos += int(m.group(2))
        elif tok in BARE:
            fields[tok] = (BARE[tok], pos)
            pos += BARE[tok]
        else:
            return None
    return (base & 0xFFFFFFFF, fields) if pos == 32 else None


def load_rows(db):
    rows = []
    for g in json.load(open(db))['instructions']:
        if 'GP' not in g['category']:
            continue
        for it in g['data']:
            op = DB_FIXES.get((it['inst'], it['op']), it['op'])
            rows.append((it['inst'], op, it.get('imm', '')))
    return rows


def row_for(rows, mnem, want, pred):
    """Find the parseable row for `mnem` whose destination is a `want` ('X'/'W')
    register and whose signature satisfies `pred`."""
    dpref = 'Xd' if want == 'X' else 'Wd'
    for inst, op, im in rows:
        head, _, rest = inst.partition(' ')
        if head != mnem or not rest.startswith(dpref):
            continue
        if pred(inst, im) and parse_op(op):
            return parse_op(op), inst, im
    return None


# Recipes drive per-instruction-class operand->field mapping; the base word
# (the encoding fact) is taken from the matched database row.
def recipes(rows):
    out = []

    def add(mnem, want, base, ops, fields, src):
        out.append((mnem, base, ops, fields, src))

    # Shifted-register data-processing, shift 0 (plain reg,reg,reg): a `, Xm`/
    # `, Wm` second source and a shift group, not the extend form.
    def is_reg3(inst, im):
        return (', Xm,' in inst or ', Wm,' in inst) and '{extend' not in inst
    for mnem in ('add', 'sub', 'adds', 'subs', 'and', 'orr', 'eor', 'ands',
                 'bic', 'orn', 'eon'):
        for want in ('X', 'W'):
            r = row_for(rows, mnem, want, is_reg3)
            if r:
                (base, _), inst, _ = r
                add(mnem, want, base, f'&[{want}, {want}, {want}]', '&[Rd, Rn, Rm]', inst)

    # add/sub immediate (unshifted 12-bit): `#immZ` third operand.
    def is_addimm(inst, im):
        return '#immZ' in inst
    for mnem in ('add', 'sub', 'adds', 'subs'):
        for want in ('X', 'W'):
            r = row_for(rows, mnem, want, is_addimm)
            if r:
                (base, fields), inst, _ = r
                w, sh = fields['immZ']
                add(mnem, want, base, f'&[{want}, {want}, Imm]',
                    f'&[Rd, Rn, UImm {{ op: 2, shift: {sh}, width: {w} }}]', inst)

    # logical immediate (bitmask): a `#imm`/`#log_imm` third operand annotated
    # LogicalImm (the db names the slot `#imm` for some mnemonics, `#log_imm`
    # for others).
    def is_logimm(inst, im):
        # The database names the bitmask-immediate encoder both `LogicalImm`
        # (and/eor/ands) and `ImmLogical` (orr) -- same encoding.
        return 'LogicalImm' in im or 'ImmLogical' in im
    for mnem in ('and', 'orr', 'eor', 'ands'):
        for want, is64 in (('X', 'true'), ('W', 'false')):
            r = row_for(rows, mnem, want, is_logimm)
            if r:
                (base, _), inst, _ = r
                add(mnem, want, base, f'&[{want}, {want}, Imm]',
                    f'&[Rd, Rn, LogicalImm {{ op: 2, is64: {is64} }}]', inst)

    # move wide: `#imm` + optional `{lsl #n}`.
    def is_movwide(inst, im):
        return '#imm, {lsl' in inst
    for mnem in ('movz', 'movk', 'movn'):
        for want in ('X', 'W'):
            r = row_for(rows, mnem, want, is_movwide)
            if r:
                (base, _), inst, _ = r
                add(mnem, want, base, f'&[{want}, Imm, OptLsl]',
                    '&[Rd, MovImm { op: 1 }, MovHw { op: 2 }]', inst)

    # lsl / lsr / asr by immediate (ubfm/sbfm aliases): `#n` shift amount.
    def is_shift(inst, im):
        return inst.endswith('#n') and ', Xn,' in inst.replace('Wn', 'Xn')
    for mnem, kind in (('lsl', 'lsl'), ('lsr', 'shr'), ('asr', 'shr')):
        for want, is64 in (('X', 'true'), ('W', 'false')):
            r = row_for(rows, mnem, want, is_shift)
            if r:
                (base, _), inst, _ = r
                field = (f'LslAlias {{ op: 2, is64: {is64} }}' if kind == 'lsl'
                         else 'ShrAlias { op: 2 }')
                add(mnem, want, base, f'&[{want}, {want}, Imm]',
                    f'&[Rd, Rn, {field}]', inst)

    # data-processing reg, reg, reg (2-source divide, 3-source multiply with the
    # accumulator fixed to the zero register): a plain third register source,
    # no shift group. smulh/umulh are 64-bit only; smull/umull mix widths and
    # are handled elsewhere.
    def is_reg3_plain(inst, im):
        return (inst.endswith('Xm') or inst.endswith('Wm')) and '{' not in inst
    for mnem in ('mul', 'mneg', 'sdiv', 'udiv', 'smulh', 'umulh'):
        for want in ('X', 'W'):
            r = row_for(rows, mnem, want, is_reg3_plain)
            if r:
                (base, _), inst, _ = r
                add(mnem, want, base, f'&[{want}, {want}, {want}]',
                    '&[Rd, Rn, Rm]', inst)

    # data-processing reg, reg (bit-count, bit-reverse, byte-reverse): a single
    # register source. rev is 32-bit only and rev32 64-bit only; row_for skips
    # the width a mnemonic lacks.
    def is_reg2(inst, im):
        return (inst.endswith('Xn') or inst.endswith('Wn')) and inst.count(',') == 1
    for mnem in ('cls', 'clz', 'rbit', 'rev', 'rev16', 'rev32'):
        for want in ('X', 'W'):
            r = row_for(rows, mnem, want, is_reg2)
            if r:
                (base, _), inst, _ = r
                add(mnem, want, base, f'&[{want}, {want}]', '&[Rd, Rn]', inst)

    # 3-source multiply-accumulate: reg, reg, reg, reg (the fourth is the
    # accumulator Ra). mul/mneg above are the Ra=zr aliases of these.
    def is_reg4(inst, im):
        return inst.endswith('Xa') or inst.endswith('Wa')
    for mnem in ('madd', 'msub'):
        for want in ('X', 'W'):
            r = row_for(rows, mnem, want, is_reg4)
            if r:
                (base, _), inst, _ = r
                add(mnem, want, base, f'&[{want}, {want}, {want}, {want}]',
                    '&[Rd, Rn, Rm, Ra]', inst)
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--db', required=True)
    ap.add_argument('--out', required=True)
    a = ap.parse_args()
    rows = load_rows(a.db)
    forms = recipes(rows)
    # Sort by mnemonic so the consumer can binary-search the catalogue; stable to
    # keep each mnemonic's W/X rows and database order.
    forms.sort(key=lambda f: f[0])
    lines = [
        '// @generated by tools/gen_isa_a64.py from an external instruction-set',
        '// database. Do not edit by hand; re-run the generator to update.',
        '//',
        '// The A64 GP data-processing catalogue interpreted by',
        '// `super::table::encode`. Four database rows are corrected before',
        '// parsing (see tools/gen_isa_a64.py DB_FIXES).',
        '',
        'use super::table::{A64Op::*, Field::*, Form};',
        '',
        '#[rustfmt::skip]',
        'pub(crate) static FORMS: &[Form] = &[',
    ]
    for mnem, base, ops, fields, src in forms:
        lines.append(
            f'    Form {{ mnemonic: "{mnem}", ops: {ops}, '
            f'base: 0x{base:08X}, fields: {fields} }},  // {src}')
    lines.append('];')
    lines.append('')
    open(a.out, 'w').write('\n'.join(lines))
    print(f'wrote {len(forms)} A64 forms to {a.out}', file=sys.stderr)


if __name__ == '__main__':
    main()
