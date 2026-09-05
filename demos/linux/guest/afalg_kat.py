#!/usr/bin/env python3
"""Known-answer and differential tests over the kernel crypto API (guest side).

Every registered implementation is reached through AF_ALG by its driver name,
so an arch-optimized path is tested on its own instead of through whichever
implementation the priority ordering would otherwise select. Hashes are
anchored against hashlib where the standard library implements the algorithm;
every other implementation is compared against the generic one registered
under the same algorithm name. Prints a JSON report on stdout and exits
non-zero when an implementation disagrees with its reference or rejects the
round trip over its own output.

    afalg_kat.py [--max-size N]
"""

from __future__ import annotations

import contextlib
import hashlib
import hmac
import json
import re
import socket
import sys
import time

# Lengths around the block and vector widths the assembly paths switch on.
MSG_SIZES = (0, 1, 15, 16, 17, 31, 32, 63, 64, 65, 127, 128, 129, 255, 256,
             511, 512, 1023, 1024, 4095, 4096, 8192)
# Key lengths tried in order until the algorithm accepts one; the tail covers
# the AEAD constructions that carry a salt or two subkeys.
KEY_SIZES = (16, 32, 24, 20, 28, 36, 40, 48, 64, 8)
DIGEST_MAX = 128

# The AF_ALG ABI, from the socket module where it defines it and from Linux
# otherwise, so the harness self-test drives the checks on any host.
AF_ALG = getattr(socket, "AF_ALG", 38)
SOL_ALG = getattr(socket, "SOL_ALG", 279)
ALG_SET_KEY = getattr(socket, "ALG_SET_KEY", 1)
ALG_SET_AEAD_AUTHSIZE = getattr(socket, "ALG_SET_AEAD_AUTHSIZE", 5)
ALG_OP_DECRYPT = getattr(socket, "ALG_OP_DECRYPT", 0)
ALG_OP_ENCRYPT = getattr(socket, "ALG_OP_ENCRYPT", 1)


def stream(n: int) -> bytes:
    """Deterministic pseudo-random bytes: xorshift32, so the guest needs no
    entropy source and two runs compare."""
    out = bytearray(n)
    x = 0x9E3779B9
    for i in range(n):
        x ^= (x << 13) & 0xFFFFFFFF
        x ^= x >> 17
        x ^= (x << 5) & 0xFFFFFFFF
        out[i] = x & 0xFF
    return bytes(out)


def parse_proc_crypto(text: str) -> list[dict]:
    out: list[dict] = []
    cur: dict = {}
    for line in text.splitlines():
        if not line.strip():
            if cur:
                out.append(cur)
            cur = {}
            continue
        k, _, v = line.partition(":")
        cur[k.strip()] = v.strip()
    if cur:
        out.append(cur)
    return out


HASHLIB_CTORS = {
    "md5": hashlib.md5, "sha1": hashlib.sha1, "sha224": hashlib.sha224,
    "sha256": hashlib.sha256, "sha384": hashlib.sha384,
    "sha512": hashlib.sha512, "sha3-224": hashlib.sha3_224,
    "sha3-256": hashlib.sha3_256, "sha3-384": hashlib.sha3_384,
    "sha3-512": hashlib.sha3_512, "sm3": None}


def hashlib_ref(name: str):
    """A one-shot hashlib digest function for kernel algorithm `name`, or
    None when the standard library does not implement it."""
    if HASHLIB_CTORS.get(name):
        return lambda data, c=HASHLIB_CTORS[name]: c(data).digest()
    for stem, ctor in (("blake2b-", hashlib.blake2b),
                       ("blake2s-", hashlib.blake2s)):
        tail = name[len(stem):]
        if name.startswith(stem) and tail.isdigit():
            return lambda data, c=ctor, n=int(tail) // 8: c(
                data, digest_size=n).digest()
    return None


def hmac_ref(name: str, key: bytes):
    """A digest function for `hmac(X)` when hashlib implements X: an oracle
    for the keyed hashes independent of the kernel."""
    m = re.fullmatch(r"hmac\((.+)\)", name)
    ctor = HASHLIB_CTORS.get(m.group(1)) if m else None
    if ctor is None:
        return None
    return lambda data: hmac.new(key, data, ctor).digest()


def is_internal(e: dict) -> bool:
    return e.get("internal") == "yes" or e.get("driver", "").startswith("__")


def reference_driver(entries: list[dict]) -> dict | None:
    """The generic implementation among same-named entries: the one whose
    driver is the algorithm name with a `-generic` suffix, the one whose
    driver is the name itself, or failing both the lowest-priority one."""
    for e in entries:
        if e["driver"] in (e["name"] + "-generic", e["name"]):
            return e
    ranked = sorted(entries, key=lambda e: int(e.get("priority", "0") or 0))
    return ranked[0] if ranked else None


class SetupError(OSError):
    """A rejection before the implementation was driven: the socket, the
    bind, the key or the tag length. Nothing about its output is known."""


def afalg(kind: str, driver: str) -> socket.socket:
    s = socket.socket(AF_ALG, socket.SOCK_SEQPACKET, 0)
    try:
        s.bind((kind, driver))
    except OSError:
        s.close()
        raise
    return s


@contextlib.contextmanager
def operation(kind: str, driver: str, key: bytes | None = None,
              authsize: int | None = None):
    """The accepted operation socket for `driver`, keyed and with the tag
    length set. A rejection up to that point is a SetupError; what the
    operation itself raises passes through unchanged."""
    with contextlib.ExitStack() as stack:
        try:
            s = stack.enter_context(afalg(kind, driver))
            if key is not None:
                s.setsockopt(SOL_ALG, ALG_SET_KEY, key)
            if authsize is not None:
                s.setsockopt(SOL_ALG, ALG_SET_AEAD_AUTHSIZE, None, authsize)
            c = stack.enter_context(s.accept()[0])
        except OSError as e:
            raise SetupError(*e.args) from e
        yield c


def recv_exact(sock: socket.socket, want: int) -> bytes:
    out = b""
    while len(out) < want:
        chunk = sock.recv(want - len(out))
        if not chunk:
            break
        out += chunk
    return out


def hash_digest(driver: str, msg: bytes, size: int,
                key: bytes | None = None) -> bytes:
    with operation("hash", driver, key) as op:
        op.sendall(msg)
        return recv_exact(op, size or DIGEST_MAX)


def hash_key(driver: str, size: int) -> bytes | None:
    """None when the implementation hashes without a key; otherwise the
    first key length it accepts. ghash, cmac, hmac and poly1305 refuse to
    produce a digest until one is set."""
    try:
        hash_digest(driver, b"", size)
        return None
    except OSError:
        pass
    for n in KEY_SIZES:
        k = stream(n + 7)[7:]
        try:
            hash_digest(driver, b"", size, k)
            return k
        except OSError:
            continue
    raise OSError("no key length accepted")


def skcipher(driver: str, key: bytes, iv: bytes, data: bytes,
             op: int) -> bytes:
    with operation("skcipher", driver, key) as c:
        kw = {"op": op}
        if iv:
            kw["iv"] = iv
        c.sendmsg_afalg([data], **kw)
        return recv_exact(c, len(data))


def aead(driver: str, key: bytes, iv: bytes, assoc: bytes, data: bytes,
         taglen: int, op: int) -> bytes:
    with operation("aead", driver, key, taglen) as c:
        kw = {"op": op, "assoclen": len(assoc)}
        if iv:
            kw["iv"] = iv
        want = len(assoc) + len(data)
        want += taglen if op == ALG_OP_ENCRYPT else -taglen
        c.sendmsg_afalg([assoc + data], **kw)
        return recv_exact(c, want)


def keyed(fn, sizes=KEY_SIZES):
    """Call `fn(key)` with each candidate key length until one is accepted;
    returns (key_length, result). An algorithm that rejects every length is
    reported as unusable rather than as a mismatch."""
    last = None
    for n in sizes:
        try:
            return n, fn(stream(n + 7)[7:] if n else b"")
        except OSError as e:
            last = e
    raise last if last else OSError("no key size")


def group_by_name(entries: list[dict], kinds: tuple[str, ...]) -> dict:
    out: dict[str, list[dict]] = {}
    for e in entries:
        if e.get("type") in kinds and not is_internal(e) and "driver" in e:
            out.setdefault(e["name"], []).append(e)
    return out


def compare(rec: dict, name: str, driver: str, kind: str, reference: str,
            want: bytes, fn, show: slice = slice(None),
            **extra) -> bytes | None:
    """`fn()` drives `driver` with parameters `reference` accepted and must
    return `want`. A rejected setup files the implementation as unusable,
    since it was not driven; a differing result, or an operation it rejected,
    as a mismatch of `kind` showing the `show` slice of both sides. Returns
    the result when it matches."""
    try:
        got = fn()
    except SetupError as err:
        rec["unusable"].append(f"{name}/{driver}: {err}")
        return None
    except OSError as err:
        shown = str(err)
    else:
        if got == want:
            return got
        shown = got[show].hex()
    rec["mismatch"].append({
        "kind": kind, "alg": name, "driver": driver, "reference": reference,
        **extra, "want": want[show].hex(), "got": shown})
    return None


def run_hashes(groups: dict, msgs: list[bytes], rec: dict) -> None:
    for name, entries in sorted(groups.items()):
        gen = reference_driver(entries)
        if gen is None:
            rec["unreferenced"].append(name)
            continue
        gsize = int(gen.get("digestsize", "0") or 0)
        try:
            key = hash_key(gen["driver"], gsize)
        except OSError as e:
            rec["unusable"].append(f"{name}/{gen['driver']}: {e}")
            continue
        ref = hmac_ref(name, key) if key else hashlib_ref(name)
        anchor = "hashlib" if ref else gen["driver"]
        if ref is None:
            if len(entries) == 1:
                rec["unreferenced"].append(name)
                continue
            ref = lambda m, d=gen["driver"], n=gsize, k=key: hash_digest(
                d, m, n, k)
        try:
            wants = [ref(m) for m in msgs]
        except OSError as e:
            rec["unusable"].append(f"{name}/{anchor}: {e}")
            continue
        for e in entries:
            size = int(e.get("digestsize", "0") or 0)
            for m, want in zip(msgs, wants):
                if compare(rec, name, e["driver"], "hash", anchor, want,
                           lambda: hash_digest(e["driver"], m, size,
                                               key)[:len(want)],
                           message_bytes=len(m)) is None:
                    break
            else:
                rec["checked"].append(e["driver"])


def run_skciphers(groups: dict, rec: dict) -> None:
    data = stream(4096)
    for name, entries in sorted(groups.items()):
        gen = reference_driver(entries)
        if gen is None:
            rec["unreferenced"].append(name)
            continue
        # With one implementation registered there is nothing to differ
        # from, but the encrypt/decrypt round trip still has to hold.
        if len(entries) == 1:
            rec["unreferenced"].append(name)
        ivsize = int(gen.get("ivsize", "0") or 0)
        iv = stream(ivsize) if ivsize else b""
        blk = max(1, int(gen.get("blocksize", "1") or 1))
        pt = data[:len(data) // blk * blk]
        try:
            klen, want = keyed(lambda k: skcipher(gen["driver"], k, iv, pt,
                                                  ALG_OP_ENCRYPT))
        except OSError as e:
            rec["unusable"].append(f"{name}/{gen['driver']}: {e}")
            continue
        key = stream(klen + 7)[7:]
        for e in entries:
            d = e["driver"]
            got = compare(rec, name, d, "skcipher", gen["driver"], want,
                          lambda: skcipher(d, key, iv, pt, ALG_OP_ENCRYPT),
                          slice(0, 32), key_bytes=klen)
            if got is None:
                continue
            back = compare(rec, name, d, "skcipher-roundtrip", d, pt,
                           lambda: skcipher(d, key, iv, got, ALG_OP_DECRYPT),
                           slice(0, 32), key_bytes=klen)
            if back is not None:
                rec["checked"].append(d)


# Assoc lengths tried in order: the rfc4106 and rfc4543 wrappers accept only
# their own, and reject everything else with EINVAL.
ASSOC_SIZES = (64, 20, 16, 12, 8, 0)


def run_aeads(groups: dict, rec: dict) -> None:
    pt = stream(1024)
    for name, entries in sorted(groups.items()):
        gen = reference_driver(entries)
        if gen is None:
            rec["unreferenced"].append(name)
            continue
        # With one implementation registered there is nothing to differ
        # from, but the encrypt/decrypt round trip still has to hold.
        if len(entries) == 1:
            rec["unreferenced"].append(name)
        ivsize = int(gen.get("ivsize", "0") or 0)
        iv = stream(ivsize) if ivsize else b""
        tag = int(gen.get("maxauthsize", "16") or 16)
        assoc, klen, want, err = b"", 0, None, None
        for alen in ASSOC_SIZES:
            assoc = stream(alen + 3)[3:] if alen else b""
            try:
                klen, want = keyed(
                    lambda k, a=assoc: aead(gen["driver"], k, iv, a, pt, tag,
                                            ALG_OP_ENCRYPT))
                break
            except OSError as e:
                err = e
        if want is None:
            rec["unusable"].append(f"{name}/{gen['driver']}: {err}")
            continue
        key = stream(klen + 7)[7:]
        for e in entries:
            d = e["driver"]
            got = compare(rec, name, d, "aead", gen["driver"], want,
                          lambda: aead(d, key, iv, assoc, pt, tag,
                                       ALG_OP_ENCRYPT),
                          slice(-tag, None), key_bytes=klen)
            if got is None:
                continue
            back = compare(rec, name, d, "aead-roundtrip", d, pt,
                           lambda: aead(d, key, iv, got[:len(assoc)],
                                        got[len(assoc):], tag,
                                        ALG_OP_DECRYPT)[len(assoc):],
                           slice(0, 32), key_bytes=klen)
            if back is not None:
                rec["checked"].append(d)


def main() -> int:
    limit = 1 << 20
    if "--max-size" in sys.argv:
        limit = int(sys.argv[sys.argv.index("--max-size") + 1])
    msgs = [stream(n) for n in MSG_SIZES if n <= limit]
    started = time.time()
    rec: dict = {"checked": [], "mismatch": [], "unusable": [],
                 "unreferenced": []}
    try:
        with open("/proc/crypto") as f:
            entries = parse_proc_crypto(f.read())
    except OSError as e:
        print(json.dumps({"error": f"/proc/crypto: {e}"}))
        return 2
    rec["registered"] = len(entries)
    run_hashes(group_by_name(entries, ("shash", "ahash")), msgs, rec)
    run_skciphers(group_by_name(entries, ("skcipher", "lskcipher")), rec)
    run_aeads(group_by_name(entries, ("aead",)), rec)
    rec["seconds"] = round(time.time() - started, 1)
    rec["checked_count"] = len(rec["checked"])
    rec["checked"] = sorted(set(rec["checked"]))
    rec["unreferenced"] = sorted(set(rec["unreferenced"]))
    print(json.dumps(rec, indent=1))
    return 1 if rec["mismatch"] else 0


if __name__ == "__main__":
    sys.exit(main())
