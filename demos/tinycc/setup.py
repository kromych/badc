#!/usr/bin/env python3
"""Fetch the tinycc source snapshot from the badc vendor-deps mirror.

After this runs, ``demos/tinycc/{tcc.c, libtcc.c, tccpp.c, ...}`` and
``demos/tinycc/include/`` exist. The vendored set is the multi-TU
build of tinycc-the-binary against the targets badc supports: x86_64
and aarch64 across ELF / Mach-O / PE. Backends badc does NOT target
(i386, arm, riscv64, c67) are skipped to keep the vendored surface
focused on what the self-host actually needs to ingest.

Pulls from the `kromych/badc` GitHub release rather than upstream
to avoid CI flakes against the upstream host. Filename embeds the
upstream commit SHA short prefix from github.com/TinyCC/tinycc;
``_fetch`` verifies a pinned sha256 before extraction. See
``scripts/vendor_deps/README.md`` for the auth model.

Idempotent: safe to call from CI before each smoke run. Output is
suppressed unless something fails -- pass ``-v`` to see every step.
"""

from __future__ import annotations

import argparse
import shutil
import sys
import zipfile
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(REPO_ROOT / "scripts" / "vendor_deps"))
import _fetch  # noqa: E402

VERSION = "20260513"
UPSTREAM_SHA = "757507eb022f7af4be63dc9a72b299761181efbb"  # github.com/TinyCC/tinycc mob HEAD
ASSET = f"tinycc-{VERSION}-{UPSTREAM_SHA[:8]}.zip"
RELEASE_TAG = "vendor-deps-v1"
SHA256 = "3111f0b293e4a30f4b0293a7541edfa0ea1ca47d5f793c5541652af0b1b6bbf4"

# Compile units always pulled in by a multi-TU tcc build, regardless
# of host triple. ONE_SOURCE is deliberately NOT defined, so libtcc.c
# does not absorb the rest as #includes -- each .c is its own TU and
# the cross-TU link is the exerciser the demo aims at.
CORE_C = (
    "tcc.c",
    "libtcc.c",
    "tccpp.c",
    "tccgen.c",
    "tccelf.c",
    "tccasm.c",
    "tccdbg.c",
    "tccrun.c",
    "tcctools.c",
)

# Target backends. Only the x86_64 / aarch64 sets are pulled in;
# i386 / arm / riscv64 / c67 are upstream's other targets and badc
# does not codegen for them. ``i386-asm.c`` carries the x86_64
# inline-assembly parser (TCC_TARGET_X86_64 still routes through
# the i386-asm sources).
TARGET_C = (
    "x86_64-gen.c",
    "x86_64-link.c",
    "i386-asm.c",
    "arm64-gen.c",
    "arm64-link.c",
    "arm64-asm.c",
)

# Output-format units. Each is internally #ifdef'd on its
# TCC_TARGET_* macro, so a TU compiled against a config.h that
# does not define the relevant macro produces an empty object.
FORMAT_C = (
    "tccpe.c",
    "tccmacho.c",
)

# Headers needed at compile time. ``elf.h`` / ``coff.h`` / ``dwarf.h``
# / ``stab.h`` / ``stab.def`` are upstream's internal copies (not
# host /usr/include versions). The ``*-tok.h`` / ``*-asm.h`` headers
# are token-table definitions shared between the gen and asm TUs.
HEADERS = (
    "tcc.h",
    "libtcc.h",
    "tcctok.h",
    "elf.h",
    "coff.h",
    "dwarf.h",
    "stab.h",
    "stab.def",
    "x86_64-asm.h",
    "i386-asm.h",
    "i386-tok.h",
    "arm64-tok.h",
)

# tinycc's shipped target headers (CONFIG_TCC_SYSINCLUDEPATHS). These
# are NOT needed to compile tcc-the-binary -- they are the headers
# tcc would expose to programs it compiles. Vendored under
# ``include/`` so a later self-host stage that runs the produced tcc
# against real C source can point it at this directory via -I.
INCLUDE_HEADERS = (
    "float.h",
    "stdalign.h",
    "stdarg.h",
    "stdatomic.h",
    "stdbool.h",
    "stddef.h",
    "stdnoreturn.h",
    "tccdefs.h",
    "tgmath.h",
    "varargs.h",
)

# Upstream runtime-support sources. Build into ``libtcc1.a`` once
# the bootstrap stage wants tcc to link its own binaries instead
# of going through host gcc + libgcc. The set here is the
# x86_64-linux row from the upstream Makefile: libtcc1.o,
# va_list.o, dsohandle.o, plus the COMMON_O set (stdatomic,
# atomic, builtin, alloca, alloca-bt) and the Native-only
# runmain.o / tcov.o. ``lib-arm64.c`` carries the binary128
# long-double softfloat helpers AArch64 needs (the host gcc
# autolinks libgcc_s for the same set on x86_64).
LIB_SOURCES = (
    "libtcc1.c",
    "va_list.c",
    "dsohandle.c",
    "stdatomic.c",
    "atomic.S",
    "builtin.c",
    "alloca.S",
    "alloca-bt.S",
    "runmain.c",
    "tcov.c",
    "lib-arm64.c",
    "armflush.c",
)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-v", "--verbose", action="store_true")
    args = parser.parse_args(argv)

    def log(msg: str) -> None:
        if args.verbose:
            print(msg, file=sys.stderr)

    tinycc_dir = Path(__file__).resolve().parent
    cache_dir = tinycc_dir / ".cache"
    zip_path = cache_dir / ASSET

    cache_dir.mkdir(parents=True, exist_ok=True)
    _fetch.fetch_and_verify(RELEASE_TAG, ASSET, zip_path, SHA256, log)

    log("extracting tinycc")
    prefix = f"tinycc-{UPSTREAM_SHA}"
    flat = CORE_C + TARGET_C + FORMAT_C + HEADERS
    include_dir = tinycc_dir / "include"
    include_dir.mkdir(exist_ok=True)
    lib_dir = tinycc_dir / "lib"
    lib_dir.mkdir(exist_ok=True)
    win32_include_dir = tinycc_dir / "win32" / "include"
    win32_include_dir.mkdir(parents=True, exist_ok=True)
    win32_include_prefix = f"{prefix}/win32/include/"
    extracted_win32: list[str] = []
    with zipfile.ZipFile(zip_path) as zf:
        for name in flat:
            with zf.open(f"{prefix}/{name}") as src, (tinycc_dir / name).open("wb") as dst:
                shutil.copyfileobj(src, dst)
        for name in INCLUDE_HEADERS:
            with zf.open(f"{prefix}/include/{name}") as src, (include_dir / name).open("wb") as dst:
                shutil.copyfileobj(src, dst)
        for name in LIB_SOURCES:
            with zf.open(f"{prefix}/lib/{name}") as src, (lib_dir / name).open("wb") as dst:
                shutil.copyfileobj(src, dst)
        # Upstream's mingw-style Windows headers (stdio.h, stdlib.h,
        # string.h, sys/*, ...) live under `win32/include/` in the
        # zip. Stage1 tcc on Windows resolves `<stdio.h>` through its
        # sysinclude path; without this tree the corpus + bootstrap
        # tiers fail at the very first `#include`.
        for member in zf.namelist():
            if not member.startswith(win32_include_prefix) or member.endswith("/"):
                continue
            rel = member[len(win32_include_prefix):]
            dst_path = win32_include_dir / rel
            dst_path.parent.mkdir(parents=True, exist_ok=True)
            with zf.open(member) as src, dst_path.open("wb") as dst:
                shutil.copyfileobj(src, dst)
            extracted_win32.append(rel)
        # Upstream's Windows-side runtime + DLL import-libs live
        # under `win32/lib/`. `wincrt1.c` supplies the `_start` PE
        # entry, `chkstk.S` supplies `__chkstk_ms` / `alloca`, and
        # the `.def` files (kernel32, msvcrt, user32, ...) tell tcc
        # which DLL exports satisfy `-lkernel32` / `-lmsvcrt`.
        win32_lib_dir = tinycc_dir / "win32" / "lib"
        win32_lib_dir.mkdir(parents=True, exist_ok=True)
        win32_lib_prefix = f"{prefix}/win32/lib/"
        extracted_win32_lib: list[str] = []
        for member in zf.namelist():
            if not member.startswith(win32_lib_prefix) or member.endswith("/"):
                continue
            rel = member[len(win32_lib_prefix):]
            dst_path = win32_lib_dir / rel
            dst_path.parent.mkdir(parents=True, exist_ok=True)
            with zf.open(member) as src, dst_path.open("wb") as dst:
                shutil.copyfileobj(src, dst)
            extracted_win32_lib.append(rel)

    if args.verbose:
        for name in flat:
            p = tinycc_dir / name
            log(f"done -- {p} {p.stat().st_size}")
        for name in INCLUDE_HEADERS:
            p = include_dir / name
            log(f"done -- {p} {p.stat().st_size}")
        for name in LIB_SOURCES:
            p = lib_dir / name
            log(f"done -- {p} {p.stat().st_size}")
        for rel in extracted_win32:
            p = win32_include_dir / rel
            log(f"done -- {p} {p.stat().st_size}")
        for rel in extracted_win32_lib:
            p = win32_lib_dir / rel
            log(f"done -- {p} {p.stat().st_size}")

    # Storage for the AArch64-only globals upstream's
    # `win32/include/stdlib.h` declares (without providing
    # storage): `__argc` / `__argv` / `__wargv` / `_environ` /
    # `_wenviron`. The Windows AArch64 msvcrt.dll variant does not
    # export the `_imp_*` indirection slots the dllimport macros
    # would expand into, so the upstream header undefs that path
    # and falls back to plain `extern`. With no module providing
    # the storage, tinycc's PE linker fires `symbol 'X' is
    # missing __declspec(dllimport)`.
    #
    # Drop a single explicitly-initialized definition file that
    # the libtcc1 build picks up on Windows AArch64. Tentative
    # definitions in the header looked tempting (C99 6.9.2 lets
    # multiple TUs contribute candidates) but tinycc's PE linker
    # lands the merged slot in `.rdata`, making `__getmainargs`
    # AV when it tries to write argc / argv into the read-only
    # page. Explicit initializers force the storage into `.data`,
    # which is writable.
    args_storage = win32_lib_dir / "c5_win_arm64_args.c"
    args_storage.write_text(
        "// Single-TU storage for the upstream AArch64 stdlib.h\n"
        "// `extern` block. Explicit initializers route the\n"
        "// linker into a writable .data slot per symbol.\n"
        "int __argc = 0;\n"
        "char **__argv = 0;\n"
        "// `wchar_t` resolves to `unsigned short` in tinycc's\n"
        "// Windows headers; spelling it out keeps the file\n"
        "// self-contained when libtcc1's build path includes it\n"
        "// without dragging in <stddef.h>.\n"
        "unsigned short **__wargv = 0;\n"
        "char **_environ = 0;\n"
        "unsigned short **_wenviron = 0;\n"
    )
    log(f"wrote -- {args_storage} (AArch64 args storage)")

    # Temporary instrumentation: at the relocate_syms `+=`
    # site, dump sym->st_value before and after, plus the
    # section's sh_addr and sh_num. The gen2-self path produces
    # truncated `val` (upper 32 bits zero) for .data symbols
    # only -- this trace pins whether the truncation is in the
    # section base or in the `+=` itself.
    tccelf = tinycc_dir / "tccelf.c"
    text = tccelf.read_text()
    needle = "            sym->st_value += s1->sections[sym->st_shndx]->sh_addr;\n"
    if needle in text:
        replacement = (
            "            {\n"
            "                addr_t pre = sym->st_value;\n"
            "                addr_t base = s1->sections[sym->st_shndx]->sh_addr;\n"
            "                sym->st_value += base;\n"
            "                fprintf(stderr,\n"
            "                    \"[SYMV] shndx=%d pre=0x%llx base=0x%llx post=0x%llx\\n\",\n"
            "                    (int)sym->st_shndx,\n"
            "                    (unsigned long long)pre, (unsigned long long)base,\n"
            "                    (unsigned long long)sym->st_value);\n"
            "            }\n"
        )
        tccelf.write_text(text.replace(needle, replacement))
        log(f"patched -- {tccelf} (TEMP SYMV instrumentation)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
