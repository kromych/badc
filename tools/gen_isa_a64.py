#!/usr/bin/env python3
"""Generate the badc AArch64 encoder catalogue from an instruction-set database.

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
}

# The store-form atomic aliases (ST<op> = LD<op> with the result discarded)
# are defined by the architecture only for the plain and release orderings;
# the acquire spellings ST<op>A / ST<op>AL do not exist (an acquire on a
# discarded load has no meaning) and the assembler rejects them.
UNDEFINED_ROW = re.compile(
    r'st(add|clr|eor|set|smax|smin|umax|umin)a[lbh]* ').match

# Rows whose written immediate is not the raw field value (addg/subg #imm1 is
# the field scaled by 16); a raw UImm form would encode them wrongly.
EXCLUDED_ROWS = {
    'addg Xd|SP, Xn|SP, #imm1, #imm2',
    'subg Xd|SP, Xn|SP, #imm1, #imm2',
}

# Bare op-string tokens whose bit width is not written inline (widths verified
# by the 32-bit row-sum constraint in the design spike).
BARE = {'Rm': 5, 'Rn': 5, 'Rd': 5, 'Ra': 5, 'Rt': 5, 'Rt2': 5, 'Rs': 5,
        'Rs2': 5, 'Rd2': 5, 'cond': 4, 'CRm': 4, 'CRn': 4, 'sop': 2,
        'option': 3}

# Aliases that store the inverted written condition (al/nv invalid there).
COND_INV = {'cset', 'csetm', 'cinc', 'cinv', 'cneg'}


def parse_op(op):
    """'10001011|sop:2|0|Rm|...' -> (base, {name:(width,shift)}) or None.
    A repeated field name (cinc-style Rn twice) is not expressible."""
    base, fields, pos = 0, {}, 0
    for tok in reversed(op.split('|')):
        tok = tok.strip()
        if re.fullmatch(r'[01]+', tok):
            base |= int(tok, 2) << pos
            pos += len(tok)
        elif (m := re.fullmatch(r'(\w+):(\d+)', tok)):
            if m.group(1) in fields:
                return None
            fields[m.group(1)] = (int(m.group(2)), pos)
            pos += int(m.group(2))
        elif tok in BARE:
            if tok in fields:
                return None
            fields[tok] = (BARE[tok], pos)
            pos += BARE[tok]
        else:
            return None
    return (base & 0xFFFFFFFF, fields) if pos == 32 else None


# Register operand suffix -> the encoding field it feeds. The bit position is
# read from each row's encoding string, not fixed: the same field lands at
# different bits across instructions (e.g. Rs at bit 0 in stlr, bit 16 in cas).
REG_FIELD = {'d': 'Rd', 'n': 'Rn', 'm': 'Rm', 'a': 'Ra', 's': 'Rs',
             't': 'Rt', 't2': 'Rt2', 'd2': 'Rd2', 's2': 'Rs2'}


def classify(heads, toks, op, im):
    """Map one row's written operands onto the field model.
    -> ('ok', ops, fields, base) or ('residual', reason)."""
    if 'mov' in heads:
        # mov's row set is an alias family whose member choice depends on the
        # operand values (wide/inverted/bitmask immediate, SP form); selecting
        # among them is the encoder caller's job.
        return ('residual', 'mov alias selection is value-dependent')
    p = parse_op(op)
    if p is None:
        return ('residual', 'op not field-expressible (repeated or unknown token)')
    base, fl = p
    consumed, ops, fields = set(), [], []
    logm = re.match(r'(?:LogicalImm|ImmLogical)\((\w+), ([01])\)', im or '')
    widem = re.match(r'ImmWide(?:Inv)?\((\w+), (\w+), ([01])\)', im or '')
    i, rd_width = 0, None
    while i < len(toks):
        t = toks[i]
        t0 = t.split('|')[0]
        if (m := re.fullmatch(r'([XW])(d2|s2|t2|[dnmast])', t0)):
            # A register operand feeds a named 5-bit field; its bit position is
            # read from the encoding, so any operand order is expressible.
            w, fname = m.group(1), REG_FIELD[m.group(2)]
            fv = fl.get(fname)
            if fv is None or fv[0] != 5:
                return ('residual', f'register field {fname} not a 5-bit field')
            consumed.add(fname)
            ops.append(w)
            fields.append(f'Reg {{ op: {i}, shift: {fv[1]} }}')
            if m.group(2) == 'd':
                rd_width = w
            i += 1
            continue
        if re.fullmatch(r'\[Xn(\|SP)?\]', t):
            # A base-register memory reference; the base feeds Rn.
            fv = fl.get('Rn')
            if fv is None or fv[0] != 5:
                return ('residual', 'memory base field Rn not a 5-bit field')
            consumed.add('Rn')
            ops.append('Mem')
            fields.append(f'Reg {{ op: {i}, shift: {fv[1]} }}')
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
        if (m := re.fullmatch(r'#(\w+)', t0)) and not im:
            name = m.group(1)
            if name.endswith('S'):
                # The trailing-S names (immS/offS/relS) are signed; a raw
                # unsigned field would mis-encode the negative half.
                return ('residual', f'signed immediate {t0}, no signed field kind')
            if name in fl:
                w, pos = fl[name]
                consumed.add(name)
                ops.append('Imm')
                fields.append(f'UImm {{ op: {i}, shift: {pos}, width: {w} }}')
                i += 1
                continue
            return ('residual', f'immediate token {t0} has no matching field')
        if t.startswith('{'):
            # Optional shift groups whose absent form is all-zero field bits
            # are dropped; extend/index groups are not (their default is not
            # the zero encoding).
            if re.match(r'\{(lsl|sop)[ |]', t) or t.startswith('{lsl|lsr|asr'):
                i += 1
                continue
            return ('residual', f'group {t} not droppable')
        return ('residual', f'operand token {t}')
    left = set(fl) - consumed - {'n', 'sop'}
    if left:
        return ('residual', 'unmapped fields: ' + ','.join(sorted(left)))
    return ('ok', ops, fields, base)


def load_rows(db):
    rows = []
    for g in json.load(open(db))['instructions']:
        if 'GP' not in g['category']:
            continue
        for it in g['data']:
            inst, op = it['inst'], it['op']
            if inst in EXCLUDED_ROWS or UNDEFINED_ROW(inst):
                continue
            fi, fo = DB_FIXES.get((inst, op), (None, None))
            rows.append((fi or inst, fo or op, it.get('imm', '')))
    return rows


def catalogue(rows, residuals=None):
    """Classify every row; -> {(mnemonic, ops-tuple): (base, fields, inst)}."""
    forms = {}
    for inst, op, im in rows:
        headpart, _, rest = inst.partition(' ')
        toks = tuple(t.strip() for t in rest.split(',')) if rest else ()
        heads = headpart.split('|')
        r = classify(heads, toks, op, im)
        if r[0] == 'residual':
            if residuals is not None:
                sig = ' '.join(t.split('|')[0] if not t.startswith('{') else t
                               for t in toks) or '(no operands)'
                residuals[(sig, r[1])].append(inst)
            continue
        _, ops, fields, base = r
        for head in heads:
            # A row names every alias spelling (`asr|asrv`); each gets a form.
            # Keep the first row per (mnemonic, operand pattern).
            forms.setdefault((head, tuple(ops)), (base, fields, inst))
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
    forms = catalogue(rows, residuals)
    # Sort by mnemonic so the consumer can binary-search the catalogue; stable
    # to keep each mnemonic's rows in database order.
    out = sorted(forms.items(), key=lambda kv: kv[0][0])
    lines = [
        '// @generated by tools/gen_isa_a64.py from an external instruction-set',
        '// database. Do not edit by hand; re-run the generator to update.',
        '//',
        '// The A64 GP catalogue interpreted by `super::table::encode`: every',
        '// database row whose written-operand signature maps onto the field',
        '// model. Some database rows are corrected and some dropped before',
        '// parsing (see tools/gen_isa_a64.py DB_FIXES / EXCLUDED_ROWS).',
        '',
        'use super::table::{A64Op, A64Op::*, Field, Field::*, Form};',
        '',
        '#[rustfmt::skip]',
        'pub(crate) static FORMS: &[Form] = &[',
    ]
    for (mnem, ops), (base, fields, src) in out:
        lines.append(
            f'    Form {{ mnemonic: "{mnem}", ops: &[{", ".join(ops)}], '
            f'base: 0x{base:08X}, fields: &[{", ".join(fields)}] }},  // {src}')
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
