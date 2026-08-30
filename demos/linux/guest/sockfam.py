#!/usr/bin/env python3
"""Socket-family probe for the kernel under test, run inside the guest.

A distribution kernel configures a dozen protocol families. The boot probes
reach AF_UNIX, AF_INET and AF_NETLINK only through whatever userspace happens
to do, so a family that fails to register, to bind or to carry a byte is
reported -- if at all -- as a service that did not start, and only on a guest
whose init creates a unit for it. This probe asks each family directly and
reports the errno.

For every family named in `FAMILIES` (comma-separated, from the environment)
it creates a socket, and where the family can be bound without a peer or a
device it binds, listens and runs a local transfer. What a family cannot
reach without external state is named in `uncovered` rather than skipped in
silence.

AF_VSOCK is driven through libc rather than through this Python's socket
module: `socket.AF_VSOCK` support varies by build, and a probe that skipped
the family on that basis would be exactly the hole this script closes.

    FAMILIES=AF_UNIX,AF_VSOCK python3 sockfam.py

Prints one JSON object. Exit 0 when every family passed or skipped, 1 when
one failed, 2 when the environment named none.
"""

from __future__ import annotations

import ctypes
import errno
import hashlib
import json
import os
import socket
import struct
import sys
import tempfile
import time

# Numeric so the probe does not depend on this Python knowing the family.
AF = {"AF_UNIX": 1, "AF_INET": 2, "AF_INET6": 10, "AF_NETLINK": 16,
      "AF_PACKET": 17, "AF_ALG": 38, "AF_VSOCK": 40}

VMADDR_CID_ANY = 0xFFFFFFFF
VMADDR_PORT_ANY = 0xFFFFFFFF
LAST_RESERVED_PORT = 1023
# _IOR(7, 0xb9, unsigned int) -- the local-CID query systemd reads.
IOCTL_VM_SOCKETS_GET_LOCAL_CID = 0x7B9
PAYLOAD = b"badc-socket-family-probe"

PASS, SKIP, FAIL = "pass", "skip", "fail"

_libc = ctypes.CDLL(None, use_errno=True)


def _call(fn, *args) -> int:
    """A libc call, returning 0 on success or the positive errno."""
    ctypes.set_errno(0)
    return 0 if fn(*args) >= 0 else ctypes.get_errno()


def sockaddr_vm(cid: int, port: int) -> ctypes.Array:
    """struct sockaddr_vm: family, reserved, port, cid, flags, zero."""
    return ctypes.create_string_buffer(
        struct.pack("=HHIIB3x", AF["AF_VSOCK"], 0, port, cid, 0), 16)


def vsock_bind(fd: int, cid: int, port: int) -> int:
    return _call(_libc.bind, fd, sockaddr_vm(cid, port), 16)


def vsock_port(fd: int) -> int:
    """The port `bind` assigned, read back through getsockname."""
    buf = ctypes.create_string_buffer(16)
    ln = ctypes.c_int(16)
    if _libc.getsockname(fd, buf, ctypes.byref(ln)) < 0:
        return VMADDR_PORT_ANY
    return struct.unpack_from("=HHII", buf.raw)[2]


def vsock_local_cid() -> tuple[int, int]:
    """(errno, cid) from /dev/vsock, the pair systemd-ssh-generator reads.
    VMADDR_CID_ANY means no transport assigns this guest a CID."""
    try:
        fd = os.open("/dev/vsock", os.O_RDONLY)
    except OSError as e:
        return e.errno, VMADDR_CID_ANY
    try:
        buf = ctypes.create_string_buffer(4)
        e = _call(_libc.ioctl, fd, IOCTL_VM_SOCKETS_GET_LOCAL_CID, buf)
        return e, struct.unpack("=I", buf.raw)[0]
    finally:
        os.close(fd)


class Probe:
    """One family's outcome: the errno of each step it ran."""

    def __init__(self, name: str):
        self.name, self.steps, self.uncovered = name, {}, []
        self.status, self.detail = PASS, ""
        self.report: dict = {}
        self.socks: list[socket.socket] = []

    def sock(self, type_: int, proto: int = 0) -> socket.socket | None:
        try:
            s = socket.socket(AF[self.name], type_, proto)
        except OSError as e:
            self.fail("create", e.errno)
            return None
        self.socks.append(s)
        self.steps["create"] = 0
        return s

    def step(self, name: str, fn) -> bool:
        """Run one step; record its errno and fail the family on an error."""
        try:
            fn()
        except OSError as e:
            self.fail(name, e.errno)
            return False
        self.steps[name] = 0
        return True

    def raw(self, name: str, e: int) -> bool:
        self.steps[name] = e
        if e in (errno.EPERM, errno.EACCES) and os.geteuid() != 0:
            # Unprivileged, this says nothing about the kernel. The stage
            # runs as root, where the same errno is a finding.
            self.status, self.detail = SKIP, f"{name} needs root"
        elif e:
            self.status = FAIL
            self.detail = f"{name}: {errno.errorcode.get(e, e)}"
        return e == 0

    def fail(self, name: str, e: int) -> None:
        self.raw(name, e or errno.EIO)

    def note(self, what: str) -> None:
        """Something this probe did not reach. Named, never counted."""
        self.uncovered.append(what)

    def skip(self, why: str) -> None:
        self.status, self.detail = SKIP, why

    def close(self) -> None:
        for s in self.socks:
            try:
                s.close()
            except OSError:
                pass

    def json(self) -> dict:
        return {"name": self.name, "status": self.status,
                "detail": self.detail, "steps": self.steps,
                "uncovered": self.uncovered, "report": self.report}


def transfer(server: socket.socket, client: socket.socket, p: Probe) -> None:
    """listen / connect / send / recv over a bound connection-oriented
    socket, all inside this guest."""
    if not p.step("listen", lambda: server.listen(1)):
        return
    if not p.step("connect", lambda: client.connect(server.getsockname())):
        return
    conn, _ = server.accept()
    p.socks.append(conn)
    client.sendall(PAYLOAD)
    got = conn.recv(len(PAYLOAD))
    p.raw("transfer", 0 if got == PAYLOAD else errno.EIO)


def probe_unix(p: Probe) -> None:
    s = p.sock(socket.SOCK_STREAM)
    if s is None:
        return
    with tempfile.TemporaryDirectory() as d:
        path = os.path.join(d, "badc.sock")
        if not p.step("bind", lambda: s.bind(path)):
            return
        c = p.sock(socket.SOCK_STREAM)
        if c is not None:
            transfer(s, c, p)


def probe_inet(p: Probe, host: str) -> None:
    s = p.sock(socket.SOCK_STREAM)
    if s is None:
        return
    if not p.step("bind", lambda: s.bind((host, 0))):
        return
    c = p.sock(socket.SOCK_STREAM)
    if c is not None:
        transfer(s, c, p)
    d = p.sock(socket.SOCK_DGRAM)
    if d is None:
        return
    if p.step("dgram-bind", lambda: d.bind((host, 0))):
        d.sendto(PAYLOAD, d.getsockname())
        d.settimeout(5)
        try:
            p.raw("dgram", 0 if d.recv(len(PAYLOAD)) == PAYLOAD else errno.EIO)
        except OSError as e:
            p.fail("dgram", e.errno)


def probe_inet6(p: Probe) -> None:
    if not os.path.exists("/proc/net/if_inet6"):
        p.skip("IPv6 is disabled in this guest (no /proc/net/if_inet6)")
        return
    probe_inet(p, "::1")


def probe_netlink(p: Probe) -> None:
    """NETLINK_ROUTE: bind, then dump the link table and read it back."""
    s = p.sock(socket.SOCK_RAW, 0)
    if s is None:
        return
    if not p.step("bind", lambda: s.bind((0, 0))):
        return
    # nlmsghdr(len,type=RTM_GETLINK,flags=REQUEST|DUMP,seq,pid) + ifinfomsg
    body = struct.pack("=BBHiIIi", socket.AF_UNSPEC, 0, 0, 0, 0, 0, 0)
    msg = struct.pack("=IHHII", 16 + len(body), 18, 0x301, 1, 0) + body
    s.settimeout(10)
    if not p.step("dump", lambda: s.send(msg)):
        return
    links, done = 0, False
    try:
        while not done:
            buf = s.recv(65536)
            off = 0
            while off + 16 <= len(buf):
                ln, ty = struct.unpack_from("=IH", buf, off)
                if ln < 16:
                    break
                if ty == 3:            # NLMSG_DONE
                    done = True
                elif ty == 2:          # NLMSG_ERROR
                    p.raw("dump", abs(struct.unpack_from("=i", buf, off + 16)[0]))
                    return
                elif ty == 16:         # RTM_NEWLINK
                    links += 1
                off += (ln + 3) & ~3
    except OSError as e:
        p.fail("dump", e.errno)
        return
    p.report["links"] = links
    p.raw("dump", 0 if links else errno.ENODEV)


def probe_packet(p: Probe) -> None:
    """ETH_P_ALL on the loopback device: create and bind only."""
    s = p.sock(socket.SOCK_DGRAM, socket.htons(3))
    if s is None:
        return
    p.step("bind", lambda: s.bind(("lo", 0)))
    p.note("capture: reading frames needs generated traffic and a bounded "
           "wait, which this probe does not run")


def probe_alg(p: Probe) -> None:
    """A sha256 transform through the kernel's own AF_ALG socket."""
    s = p.sock(socket.SOCK_SEQPACKET)
    if s is None:
        return
    if not p.step("bind", lambda: s.bind(("hash", "sha256"))):
        return
    try:
        conn, _ = s.accept()
    except OSError as e:
        p.fail("accept", e.errno)
        return
    p.socks.append(conn)
    p.steps["accept"] = 0
    conn.sendall(PAYLOAD)
    got = conn.recv(32)
    p.raw("digest", 0 if got == hashlib.sha256(PAYLOAD).digest() else errno.EIO)


def probe_vsock(p: Probe) -> None:
    """Create, bind an auto-assigned and a reserved port, listen, and read
    the local CID the way systemd-ssh-generator does. bind is the step a
    family that registers but cannot be bound fails at, and it is what an
    AF_VSOCK listener does first; a local CID of VMADDR_CID_ANY is a guest
    with no transport, not a defect."""
    s = p.sock(socket.SOCK_STREAM)
    if s is None:
        return
    if not p.raw("bind", vsock_bind(s.fileno(), VMADDR_CID_ANY,
                                   VMADDR_PORT_ANY)):
        return
    port = vsock_port(s.fileno())
    p.report["port"] = port
    if not p.raw("listen", _call(_libc.listen, s.fileno(), 4)):
        return
    # The reserved range takes a privileged path of its own; systemd's
    # sshd-vsock.socket binds vsock::22 through it. Walk down from the top of
    # the range, since a guest whose init already listens owns some of it and
    # EADDRINUSE is that listener, not a defect.
    r = p.sock(socket.SOCK_STREAM)
    if r is not None:
        e = errno.EADDRINUSE
        for port in range(LAST_RESERVED_PORT, LAST_RESERVED_PORT - 16, -1):
            e = vsock_bind(r.fileno(), VMADDR_CID_ANY, port)
            if e != errno.EADDRINUSE:
                break
        if e == errno.EADDRINUSE:
            p.note("reserved-port bind: every port this probe tried in the "
                   "reserved range is already bound in this guest")
        else:
            p.raw("bind-reserved", e)
    e, cid = vsock_local_cid()
    p.raw("local-cid", e)
    p.report["local_cid"] = cid
    p.note("peer traffic: which transport carries a connection depends on "
           "the transports registered in this guest, so a round trip here "
           "would report the guest's module state, not the kernel's")


PROBES = {"AF_UNIX": probe_unix,
          "AF_INET": lambda p: probe_inet(p, "127.0.0.1"),
          "AF_INET6": probe_inet6,
          "AF_NETLINK": probe_netlink,
          "AF_PACKET": probe_packet,
          "AF_ALG": probe_alg,
          "AF_VSOCK": probe_vsock}


def run(names: list[str]) -> dict:
    started = time.time()
    out = []
    for name in names:
        p = Probe(name)
        if name not in PROBES:
            p.status, p.detail = FAIL, "no probe for this family"
        else:
            try:
                PROBES[name](p)
            except OSError as e:
                p.status = FAIL
                p.detail = f"unexpected {errno.errorcode.get(e.errno, e.errno)}"
            finally:
                p.close()
        out.append(p.json())
    return {"families": out, "seconds": round(time.time() - started, 1)}


def main() -> int:
    names = [n for n in os.environ.get("FAMILIES", "").split(",") if n]
    if not names:
        print(json.dumps({"families": [], "error": "FAMILIES is empty"}))
        return 2
    result = run(names)
    print(json.dumps(result))
    return 1 if any(f["status"] == FAIL for f in result["families"]) else 0


if __name__ == "__main__":
    sys.exit(main())
