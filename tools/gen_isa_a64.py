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
        'Rs2': 5, 'Rd2': 5, 'cond': 4, 'nzcv': 4, 'CRm': 4, 'CRn': 4,
        'sop': 2, 'option': 3}

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


def classify(heads, toks, op, im, scaled_wb=False):
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
    # `ImmBFM(immr, imms)` tags the base bfm/ubfm/sbfm, whose two immediates are
    # the raw immr/imms fields (unlike the ImmBFX/ImmBFIZ aliases, whose written
    # lsb/width are value-transformed and stay unexpressible).
    bfmm = re.match(r'ImmBFM\(', im or '')
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
        if (mm := re.fullmatch(
                r'\[Xn(?:\|SP)?(?:, #(\w+)(?:\*(\d+))?)?\]([!@]?)', t)):
            # A memory reference: the base feeds Rn, an optional immediate
            # offset feeds its named field. `#offS` is a two's-complement
            # offset, `#offZ` unsigned; a `*N` multiplier scales the written
            # byte offset. A `!` suffix is the pre-index writeback form; `@`
            # the post-index form, whose offset is a trailing written operand.
            fv = fl.get('Rn')
            if fv is None or fv[0] != 5:
                return ('residual', 'memory base field Rn not a 5-bit field')
            mode = mm.group(3)
            consumed.add('Rn')
            ops.append('MemPre' if mode == '!' else 'Mem')
            fields.append(f'Reg {{ op: {i}, shift: {fv[1]} }}')
            offname = mm.group(1)
            if mode and offname is None:
                return ('residual', 'writeback form without an offset field')
            if mode == '@' and i != len(toks) - 1:
                return ('residual', 'post-index memory operand not last')
            if offname is not None:
                ov = fl.get(offname)
                if ov is None:
                    return ('residual', f'memory offset #{offname} has no field')
                consumed.add(offname)
                scale = int(mm.group(2) or 1)
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
        if re.fullmatch(r'\[Xn(?:\|SP)?, Rm, '
                        r'\{uxtw\|lsl\|sxtw\|sxtx #n(?:\*\d+)?\}\]', t):
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
        # ImmPRF tags prfm's prefetch-op slot, a raw 5-bit code.
        if (m := re.fullmatch(r'#(\w+)', t0)) and (
                not im or bfmm or im.startswith('ImmPRF')):
            name = m.group(1)
            if name not in fl:
                return ('residual', f'immediate token {t0} has no matching field')
            w, pos = fl[name]
            consumed.add(name)
            ops.append('Imm')
            # Trailing-S names (immS) are two's-complement signed; the rest
            # are raw unsigned fields.
            kind = 'SImm' if name.endswith('S') else 'UImm'
            fields.append(f'{kind} {{ op: {i}, shift: {pos}, width: {w} }}')
            i += 1
            continue
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
            for einst, eop, scaled_wb in expand_wb(fi or inst, fo or op):
                rows.append((einst, eop, it.get('imm', ''), scaled_wb))
    return rows


def catalogue(rows, residuals=None):
    """Classify every row; -> {(mnemonic, ops-tuple): (base, fields, inst)}."""
    forms = {}
    for inst, op, im, scaled_wb in rows:
        headpart, _, rest = inst.partition(' ')
        toks = tuple(split_ops(rest)) if rest else ()
        heads = headpart.split('|')
        r = classify(heads, toks, op, im, scaled_wb)
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
