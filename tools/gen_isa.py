#!/usr/bin/env python3
"""Generate the badc x86-64 encoder catalogue from an instruction-set database.

Reads a machine-readable ISA database (the asmjit `db/isa_x86.json` schema)
and emits `src/c5/codegen/x86_64/isa_x86_table.rs`: a compact `const` array of
`Form`s that `x86_64::table::encode` interprets. Opcode facts are not
copyrightable expression; the database it is derived from is under the zlib
licence. The database is read by path and is not vendored into badc; the
generated file is the checked-in artifact and the build has no dependency on
this tool.

Usage:
    tools/gen_isa.py --db /path/to/db/isa_x86.json \
        --out src/c5/codegen/x86_64/isa_x86_table.rs

Scope: the legacy general-purpose + system instruction surface C reaches
through inline asm and that the general lowering emits. VEX/EVEX/XOP/APX and
explicit-66 (operand-size-redundant or niche) forms are excluded; the width
groups `v` (16/32/64) and `y` (32/64) cover the 16-bit case, and the encoder
adds the operand-size prefix by width.
"""
import argparse, json, re, sys

CATS = ('GP', 'GP GP_EXT', 'GP GP_IN_OUT', 'VIRTUALIZATION')
# Mnemonics we admit into the first catalogue: the inline-asm + general-lowering
# surface. Kept explicit so the table's contents are a reviewed decision.
ALLOW = set("""
add sub and or xor cmp adc sbb mov test xchg
inc dec neg not mul imul div idiv
shl shr sar sal rol ror rcl rcr
bsf bsr bswap bt btc btr bts
setb setbe setl setle setnb setnbe setnl setnle
setno setnp setns setnz seto setp sets setz
cmovb cmovbe cmovl cmovle cmovnb cmovnbe cmovnl cmovnle
cmovno cmovnp cmovns cmovnz cmovo cmovp cmovs cmovz
cwde cdqe cdq cqo
lfence mfence sfence
syscall sysret sysenter sysexit swapgs clts ud2 serialize
lahf sahf xgetbv xsetbv iretq rdpkru
rdrand rdseed movnti
clflush prefetchnta prefetcht0 prefetcht1 prefetcht2 prefetchw
fxsave fxrstor fxsave64 fxrstor64
lgdt lidt sgdt sidt
push pop lea nop
movzx movsx movsxd
cmpxchg xadd
int int3 hlt pause leave ret
cli sti cld std cmc clc stc
rdtsc rdtscp rdmsr wrmsr rdpmc cpuid
invd wbinvd monitor mwait
in out
""".split())

ACCESS = re.compile(r'^[a-zA-Z]:')
DEFAULT64 = {'push', 'pop', 'call', 'jmp', 'leave', 'ret', 'retf', 'enter',
             'pushf', 'popf', 'pushfq', 'popfq', 'int3'}


def parse_opnd(tok):
    tok = ACCESS.sub('', tok.strip()).replace('~', '')
    implicit = tok.startswith('<') and tok.endswith('>')
    if implicit:
        tok = tok[1:-1]
    tok = re.sub(r'\[[^\]]*\]', '', tok)
    return {'raw': tok, 'implicit': implicit}


def sig_ops(sig):
    sig = re.sub(r'^\[[^\]]*\]\s*', '', sig.strip())
    m = re.match(r'^(\S+)\s*(.*)$', sig)
    rest = m.group(2).strip()
    ops = [parse_opnd(t) for t in rest.split(',')] if rest else []
    return m.group(1), ops


def parse_op(op):
    """Legacy encoding -> dict, or None for VEX/EVEX/explicit-66/unmodelled."""
    tag = None
    m = re.match(r'^\[([A-Z ]+)\]\s*(.*)$', op)
    if m:
        tag = m.group(1).strip()
        op = m.group(2)
    parts = op.split()
    if any(p.startswith(('VEX', 'EVEX', 'XOP', 'REX2')) for p in parts):
        return None
    enc = {'tag': tag, 'map': 'Legacy', 'rexw': False, 'opbytes': [],
           'plus_r': False, 'ext': None, 'modrm_r': False, 'imm': None,
           'rel': None}
    seen = False
    i = 0
    while i < len(parts):
        p = parts[i]; i += 1
        if p in ('NFx', 'NOREP', 'NO67', 'NP', 'P0'):
            continue
        if p == 'REX.W':
            enc['rexw'] = True; continue
        if p == '66' and not seen:
            # Legacy `66` is the operand-size prefix; the encoder re-derives it
            # from the operation width, so the form's operands already carry the
            # 16-bit class. (0F38/0F3A forms where 66 is mandatory are excluded
            # below and unused by the GP/system surface.)
            continue
        if p in ('F2', 'F3') and not seen:
            return None                            # F2/F3-prefixed niche GP
        if p == '0F' and enc['map'] == 'Legacy' and not seen:
            enc['map'] = 'Op0F'; continue
        if enc['map'] == 'Op0F' and p == '38' and not seen:
            return None                            # 0F38 map: unused GP niche
        if enc['map'] == 'Op0F' and p == '3A' and not seen:
            return None                            # 0F3A map: unused GP niche
        mo = re.match(r'^([0-9A-F]{2})(\+[ri])?$', p)
        if mo:
            enc['opbytes'].append(int(mo.group(1), 16))
            if mo.group(2):
                enc['plus_r'] = True
            seen = True
            continue
        mo = re.match(r'^/([r0-7])$', p)
        if mo:
            if mo.group(1) == 'r':
                enc['modrm_r'] = True
            else:
                enc['ext'] = int(mo.group(1))
            continue
        if p in ('ib', 'iw', 'id', 'iq', 'iv', 'if'):
            enc['imm'] = p; continue
        if p in ('cb', 'cw', 'cd'):
            enc['rel'] = p; continue
        return None
    if not enc['opbytes']:
        return None
    return enc


IMM_MAP = {'imm8': 'Ib', 'imms8': 'Imms8', 'imm16': 'Iw', 'imm32': 'Id',
           'immu32': 'Id', 'imms32': 'Id', 'imm64': 'Iq', 'immv': 'Iv',
           'iv': 'Iv', '1': 'One'}
FIXED = {'al': (0, 'B'), 'ax': (0, 'Wd'), 'eax': (0, 'L'), 'rax': (0, 'Q'),
         'cl': (1, 'B'), 'dx': (2, 'Wd')}


def op_pattern(raw):
    """(OpPat-Rust, role) where role in reg/rm/imm/other. None => unmodelled."""
    if raw in FIXED:
        n, w = FIXED[raw]
        return f'Fixed({n}, W::{w})', 'fixed'
    if raw in ('axv',):
        return 'Fixed(0, W::V)', 'fixed'
    if raw in IMM_MAP:
        return f'Imm(ImmC::{IMM_MAP[raw]})', 'imm'
    if raw.startswith('rel'):
        sz = {'rel8': 1, 'rel16': 2, 'rel32': 4}.get(raw)
        return (f'Rel({sz})', 'imm') if sz else (None, None)
    if raw == 'mem':
        return 'MemAny', 'rm'
    # reg / mem / reg-or-mem width classes
    def cls(s):
        return {'8': 'B', '16': 'Wd', '32': 'L', '64': 'Q', 'v': 'V', 'y': 'Y'}.get(s)
    if '/' in raw:
        a, b = raw.split('/')
        ma = re.match(r'^r(8|16|32|64|v|y)$', a)
        mb = re.match(r'^m(8|16|32|64|v|y)$', b)
        if ma and mb and ma.group(1) == mb.group(1):
            return f'Rm(W::{cls(ma.group(1))})', 'rm'
        return None, None
    m = re.match(r'^r(8|16|32|64|v|y)$', raw)
    if m:
        return f'Reg(W::{cls(m.group(1))})', 'reg'
    m = re.match(r'^m(8|16|32|64|v|y)$', raw)
    if m:
        return f'Mem(W::{cls(m.group(1))})', 'rm'
    return None, None


def build_form(mnem, sig_operands, enc):
    explicit = [o for o in sig_operands if not o['implicit']]
    pats, roles = [], []
    for o in explicit:
        p, role = op_pattern(o['raw'])
        if p is None:
            return None
        pats.append(p); roles.append(role)
    # role indices
    reg_idx = rm_idx = imm_idx = None
    tag = enc['tag']
    for i, role in enumerate(roles):
        if role == 'imm':
            imm_idx = i
    # reg / rm assignment from the tag
    regmem = [i for i, r in enumerate(roles) if r in ('reg', 'rm', 'fixed')]
    if enc['plus_r']:
        rm_idx = regmem[0] if regmem else None
        regfield = 'NoReg'
    elif enc['ext'] is not None:
        rm_idx = regmem[0] if regmem else None
        regfield = f'Ext({enc["ext"]})'
    elif enc['modrm_r']:
        if tag == 'RM':
            reg_idx, rm_idx = regmem[0], regmem[1]
        elif tag == 'MR':
            rm_idx, reg_idx = regmem[0], regmem[1]
        else:
            # default: reg is a bare register operand, rm the reg-or-mem one
            regs = [i for i in regmem if roles[i] == 'reg']
            rms = [i for i in regmem if roles[i] in ('rm', 'fixed')]
            if len(regs) == 1 and len(rms) == 1:
                reg_idx, rm_idx = regs[0], rms[0]
            elif not regs and len(rms) == 1:
                # One-operand ModRM form (setcc): the reg field is an ignored
                # opcode extension, emitted as zero.
                rm_idx = rms[0]
            elif len(regmem) == 2:
                rm_idx, reg_idx = regmem[0], regmem[1]
            else:
                return None
        regfield = 'Ext(0)' if reg_idx is None else f'FromOp({reg_idx})'
    else:
        # no ModRM (nullary / OP forms)
        regfield = 'NoReg'
    rexw = ('W1' if enc['rexw']
            else 'Default64' if mnem in DEFAULT64
            else 'ByWidth' if any('W::V' in p or 'W::Y' in p or 'W::Q' in p for p in pats)
            else 'W0')
    imm_enc = 'None'
    if imm_idx is not None:
        imm_enc = f'Some({pats[imm_idx].split("(")[1][:-1]})'  # ImmC::X
    ob = ', '.join(f'0x{b:02X}' for b in enc['opbytes'])
    ops_s = ', '.join(pats)
    return {
        'mnem': mnem, 'ops': ops_s, 'map': enc['map'], 'opcode': ob,
        'plus_r': str(enc['plus_r']).lower(), 'rexw': rexw, 'reg': regfield,
        'rm': 255 if rm_idx is None else rm_idx,
        'imm': imm_enc, 'imm_op': 255 if imm_idx is None else imm_idx,
        'src': sig_from(mnem, sig_operands, enc),
    }


def sig_from(mnem, ops, enc):
    return f'{mnem} {" ".join(o["raw"] for o in ops)}'.strip()


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--db', required=True)
    ap.add_argument('--out', required=True)
    args = ap.parse_args()
    d = json.load(open(args.db))
    aliases = d.get('aliases', {})
    # AT&T spellings the database does not carry; GCC inline asm uses these for
    # the accumulator sign-extends.
    att_aliases = {'cwde': ['cwtl'], 'cdqe': ['cltq'], 'cdq': ['cltd'], 'cqo': ['cqto']}
    forms = []
    seen = set()
    for g in d['instructions']:
        if g['category'] not in CATS:
            continue
        for it in g['instructions']:
            sig = it.get('any') or it.get('x64')
            if not sig:
                continue
            mnem, ops = sig_ops(sig)
            if mnem not in ALLOW:
                continue
            enc = parse_op(it['op'])
            if enc is None:
                continue
            # Emit the canonical mnemonic and every alias spelling of it (the
            # condition-code aliases: sete == setz, and so on).
            alias_names = aliases.get(mnem, {}).get('aliases', []) + att_aliases.get(mnem, [])
            for name in [mnem] + alias_names:
                f = build_form(name, ops, enc)
                if f is None:
                    continue
                key = (f['mnem'], f['ops'], f['opcode'], f['imm'])
                if key in seen:
                    continue
                seen.add(key)
                forms.append(f)
    # Sort by mnemonic so the consumer can binary-search the catalogue; the sort
    # is stable, preserving database (preference) order among a mnemonic's forms
    # for the shortest-encoding tie-break.
    forms.sort(key=lambda f: f['mnem'])
    emit(forms, args.out)


def emit(forms, out):
    lines = []
    lines.append('// @generated by tools/gen_isa.py from an external instruction-set')
    lines.append('// database. Do not edit by hand; re-run the generator to update.')
    lines.append('//')
    lines.append('// The x86-64 GP / system encoder catalogue interpreted by')
    lines.append('// `super::table::encode`.')
    lines.append('')
    lines.append('use super::table::{Form, ImmC, Map, OpPat::*, RegField::*, RexW::*, W};')
    lines.append('use Mnem::*;')
    lines.append('')
    # One enum variant per distinct mnemonic, in the same (sorted) order as the
    # catalogue, so `Mnem`'s derived Ord matches the FORMS row order and the
    # encoder can binary-search on the integer discriminant.
    mnems = sorted({f['mnem'] for f in forms})

    def variant(m):
        return m[0].upper() + m[1:]

    lines.append('/// Every mnemonic the catalogue encodes. Generated; the native emitter')
    lines.append('/// passes these instead of strings, and the inline-asm parser maps a')
    lines.append('/// token to one via `Mnem::from_name`.')
    lines.append('#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]')
    lines.append('pub(crate) enum Mnem {')
    for m in mnems:
        lines.append(f'    {variant(m)},')
    lines.append('}')
    lines.append('')
    lines.append('#[rustfmt::skip]')
    lines.append('pub(crate) static FORMS: &[Form] = &[')
    for f in forms:
        lines.append(
            f'    Form {{ mnem: {variant(f["mnem"])}, mnemonic: "{f["mnem"]}", '
            f'ops: &[{f["ops"]}], '
            f'pp: &[], map: Map::{f["map"]}, opcode: &[{f["opcode"]}], '
            f'plus_r: {f["plus_r"]}, rexw: {f["rexw"]}, reg: {f["reg"]}, '
            f'rm: {f["rm"]}, imm: {f["imm"]}, imm_op: {f["imm_op"]} }},'
            f'  // {f["src"]}')
    lines.append('];')
    lines.append('')
    open(out, 'w').write('\n'.join(lines))
    print(f'wrote {len(forms)} forms to {out}', file=sys.stderr)


if __name__ == '__main__':
    main()
