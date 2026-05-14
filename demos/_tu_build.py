"""Helpers for invoking badc's multi-translation-unit build path
from a demo smoke harness.

Two flavours:

* ``build_tu_separate(badc, srcs, ...)``  -- compile each
  ``.c`` to its own ``.o`` via ``badc -c`` and link the lot
  into a final native binary. Exercises the basic separate-
  compilation path: parser writes one object per source,
  linker concatenates + relocates.

* ``build_tu_archive(badc, lib_srcs, driver_srcs, lib_name,
  ...)``  -- bundles ``lib_srcs`` into a SysV ``.a`` archive
  via ``badc --ar``, then links the driver against the archive
  through ``-L<tmpdir> -l<lib_name>``. Exercises the archive
  pull-in path: only members that satisfy an unresolved
  reference are included in the final image.

Each demo's smoke.py imports this module by path; the helpers
share the demo's existing ``-D`` / ``-I`` / ``-include`` flag
set so the TU build sees the same preprocessor environment as
the amalgamation build.
"""

from __future__ import annotations

import os
import subprocess
from pathlib import Path
from typing import Iterable, Sequence


def _compile_one_to_object(
    badc: Path,
    src: Path,
    out_object: Path,
    *,
    optimize: bool,
    defines: Iterable[str],
    include_paths: Iterable[Path],
    force_includes: Iterable[str],
) -> None:
    """Compile a single .c to a .o via ``badc -c``."""
    cmd: list[str | os.PathLike[str]] = [str(badc)]
    if optimize:
        cmd.append("-O")
    for ip in include_paths:
        cmd += ["-I", str(ip)]
    for fi in force_includes:
        cmd += ["-include", fi]
    for d in defines:
        cmd.append(f"-D{d}")
    cmd += ["-c", "-o", str(out_object), str(src)]
    subprocess.run(cmd, check=True)


def build_tu_separate(
    badc: Path,
    srcs: Sequence[Path],
    out_bin: Path,
    *,
    optimize: bool,
    defines: Iterable[str] = (),
    include_paths: Iterable[Path] = (),
    force_includes: Iterable[str] = (),
    work_dir: Path,
) -> None:
    """Compile every entry in ``srcs`` to an individual ``.o``
    in ``work_dir``, then invoke badc once more to link them
    into ``out_bin``. The link step passes ``-O`` only when the
    caller did (the bytecode optimizer runs in compile mode; the
    register-allocator runs in link mode). ``-include`` /
    ``-D`` / ``-I`` are flowed through to each compile but not
    to the link -- there are no source-level inputs at link
    time."""
    defines = tuple(defines)
    include_paths = tuple(include_paths)
    force_includes = tuple(force_includes)
    objects: list[Path] = []
    for src in srcs:
        obj = work_dir / (src.stem + ".o")
        _compile_one_to_object(
            badc,
            src,
            obj,
            optimize=optimize,
            defines=defines,
            include_paths=include_paths,
            force_includes=force_includes,
        )
        objects.append(obj)

    link_cmd: list[str | os.PathLike[str]] = [str(badc)]
    if optimize:
        link_cmd.append("-O")
    link_cmd += [str(o) for o in objects]
    link_cmd += ["-o", str(out_bin)]
    subprocess.run(link_cmd, check=True)


def build_tu_archive(
    badc: Path,
    lib_srcs: Sequence[Path],
    driver_srcs: Sequence[Path],
    lib_name: str,
    out_bin: Path,
    *,
    optimize: bool,
    defines: Iterable[str] = (),
    include_paths: Iterable[Path] = (),
    force_includes: Iterable[str] = (),
    work_dir: Path,
) -> None:
    """Bundle ``lib_srcs`` into ``lib<lib_name>.a`` (an ar(5)
    archive with a SysV symbol index), then link
    ``driver_srcs`` against it via ``-L`` / ``-l``. Members
    are pulled in lazily -- a member is only included if it
    defines a name the driver (or another pulled member)
    references."""
    defines = tuple(defines)
    include_paths = tuple(include_paths)
    force_includes = tuple(force_includes)
    archive_path = work_dir / f"lib{lib_name}.a"

    archive_cmd: list[str | os.PathLike[str]] = [str(badc)]
    if optimize:
        archive_cmd.append("-O")
    archive_cmd.append("--ar")
    for ip in include_paths:
        archive_cmd += ["-I", str(ip)]
    for fi in force_includes:
        archive_cmd += ["-include", fi]
    for d in defines:
        archive_cmd.append(f"-D{d}")
    archive_cmd += ["-o", str(archive_path)]
    archive_cmd += [str(s) for s in lib_srcs]
    subprocess.run(archive_cmd, check=True)

    # Compile each driver source separately so we have proper
    # .o inputs to link against the archive.
    driver_objects: list[Path] = []
    for src in driver_srcs:
        obj = work_dir / (src.stem + ".o")
        _compile_one_to_object(
            badc,
            src,
            obj,
            optimize=optimize,
            defines=defines,
            include_paths=include_paths,
            force_includes=force_includes,
        )
        driver_objects.append(obj)

    link_cmd: list[str | os.PathLike[str]] = [str(badc)]
    if optimize:
        link_cmd.append("-O")
    link_cmd += [str(o) for o in driver_objects]
    link_cmd += ["-L", str(work_dir), "-l", lib_name]
    link_cmd += ["-o", str(out_bin)]
    subprocess.run(link_cmd, check=True)
