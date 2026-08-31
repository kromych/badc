#!/usr/bin/env python3
"""Known-answer and differential tests over the kernel crypto API (guest side).

Every registered implementation is reached through AF_ALG by its driver name,
so an arch-optimized path is tested on its own instead of through whichever
implementation the priority ordering would otherwise select. Hashes are
anchored against hashlib where the standard library implements the algorithm;
every other implementation is compared against the generic one registered
under the same algorithm name. Prints a JSON report on stdout and exits
non-zero when an implementation disagrees with its reference.

    afalg_kat.py [--max-size N]
"""

from __future__ import annotations

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


def afalg(kind: str, driver: str) -> socket.socket:
    s = socket.socket(socket.AF_ALG, socket.SOCK_SEQPACKET, 0)
    try:
        s.bind((kind, driver))
    except OSError:
        s.close()
        raise
    return s


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
    with afalg("hash", driver) as s:
        if key is not None:
            set_key(s, key)
        op, _ = s.accept()
        with op:
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


def set_key(s: socket.socket, key: bytes) -> None:
    s.setsockopt(socket.SOL_ALG, socket.ALG_SET_KEY, key)


def skcipher(driver: str, key: bytes, iv: bytes, data: bytes,
             op: int) -> bytes:
    with afalg("skcipher", driver) as s:
        set_key(s, key)
        c, _ = s.accept()
        with c:
            kw = {"op": op}
            if iv:
                kw["iv"] = iv
            c.sendmsg_afalg([data], **kw)
            return recv_exact(c, len(data))


def aead(driver: str, key: bytes, iv: bytes, assoc: bytes, data: bytes,
         taglen: int, op: int) -> bytes:
    with afalg("aead", driver) as s:
        set_key(s, key)
        s.setsockopt(socket.SOL_ALG, socket.ALG_SET_AEAD_AUTHSIZE, None,
                     taglen)
        c, _ = s.accept()
        with c:
            kw = {"op": op, "assoclen": len(assoc)}
            if iv:
                kw["iv"] = iv
            want = len(assoc) + len(data)
            want += taglen if op == socket.ALG_OP_ENCRYPT else -taglen
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
            try:
                ref = lambda m, d=gen["driver"], n=gsize, k=key: hash_digest(
                    d, m, n, k)
                ref(msgs[0])
            except OSError as e:
                rec["unusable"].append(f"{name}/{anchor}: {e}")
                continue
        for e in entries:
            size = int(e.get("digestsize", "0") or 0)
            try:
                for m in msgs:
                    want = ref(m)
                    got = hash_digest(e["driver"], m, size, key)[:len(want)]
                    if got != want:
                        rec["mismatch"].append({
                            "kind": "hash", "alg": name,
                            "driver": e["driver"], "reference": anchor,
                            "message_bytes": len(m),
                            "want": want.hex(), "got": got.hex()})
                        break
                else:
                    rec["checked"].append(e["driver"])
            except OSError as err:
                rec["unusable"].append(f"{name}/{e['driver']}: {err}")


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
                                                  socket.ALG_OP_ENCRYPT))
        except OSError as e:
            rec["unusable"].append(f"{name}/{gen['driver']}: {e}")
            continue
        key = stream(klen + 7)[7:]
        for e in entries:
            try:
                got = skcipher(e["driver"], key, iv, pt,
                               socket.ALG_OP_ENCRYPT)
                back = skcipher(e["driver"], key, iv, got,
                                socket.ALG_OP_DECRYPT)
            except OSError as err:
                rec["unusable"].append(f"{name}/{e['driver']}: {err}")
                continue
            if got != want:
                rec["mismatch"].append({
                    "kind": "skcipher", "alg": name, "driver": e["driver"],
                    "reference": gen["driver"], "key_bytes": klen,
                    "want": want[:32].hex(), "got": got[:32].hex()})
            elif back != pt:
                rec["mismatch"].append({
                    "kind": "skcipher-roundtrip", "alg": name,
                    "driver": e["driver"], "reference": e["driver"],
                    "key_bytes": klen, "want": pt[:32].hex(),
                    "got": back[:32].hex()})
            else:
                rec["checked"].append(e["driver"])


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
                                            socket.ALG_OP_ENCRYPT))
                break
            except OSError as e:
                err = e
        if want is None:
            rec["unusable"].append(f"{name}/{gen['driver']}: {err}")
            continue
        key = stream(klen + 7)[7:]
        for e in entries:
            try:
                got = aead(e["driver"], key, iv, assoc, pt, tag,
                           socket.ALG_OP_ENCRYPT)
                back = aead(e["driver"], key, iv, got[:len(assoc)],
                            got[len(assoc):], tag, socket.ALG_OP_DECRYPT)
            except OSError as err:
                rec["unusable"].append(f"{name}/{e['driver']}: {err}")
                continue
            if got != want:
                rec["mismatch"].append({
                    "kind": "aead", "alg": name, "driver": e["driver"],
                    "reference": gen["driver"], "key_bytes": klen,
                    "want": want[-tag:].hex(), "got": got[-tag:].hex()})
            elif back[len(assoc):] != pt:
                rec["mismatch"].append({
                    "kind": "aead-roundtrip", "alg": name,
                    "driver": e["driver"], "reference": e["driver"],
                    "key_bytes": klen, "want": pt[:32].hex(),
                    "got": back[len(assoc):len(assoc) + 32].hex()})
            else:
                rec["checked"].append(e["driver"])


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
