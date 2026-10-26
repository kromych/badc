#!/usr/bin/env python3
"""Build and check the SimpleSvm demo with badc.

Three checks, none of which loads a hypervisor (the boxes are shared and
an SVM fault takes the host down):

1. Driver build + structure. The converted SVM core (src/SimpleSvm.c,
   produced by setup.py) and the translated entry stubs (x64_asm.c) are
   compiled and linked into a native-subsystem .sys for
   --target=windows-x64 from any host. The output is parsed and
   asserted: PE32+, machine AMD64, Subsystem NATIVE, an entry point
   inside .text, and an import table naming ntoskrnl.exe. SimpleSvm is
   x86-64 only, so no arm64 driver is built.

2. Import resolution (Windows hosts only). Every name the driver imports
   from ntoskrnl.exe is looked up in the export directory of the host's
   own C:\\Windows\\System32\\ntoskrnl.exe, read as a file. An import the
   running kernel does not export would fail to load.

3. User-mode logic harness. The pure bitfield logic (the segment
   descriptor decode and the #GP event packing) is built for the host
   target by badc and, when a host C compiler is present, by that
   compiler too; both are run and their output compared. The harness
   also self-checks hand-computed invariants.

Override the badc binary with `BADC=path/to/badc`; the host C compiler
with `CC=...` (default: cc, then clang, then gcc).
"""

from __future__ import annotations

import os
import shutil
import struct
import subprocess
import sys
from pathlib import Path

DEMO = Path(__file__).resolve().parent
REPO_ROOT = DEMO.parents[1]
SRC = DEMO / "src"

IMAGE_FILE_MACHINE_AMD64 = 0x8664
IMAGE_SUBSYSTEM_NATIVE = 1
PE32PLUS_MAGIC = 0x20B

CORE = ["SimpleSvm.c"]
ASM = ["x64_asm.c"]

# ntoskrnl.exe imports the driver binds. Checked against the host
# kernel's exports on Windows (check 2).
EXPECTED_IMPORTS = {
    "ExAllocatePool2",
    "ExFreePoolWithTag",
    "MmAllocateContiguousNodeMemory",
    "MmFreeContiguousMemory",
    "MmGetPhysicalAddress",
    "KeGetCurrentIrql",
    "KeRaiseIrqlToDpcLevel",
    "KeLowerIrql",
    "KeBugCheck",
    "KeQueryActiveProcessorCountEx",
    "KeGetProcessorNumberFromIndex",
    "KeSetSystemGroupAffinityThread",
    "KeRevertToUserGroupAffinityThread",
    "RtlCaptureContext",
    "RtlInitializeBitMap",
    "RtlClearAllBits",
    "RtlSetBits",
    "ExInitializeDriverRuntime",
    "ExCreateCallback",
    "ExRegisterCallback",
    "ExUnregisterCallback",
    "ObfDereferenceObject",
    "vDbgPrintExWithPrefix",
    "strcmp",
    "memset",
    "memcpy",
}


def resolve_badc() -> Path:
    env = os.environ.get("BADC")
    cands: list[Path] = []
    if env:
        cands.append(Path(env))
    default = REPO_ROOT / "target" / "release" / "badc"
    cands += [default, default.with_suffix(".exe")]
    for c in cands:
        if c.is_file() and os.access(c, os.X_OK):
            return c
    sys.exit("smoke: badc not found; hint: cargo build --release --features full")


def host_cc() -> str | None:
    if os.environ.get("CC"):
        return os.environ["CC"]
    for cc in ("cc", "clang", "gcc"):
        if shutil.which(cc):
            return cc
    return None


def run(cmd: list[str], **kw) -> subprocess.CompletedProcess:
    return subprocess.run(cmd, capture_output=True, text=True, **kw)


# ---- minimal PE32+ reader -------------------------------------------------


class PE:
    def __init__(self, data: bytes):
        self.data = data
        self.pe = struct.unpack_from("<I", data, 0x3C)[0]
        if data[self.pe : self.pe + 4] != b"PE\0\0":
            raise ValueError("not a PE")
        self.machine, self.nsec = struct.unpack_from("<HH", data, self.pe + 4)
        opt = self.pe + 24
        self.magic = struct.unpack_from("<H", data, opt)[0]
        self.entry = struct.unpack_from("<I", data, opt + 16)[0]
        self.subsystem = struct.unpack_from("<H", data, opt + 68)[0]
        self.import_rva = struct.unpack_from("<I", data, opt + 112 + 1 * 8)[0]
        opt_size = struct.unpack_from("<H", data, self.pe + 20)[0]
        self.secs = []
        base = opt + opt_size
        for i in range(self.nsec):
            o = base + i * 40
            name = data[o : o + 8].rstrip(b"\0").decode("latin1")
            vsz, vrva, rsz, rptr = struct.unpack_from("<IIII", data, o + 8)
            self.secs.append((name, vrva, vsz, rptr, rsz))

    def rva2off(self, rva: int):
        for _n, vrva, vsz, rptr, rsz in self.secs:
            if vrva <= rva < vrva + max(vsz, rsz):
                return rptr + (rva - vrva)
        return None

    def section_of(self, rva: int):
        for n, vrva, vsz, rptr, rsz in self.secs:
            if vrva <= rva < vrva + max(vsz, rsz):
                return n
        return None

    def imports(self) -> dict[str, list[str]]:
        out: dict[str, list[str]] = {}
        if not self.import_rva:
            return out
        o = self.rva2off(self.import_rva)
        while True:
            oft, _t, _f, namerva, firstthunk = struct.unpack_from("<IIIII", self.data, o)
            if namerva == 0:
                break
            no = self.rva2off(namerva)
            dll = self.data[no : self.data.index(b"\0", no)].decode("latin1")
            names: list[str] = []
            t = self.rva2off(oft or firstthunk)
            while True:
                val = struct.unpack_from("<Q", self.data, t)[0]
                if val == 0:
                    break
                if not (val >> 63):
                    fo = self.rva2off(val & 0xFFFFFFFF)
                    names.append(self.data[fo + 2 : self.data.index(b"\0", fo + 2)].decode("latin1"))
                t += 8
            out[dll] = names
            o += 20
        return out

    def exports(self) -> set[str]:
        opt = self.pe + 24
        exp_rva, exp_sz = struct.unpack_from("<II", self.data, opt + 112)
        if not exp_rva:
            return set()
        o = self.rva2off(exp_rva)
        nnames = struct.unpack_from("<I", self.data, o + 24)[0]
        names_rva = struct.unpack_from("<I", self.data, o + 32)[0]
        names_off = self.rva2off(names_rva)
        out = set()
        for i in range(nnames):
            nrva = struct.unpack_from("<I", self.data, names_off + i * 4)[0]
            no = self.rva2off(nrva)
            out.add(self.data[no : self.data.index(b"\0", no)].decode("latin1"))
        return out


# ---- checks ---------------------------------------------------------------


def check_driver(badc: Path, work: Path) -> PE:
    out = work / "simplesvm.sys"
    cmd = [
        str(badc),
        "--target=windows-x64",
        "-I", str(DEMO / "include"),
        "-I", str(SRC),
        "-include", "svcompat.h",
    ]
    cmd += [str(SRC / f) for f in CORE]
    cmd += [str(DEMO / f) for f in ASM]
    cmd += ["-o", str(out)]
    p = run(cmd)
    if p.returncode != 0 or not out.exists():
        sys.exit(f"smoke: driver build failed\n{p.stdout}\n{p.stderr}")
    pe = PE(out.read_bytes())
    if pe.magic != PE32PLUS_MAGIC:
        sys.exit(f"smoke: not PE32+ (magic 0x{pe.magic:x})")
    if pe.machine != IMAGE_FILE_MACHINE_AMD64:
        sys.exit(f"smoke: machine 0x{pe.machine:x} (want AMD64)")
    if pe.subsystem != IMAGE_SUBSYSTEM_NATIVE:
        sys.exit(f"smoke: subsystem {pe.subsystem} (want NATIVE {IMAGE_SUBSYSTEM_NATIVE})")
    if pe.section_of(pe.entry) != ".text":
        sys.exit(f"smoke: entry rva 0x{pe.entry:x} not in .text (in {pe.section_of(pe.entry)})")
    imps = pe.imports()
    dlls = {k.lower() for k in imps}
    if dlls != {"ntoskrnl.exe"}:
        sys.exit(f"smoke: driver imports from unexpected modules {sorted(dlls)}")
    got = set(imps.get("ntoskrnl.exe", []))
    missing = EXPECTED_IMPORTS - got
    if missing:
        sys.exit(f"smoke: driver missing ntoskrnl imports {sorted(missing)}")
    extra = got - EXPECTED_IMPORTS
    print(f"build OK: simplesvm.sys PE32+/AMD64, Subsystem NATIVE, entry 0x{pe.entry:x} in .text")
    print(f"  imports ntoskrnl.exe: {len(got)} names" + (f" (+extra {sorted(extra)})" if extra else ""))
    print(f"  sections: {', '.join(n for n, *_ in pe.secs)}")
    return pe


def check_import_resolution(pe: PE) -> None:
    ntos = Path(os.environ.get("SystemRoot", r"C:\Windows")) / "System32" / "ntoskrnl.exe"
    if not ntos.is_file():
        print(f"import-resolution: skipped ({ntos} not found)")
        return
    exports = PE(ntos.read_bytes()).exports()
    got = set(pe.imports().get("ntoskrnl.exe", []))
    unresolved = sorted(n for n in got if n not in exports)
    if unresolved:
        sys.exit(f"smoke: imports not exported by {ntos}: {unresolved}")
    print(f"import-resolution OK: all {len(got)} imports resolve against {ntos}")


def build_harness(compiler: str, work: Path, tag: str, is_badc: bool) -> Path | None:
    out = work / f"harness-{tag}"
    cmd = [compiler]
    if is_badc:
        cmd.append("-O")
    cmd += [
        "-I", str(DEMO / "harness"),
        str(DEMO / "harness" / "harness.c"),
        "-o", str(out),
    ]
    p = run(cmd)
    if p.returncode != 0 or not out.exists():
        print(f"harness build ({tag}) failed:\n{p.stdout}\n{p.stderr}", file=sys.stderr)
        return None
    return out


def check_harness(badc: Path, work: Path) -> None:
    bexe = build_harness(str(badc), work, "badc", True)
    if bexe is None:
        sys.exit("smoke: harness build with badc failed")
    bp = run([str(bexe)])
    print(bp.stdout, end="")
    if bp.returncode != 0:
        sys.exit(f"smoke: harness (badc) self-check failed rc={bp.returncode}\n{bp.stderr}")

    cc = host_cc()
    if cc is None:
        print("harness: no host C compiler; badc self-check only")
        return
    cexe = build_harness(cc, work, "cc", False)
    if cexe is None:
        print(f"harness: reference build with {cc} failed; badc self-check only")
        return
    cp = run([str(cexe)])
    if cp.returncode != 0:
        sys.exit(f"smoke: harness ({cc}) self-check failed rc={cp.returncode}\n{cp.stderr}")
    if cp.stdout != bp.stdout:
        sys.exit(f"smoke: harness output differs badc vs {cc}\n--- {cc}\n{cp.stdout}\n--- badc\n{bp.stdout}")
    print(f"harness OK: badc output matches {cc}")


def main() -> int:
    badc = resolve_badc()
    rc = subprocess.run([sys.executable, str(DEMO / "setup.py")]).returncode
    if rc != 0:
        return rc
    work = DEMO / ".build"
    work.mkdir(parents=True, exist_ok=True)

    pe = check_driver(badc, work)
    if sys.platform == "win32":
        check_import_resolution(pe)
    else:
        print("import-resolution: skipped (non-Windows host)")
    check_harness(badc, work)
    print("\nsimplesvm smoke: OK")
    return 0


if __name__ == "__main__":
    sys.exit(main())
