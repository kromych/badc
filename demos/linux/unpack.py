#!/usr/bin/env python3
"""The initramfs that exercises decompression, and how its boot is read.

The marker image initramfs.py builds is 1.4 MB and the kernel unpacks it in a
fraction of a second, so a decompressor whose cost doubled passes that boot.
This builds the image for one more boot: the marker archive, uncompressed,
followed by ``PAYLOAD_BYTES`` of deterministic content compressed with the
method the tree's configuration decompresses -- zstd where ``CONFIG_RD_ZSTD``
is set, as defconfig sets it, gzip otherwise. That is the shape of a
distribution initramfs, whose early archive precedes the compressed one, and
the kernel checks the frame's content checksum, so a decompressor that
produces wrong bytes fails the boot rather than passing it.

The payload archive depends only on the seed and the size, so it is built
once and kept: compressing it costs more than booting it.

``unpack_time`` reads the phase from the console: the kernel's printk
timestamps from ``Unpacking initramfs...`` to ``Freeing initrd memory``.

    python3 demos/linux/unpack.py --marker initramfs.cpio.gz -o unpack.initrd
    python3 demos/linux/unpack.py --self-test
"""

from __future__ import annotations

import argparse
import gzip
import hashlib
import re
import shutil
import struct
import subprocess
import sys
import tempfile
import time
from pathlib import Path

import initramfs

PAYLOAD_BYTES = 250_000_000
PAYLOAD_FILE_BYTES = 10_000_000
PAYLOAD_SEED = 1
POOL_BYTES = 1 << 16

# Method -> the symbol whose decompressor the kernel builds in, the archive
# suffix, and the magic the kernel detects the archive by. In order of
# preference.
METHODS = {
    "zstd": ("CONFIG_RD_ZSTD", "zst", b"\x28\xb5\x2f\xfd"),
    "gzip": ("CONFIG_RD_GZIP", "gz", b"\x1f\x8b"),
}

UNPACK_LINE = re.compile(
    r"\[\s*(\d+\.\d+)\]\s*(Unpacking initramfs|"
    r"Trying to unpack rootfs image as initramfs|Freeing initrd memory|"
    r"Initramfs unpacking failed)(.*)")


def method_for(config: str) -> str:
    """The first of METHODS the configuration decompresses, or ""."""
    lines = set(config.splitlines())
    for name, (symbol, _, _) in METHODS.items():
        if f"{symbol}=y" in lines:
            return name
    return ""


def payload_name(method: str, size: int = PAYLOAD_BYTES,
                 seed: int = PAYLOAD_SEED) -> str:
    return f"initramfs-payload-{size // 1_000_000}MB-seed{seed}.cpio.{METHODS[method][1]}"


def _alphabet() -> bytes:
    """A translation table from 256 byte values onto 28 symbols with
    Zipf-like frequencies, so literal bytes carry the entropy of text."""
    symbols = list(range(97, 123)) + [32, 10]
    weights = [1.0 / (k + 1) for k in range(len(symbols))]
    counts = [max(1, round(256 * w / sum(weights))) for w in weights]
    while sum(counts) > 256:
        counts[counts.index(max(counts))] -= 1
    while sum(counts) < 256:
        counts[0] += 1
    return bytes(s for s, c in zip(symbols, counts) for _ in range(c))


def payload_file(seed: int, index: int, size: int) -> bytes:
    """`size` bytes of payload file `index`: slices of a 64 KiB pool at
    random offsets, which compress as matches, interleaved with runs of
    text-like literals. Under `zstd -19` the mix compresses 5.3:1, near a
    distribution initramfs. SHAKE-256 streams keyed by the seed and the
    index define the content independently of the Python version."""
    tag = f"badc initramfs payload seed={seed} file={index} ".encode()
    table = _alphabet()
    pool = hashlib.shake_256(tag + b"pool").digest(POOL_BYTES).translate(table)
    literal = hashlib.shake_256(tag + b"literal").digest(size).translate(table)
    control = hashlib.shake_256(tag + b"control").digest(size // 64 + 7)
    out = bytearray()
    used = 0
    for kind, n, off in struct.iter_unpack("<BHI", control[: len(control) // 7 * 7]):
        if kind & 1:
            n = 32 + n % 2048
            off %= POOL_BYTES - n
            out += pool[off:off + n]
        else:
            n = 8 + n % 1024
            out += literal[used:used + n]
            used += n
        if len(out) >= size:
            return bytes(out[:size])
    raise AssertionError("the control stream ended before the file did")


def payload_archive(size: int = PAYLOAD_BYTES, seed: int = PAYLOAD_SEED) -> bytes:
    """A newc archive of the payload, under /payload in PAYLOAD_FILE_BYTES
    files."""
    entries = [("payload", 0o040755, b"")]
    for i in range(-(-size // PAYLOAD_FILE_BYTES)):
        n = min(PAYLOAD_FILE_BYTES, size - i * PAYLOAD_FILE_BYTES)
        entries.append((f"payload/{i:03d}", 0o100644, payload_file(seed, i, n)))
    return initramfs.cpio_newc(entries)


def compress(data: bytes, method: str) -> bytes:
    """`data` as the kernel's decompressor for `method` reads it. zstd at
    the level kbuild uses for an initramfs, with the content checksum the
    CLI adds by default; the standard library's module stands in for a host
    without the CLI."""
    if method == "gzip":
        return gzip.compress(data, 9)
    if shutil.which("zstd"):
        return subprocess.run(["zstd", "-19", "-T0", "-q", "-c"], input=data,
                              capture_output=True, check=True).stdout
    try:
        from compression import zstd
    except ImportError:
        sys.exit("linux unpack: zstd is not on PATH and Python has no "
                 "compression.zstd module; install zstd")
    p = zstd.CompressionParameter
    return zstd.compress(data, options={p.compression_level: 19,
                                        p.checksum_flag: 1})


def zstd_decompress(data: bytes) -> bytes:
    if shutil.which("zstd"):
        return subprocess.run(["zstd", "-d", "-q", "-c"], input=data,
                              capture_output=True, check=True).stdout
    from compression import zstd
    return zstd.decompress(data)


def build_payload(path: Path, method: str, size: int = PAYLOAD_BYTES,
                  seed: int = PAYLOAD_SEED) -> None:
    """Write the compressed payload archive to `path`, through a temporary
    name so an interrupted build leaves no partial file under the final
    one."""
    tmp = path.with_name(path.name + ".tmp")
    tmp.write_bytes(compress(payload_archive(size, seed), method))
    tmp.replace(path)


def marker_archive(image: Path) -> bytes:
    """initramfs.py's image as the kernel reads it, uncompressed when it is
    the gzip that script writes."""
    data = image.read_bytes()
    return gzip.decompress(data) if data[:2] == METHODS["gzip"][2] else data


def build_image(marker: Path, payload: Path, out: Path) -> int:
    """The image to boot: the marker archive followed by the payload
    archive. Returns its size."""
    out.write_bytes(marker_archive(marker) + payload.read_bytes())
    return out.stat().st_size


def unpack_time(text: str) -> tuple[float | None, str]:
    """Seconds between the kernel's `Unpacking initramfs` and `Freeing
    initrd memory` lines, by their printk timestamps, and what the boot did
    wrong or "": the kernel's own `Initramfs unpacking failed` line, or a
    missing bracket. The text reads after the boot's name."""
    start = end = None
    failure = ""
    for m in UNPACK_LINE.finditer(text):
        stamp, what, rest = float(m.group(1)), m.group(2), m.group(3)
        if what.startswith(("Unpacking", "Trying")) and start is None:
            start = stamp
        elif what.startswith("Initramfs"):
            failure = f"reported `{(what + rest).strip()}`"
        elif what.startswith("Freeing") and start is not None and end is None:
            end = stamp
    seconds = (round(end - start, 6)
               if start is not None and end is not None else None)
    if failure:
        return seconds, failure
    if start is None:
        return None, "has no `Unpacking initramfs` line on its console"
    if end is None:
        return None, "has no `Freeing initrd memory` line after `Unpacking initramfs`"
    return seconds, ""


def self_test() -> None:
    assert method_for("CONFIG_RD_GZIP=y\nCONFIG_RD_ZSTD=y\n") == "zstd"
    assert method_for("# CONFIG_RD_ZSTD is not set\nCONFIG_RD_GZIP=y\n") == "gzip"
    assert method_for("CONFIG_RD_ZSTD=m\n") == ""
    assert payload_name("zstd") == "initramfs-payload-250MB-seed1.cpio.zst"

    # The content is a function of the seed and the index alone.
    a = payload_file(1, 0, 1 << 20)
    assert len(a) == 1 << 20 and a == payload_file(1, 0, 1 << 20)
    assert a != payload_file(2, 0, 1 << 20) and a != payload_file(1, 1, 1 << 20)
    assert a[:4096] == payload_file(1, 0, 4096)
    # Compressible as a filesystem is, not as noise or as zeros.
    packed = compress(a, "gzip")
    assert len(a) // 20 < len(packed) < len(a) // 2, len(packed)

    archive = payload_archive(3 * PAYLOAD_FILE_BYTES // 2, 1)
    assert archive.startswith(b"070701") and b"TRAILER!!!" in archive
    assert archive.count(b"payload/00") == 2, "two files for one and a half"
    for method in METHODS:
        if method == "zstd" and not shutil.which("zstd"):
            try:
                import compression.zstd  # noqa: F401
            except ImportError:
                continue
        packed = compress(archive[:1 << 20], method)
        assert packed.startswith(METHODS[method][2]), method
        back = (zstd_decompress(packed) if method == "zstd"
                else gzip.decompress(packed))
        assert back == archive[:1 << 20], method

    with tempfile.TemporaryDirectory() as d:
        marker = Path(d) / "marker.cpio.gz"
        raw = initramfs.cpio_newc([("init", 0o100755, b"#!/bin/sh\n")])
        marker.write_bytes(gzip.compress(raw, 9))
        payload = Path(d) / payload_name("gzip", 4096, 1)
        build_payload(payload, "gzip", 4096, 1)
        assert not payload.with_name(payload.name + ".tmp").exists()
        image = Path(d) / "unpack.initrd"
        n = build_image(marker, payload, image)
        data = image.read_bytes()
        assert n == len(data) == len(raw) + payload.stat().st_size
        assert data.startswith(raw) and data[len(raw):].startswith(METHODS["gzip"][2])
        # A marker image that is not gzip is carried as it is.
        marker.write_bytes(raw)
        assert marker_archive(marker) == raw

    # The console of the aarch64 box's marker boot, CRLF included.
    boot = ("[    0.194283] SMP: Total of 2 processors activated.\r\n"
            "[    1.133642] Unpacking initramfs...\r\n"
            "[    1.271363] Freeing initrd memory: 1248K\r\n"
            "[    2.135039] Run /init as init process\r\n")
    seconds, failure = unpack_time(boot)
    assert failure == "" and abs(seconds - 0.137721) < 1e-6, (seconds, failure)
    # The spelling a CONFIG_BLK_DEV_RAM kernel uses.
    seconds, failure = unpack_time(
        "[    1.5] Trying to unpack rootfs image as initramfs...\r\n"
        "[    7.5] Freeing initrd memory: 45912K\r\n")
    assert (seconds, failure) == (6.0, "")
    seconds, failure = unpack_time(
        "[    1.5] Unpacking initramfs...\r\n"
        "[    3.0] Initramfs unpacking failed: ZSTD-compressed data is corrupt\r\n"
        "[    3.1] Freeing initrd memory: 45912K\r\n")
    assert failure == ("reported `Initramfs unpacking failed: ZSTD-compressed "
                       "data is corrupt`"), failure
    assert abs(seconds - 1.6) < 1e-9
    seconds, failure = unpack_time("[    1.5] Unpacking initramfs...\r\n")
    assert seconds is None and failure.startswith("has no `Freeing initrd memory`")
    assert unpack_time("a quiet console\n")[1].startswith("has no `Unpacking initramfs`")
    # Lines the console replays after it registers keep their timestamps.
    assert unpack_time(boot + boot) == unpack_time(boot)


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("-o", "--output", type=Path, required=True,
                    help="the image to boot")
    ap.add_argument("--marker", type=Path, required=True,
                    help="the image initramfs.py wrote")
    ap.add_argument("--method", choices=sorted(METHODS), default="zstd")
    ap.add_argument("--payload-dir", type=Path,
                    help="where the payload archive is kept (default: beside "
                         "the output)")
    args = ap.parse_args()
    where = (args.payload_dir or args.output.parent).resolve()
    where.mkdir(parents=True, exist_ok=True)
    payload = where / payload_name(args.method)
    if not payload.exists():
        start = time.time()
        build_payload(payload, args.method)
        print(f"linux unpack: wrote {payload} ({payload.stat().st_size} bytes) "
              f"in {time.time() - start:.0f}s", flush=True)
    n = build_image(args.marker, payload, args.output)
    print(f"linux unpack: wrote {args.output} ({n} bytes)", flush=True)
    return 0


if __name__ == "__main__":
    if sys.argv[1:] == ["--self-test"]:
        self_test()
        print("linux unpack: self-test ok", flush=True)
        sys.exit(0)
    sys.exit(main())
