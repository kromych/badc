#!/usr/bin/env python3
"""Struct-layout differ for the badc-built kernel.

Reads DWARF from a reference-compiler build and a badc build of the same
kernel and reports every aggregate whose layout differs: total size, member
offsets and sizes, and bitfield bit position and width. A layout difference
is an ABI defect that produces memory corruption rather than a diagnostic --
the kernel boots, the modules load, and a wrong member offset shows up as a
corrupted field somewhere else -- so nothing else in the harness catches one.

Three input modes:

``--ref-elf/--badc-elf``
    Compare two ELF files directly (vmlinux, a .ko, or a .o).

``--ref-tree/--badc-tree``
    Compare ``vmlinux`` plus every ``.ko`` the two trees have in common,
    pairing by tree-relative path. Both trees must hold the same source and
    the same configuration; the run refuses to compare otherwise, because a
    configuration difference produces layout differences that say nothing
    about the compiler.

``--replay --tree``
    Compile each kernel unit twice from the tree's Kbuild ``.cmd`` corpus --
    once with the recorded command plus debug info, once with badc's flag
    set plus ``-g`` -- and compare per unit. The two sides run the same
    preprocessor surface over the same sources by construction, so this mode
    cannot be confounded by configuration, and it covers every translation
    unit rather than only the types that reached vmlinux.

    A tree the badc gate built records ``buildcc.py`` -- badc's Kbuild CC
    shim -- as the compiler of every kernel unit, so the reference leg
    substitutes ``--real-cc`` for that driver. The recorded arguments are
    the reference compiler's own surface: the shim rewrites for badc
    internally and leaves the configuration probes to the reference
    compiler, so naming it ahead of them reproduces the command the build
    would have run without the shim.

Extraction backend: ``llvm-dwarfdump``, whose one-attribute-per-line DIE dump
is parsed directly. ``--cross-check N`` re-reads N aggregates with gdb's
``ptype /o`` and asserts the parse agrees, which also demonstrates that a
debugger consumes the DWARF at all.

Comparison is on the ABI facts only -- aggregate size, and per member the
name, byte offset, size, bit offset and bit width. Member type spellings are
recorded in the JSON but not compared: the two compilers name types
differently and that is not an ABI difference.

    python3 demos/linux/layout.py --arch x86_64 \
        --ref-tree ~/k/ref --badc-tree ~/k/badc --report layout.json
"""

from __future__ import annotations

import argparse
import collections
import hashlib
import json
import os
import platform
import re
import shutil
import subprocess
import sys
import tempfile
import time
from concurrent.futures import ProcessPoolExecutor, ThreadPoolExecutor
from pathlib import Path
from typing import NamedTuple

import karch
import sweep

LINUX_DIR = Path(__file__).resolve().parent
REPO_ROOT = LINUX_DIR.parents[1]

ARCHES = sorted(sweep.TARGETS)

# Scripts here that stand in as Kbuild's ``CC``. Neither is a compiler:
# buildcc.py routes kernel units to badc and needs ``$BADC``, ccshim.py
# answers Kconfig's probes. A tree built through one records it as the
# compiler of every unit, so a replay has to name the compiler behind it.
CC_SHIMS = frozenset(("buildcc.py", "ccshim.py"))

# Aggregate members can only refer to these tags, so the per-unit type table
# skips everything else (subprograms, variables, call sites and location
# lists are the bulk of kernel DWARF and none of them carry layout).
TYPE_TAGS = frozenset((
    "base_type", "pointer_type", "typedef", "const_type", "volatile_type",
    "restrict_type", "array_type", "subrange_type", "enumeration_type",
    "structure_type", "union_type", "subroutine_type", "member",
    "class_type", "atomic_type",
))
AGG_TAGS = frozenset(("structure_type", "union_type", "class_type"))

# Attributes the parse consumes. Filtering the dumper's output in the pipe
# keeps the decl_file/decl_line/sibling/location bulk out of Python.
WANT_ATTRS = ("name", "byte_size", "bit_size", "bit_offset", "data_bit_offset",
              "data_member_location", "type", "declaration", "count",
              "upper_bound", "encoding")
FILTER_ERE = (r"DW_TAG_|Compile Unit:|DW_AT_(" + "|".join(WANT_ATTRS) + r")\b")
DUMP_FILTER = re.compile("(" + FILTER_ERE + ")")

# An aggregate the source left untagged carries no DW_AT_name on either
# side. badc once synthesized one from its registry key, with a per-unit
# serial that matched nothing across compilers or units; the pattern is
# kept so such a name is recognized as the anonymous type it describes
# rather than counted as a type only badc has.
ANON_NAME = re.compile(r"^__anon_(?:struct|union)_\d+(?:_in_.*)?$")

DIE_RE = re.compile(r"^0x([0-9a-f]+):(\s+)DW_TAG_(\w+)\s*$")
ATTR_RE = re.compile(r"^\s+DW_AT_(\w+)\s+\((.*)\)\s*$")


def log(m: str) -> None:
    print(f"linux layout: {m}", flush=True)


def die(m: str) -> "None":
    sys.exit(f"linux layout: {m}")


def host_arch() -> str:
    return sweep.host_arch()


def tool(name: str, purpose: str = "to read DWARF") -> str:
    p = shutil.which(name)
    if not p:
        die(f"{name} not found; it is required {purpose}")
    return p


def executable(name: str) -> str | None:
    """`name` resolved to a runnable program, or None."""
    if os.sep in name or (os.altsep and os.altsep in name):
        p = Path(name)
        return str(p) if p.is_file() and os.access(p, os.X_OK) else None
    return shutil.which(name)


# --------------------------------------------------------------------------
# DWARF extraction


def attr_int(raw: str) -> int | None:
    """An integer attribute value, including the exprloc spellings Kbuild's
    compilers use for member locations."""
    raw = raw.strip()
    m = re.match(r"^(0x[0-9a-fA-F]+|-?\d+)$", raw)
    if m:
        return int(m.group(1), 0)
    m = re.match(r"^DW_OP_plus_uconst\s+(0x[0-9a-fA-F]+|\d+)$", raw)
    if m:
        return int(m.group(1), 0)
    m = re.match(r"^<0x[0-9a-fA-F]+>\s*(0x[0-9a-fA-F]+|\d+)", raw)
    if m:
        return int(m.group(1), 0)
    return None


def attr_str(raw: str) -> str | None:
    m = re.match(r'^"(.*)"$', raw.strip(), re.S)
    return m.group(1) if m else None


def attr_ref(raw: str) -> int | None:
    m = re.match(r"^\(?(0x[0-9a-fA-F]+)", raw.strip())
    return int(m.group(1), 0) if m else None


def ref_die(die: "Die", table: dict[int, "Die"]) -> "Die | None":
    """The DIE a `DW_AT_type` attribute names, or None when there is no such
    attribute or it leaves the unit."""
    if "type" not in die.attrs:
        return None
    off = attr_ref(die.attrs["type"])
    return None if off is None else table.get(off)


class Die:
    __slots__ = ("tag", "attrs", "kids", "off")

    def __init__(self, off: int, tag: str):
        self.off = off
        self.tag = tag
        self.attrs: dict[str, str] = {}
        self.kids: list["Die"] = []


def parse_units(lines):
    """Yield one {offset: Die} table per compile unit.

    DWARF 4 type references are unit-relative, so a unit is a closed world:
    holding one unit at a time bounds memory by the largest unit rather than
    by the file, which matters because a kernel vmlinux carries millions of
    DIEs. A reference that leaves the unit stays unresolved and its member
    size is reported unknown rather than guessed.
    """
    table: dict[int, Die] = {}
    stack: list[tuple[int, Die]] = []
    cur: Die | None = None
    for line in lines:
        if line.startswith("Compile Unit:") or ": Compile Unit:" in line:
            if table:
                yield table
            table, stack, cur = {}, [], None
            continue
        m = DIE_RE.match(line)
        if m:
            off, indent, tag = int(m.group(1), 16), len(m.group(2)), m.group(3)
            depth = (indent - 1) // 2
            keep = tag in TYPE_TAGS
            cur = Die(off, tag) if keep else None
            while stack and stack[-1][0] >= depth:
                stack.pop()
            if cur is not None:
                table[off] = cur
                if stack and stack[-1][0] == depth - 1:
                    stack[-1][1].kids.append(cur)
                stack.append((depth, cur))
            else:
                # A dropped DIE still occupies a level: a member nested under
                # one must not be attached to the aggregate above it.
                stack.append((depth, Die(off, tag)))
            continue
        if cur is None:
            continue
        m = ATTR_RE.match(line)
        if m and m.group(1) in WANT_ATTRS:
            cur.attrs[m.group(1)] = m.group(2)
    if table:
        yield table


def type_size(die: Die | None, table: dict[int, Die], addr_size: int,
              depth: int = 0) -> int | None:
    """The byte size of a type DIE, following the qualifier and typedef
    chain and computing array extents."""
    if die is None or depth > 24:
        return None
    if "byte_size" in die.attrs:
        n = attr_int(die.attrs["byte_size"])
        if n is not None:
            return n
    if die.tag == "pointer_type":
        # A pointer whose DIE omits DW_AT_byte_size is the unit's address
        # size; without this every typedef'd pointer member reports unknown.
        return addr_size
    if die.tag == "array_type":
        elem = ref_die(die, table)
        esz = type_size(elem, table, addr_size, depth + 1)
        if esz is None:
            return None
        total = 1
        saw = False
        for k in die.kids:
            if k.tag != "subrange_type":
                continue
            saw = True
            if "count" in k.attrs:
                n = attr_int(k.attrs["count"])
            elif "upper_bound" in k.attrs:
                ub = attr_int(k.attrs["upper_bound"])
                # An unbounded array is spelled with a negative bound or an
                # all-ones unsigned one; both mean no elements, not 2**32.
                n = None if ub is None else (0 if ub < 0 or ub >= 1 << 31
                                             else ub + 1)
            else:
                n = 0  # flexible array member
            if n is None:
                return None
            total *= n
        return esz * total if saw else 0
    ref = attr_ref(die.attrs.get("type", "")) if "type" in die.attrs else None
    if ref is None:
        return None
    return type_size(table.get(ref), table, addr_size, depth + 1)


def type_name(die: Die | None, table: dict[int, Die],
              depth: int = 0) -> str:
    """A short spelling of a member's type. Recorded for the report only;
    the two compilers spell types differently and that is not an ABI fact."""
    if die is None or depth > 24:
        return "?"
    nm = attr_str(die.attrs.get("name", ""))
    if die.tag in AGG_TAGS:
        kind = "union" if die.tag == "union_type" else "struct"
        if nm is None or ANON_NAME.match(nm):
            return f"{kind} <anon>"
        return f"{kind} {nm}"
    if die.tag == "enumeration_type":
        return f"enum {nm}" if nm else "enum <anon>"
    if nm is not None:
        return nm
    inner = ref_die(die, table)
    if die.tag == "pointer_type":
        return (type_name(inner, table, depth + 1) + " *") if inner else "void *"
    if die.tag == "array_type":
        return type_name(inner, table, depth + 1) + " []"
    if die.tag in ("const_type", "volatile_type", "restrict_type",
                   "atomic_type"):
        return type_name(inner, table, depth + 1)
    if die.tag == "subroutine_type":
        return "<function>"
    return "?"


def member_facts(m: Die, table: dict[int, Die], big_endian: bool,
                 addr_size: int) -> dict:
    """One member's ABI facts, with both DWARF bitfield encodings normalized
    to an absolute bit offset from the start of the aggregate.

    DWARF 4 5.6.6 gives bitfields DW_AT_data_bit_offset directly. The pre-4
    form gives DW_AT_bit_offset counted from the most significant bit of the
    storage unit named by DW_AT_byte_size, which on a little-endian target is
    the complement of the position wanted.
    """
    name = attr_str(m.attrs.get("name", ""))
    tdie = ref_die(m, table)
    out: dict = {
        "name": name,
        "type": type_name(tdie, table),
        "offset": None,
        "bit_offset": None,
        "bit_size": None,
        "size": None,
    }
    bit_size = attr_int(m.attrs.get("bit_size", "")) if "bit_size" in m.attrs \
        else None
    loc = attr_int(m.attrs.get("data_member_location", "")) \
        if "data_member_location" in m.attrs else None
    if bit_size is not None:
        out["bit_size"] = bit_size
        if "data_bit_offset" in m.attrs:
            out["bit_offset"] = attr_int(m.attrs["data_bit_offset"])
        elif "bit_offset" in m.attrs:
            bo = attr_int(m.attrs["bit_offset"])
            unit = attr_int(m.attrs.get("byte_size", "")) \
                if "byte_size" in m.attrs else type_size(tdie, table, addr_size)
            base = (loc or 0) * 8
            if bo is None or unit is None:
                out["bit_offset"] = None
            elif big_endian:
                out["bit_offset"] = base + bo
            else:
                out["bit_offset"] = base + unit * 8 - bo - bit_size
        if out["bit_offset"] is not None:
            out["offset"] = out["bit_offset"] // 8
        return out
    out["offset"] = 0 if loc is None else loc
    out["size"] = type_size(tdie, table, addr_size)
    return out


def strip_type(die: Die | None, table: dict[int, Die]) -> Die | None:
    """The type behind the typedef and qualifier chain."""
    for _ in range(24):
        if die is None or die.tag not in ("typedef", "const_type",
                                          "volatile_type", "restrict_type",
                                          "atomic_type"):
            return die
        die = ref_die(die, table)
    return die


def flat_members(die: Die, table: dict[int, Die], big_endian: bool,
                 addr_size: int, base: int = 0, depth: int = 0) -> list[dict]:
    """One aggregate's members with C11 anonymous members spliced in at their
    absolute offsets.

    The two compilers represent an unnamed member differently: the reference
    keeps it as a member whose type is an anonymous aggregate, badc promotes
    the inner fields into the enclosing one. Flattening both to the named
    leaf members makes the comparison about offsets rather than about which
    representation was chosen.
    """
    out: list[dict] = []
    for k in die.kids:
        if k.tag != "member":
            continue
        f = member_facts(k, table, big_endian, addr_size)
        inner = strip_type(ref_die(k, table), table)
        anon_agg = (inner is not None and inner.tag in AGG_TAGS
                    and (attr_str(inner.attrs.get("name", "")) is None
                         or ANON_NAME.match(
                             attr_str(inner.attrs.get("name", "")) or "")))
        if f["name"] is None and anon_agg and depth < 8:
            out += flat_members(inner, table, big_endian, addr_size,
                                base + (f["offset"] or 0), depth + 1)
            continue
        if f["offset"] is not None:
            f["offset"] += base
        if f["bit_offset"] is not None:
            f["bit_offset"] += base * 8
        out.append(f)
    return out


def unit_aggregates(table: dict[int, Die], big_endian: bool,
                    addr_size: int):
    """(name, kind, size, members) for every complete named aggregate in one
    unit. Incomplete declarations carry no layout and are skipped."""
    for die in table.values():
        if die.tag not in AGG_TAGS:
            continue
        if "declaration" in die.attrs or "byte_size" not in die.attrs:
            continue
        nm = attr_str(die.attrs.get("name", ""))
        if nm is None or ANON_NAME.match(nm):
            continue  # anonymous: no identity to match across compilers
        size = attr_int(die.attrs["byte_size"])
        members = flat_members(die, table, big_endian, addr_size)
        kind = "union" if die.tag == "union_type" else "struct"
        yield nm, kind, size, members


def signature(size, members) -> tuple:
    """The ABI identity of a layout: the aggregate size and, per member, the
    name, byte offset, size, bit offset and bit width. Member type spelling
    is excluded."""
    return (size, tuple((m["name"], m["offset"], m["size"],
                         m["bit_offset"], m["bit_size"]) for m in members))


def elf_shape(path: Path) -> tuple[bool, int]:
    """(big_endian, address size) from the ELF header."""
    with path.open("rb") as fh:
        ident = fh.read(6)
    if len(ident) < 6 or ident[:4] != b"\x7fELF":
        die(f"{path} is not an ELF file")
    return ident[5] == 2, 8 if ident[4] == 2 else 4


def extract(path: Path, dwarfdump: str) -> dict:
    """name -> {"kind":..., "layouts": {sig: {"count":n, "members":[...],
    "size":n}}} for one ELF file."""
    big_endian, addr_size = elf_shape(path)
    # A kernel vmlinux carries a few hundred megabytes of .debug_info, which
    # the dumper renders as several gigabytes of text. Discarding the lines
    # the parse never reads (decl_file/decl_line/sibling/location, and every
    # DIE that is not a type) in grep rather than in Python is what keeps the
    # extraction bound by the dumper instead of by the interpreter.
    # `grep` exits 1 on no match, so the dumper's own status is what says
    # whether the read worked; a pipeline that reported only the last stage
    # would hide it and an unreadable file would report as a clean comparison
    # of nothing. The two stages are run directly rather than through a shell
    # so the dumper's status is the one read, on any /bin/sh.
    errs = tempfile.TemporaryFile()
    dump = subprocess.Popen([dwarfdump, "--debug-info", str(path)],
                            stdout=subprocess.PIPE, stderr=errs,
                            bufsize=1 << 20)
    assert dump.stdout is not None
    proc = subprocess.Popen(["grep", "-E", FILTER_ERE], stdin=dump.stdout,
                            stdout=subprocess.PIPE, text=True,
                            errors="replace", bufsize=1 << 20)
    # The parent's copy, so the dumper sees the reader go away.
    dump.stdout.close()
    assert proc.stdout is not None
    out: dict = {}
    units = 0
    try:
        for table in parse_units(proc.stdout):
            units += 1
            for nm, kind, size, members in unit_aggregates(
                    table, big_endian, addr_size):
                sig = signature(size, members)
                ent = out.setdefault(nm, {"kind": kind, "layouts": {}})
                key = repr(sig)
                slot = ent["layouts"].get(key)
                if slot is None:
                    ent["layouts"][key] = {"count": 1, "size": size,
                                           "members": members}
                else:
                    slot["count"] += 1
    finally:
        proc.stdout.close()
        proc.wait()
        dump.wait()
    if dump.returncode != 0:
        errs.seek(0)
        err = errs.read().decode("utf-8", "replace").strip()
        errs.close()
        die(f"reading DWARF from {path} failed (rc={dump.returncode})"
            + (f": {err.splitlines()[0]}" if err else ""))
    errs.close()
    return {"aggregates": out, "units": units,
            "big_endian": big_endian, "addr_size": addr_size}


def dominant(entry: dict) -> tuple[dict, bool]:
    """The most frequent layout for a name, and whether the name had more
    than one. A kernel does define distinct types under one tag name in
    different units; those are reported, not silently diffed."""
    layouts = sorted(entry["layouts"].values(), key=lambda v: -v["count"])
    return layouts[0], len(layouts) > 1


# --------------------------------------------------------------------------
# Comparison


# Where a member lies. These plus the aggregate's own size are the layout;
# a disagreement on any of them is an ABI defect.
LAYOUT_FIELDS = ("offset", "bit_offset", "bit_size")
# What the member is. A disagreement here with the layout intact is a defect
# in the type description, not in the layout: a debugger shows the member
# wrongly but code compiled against it still agrees on addresses.
TYPE_FIELDS = ("size",)


def compare_members(ref: list[dict],
                    badc: list[dict]) -> tuple[list, list, list]:
    """(layout differences, type-description differences, coverage gaps).

    A member only one side describes is a gap: it says nothing about where
    the member lies, only that one compiler did not record it. The three are
    counted apart because they call for different work.
    """
    diffs: list[dict] = []
    types: list[dict] = []
    gaps: list[dict] = []
    by_r = {m["name"]: m for m in ref if m["name"]}
    by_b = {m["name"]: m for m in badc if m["name"]}
    for nm, r in by_r.items():
        b = by_b.get(nm)
        if b is None:
            gaps.append({"member": nm, "kind": "missing-in-badc"})
            continue
        for group, sink in ((LAYOUT_FIELDS, diffs), (TYPE_FIELDS, types)):
            fields = {f: [r[f], b[f]] for f in group
                      if r[f] is not None and b[f] is not None
                      and r[f] != b[f]}
            if fields:
                sink.append({"member": nm, "kind": "field", "fields": fields,
                             "type": [r["type"], b["type"]]})
    for nm in by_b:
        if nm not in by_r:
            gaps.append({"member": nm, "kind": "missing-in-reference"})
    anon_r = [m for m in ref if not m["name"]]
    anon_b = [m for m in badc if not m["name"]]
    if len(anon_r) == len(anon_b):
        for i, (r, b) in enumerate(zip(anon_r, anon_b)):
            fields = {f: [r[f], b[f]] for f in LAYOUT_FIELDS
                      if r[f] is not None and b[f] is not None and r[f] != b[f]}
            if fields:
                diffs.append({"member": f"<unnamed#{i}>", "kind": "field",
                              "fields": fields,
                              "type": [r["type"], b["type"]]})
    elif anon_r or anon_b:
        gaps.append({"member": "<unnamed>", "kind": "unnamed-count",
                     "count": [len(anon_r), len(anon_b)]})
    return diffs, types, gaps


def compare(ref: dict, badc: dict) -> dict:
    """Compare two extraction results.

    Each name common to both sides lands in exactly one bucket: identical,
    a layout difference (an ABI defect), or a coverage gap (one side's DWARF
    describes less than the other's, with everything it does describe in
    agreement).
    """
    ra, ba = ref["aggregates"], badc["aggregates"]
    common = set(ra) & set(ba)
    res = {
        "counts": {
            "ref_names": len(ra), "badc_names": len(ba),
            "compared": len(common), "identical": 0, "layout_differing": 0,
            "type_differing": 0, "coverage_gap": 0,
            "ref_only": len(set(ra) - set(ba)),
            "badc_only": len(set(ba) - set(ra)),
            "ambiguous": 0,
        },
        "differences": [],
        "type_differences": [],
        "coverage": [],
        "ref_only": sorted(set(ra) - set(ba)),
        "badc_only": sorted(set(ba) - set(ra)),
        "ambiguous": [],
    }
    for nm in sorted(common):
        r, r_amb = dominant(ra[nm])
        b, b_amb = dominant(ba[nm])
        incidence = max(r["count"], b["count"])
        if r_amb or b_amb:
            res["counts"]["ambiguous"] += 1
            res["ambiguous"].append({
                "name": nm, "ref_layouts": len(ra[nm]["layouts"]),
                "badc_layouts": len(ba[nm]["layouts"]), "incidence": incidence})
        mdiffs, mtypes, mgaps = compare_members(r["members"], b["members"])
        # A side that describes nothing where the other describes a definition
        # holds a forward declaration it emitted as one: a gap, not a
        # difference. An aggregate both sides agree is empty is not that.
        described = {"reference": bool(r["members"]) or bool(r["size"]),
                     "badc": bool(b["members"]) or bool(b["size"])}
        incomplete = ([] if all(described.values())
                      or not any(described.values())
                      else [s for s, on in described.items() if not on])
        size_diff = (r["size"] != b["size"]) and not incomplete
        if r_amb or b_amb:
            # The build defines this tag name more than once and the two
            # sides need not have picked the same definition, so neither
            # agreement nor disagreement is evidence. Counted as ambiguous
            # only, and kept out of the exit status.
            continue
        if size_diff or mdiffs:
            res["counts"]["layout_differing"] += 1
            res["differences"].append({
                "name": nm, "kind": ra[nm]["kind"], "incidence": incidence,
                "ambiguous": bool(r_amb or b_amb),
                "size": {"ref": r["size"], "badc": b["size"]}
                        if size_diff else None,
                "members": mdiffs,
                "member_count": {"ref": len(r["members"]),
                                 "badc": len(b["members"])}})
        elif mtypes:
            res["counts"]["type_differing"] += 1
            res["type_differences"].append({
                "name": nm, "incidence": incidence, "members": mtypes[:12],
                "also_coverage_gap": bool(mgaps or incomplete)})
        elif mgaps or incomplete:
            res["counts"]["coverage_gap"] += 1
            res["coverage"].append({
                "name": nm, "incidence": incidence,
                "incomplete_in": incomplete,
                "size": {"ref": r["size"], "badc": b["size"]},
                "member_count": {"ref": len(r["members"]),
                                 "badc": len(b["members"])},
                "members": mgaps[:12]})
        else:
            res["counts"]["identical"] += 1
    for k in ("differences", "type_differences", "coverage"):
        res[k].sort(key=lambda d: (-d["incidence"], d["name"]))
    return res


# --------------------------------------------------------------------------
# gdb cross-check


GDB_OFFSET_RE = re.compile(
    r"^/\*\s*(?:(\d+)|(\d+):\s*(\d+))\s*\|\s*(\d+)\s*\*/\s+(.*)$")


GDB_MARK = "@@layout@@"


def gdb_layouts(path: Path, names: list[tuple[str, str]],
                gdb: str) -> dict[str, str]:
    """gdb's own rendering of each (kind, name), keyed by name.

    One gdb process for the whole set: loading a kernel vmlinux costs far
    more than the `ptype /o` calls themselves, so a process per type would
    pay that cost once per name.
    """
    exs = ["-ex", "set pagination off"]
    for kind, nm in names:
        exs += ["-ex", f"echo {GDB_MARK}{nm}\\n", "-ex", f"ptype /o {kind} {nm}"]
    r = subprocess.run([gdb, "-batch", "-nx", *exs, str(path)],
                       capture_output=True, text=True, timeout=3600)
    out: dict[str, str] = {}
    cur: str | None = None
    buf: list[str] = []
    for line in r.stdout.splitlines():
        if line.startswith(GDB_MARK):
            if cur is not None:
                out[cur] = "\n".join(buf)
            cur, buf = line[len(GDB_MARK):].strip(), []
            continue
        buf.append(line)
    if cur is not None:
        out[cur] = "\n".join(buf)
    return out


def cross_check(path: Path, extracted: dict, names: list[str],
                gdb: str) -> dict:
    """For each name, compare the byte offsets the parse produced with the
    offsets gdb prints for its top-level members."""
    out = {"checked": 0, "agree": 0, "unavailable": 0, "mismatch": []}
    want = [(extracted["aggregates"][n]["kind"], n) for n in names
            if n in extracted["aggregates"]]
    rendered = gdb_layouts(path, want, gdb)
    for _kind, nm in want:
        ent = extracted["aggregates"][nm]
        lay, _ = dominant(ent)
        text = rendered.get(nm)
        if not text or "No struct type named" in text or "type = " not in text:
            out["unavailable"] += 1
            continue
        out["checked"] += 1
        seen: dict[str, int] = {}
        depth = 0
        for line in text.splitlines():
            m = GDB_OFFSET_RE.match(line.strip())
            if not m:
                depth += line.count("{") - line.count("}")
                continue
            body = m.group(5)
            byte_off = int(m.group(1) or m.group(2))
            # Only top-level members: gdb indents nested aggregates inline.
            if depth == 1:
                # The member name is the identifier immediately before the
                # first array bound, bitfield colon or terminating semicolon;
                # indexing a findall picks the bitfield width instead.
                ident = re.match(r"^.*?\b(\w+)\s*(?:\[|:|;)", body)
                if ident:
                    seen.setdefault(ident.group(1), byte_off)
            depth += line.count("{") - line.count("}")
        bad = []
        for m2 in lay["members"]:
            if m2["name"] in seen and m2["offset"] is not None:
                if seen[m2["name"]] != m2["offset"]:
                    bad.append({"member": m2["name"], "parsed": m2["offset"],
                                "gdb": seen[m2["name"]]})
        if bad:
            out["mismatch"].append({"name": nm, "members": bad})
        else:
            out["agree"] += 1
    return out


# --------------------------------------------------------------------------
# Preconditions


# Symbols that record which toolchain configured the tree. They differ
# between the two sides by construction and no kernel type's layout reads
# them, so they are excluded from the configuration identity. Every other
# symbol -- including the CONFIG_CC_HAS_* capability answers and
# CONFIG_CC_IS_GCC, which Kconfig and kernel sources do branch on -- must
# match, because a difference there can move a member.
CONFIG_IDENT = re.compile(
    r"^CONFIG_(CC_VERSION_TEXT|GCC_VERSION|CLANG_VERSION|LLD_VERSION|"
    r"RUSTC_VERSION\w*|BINDGEN_VERSION\w*|AS_VERSION|LD_VERSION|"
    r"PAHOLE_VERSION)=")

# A symbol with a value, as opposed to a blank line, a section comment, or
# the `# CONFIG_X is not set` form Kconfig writes for a visible unset one.
CONFIG_SET = re.compile(r"^CONFIG_\w+=")


def config_digest(tree: Path) -> tuple[str, str, list[str]]:
    """(exact digest, digest with toolchain identification removed, the
    identification lines that were removed).

    The second digest covers the symbols that are set, not the file's
    text. A symbol left unset is written as an `is not set` comment only
    while Kconfig considers it visible, and visibility can turn on the
    linker's version -- so the badc-linked and reference-linked trees
    write a different number of those comments for symbols that are
    unset on both sides. Comparing the set symbols keeps the guarantee
    the check exists for: equal digests mean equal configurations."""
    cfg = tree / ".config"
    if not cfg.is_file():
        die(f"{tree} has no .config; the trees must be configured")
    raw = cfg.read_bytes()
    ident, kept = [], []
    for line in raw.decode(errors="replace").splitlines():
        if CONFIG_IDENT.match(line):
            ident.append(line)
        elif CONFIG_SET.match(line):
            kept.append(line)
    return (hashlib.sha256(raw).hexdigest(),
            hashlib.sha256("\n".join(sorted(kept)).encode()).hexdigest(),
            ident)


def kernel_release(tree: Path) -> str:
    rel = tree / "include/config/kernel.release"
    if rel.is_file():
        return rel.read_text().strip()
    mk = (tree / "Makefile").read_text(errors="replace")
    parts = []
    for key in ("VERSION", "PATCHLEVEL", "SUBLEVEL"):
        m = re.search(rf"^{key}\s*=\s*(\S+)", mk, re.M)
        parts.append(m.group(1) if m else "?")
    return ".".join(parts)


def require_same_build(ref_tree: Path, badc_tree: Path) -> dict:
    """Refuse to compare trees that do not hold the same source and the same
    configuration: every layout difference such a comparison reports is a
    configuration artifact, so the run would be worthless rather than
    merely noisy."""
    r_exact, r_norm, r_ident = config_digest(ref_tree)
    b_exact, b_norm, b_ident = config_digest(badc_tree)
    ev = {
        "ref_tree": str(ref_tree), "badc_tree": str(badc_tree),
        "ref_config_sha256": r_exact, "badc_config_sha256": b_exact,
        "ref_config_sha256_no_ident": r_norm,
        "badc_config_sha256_no_ident": b_norm,
        "config_identical": r_exact == b_exact,
        "ref_release": kernel_release(ref_tree),
        "badc_release": kernel_release(badc_tree),
    }
    if r_norm != b_norm:
        die("the two trees are configured differently "
            f"({r_norm[:12]} vs {b_norm[:12]} with toolchain identification "
            "removed); a layout comparison across configurations measures "
            "the configuration, not the compiler")
    if ev["ref_release"] != ev["badc_release"]:
        die(f"kernel release differs: {ev['ref_release']} vs "
            f"{ev['badc_release']}")
    if r_exact != b_exact:
        ev["toolchain_identification_differs"] = sorted(
            set(r_ident) ^ set(b_ident))
        log("configurations agree except for toolchain identification "
            f"({len(ev['toolchain_identification_differs'])} lines)")
    ev["ok"] = True
    return ev


def pair_artifacts(ref_tree: Path, badc_tree: Path) -> list[tuple[str, Path, Path]]:
    """(relative name, ref path, badc path) for vmlinux and every .ko both
    trees built."""
    out = []
    for rel in ["vmlinux"]:
        r, b = ref_tree / rel, badc_tree / rel
        if r.is_file() and b.is_file():
            out.append((rel, r, b))
    ref_ko = {p.relative_to(ref_tree).as_posix() for p in ref_tree.rglob("*.ko")}
    badc_ko = {p.relative_to(badc_tree).as_posix()
               for p in badc_tree.rglob("*.ko")}
    for rel in sorted(ref_ko & badc_ko):
        out.append((rel, ref_tree / rel, badc_tree / rel))
    return out


# --------------------------------------------------------------------------
# Replay mode


class Unit(NamedTuple):
    """One replayed translation unit: its source, the driver the tree
    recorded, the arguments behind that driver, and the CC shim's script
    name when the driver is one of them."""
    source: str
    driver: str
    args: list[str]
    shim: str | None


def split_driver(argv: list[str]) -> tuple[str, list[str], str | None]:
    """(driver, arguments behind it, CC shim script name or None).

    Kbuild records ``$(CC) <args>``, optionally through an interpreter when
    ``CC`` names a script."""
    i = 1 if len(argv) > 1 and Path(argv[0]).name.startswith("python") else 0
    name = Path(argv[i]).name
    return argv[i], argv[i + 1:], name if name in CC_SHIMS else None


def replay_corpus(tree: Path, limit: int, stride: int) -> list[Unit]:
    """The kernel C units to replay from the tree's Kbuild `.cmd` corpus.
    `stride` keeps every Nth unit of the path-sorted corpus, a sample spread
    over the subsystems rather than a prefix of one; `limit` caps the count."""
    units: list[Unit] = []
    seen = 0
    for p in sorted(tree.rglob(".*.o.cmd")):
        if set(p.relative_to(tree).parts) & sweep.SKIP_DIRS:
            continue
        argv = sweep.parse_cmd_file(p)
        if not argv:
            continue
        kind, src = sweep.classify(argv)
        if kind != "c":
            continue
        seen += 1
        if (seen - 1) % stride:
            continue
        driver, rest, shim = split_driver(argv)
        units.append(Unit(src, driver, rest, shim))
        if limit and len(units) >= limit:
            break
    return units


def first_line(text: str) -> str:
    lines = [ln.strip() for ln in (text or "").splitlines() if ln.strip()]
    return lines[0] if lines else ""


def reference_cc(args, units: list[Unit], report: dict) -> str | None:
    """The compiler the reference leg runs, or None to keep each unit's own
    recorded driver.

    The recorded driver is the reference compiler in a tree the reference
    compiler built. It is not one in a tree built through a CC shim:
    re-running the shim compiles the reference leg with badc too, and with
    ``$BADC`` unset it compiles nothing at all."""
    shims = sorted({u.shim for u in units if u.shim})
    shim_units = sum(1 for u in units if u.shim)
    report["reference_cc"] = {
        "units": len(units), "shim_units": shim_units,
        "recorded_shims": shims,
        "recorded_drivers": sorted({u.driver for u in units})[:4],
    }
    if args.real_cc:
        name, why = args.real_cc, "--real-cc"
    elif not shims:
        report["reference_cc"]["resolved"] = "recorded driver"
        return None
    else:
        env = os.environ.get("BADC_REAL_CC")
        name = env or karch.tool(args.arch, "gcc")
        why = "$BADC_REAL_CC" if env else f"the {args.arch} gcc"
    path = executable(name)
    report["reference_cc"].update({"resolved": name, "source": why,
                                   "path": path})
    if path is None:
        die((f"{args.tree} records {' and '.join(shims)} as the compiler of "
             f"{shim_units} of {len(units)} replayed units; that is badc's "
             "Kbuild CC shim, not a compiler, so replaying it makes the "
             "reference leg badc as well. " if shims else "")
            + f"The reference compiler for the replay -- {name}, from {why} "
              "-- is not executable. Pass --real-cc with a compiler that "
              "builds this kernel"
            + (", or replay a tree the reference compiler built."
               if shims else "."))
    return path


def replay_units(tree: Path, arch: str, badc: Path, scratch: Path,
                 jobs: int, timeout: int, units: list[Unit],
                 ref_cc: str | None) -> list[dict]:
    """Compile each unit with both compilers at debug-info level into
    `scratch`, returning per-unit object paths. `ref_cc` drives the
    reference leg in place of the recorded driver; None keeps that
    driver."""
    target = sweep.TARGETS[arch]
    scratch.mkdir(parents=True, exist_ok=True)

    def one(idx_item):
        idx, u = idx_item
        stem = f"{idx:05d}-{Path(u.source).name}"
        rec = {"source": u.source, "ref_obj": None, "badc_obj": None,
               "ref_rc": None, "badc_rc": None, "ref_error": None,
               "badc_error": None}
        ro = scratch / f"{stem}.ref.o"
        cmd = [ref_cc or u.driver, *u.args]
        for i, a in enumerate(cmd[:-1]):
            if a == "-o":
                cmd[i + 1] = str(ro)
        cmd += ["-gdwarf-4"]
        cmd = [a for a in cmd if not a.startswith("-Wp,-MMD,")]
        bo = scratch / f"{stem}.badc.o"
        bcmd = [str(badc), "--gnu", "-q", "-c", f"--target={target}",
                *sweep.rewrite([u.driver, *u.args]), "-g", u.source,
                "-o", str(bo)]
        # An object already in the scratch directory is reused: a re-run
        # then costs only the extraction, and an interrupted run resumes.
        for key, obj, run in (("ref", ro, cmd), ("badc", bo, bcmd)):
            if obj.is_file() and obj.stat().st_size:
                rec[f"{key}_obj"], rec[f"{key}_rc"] = str(obj), "cached"
                continue
            try:
                r = subprocess.run(run, cwd=tree, capture_output=True,
                                   text=True, timeout=timeout)
                rec[f"{key}_rc"] = r.returncode
                if r.returncode == 0 and obj.is_file():
                    rec[f"{key}_obj"] = str(obj)
                else:
                    rec[f"{key}_error"] = (first_line(r.stderr)
                                           or f"exit {r.returncode}")
            except subprocess.TimeoutExpired:
                rec[f"{key}_rc"] = "timeout"
                rec[f"{key}_error"] = f"timeout after {timeout}s"
            except OSError as e:
                rec[f"{key}_rc"] = f"exec-failed: {e.strerror}"
                rec[f"{key}_error"] = f"{run[0]}: {e.strerror}"
        return rec

    with ThreadPoolExecutor(max_workers=jobs) as pool:
        return list(pool.map(one, enumerate(units)))


def extract_pair(args: tuple[str, str, str]) -> tuple[dict, dict]:
    """(reference, badc) extraction for one unit pair, as a process-pool
    payload: parsing the dumper's output is interpreter-bound, so unit pairs
    are spread over processes rather than threads."""
    ref, badc, dwarfdump = args
    return extract(Path(ref), dwarfdump), extract(Path(badc), dwarfdump)


def merge(into: dict, other: dict) -> dict:
    """Fold one extraction result into an accumulator."""
    if not into:
        return {"aggregates": {k: {"kind": v["kind"],
                                   "layouts": dict(v["layouts"])}
                               for k, v in other["aggregates"].items()},
                "units": other["units"], "big_endian": other["big_endian"],
                "addr_size": other["addr_size"]}
    for nm, ent in other["aggregates"].items():
        cur = into["aggregates"].setdefault(nm, {"kind": ent["kind"],
                                                 "layouts": {}})
        for key, val in ent["layouts"].items():
            slot = cur["layouts"].get(key)
            if slot is None:
                cur["layouts"][key] = dict(val)
            else:
                slot["count"] += val["count"]
    into["units"] += other["units"]
    return into


# --------------------------------------------------------------------------
# Reporting


def fmt_member_diff(d: dict) -> str:
    bits = ", ".join(
        f"{f} {v[0]}->{v[1]}" for f, v in sorted(d["fields"].items()))
    return f"      {d['member']}: {bits}"


def write_report(path: Path | None, report: dict) -> None:
    if path is None:
        return
    try:
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(json.dumps(report, indent=1, sort_keys=True,
                                   default=str))
    except OSError as e:
        log(f"could not write {path}: {e.strerror}")
        return
    log(f"report: {path}")


def summarize(res: dict, top: int) -> str:
    c = res["counts"]
    lines = [
        f"structs/unions compared:      {c['compared']}",
        f"  identical:                  {c['identical']}",
        f"  layout differs (ABI defect):{c['layout_differing']:5d}",
        f"  member type differs:        {c['type_differing']}",
        f"  coverage gap (debug info):  {c['coverage_gap']}",
        f"  ambiguous (>1 layout):      {c['ambiguous']}",
        f"reference-only names:         {c['ref_only']}",
        f"badc-only names:              {c['badc_only']}",
    ]
    if res["differences"]:
        lines.append("")
        lines.append(f"top {min(top, len(res['differences']))} layout "
                     "differences by incidence (units defining the type):")
        for d in res["differences"][:top]:
            head = f"  {d['kind']} {d['name']}  (in {d['incidence']} units)"
            if d["size"]:
                head += f"  size {d['size']['ref']} -> {d['size']['badc']}"
            if d["ambiguous"]:
                # The build defines this tag name more than once; the two
                # sides may not have picked the same definition.
                head += "  [ambiguous name]"
            lines.append(head)
            for m in d["members"][:8]:
                lines.append(fmt_member_diff(m))
            if len(d["members"]) > 8:
                lines.append(f"      ... {len(d['members']) - 8} more members")
    if res["type_differences"]:
        lines.append("")
        lines.append(f"top {min(top, len(res['type_differences']))} member "
                     "type differences (offsets and aggregate size agree):")
        for d in res["type_differences"][:top]:
            lines.append(f"  {d['name']}  (in {d['incidence']} units)")
            for m in d["members"][:4]:
                lines.append(fmt_member_diff(m)
                             + f"   [{m['type'][0]} | {m['type'][1]}]")
    if res["coverage"]:
        lines.append("")
        lines.append(f"top {min(top, len(res['coverage']))} coverage gaps "
                     "(offsets agree where both sides describe a member):")
        for d in res["coverage"][:top]:
            note = (f" incomplete in {'/'.join(d['incomplete_in'])}"
                    if d["incomplete_in"] else "")
            lines.append(
                f"  {d['name']}  (in {d['incidence']} units)  members "
                f"{d['member_count']['ref']} -> {d['member_count']['badc']}"
                f"{note}")
    return "\n".join(lines)


SELF_TEST_DUMP = """\
0x00000000: Compile Unit: length = 0x100, format = DWARF32, version = 0x0004
0x0000000b: DW_TAG_compile_unit
              DW_AT_name	("t.c")
0x00000020:   DW_TAG_base_type
                DW_AT_name	("unsigned int")
                DW_AT_byte_size	(0x04)
0x00000030:   DW_TAG_base_type
                DW_AT_name	("char")
                DW_AT_byte_size	(0x01)
0x00000040:   DW_TAG_structure_type
                DW_AT_name	("modern")
                DW_AT_byte_size	(0x08)
0x00000048:     DW_TAG_member
                  DW_AT_name	("a")
                  DW_AT_type	(0x00000020 "unsigned int")
                  DW_AT_data_bit_offset	(0)
                  DW_AT_bit_size	(3)
0x00000050:     DW_TAG_member
                  DW_AT_name	("b")
                  DW_AT_type	(0x00000020 "unsigned int")
                  DW_AT_data_bit_offset	(3)
                  DW_AT_bit_size	(5)
0x00000058:     DW_TAG_member
                  DW_AT_name	("tail")
                  DW_AT_type	(0x00000030 "char")
                  DW_AT_data_member_location	(DW_OP_plus_uconst 0x4)
0x00000060:   DW_TAG_structure_type
                DW_AT_name	("legacy")
                DW_AT_byte_size	(0x08)
0x00000068:     DW_TAG_member
                  DW_AT_name	("a")
                  DW_AT_type	(0x00000020 "unsigned int")
                  DW_AT_byte_size	(0x04)
                  DW_AT_bit_offset	(29)
                  DW_AT_bit_size	(3)
                  DW_AT_data_member_location	(0)
0x00000070:     DW_TAG_member
                  DW_AT_name	("b")
                  DW_AT_type	(0x00000020 "unsigned int")
                  DW_AT_byte_size	(0x04)
                  DW_AT_bit_offset	(24)
                  DW_AT_bit_size	(5)
                  DW_AT_data_member_location	(0)
0x00000078:     DW_TAG_member
                  DW_AT_name	("tail")
                  DW_AT_type	(0x00000030 "char")
                  DW_AT_data_member_location	(4)
0x00000080:   DW_TAG_structure_type
                DW_AT_name	("__anon_struct_17")
                DW_AT_byte_size	(0x04)
0x00000088:   DW_TAG_union_type
                DW_AT_name	("__anon_union_3_in___anon_struct_1_in_outer")
                DW_AT_byte_size	(0x04)
0x00000090:   DW_TAG_structure_type
                DW_AT_name	("fwd")
                DW_AT_declaration	(true)
"""


ANON_TEST_DUMP = """\
0x00000000: Compile Unit: length = 0x80, format = DWARF32, version = 0x0004
0x0000000b: DW_TAG_compile_unit
              DW_AT_name	("a.c")
0x00000020:   DW_TAG_base_type
                DW_AT_name	("int")
                DW_AT_byte_size	(0x04)
0x00000030:   DW_TAG_structure_type
                DW_AT_byte_size	(0x08)
0x00000038:     DW_TAG_member
                  DW_AT_name	("x")
                  DW_AT_type	(0x00000020 "int")
                  DW_AT_data_member_location	(0)
0x00000040:     DW_TAG_member
                  DW_AT_name	("y")
                  DW_AT_type	(0x00000020 "int")
                  DW_AT_data_member_location	(4)
0x00000050:   DW_TAG_structure_type
                DW_AT_name	("outer")
                DW_AT_byte_size	(0x0c)
0x00000058:     DW_TAG_member
                  DW_AT_name	("head")
                  DW_AT_type	(0x00000020 "int")
                  DW_AT_data_member_location	(0)
0x00000060:     DW_TAG_member
                  DW_AT_type	(0x00000030 "")
                  DW_AT_data_member_location	(4)
"""


def _self_test() -> int:
    """Parse a synthetic dump and assert the layout facts, so the two DWARF
    bitfield encodings, the exprloc member location, synthesized anonymous
    names and incomplete declarations stay covered without a toolchain."""
    tables = list(parse_units(
        ln for ln in SELF_TEST_DUMP.splitlines(True) if DUMP_FILTER.search(ln)))
    assert len(tables) == 1, len(tables)
    got = {nm: (size, members) for nm, _k, size, members
           in unit_aggregates(tables[0], big_endian=False, addr_size=8)}
    assert set(got) == {"modern", "legacy"}, sorted(got)

    for nm in ("modern", "legacy"):
        size, ms = got[nm]
        assert size == 8, (nm, size)
        by = {m["name"]: m for m in ms}
        # Both encodings must normalize to the same absolute bit offsets.
        assert (by["a"]["bit_offset"], by["a"]["bit_size"]) == (0, 3), by["a"]
        assert (by["b"]["bit_offset"], by["b"]["bit_size"]) == (3, 5), by["b"]
        assert by["tail"]["offset"] == 4, by["tail"]
        assert by["tail"]["size"] == 1, by["tail"]
        assert by["tail"]["bit_size"] is None

    # Big-endian reads the pre-4 form directly rather than complementing it.
    be = {nm: ms for nm, _k, _s, ms
          in unit_aggregates(tables[0], big_endian=True, addr_size=8)}
    assert [m["bit_offset"] for m in be["legacy"] if m["bit_size"]] == [29, 24]

    ref = {"aggregates": {"s": {"kind": "struct", "layouts": {
        "k": {"count": 3, "size": 8,
              "members": [{"name": "a", "offset": 0, "size": 4,
                           "bit_offset": None, "bit_size": None, "type": "int"},
                          {"name": "b", "offset": 4, "size": 4,
                           "bit_offset": None, "bit_size": None,
                           "type": "int"}]}}}},
        "units": 3, "big_endian": False, "addr_size": 8}
    bad = json.loads(json.dumps(ref))
    bad["aggregates"]["s"]["layouts"]["k"]["members"][1]["offset"] = 8
    bad["aggregates"]["s"]["layouts"]["k"]["size"] = 12
    res = compare(ref, bad)
    assert res["counts"]["layout_differing"] == 1, res["counts"]
    d = res["differences"][0]
    assert d["size"] == {"ref": 8, "badc": 12}, d
    assert d["members"] == [{"member": "b", "kind": "field",
                             "fields": {"offset": [4, 8]},
                             "type": ["int", "int"]}], d["members"]
    assert d["incidence"] == 3, d
    assert compare(ref, ref)["counts"]["identical"] == 1

    # A member only one side describes is a coverage gap, not a difference.
    thin = json.loads(json.dumps(ref))
    thin["aggregates"]["s"]["layouts"]["k"]["members"].pop()
    res = compare(ref, thin)
    assert res["counts"] == {**res["counts"], "layout_differing": 0,
                             "coverage_gap": 1, "identical": 0}, res["counts"]
    assert res["coverage"][0]["members"] == [
        {"member": "b", "kind": "missing-in-badc"}], res["coverage"]

    # An aggregate both sides agree is empty is identical, not a gap.
    empty = {"aggregates": {"e": {"kind": "struct", "layouts": {
        "k": {"count": 1, "size": 0, "members": []}}}},
        "units": 1, "big_endian": False, "addr_size": 8}
    assert compare(empty, empty)["counts"]["identical"] == 1, \
        compare(empty, empty)["counts"]
    # ... but one side describing nothing where the other has a definition is.
    assert compare(ref, empty)["counts"]["coverage_gap"] == 0  # name differs
    two = json.loads(json.dumps(ref))
    two["aggregates"]["e"] = empty["aggregates"]["e"]
    other = json.loads(json.dumps(two))
    other["aggregates"]["e"]["layouts"]["k"] = {
        "count": 1, "size": 8, "members": [
            {"name": "q", "offset": 0, "size": 8, "bit_offset": None,
             "bit_size": None, "type": "long"}]}
    assert compare(two, other)["counts"]["coverage_gap"] == 1, \
        compare(two, other)["counts"]

    # A tag name the build defines twice is evidence of nothing: the two
    # sides need not have picked the same definition.
    amb = json.loads(json.dumps(ref))
    amb["aggregates"]["s"]["layouts"]["other"] = {
        "count": 1, "size": 99, "members": []}
    res = compare(ref, amb)
    assert res["counts"]["ambiguous"] == 1, res["counts"]
    assert res["counts"]["layout_differing"] == 0, res["counts"]

    # An unbounded array's extent is zero, not 2**32.
    tbl = {0: Die(0, "base_type")}
    tbl[0].attrs["byte_size"] = "0x04"
    arr = Die(1, "array_type")
    arr.attrs["type"] = "0x00000000"
    sub = Die(2, "subrange_type")
    sub.attrs["upper_bound"] = "0xffffffff"
    arr.kids.append(sub)
    tbl[1] = arr
    assert type_size(arr, tbl, 8) == 0, type_size(arr, tbl, 8)
    sub.attrs["upper_bound"] = "-1"
    assert type_size(arr, tbl, 8) == 0
    sub.attrs["upper_bound"] = "0x07"
    assert type_size(arr, tbl, 8) == 32

    # gdb renders a bitfield as `unsigned int b : 3;`; the member is `b`.
    line = "/*      4: 0   |       4 */    unsigned int b : 3;"
    m = GDB_OFFSET_RE.match(line.strip())
    assert m and re.match(r"^.*?\b(\w+)\s*(?:\[|:|;)",
                          m.group(5)).group(1) == "b", line

    # An unnamed member holding an anonymous aggregate flattens to its leaves.
    anon = list(parse_units(ln for ln in ANON_TEST_DUMP.splitlines(True)
                            if DUMP_FILTER.search(ln)))[0]
    got = {nm: ms for nm, _k, _s, ms
           in unit_aggregates(anon, big_endian=False, addr_size=8)}
    assert [(m["name"], m["offset"]) for m in got["outer"]] == [
        ("head", 0), ("x", 4), ("y", 8)], got["outer"]

    # A tree the badc gate built records the CC shim, not a compiler.
    shim = str(LINUX_DIR / "buildcc.py")
    assert split_driver([shim, "-c", "a.c"]) == (shim, ["-c", "a.c"],
                                                 "buildcc.py")
    assert split_driver(["python3", shim, "-c"]) == (shim, ["-c"],
                                                     "buildcc.py")
    assert split_driver(["gcc", "-c", "a.c"]) == ("gcc", ["-c", "a.c"], None)
    assert split_driver(["/usr/bin/aarch64-linux-gnu-gcc", "-c"]) == (
        "/usr/bin/aarch64-linux-gnu-gcc", ["-c"], None)

    ns = argparse.Namespace(real_cc=None, arch="x86_64", tree=Path("/t"))
    gcc_units = [Unit("a.c", "gcc", ["-c"], None)]
    shim_units = [Unit("a.c", shim, ["-c"], "buildcc.py")]
    rep: dict = {}
    assert reference_cc(ns, gcc_units, rep) is None, rep
    assert rep["reference_cc"]["recorded_shims"] == []
    saved = os.environ.get("BADC_REAL_CC")
    try:
        os.environ["BADC_REAL_CC"] = sys.executable
        rep = {}
        assert reference_cc(ns, shim_units, rep) == sys.executable, rep
        assert rep["reference_cc"]["shim_units"] == 1, rep
        ns.real_cc = sys.executable
        assert reference_cc(ns, gcc_units, {}) == sys.executable
        ns.real_cc = None
        # A shim with no compiler behind it stops the run rather than
        # reporting an empty comparison.
        os.environ["BADC_REAL_CC"] = "layout-self-test-absent-cc"
        try:
            reference_cc(ns, shim_units, {})
        except SystemExit as e:
            assert "Kbuild CC shim" in str(e.code), e.code
            assert "layout-self-test-absent-cc" in str(e.code), e.code
        else:
            raise AssertionError("a shim with no compiler must stop the run")
    finally:
        os.environ.pop("BADC_REAL_CC", None)
        if saved is not None:
            os.environ["BADC_REAL_CC"] = saved

    # A run that cannot compare still publishes its report: the artifact is
    # what explains the failure.
    with tempfile.TemporaryDirectory() as d:
        rp = Path(d) / "out" / "layout.json"
        try:
            main(["--replay", "--tree", d, "--report", str(rp),
                  "--dwarfdump", sys.executable])
        except SystemExit:
            pass
        assert rp.is_file(), rp
        assert json.loads(rp.read_text()).get("error"), rp.read_text()

    print("linux layout: self-test ok")
    return 0


def run(args, report: dict) -> int:
    modes = [bool(args.ref_elf and args.badc_elf),
             bool(args.ref_tree and args.badc_tree),
             bool(args.replay)]
    if sum(modes) != 1:
        die("choose exactly one of --ref-elf/--badc-elf, "
            "--ref-tree/--badc-tree, or --replay --tree")
    dwarfdump = tool(args.dwarfdump)

    ref_acc: dict = {}
    badc_acc: dict = {}
    sample_elf: Path | None = None

    if args.replay:
        if not args.tree:
            die("--replay needs --tree")
        report["mode"] = "replay"
        badc = sweep.resolve_badc(str(args.badc) if args.badc else None)
        scratch = args.scratch or (
            (args.report.parent if args.report else Path.cwd())
            / f"layout-replay-{args.arch}")
        report["preconditions"] = {
            "tree": str(args.tree),
            "config_sha256": config_digest(args.tree)[0],
            "release": kernel_release(args.tree),
            "same_source_and_config": "by construction: both compilers "
                                      "replay the same recorded arguments "
                                      "over the same tree",
        }
        stride = max(1, args.stride)
        units = replay_corpus(args.tree, args.limit, stride)
        if not units:
            die(f"{args.tree} holds no kernel C unit .cmd file; the tree has "
                "not been built, so there is no command to replay")
        # Resolved before anything is compiled: a reference leg that cannot
        # run is a defect in the invocation, not a result to be reported as
        # an empty comparison.
        ref_cc = reference_cc(args, units, report)
        log(f"replaying {len(units)} units from {args.tree} "
            f"(jobs={args.jobs}, reference {ref_cc or 'as recorded'})")
        recs = replay_units(args.tree, args.arch, badc, scratch, args.jobs,
                            args.timeout, units, ref_cc)
        ok_ref = sum(1 for r in recs if r["ref_obj"])
        ok_badc = sum(1 for r in recs if r["badc_obj"])
        both = [r for r in recs if r["ref_obj"] and r["badc_obj"]]
        log(f"units: {len(recs)}; reference built {ok_ref}; badc built "
            f"{ok_badc}; both {len(both)}")
        report["replay"] = {
            "units": len(recs), "stride": stride, "ref_built": ok_ref,
            "badc_built": ok_badc, "both": len(both),
            "reference_cc": ref_cc or "as recorded",
            "failures": [{k: r[k] for k in ("source", "ref_rc", "ref_error",
                                            "badc_rc", "badc_error")}
                         for r in recs
                         if not (r["ref_obj"] and r["badc_obj"])][:50],
        }
        if not both:
            stalled = [n for n, k in (("the reference compiler", ok_ref),
                                      ("badc", ok_badc)) if not k]
            why = (" and ".join(stalled) + " compiled nothing" if stalled
                   else "no unit compiled on both sides")
            first = next((r for r in recs
                          if not (r["ref_obj"] and r["badc_obj"])), None)
            detail = "; ".join(
                f"{lbl} {first[k + '_error']}" for k, lbl in
                (("ref", "reference:"), ("badc", "badc:"))
                if first and first[k + "_error"])
            die(f"the replay produced no comparable unit pair out of "
                f"{len(recs)} units: {why} (reference {ok_ref}, badc "
                f"{ok_badc}, reference compiler {ref_cc or 'as recorded'})."
                + (f" First failure, {first['source']} -- {detail}"
                   if detail else ""))
        payload = [(r["ref_obj"], r["badc_obj"], dwarfdump) for r in both]
        with ProcessPoolExecutor(max_workers=args.jobs) as pool:
            for i, (rx, bx) in enumerate(
                    pool.map(extract_pair, payload, chunksize=8)):
                ref_acc, badc_acc = merge(ref_acc, rx), merge(badc_acc, bx)
                if i % 500 == 0:
                    log(f"extracted {i}/{len(both)} unit pairs")
        if both:
            sample_elf = Path(both[0]["badc_obj"])
    elif args.ref_tree:
        report["mode"] = "tree"
        report["preconditions"] = require_same_build(args.ref_tree,
                                                     args.badc_tree)
        pairs = pair_artifacts(args.ref_tree, args.badc_tree)
        if not pairs:
            die("neither tree holds a vmlinux or a .ko both sides built")
        log(f"comparing {len(pairs)} artifact pairs")
        for rel, r, b in pairs:
            t0 = time.time()
            rx, bx = extract(r, dwarfdump), extract(b, dwarfdump)
            report["artifacts"].append({
                "name": rel, "ref_units": rx["units"], "badc_units": bx["units"],
                "ref_names": len(rx["aggregates"]),
                "badc_names": len(bx["aggregates"]),
                "seconds": round(time.time() - t0, 1)})
            log(f"  {rel}: reference {len(rx['aggregates'])} names / "
                f"{rx['units']} units, badc {len(bx['aggregates'])} names / "
                f"{bx['units']} units ({time.time() - t0:.1f}s)")
            ref_acc, badc_acc = merge(ref_acc, rx), merge(badc_acc, bx)
            # vmlinux is first and carries the most types: cross-check there
            # rather than in whichever artifact happened to come last.
            sample_elf = sample_elf or b
    else:
        report["mode"] = "elf"
        report["preconditions"] = {"note": "two ELF files compared directly; "
                                           "sameness of source and "
                                           "configuration is the caller's"}
        ref_acc = extract(args.ref_elf, dwarfdump)
        badc_acc = extract(args.badc_elf, dwarfdump)
        sample_elf = args.badc_elf
        report["artifacts"].append({"name": str(args.badc_elf),
                                    "ref_units": ref_acc["units"],
                                    "badc_units": badc_acc["units"]})

    for side, acc in (("reference", ref_acc), ("badc", badc_acc)):
        if not acc or not acc.get("aggregates"):
            die(f"the {side} side yielded no aggregates; it carries no debug "
                "info (CONFIG_DEBUG_INFO_DWARF4) or could not be read")

    res = compare(ref_acc, badc_acc)
    report["result"] = res

    if args.cross_check and sample_elf is not None:
        gdb = tool(args.gdb, "for --cross-check")
        names = [d["name"] for d in res["differences"][:args.cross_check]]
        pool = [n for n, e in sorted(badc_acc["aggregates"].items())
                if dominant(e)[0]["members"] and n not in names]
        names += pool[:max(0, args.cross_check - len(names))]
        log(f"gdb cross-check on {len(names)} aggregates in {sample_elf.name}")
        report["cross_check"] = cross_check(sample_elf, badc_acc, names, gdb)
        cc = report["cross_check"]
        log(f"  gdb agreed on {cc['agree']}/{cc['checked']} "
            f"({cc['unavailable']} not visible to gdb)")

    print(summarize(res, args.top))
    return 1 if res["counts"]["layout_differing"] else 0


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(
        description="compare struct layouts between a reference-compiler "
                    "kernel build and a badc one")
    ap.add_argument("--arch", choices=ARCHES, default=host_arch())
    ap.add_argument("--ref-elf", type=Path, help="reference ELF to compare")
    ap.add_argument("--badc-elf", type=Path, help="badc ELF to compare")
    ap.add_argument("--ref-tree", type=Path, help="reference kernel tree")
    ap.add_argument("--badc-tree", type=Path, help="badc kernel tree")
    ap.add_argument("--replay", action="store_true",
                    help="compile each unit of --tree with both compilers "
                         "and compare per unit")
    ap.add_argument("--tree", type=Path, help="kernel tree for --replay")
    ap.add_argument("--badc", type=Path, help="badc binary")
    ap.add_argument("--real-cc",
                    help="reference compiler for --replay; replaces the "
                         "driver the tree recorded (default: that driver, or "
                         "$BADC_REAL_CC / the target's gcc when the tree "
                         "records a badc CC shim)")
    ap.add_argument("--scratch", type=Path,
                    help="replay object directory (default: alongside "
                         "--report)")
    ap.add_argument("--limit", type=int, default=0,
                    help="replay at most N units (0: all)")
    ap.add_argument("--stride", type=int, default=1,
                    help="replay every Nth unit of the path-sorted corpus "
                         "(default 1: every unit)")
    ap.add_argument("-j", "--jobs", type=int, default=os.cpu_count() or 4)
    ap.add_argument("--timeout", type=int, default=600,
                    help="seconds per compile in --replay")
    ap.add_argument("--cross-check", type=int, default=0, metavar="N",
                    help="re-read N aggregates with gdb and assert the parse "
                         "agrees")
    ap.add_argument("--top", type=int, default=25,
                    help="differences to print in the summary")
    ap.add_argument("--report", type=Path, help="write the full result as JSON")
    ap.add_argument("--dwarfdump", default="llvm-dwarfdump")
    ap.add_argument("--gdb", default="gdb")
    ap.add_argument("--self-test", action="store_true",
                    help="check the DWARF parse and the differ, no inputs")
    args = ap.parse_args(argv)

    if args.self_test:
        return _self_test()

    started = time.time()
    report: dict = {"arch": args.arch, "mode": None, "preconditions": {},
                    "artifacts": []}
    try:
        return run(args, report)
    except SystemExit as e:
        # A precondition that stops the run is the finding, so it belongs in
        # the report the caller publishes, not only on the console.
        if isinstance(e.code, str):
            report["error"] = e.code
        raise
    finally:
        report.setdefault("seconds", round(time.time() - started, 1))
        write_report(args.report, report)


if __name__ == "__main__":
    raise SystemExit(main())
