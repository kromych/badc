#!/usr/bin/env python3
"""KASLR displacement control for the kernel gate.

A kernel booted with base randomization applies its relocations against a
displacement drawn at boot, so a defect in relocated output can present at one
displacement and not at another. verify.py therefore pins the displacements it
boots at rather than taking whatever the machine draws.

aarch64: the early boot code takes the displacement from `/chosen/kaslr-seed`
in the device tree it is handed, and `-M virt` honours a tree passed with
`-dtb`. `-M virt,dumpdtb=` writes the machine's own tree; `set_kaslr_seed`
overwrites the seed in it, and the result is passed back. Reusing one dumped
tree also fixes `/chosen/rng-seed`, which the guest's RNG consumes.

x86_64: the boot path mixes RDRAND, the TSC and the i8254 counter with a hash
of `boot_params` (arch/x86/lib/kaslr.c). No part of that is settable by the
boot loader, the command line or the firmware, so a displacement there cannot
be pinned -- only observed.

Both architectures print `Kernel Offset:` from the panic notifier, so a boot
that ends in a panic reports the displacement it ran at.

Run this file directly to self-check the device-tree writer and the log parser.
"""

from __future__ import annotations

import random
import re
import struct
import sys

# Seeds the gate pins its aarch64 boots to. Fixed so a run covers the same
# displacements as the last one and a regression is attributable; `seed_plan`
# adds one drawn per run so the covered set is not frozen to these three.
DEFAULT_SEEDS = (
    0xDAA66D1041C67EA6,
    0x0000000100000002,
    0xFFFFFFFFFFFFFFFF,
)

FDT_MAGIC = 0xD00DFEED
FDT_BEGIN_NODE = 1
FDT_END_NODE = 2
FDT_PROP = 3
FDT_NOP = 4
FDT_END = 9

KASLR_SEED_PROP = "kaslr-seed"
CHOSEN_NODE = "chosen"

# "Kernel Offset: 0x<disp> from 0x<link addr>" (both arches) or
# "Kernel Offset: disabled" when the kernel drew no displacement.
_OFFSET_RE = re.compile(r"Kernel Offset:\s+(disabled|0x[0-9a-fA-F]+)")


class FdtError(Exception):
    """The device tree does not carry a property the caller asked to set."""


def _u32(buf: bytes, off: int) -> int:
    return struct.unpack_from(">I", buf, off)[0]


def _cstr(buf: bytes, off: int) -> str:
    end = buf.index(b"\0", off)
    return buf[off:end].decode("ascii", "replace")


def find_property(dtb: bytes, node: str, prop: str) -> tuple[int, int]:
    """Byte offset and length of `/<node>/<prop>`'s value inside `dtb`.

    Walks the structure block (DTSpec 5.4). Raises FdtError when the tree is
    not a flattened device tree or does not carry the property.
    """
    if len(dtb) < 40 or _u32(dtb, 0) != FDT_MAGIC:
        raise FdtError("not a flattened device tree")
    off_struct = _u32(dtb, 8)
    off_strings = _u32(dtb, 12)
    size_struct = _u32(dtb, 36)
    cur, end = off_struct, off_struct + size_struct
    path: list[str] = []
    while cur + 4 <= end:
        token = _u32(dtb, cur)
        cur += 4
        if token == FDT_BEGIN_NODE:
            name = _cstr(dtb, cur)
            cur += (len(name) + 4) & ~3
            path.append(name)
        elif token == FDT_END_NODE:
            if path:
                path.pop()
        elif token == FDT_PROP:
            length = _u32(dtb, cur)
            nameoff = _u32(dtb, cur + 4)
            data = cur + 8
            cur = data + ((length + 3) & ~3)
            if path[1:] == [node] and _cstr(dtb, off_strings + nameoff) == prop:
                return data, length
        elif token == FDT_NOP:
            continue
        elif token == FDT_END:
            break
        else:
            raise FdtError(f"unknown structure token {token} at {cur - 4}")
    raise FdtError(f"/{node}/{prop} is not in the device tree")


def pack(dtb: bytes) -> bytes:
    """Return `dtb` with the free space between its blocks removed.

    `-M virt,dumpdtb=` writes qemu's whole tree buffer, whose header claims
    all of it: passing that back with `-dtb` puts a megabyte-sized blob in
    guest memory over the images loaded around it, and the boot produces no
    output at all. Packing rebuilds the header offsets around the reservation,
    structure and strings blocks laid end to end.
    """
    if len(dtb) < 40 or _u32(dtb, 0) != FDT_MAGIC:
        raise FdtError("not a flattened device tree")
    off_struct, off_strings, off_rsv = _u32(dtb, 8), _u32(dtb, 12), _u32(dtb, 16)
    size_strings, size_struct = _u32(dtb, 32), _u32(dtb, 36)
    end = off_rsv
    while end + 16 <= len(dtb) and dtb[end : end + 16] != bytes(16):
        end += 16
    rsv = dtb[off_rsv : end + 16]
    new_rsv = 40
    new_struct = new_rsv + len(rsv)
    new_strings = new_struct + size_struct
    header = struct.pack(
        ">IIIIIIIIII",
        FDT_MAGIC,
        new_strings + size_strings,
        new_struct,
        new_strings,
        new_rsv,
        _u32(dtb, 20),
        _u32(dtb, 24),
        _u32(dtb, 28),
        size_strings,
        size_struct,
    )
    return (
        header
        + rsv
        + dtb[off_struct : off_struct + size_struct]
        + dtb[off_strings : off_strings + size_strings]
    )


def set_kaslr_seed(dtb: bytes, seed: int) -> bytes:
    """Return a packed `dtb` with `/chosen/kaslr-seed` replaced by `seed`.

    The value is overwritten in place -- no block moves, no property is added.
    A tree without the property is rejected rather than grown: `-M virt`
    writes one unless `dtb-randomness=off` says otherwise, and a grown tree
    would be a second code path the gate never exercises.
    """
    at, length = find_property(dtb, CHOSEN_NODE, KASLR_SEED_PROP)
    if length != 8:
        raise FdtError(f"/chosen/kaslr-seed is {length} bytes, expected 8")
    out = bytearray(dtb)
    struct.pack_into(">Q", out, at, seed & 0xFFFFFFFFFFFFFFFF)
    return pack(bytes(out))


def parse_kernel_offset(text: str) -> int | None:
    """The displacement the panic notifier reported, or None if it did not.

    "Kernel Offset: disabled" reads as 0: the kernel ran at its link address.
    """
    m = _OFFSET_RE.search(text)
    if not m:
        return None
    return 0 if m.group(1) == "disabled" else int(m.group(1), 16)


def parse_seed(text: str) -> int:
    """Parse a seed the command line spelled, in hex or decimal."""
    value = int(text, 0)
    if not 0 <= value <= 0xFFFFFFFFFFFFFFFF:
        raise ValueError(f"seed out of 64-bit range: {text}")
    return value


def format_offset(off: int | None) -> str:
    """A displacement as text; unknown when no boot reported one."""
    return "unknown" if off is None else f"0x{off:x}"


def seed_plan(boots: int, requested: list[str] | None,
              pinnable: bool) -> list[int | None]:
    """One seed per boot; None where the boot cannot be pinned.

    Spelled seeds are the whole plan. Otherwise it is the fixed seeds plus
    one drawn for this run: the fixed ones make a run cover the same
    displacements as the last one, and the drawn one keeps the covered set
    from being those three forever. It is reported, so a boot that fails on
    it replays exactly.
    """
    if requested:
        return [None if s == "random" else parse_seed(s) for s in requested]
    if not pinnable:
        return [None] * boots
    fixed = list(DEFAULT_SEEDS)[: max(boots - 1, 0)]
    return fixed + [random.getrandbits(64) for _ in range(boots - len(fixed))]


def displacement_failures(configured: bool, plan: list[int | None],
                          offsets: dict[int | None, int | None]) -> list[str]:
    """Check that the boots ran at the displacements the gate asked for.

    Without these the gate can quietly stop covering relocated output: a
    configuration change, a machine that ignores the seed, or a kernel that
    turns randomization off leaves every boot at the link address, and the
    boots still pass.
    """
    if not configured:
        return []
    if not [o for o in offsets.values() if o]:
        return ["the configuration randomizes the kernel base but no boot ran "
                "displaced: the gate is not covering relocated output"]
    pinned = [s for s in plan if s is not None]
    distinct = {offsets.get(s) for s in pinned}
    if len(set(pinned)) > 1 and len(distinct) == 1:
        return [f"{len(set(pinned))} distinct seeds all produced displacement "
                f"{format_offset(distinct.pop())}: the seed is not reaching "
                f"the kernel"]
    return []


def _synthetic_dtb(seed: int, slack: int = 0) -> bytes:
    """A minimal tree with /chosen/{rng-seed,kaslr-seed}, for the self-check.

    `slack` pads the tail and inflates the claimed total size, reproducing the
    shape `-M virt,dumpdtb=` writes.
    """
    strings = b"rng-seed\0kaslr-seed\0"
    body = struct.pack(">II", FDT_BEGIN_NODE, 0)  # root node, empty name
    body += struct.pack(">I", FDT_BEGIN_NODE) + b"chosen\0\0"
    body += struct.pack(">III", FDT_PROP, 32, 0) + bytes(32)
    body += struct.pack(">III", FDT_PROP, 8, 9) + struct.pack(">Q", seed)
    body += struct.pack(">II", FDT_END_NODE, FDT_END_NODE)
    body += struct.pack(">I", FDT_END)
    off_rsv = 40
    off_struct = off_rsv + 16
    off_strings = off_struct + len(body)
    header = struct.pack(
        ">IIIIIIIIII",
        FDT_MAGIC,
        off_strings + len(strings) + slack,
        off_struct,
        off_strings,
        off_rsv,
        17,
        16,
        0,
        len(strings),
        len(body),
    )
    return header + bytes(16) + body + strings + bytes(slack)


def _no_seed_dtb() -> bytes:
    """A tree whose /chosen carries only a bootargs string."""
    strings = b"bootargs\0"
    body = struct.pack(">II", FDT_BEGIN_NODE, 0)
    body += struct.pack(">I", FDT_BEGIN_NODE) + b"chosen\0\0"
    body += struct.pack(">III", FDT_PROP, 4, 0) + b"ro\0\0"
    body += struct.pack(">III", FDT_END_NODE, FDT_END_NODE, FDT_END)
    off_struct = 40
    off_strings = off_struct + len(body)
    header = struct.pack(">IIIIIIIIII", FDT_MAGIC, off_strings + len(strings),
                         off_struct, off_strings, 0, 17, 16, 0, len(strings),
                         len(body))
    return header + body + strings


def _self_test() -> int:
    dtb = _synthetic_dtb(0x1122334455667788)
    at, length = find_property(dtb, CHOSEN_NODE, KASLR_SEED_PROP)
    assert length == 8 and dtb[at : at + 8] == bytes.fromhex("1122334455667788")
    patched = set_kaslr_seed(dtb, 0xDAA66D1041C67EA6)
    assert len(patched) == len(dtb), "the seed is overwritten, not inserted"
    at2, len2 = find_property(patched, CHOSEN_NODE, KASLR_SEED_PROP)
    assert len2 == 8 and patched[at2 : at2 + 8] == bytes.fromhex("daa66d1041c67ea6")
    # The 32-byte rng-seed sits before it and must be untouched.
    rng_at, rng_len = find_property(patched, CHOSEN_NODE, "rng-seed")
    assert rng_len == 32 and patched[rng_at : rng_at + 32] == bytes(32)
    # A tree with free space claimed by its header packs down to the same
    # content, and the claimed size then matches the file.
    padded = _synthetic_dtb(0x1122334455667788, slack=4096)
    assert len(padded) == len(dtb) + 4096
    repacked = set_kaslr_seed(padded, 0xDAA66D1041C67EA6)
    assert repacked == patched, "a padded tree packs to the same bytes"
    assert _u32(repacked, 4) == len(repacked), "the header claims the whole file"
    for bad, why in (
        (b"", "empty"),
        (b"\0" * 64, "no magic"),
        (_synthetic_dtb(0)[:39], "truncated header"),
    ):
        try:
            find_property(bad, CHOSEN_NODE, KASLR_SEED_PROP)
        except FdtError:
            pass
        else:
            raise AssertionError(f"{why} input must be rejected")
    # `-M virt,dtb-randomness=off` writes a tree with neither seed: the caller
    # degrades to unpinned boots on this, so it has to be an error and not a
    # silently ignored write.
    try:
        set_kaslr_seed(_no_seed_dtb(), 1)
    except FdtError:
        pass
    else:
        raise AssertionError("a tree without the property must be rejected")

    a64 = "[    1.9] Kernel Offset: 0x2caef1a00000 from 0xffff800080000000"
    x86 = ("[    2.5] Kernel Offset: 0x21600000 from 0xffffffff81000000 "
           "(relocation range: 0xffffffff80000000-0xffffffffbfffffff)")
    assert parse_kernel_offset(a64) == 0x2CAEF1A00000
    assert parse_kernel_offset(x86) == 0x21600000
    assert parse_kernel_offset("[    2.5] Kernel Offset: disabled") == 0
    assert parse_kernel_offset("no panic here") is None
    assert parse_seed("0xdaa66d1041c67ea6") == DEFAULT_SEEDS[0]
    assert parse_seed("18") == 18
    assert len(set(DEFAULT_SEEDS)) == len(DEFAULT_SEEDS)

    plan = seed_plan(4, None, pinnable=True)
    assert plan[:3] == list(DEFAULT_SEEDS) and len(set(plan)) == 4, plan
    assert seed_plan(4, None, pinnable=True) != plan, "the last seed is drawn"
    assert seed_plan(3, None, pinnable=False) == [None] * 3
    assert seed_plan(9, ["0x1", "random"], pinnable=True) == [1, None]
    assert seed_plan(1, None, pinnable=True) not in ([None], []), "one boot pins"

    # The gate's own checks: a randomizing configuration whose boots did not
    # move, and seeds that all landed on one displacement, both mean the gate
    # stopped covering relocated output.
    assert displacement_failures(False, [1, 2], {1: 0, 2: 0}) == []
    assert len(displacement_failures(True, [1, 2], {1: 0, 2: 0})) == 1
    assert len(displacement_failures(True, [1, 2], {1: 4096, 2: 4096})) == 1
    assert displacement_failures(True, [1, 2], {1: 4096, 2: 8192}) == []
    assert displacement_failures(True, [1, 1], {1: 4096}) == []
    assert displacement_failures(True, [None], {None: 4096}) == []
    print("linux kaslr: self-test ok", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(_self_test())
