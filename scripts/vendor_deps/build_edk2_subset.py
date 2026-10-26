#!/usr/bin/env python3
"""Pack the EDK II MdePkg subset demos/edk2 builds against.

The input is the GitHub archive of an `edk2-stable<YYYYMM>` tag
(https://github.com/tianocore/edk2/archive/refs/tags/<tag>.tar.gz); the
output is `edk2-mdepkg-<YYYYMM>-<sha8>.tar.gz`, where sha8 is the first 8
hex digits of the output's own sha256 (the pin demos/edk2/setup.py
carries). The subset is `License.txt`, `MdePkg/MdePkg.dec`, the whole
`MdePkg/Include` tree, and the top-level C sources and headers of the
libraries in `LIBRARIES` -- the closure of the demo's application. The
archive is reproducible: members sorted, owners and times zeroed.

    python3 scripts/vendor_deps/build_edk2_subset.py \\
        --archive edk2-stable202608.tar.gz --version 202608 --out /tmp/edk2
"""

from __future__ import annotations

import argparse
import gzip
import hashlib
import io
import sys
import tarfile
from pathlib import Path, PurePosixPath

PREFIX = "edk2-subset"
LIBRARIES = (
    "BaseDebugLibNull",
    "BaseLib",
    "BaseMemoryLib",
    "BasePrintLib",
    "UefiApplicationEntryPoint",
    "UefiBootServicesTableLib",
    "UefiRuntimeServicesTableLib",
)
# The stack probe is GCC-only and the demo links none.
EXCLUDE = {"MdePkg/Library/BaseLib/ChkStkGcc.c"}


def wanted(rel: str) -> bool:
    p = PurePosixPath(rel)
    if rel in EXCLUDE:
        return False
    if rel in ("License.txt", "MdePkg/MdePkg.dec"):
        return True
    if rel.startswith("MdePkg/Include/"):
        return True
    return (len(p.parts) == 4 and p.parts[:2] == ("MdePkg", "Library")
            and p.parts[2] in LIBRARIES and p.suffix in (".c", ".h"))


def dir_entry(name: str) -> tarfile.TarInfo:
    ti = tarfile.TarInfo(name)
    ti.type = tarfile.DIRTYPE
    ti.mode = 0o755
    return ti


def pack(archive: Path) -> bytes:
    files: dict[str, bytes] = {}
    with tarfile.open(archive, "r:gz") as tf:
        for m in tf.getmembers():
            rel = m.name.split("/", 1)[1] if "/" in m.name else ""
            if m.isreg() and wanted(rel):
                files[rel] = tf.extractfile(m).read()
    for need in ("License.txt", "MdePkg/MdePkg.dec", "MdePkg/Include/Uefi.h"):
        if need not in files:
            sys.exit(f"build_edk2_subset: {archive} has no {need}")
    buf = io.BytesIO()
    seen: set[str] = set()
    with tarfile.open(fileobj=buf, mode="w", format=tarfile.PAX_FORMAT) as out:
        for rel in sorted(files):
            parts = rel.split("/")
            for i in range(len(parts)):
                d = "/".join([PREFIX, *parts[:i]])
                if d not in seen:
                    seen.add(d)
                    out.addfile(dir_entry(d))
            ti = tarfile.TarInfo(f"{PREFIX}/{rel}")
            ti.size = len(files[rel])
            ti.mode = 0o644
            out.addfile(ti, io.BytesIO(files[rel]))
    gz = io.BytesIO()
    with gzip.GzipFile(fileobj=gz, mode="wb", mtime=0, filename="") as z:
        z.write(buf.getvalue())
    return gz.getvalue()


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--archive", type=Path, required=True,
                    help="GitHub archive of an edk2-stable tag (.tar.gz)")
    ap.add_argument("--version", required=True, help="the tag's YYYYMM")
    ap.add_argument("--out", type=Path, required=True, help="output directory")
    args = ap.parse_args()
    data = pack(args.archive)
    sha = hashlib.sha256(data).hexdigest()
    args.out.mkdir(parents=True, exist_ok=True)
    dst = args.out / f"edk2-mdepkg-{args.version}-{sha[:8]}.tar.gz"
    dst.write_bytes(data)
    print(f"{dst}  sha256={sha}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
