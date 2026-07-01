#!/usr/bin/env python3
"""End-to-end smoke for badc against the curl 8.11.1 source.

badc compiles the whole libcurl source tree (HTTP + file:// + WebSocket,
threaded resolver, IPv6, no external dependencies) and the demo builds it
three ways at -O0 and -O:

  * static   -- ``badc --ar`` bundles the objects into ``libcurl.a``; the
                driver links against it via ``-L/-l``.
  * shared   -- ``badc --shared --export-all`` produces ``libcurl.<so|dylib>``;
                the driver binds to it through a generated ``#pragma`` header.
  * system   -- the driver binds to the platform's installed libcurl through
                ``curl_syslink.h`` (proves badc's frontend matches the OS ABI).
                Skipped where no system libcurl is present.

Each built driver runs the offline scenarios (version / URL API / escape /
string list), a ``file://`` transfer, and an ``http://`` transfer against a
hermetic loopback server this harness starts on 127.0.0.1 -- no external
network.

Override the badc binary via ``BADC`` (default ``target/release/badc[.exe]``).
"""

from __future__ import annotations

import glob
import http.server
import os
import shutil
import ssl
import subprocess
import sys
import tempfile
import threading
from pathlib import Path

CURL_DIR = Path(__file__).resolve().parent
REPO_ROOT = CURL_DIR.parents[1]
BEAR_DIR = CURL_DIR.parent / "bearssl"
SRC = CURL_DIR / "src"
INC = CURL_DIR / "include"
WIN = sys.platform == "win32"
MAC = sys.platform == "darwin"
LINUX = sys.platform.startswith("linux")
EXE = ".exe" if WIN else ""
SHLIB = ".dylib" if MAC else (".dll" if WIN else ".so")

LOOPBACK_BODY = "hello-from-loopback"

# HTTP-only trim: keep FILE + HTTP + WebSocket, drop the other protocols.
CURL_DISABLE = [
    "FTP", "TFTP", "TELNET", "DICT", "GOPHER", "POP3", "IMAP", "SMTP",
    "RTSP", "MQTT", "SMB", "LDAP", "LDAPS", "NTLM",
]
# POSIX selects the hand-written curl_config.h via -DHAVE_CONFIG_H. Windows
# leaves it undefined so curl_setup.h pulls curl's own lib/config-win32.h, and
# defines __MINGW32__ so curl/system.h takes the LLP64 branch (correct
# curl_off_t) instead of the POSIX one.
_CONFIG_DEFINES = ["-D__MINGW32__"] if WIN else ["-DHAVE_CONFIG_H"]
BASE_DEFINES = (
    ["--gnu", "-DBUILDING_LIBCURL", "-DCURL_STATICLIB"] + _CONFIG_DEFINES
    + [f"-DCURL_DISABLE_{d}" for d in CURL_DISABLE]
)
# curl_config.h lives in the demo dir; the public headers under include/curl.
INCLUDE_PATHS = ["-I", str(SRC), "-I", str(INC), "-I", str(CURL_DIR)]

# Symbols the driver calls; used to generate the shared/system binding headers.
CLIENT_SYMBOLS = [
    "curl_global_init", "curl_global_cleanup", "curl_version",
    "curl_version_info", "curl_free", "curl_url", "curl_url_set",
    "curl_url_get", "curl_url_cleanup", "curl_easy_init", "curl_easy_cleanup",
    "curl_easy_setopt", "curl_easy_perform", "curl_easy_strerror",
    "curl_easy_escape", "curl_easy_unescape", "curl_slist_append",
    "curl_slist_free_all",
]

EXPECTED_PREFIXES = (
    "version OK:",
    "version_info OK:",
    "url OK:",
    "escape OK:",
    "slist OK:",
    "transfer OK: file://",
    "transfer OK: {scheme}://",
    "curl smoke: all scenarios green",
)


def resolve_badc() -> Path:
    env = os.environ.get("BADC")
    candidates = [Path(env)] if env else []
    default = REPO_ROOT / "target" / "release" / "badc"
    candidates += [default, default.with_suffix(".exe")]
    for c in candidates:
        if c.is_file() and os.access(c, os.X_OK):
            return c
    print("smoke: BADC binary not found / not executable\n"
          f"       hint: cargo build --release --manifest-path={REPO_ROOT}/Cargo.toml",
          file=sys.stderr)
    sys.exit(2)


def run(cmd, **kw):
    return subprocess.run(cmd, check=False, **kw)


def lib_sources() -> list[Path]:
    return sorted(p for p in SRC.rglob("*.c"))


def compile_objects(badc: Path, work: Path, optimize: bool) -> list[Path] | None:
    objs = []
    cmd_base = [str(badc)] + (["-O"] if optimize else []) + BASE_DEFINES + INCLUDE_PATHS
    for src in lib_sources():
        obj = work / (src.stem + ".o")
        r = run(cmd_base + ["-c", "-o", str(obj), str(src)], capture_output=True, text=True)
        if r.returncode != 0:
            print(f"smoke FAIL: compile {src.name}\n{r.stderr[:600]}", file=sys.stderr)
            return None
        objs.append(obj)
    return objs


def write_binding_header(path: Path, lib_spec: str) -> None:
    """Emit #pragma dylib + per-symbol bindings for a libcurl at lib_spec
    (install name / soname / abspath / DLL name). Mach-O prefixes exports with
    '_'; ELF and PE use the bare C name. A PE import is resolved by DLL name,
    so on Windows lib_spec must be the basename and the DLL sit beside the exe."""
    us = "_" if MAC else ""
    lines = [f'#pragma dylib(libcurl, "{lib_spec}")']
    lines += [f'#pragma binding(libcurl::{s}, "{us}{s}")' for s in CLIENT_SYMBOLS]
    path.write_text("\n".join(lines) + "\n")


def link_client(badc: Path, work: Path, out: Path, optimize: bool,
                *, archive: Path | None = None, binding_header: Path | None = None) -> bool:
    cmd = [str(badc)] + (["-O"] if optimize else [])
    cmd += ["--gnu", "-DCURL_STATICLIB", "-I", str(INC), "-I", str(CURL_DIR)]
    if binding_header is not None:
        cmd += ["-include", str(binding_header)]
    cmd += [str(CURL_DIR / "curl_client.c")]
    if archive is not None:
        cmd += ["-L", str(archive.parent), "-l", "curl"]
    cmd += ["-o", str(out)]
    r = run(cmd, capture_output=True, text=True)
    if r.returncode != 0:
        print(f"smoke FAIL: link {out.name}\n{r.stderr[:800]}", file=sys.stderr)
        return False
    return True


class LoopbackServer:
    """Threaded HTTP(S) server on 127.0.0.1 serving a fixed body at any path.

    Passing a (certfile, keyfile) pair wraps the listener in TLS, so the same
    harness drives both the plain-HTTP flavours and the HTTPS (BearSSL /
    system-TLS) lane."""

    def __init__(self, tls: tuple[str, str] | None = None) -> None:
        body = LOOPBACK_BODY.encode()

        class Handler(http.server.BaseHTTPRequestHandler):
            def do_GET(self):  # noqa: N802
                self.send_response(200)
                self.send_header("Content-Type", "text/plain")
                self.send_header("Content-Length", str(len(body)))
                self.end_headers()
                self.wfile.write(body)

            def log_message(self, *a):  # silence
                pass

        self.httpd = http.server.ThreadingHTTPServer(("127.0.0.1", 0), Handler)
        if tls is not None:
            ctx = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
            ctx.load_cert_chain(tls[0], tls[1])
            self.httpd.socket = ctx.wrap_socket(self.httpd.socket, server_side=True)
        self.scheme = "https" if tls else "http"
        self.port = self.httpd.socket.getsockname()[1]
        self.thread = threading.Thread(target=self.httpd.serve_forever, daemon=True)

    @property
    def base_url(self) -> str:
        return f"{self.scheme}://127.0.0.1:{self.port}"

    def __enter__(self):
        self.thread.start()
        return self

    def __exit__(self, *a):
        self.httpd.shutdown()
        self.httpd.server_close()


def make_self_signed_cert(work: Path) -> tuple[str, str] | None:
    """Generate a throwaway self-signed cert+key for 127.0.0.1 via openssl.
    Returns (certfile, keyfile), or None when openssl is unavailable."""
    if not shutil.which("openssl"):
        return None
    cert = work / "loopback_cert.pem"
    key = work / "loopback_key.pem"
    r = run(["openssl", "req", "-x509", "-newkey", "rsa:2048", "-keyout", str(key),
             "-out", str(cert), "-days", "2", "-nodes", "-subj", "/CN=127.0.0.1",
             "-addext", "subjectAltName=IP:127.0.0.1"], capture_output=True, text=True)
    if r.returncode != 0 or not cert.exists():
        return None
    return (str(cert), str(key))


def build_bearssl_archive(badc: Path, work: Path) -> Path | None:
    """Compile the vendored BearSSL sources into libbearssl.a."""
    subprocess.run([sys.executable, str(BEAR_DIR / "setup.py")], check=True)
    srcs = sorted(glob.glob(str(BEAR_DIR / "src" / "**" / "*.c"), recursive=True))
    if not srcs:
        print("smoke FAIL: no BearSSL sources (setup.py)", file=sys.stderr)
        return None
    objs = []
    incs = ["-I", str(BEAR_DIR / "inc"), "-I", str(BEAR_DIR / "src")]
    for i, src in enumerate(srcs):
        obj = work / f"be_{i}.o"
        # BR_USE_WIN32_RAND=0: the Win32 CryptoAPI seeder needs a <wincrypt.h>
        # surface badc does not ship; the portable PRNGs cover the demo.
        r = run([str(badc), "--gnu", "-DBR_USE_WIN32_RAND=0", *incs,
                 "-c", "-o", str(obj), src], capture_output=True, text=True)
        if r.returncode != 0:
            print(f"smoke FAIL: BearSSL {Path(src).name}\n{r.stderr[:500]}", file=sys.stderr)
            return None
        objs.append(obj)
    archive = work / "libbearssl.a"
    if run([str(badc), "--ar", "-o", str(archive)] + [str(o) for o in objs],
           capture_output=True, text=True).returncode != 0:
        print("smoke FAIL: libbearssl.a", file=sys.stderr)
        return None
    return archive


def build_tls_lane(badc: Path, work: Path, bearssl: Path, https_base: str) -> bool:
    """Compile libcurl with USE_BEARSSL, link the driver against it plus
    libbearssl, and run an HTTPS transfer against the TLS loopback."""
    od = work / "tls"
    od.mkdir(exist_ok=True)
    defs = BASE_DEFINES + ["-DUSE_BEARSSL", "-I", str(BEAR_DIR / "inc")]
    objs = []
    for src in lib_sources():
        obj = od / (src.stem + ".o")
        r = run([str(badc), *defs, *INCLUDE_PATHS, "-c", "-o", str(obj), str(src)],
                capture_output=True, text=True)
        if r.returncode != 0:
            print(f"smoke FAIL: compile (TLS) {src.name}\n{r.stderr[:600]}", file=sys.stderr)
            return False
        objs.append(obj)
    archive = od / "libcurl.a"
    if run([str(badc), "--ar", "-o", str(archive)] + [str(o) for o in objs],
           capture_output=True, text=True).returncode != 0:
        print("smoke FAIL: libcurl.a (TLS)", file=sys.stderr)
        return False
    # Link against both archives (curl references BearSSL's br_* symbols).
    exe = od / f"curl_client_tls{EXE}"
    cmd = [str(badc), "--gnu", "-DCURL_STATICLIB", "-I", str(INC), "-I", str(CURL_DIR),
           str(CURL_DIR / "curl_client.c"), "-L", str(od), "-l", "curl",
           "-L", str(bearssl.parent), "-l", "bearssl", "-o", str(exe)]
    r = run(cmd, capture_output=True, text=True)
    if r.returncode != 0:
        print(f"smoke FAIL: link TLS client\n{r.stderr[:800]}", file=sys.stderr)
        return False
    return run_and_check("bearssl-tls", exe, https_base)


def run_and_check(label: str, exe: Path, base_url: str, env=None) -> bool:
    # Run from the exe's directory so the client's temp file lands there and,
    # on Windows, the loader finds a co-located libcurl.dll.
    proc = run([str(exe), base_url], capture_output=True, text=True, env=env,
               cwd=str(exe.parent))
    out = proc.stdout.replace("\r", "")
    err = proc.stderr.replace("\r", "")
    if proc.returncode != 0:
        print(f"smoke FAIL [{label}]: exit {proc.returncode}\n--- stdout ---\n{out}\n"
              f"--- stderr ---\n{err}", file=sys.stderr)
        return False
    scheme = base_url.split("://", 1)[0]
    expected = [p.format(scheme=scheme) for p in EXPECTED_PREFIXES]
    lines = [ln for ln in out.splitlines() if ln.strip()]
    if len(lines) != len(expected):
        print(f"smoke FAIL [{label}]: expected {len(expected)} lines, got "
              f"{len(lines)}\n{out}", file=sys.stderr)
        return False
    for i, prefix in enumerate(expected):
        if not lines[i].startswith(prefix):
            print(f"smoke FAIL [{label}]: line {i+1} {lines[i]!r} != {prefix!r}",
                  file=sys.stderr)
            return False
    print(f"smoke OK [{label}]")
    return True


def system_libcurl_present() -> bool:
    if MAC:
        return Path("/usr/lib/libcurl.4.dylib").exists() or _dyld_has("libcurl.4.dylib")
    if LINUX:
        for d in ("/usr/lib", "/lib", "/usr/lib/x86_64-linux-gnu",
                  "/usr/lib/aarch64-linux-gnu", "/lib64"):
            if list(Path(d).glob("libcurl.so*")) if Path(d).is_dir() else []:
                return True
        return False
    return False


def _dyld_has(name: str) -> bool:
    # On modern macOS the dylib is in the shared cache, not on disk; probe it.
    try:
        import ctypes
        return ctypes.CDLL(name) is not None
    except OSError:
        return False


def build_and_run(badc: Path, work: Path, base_url: str) -> bool:
    ok = True
    for optimize in (False, True):
        tag = "O" if optimize else "O0"
        od = work / tag
        od.mkdir(exist_ok=True)
        objs = compile_objects(badc, od, optimize)
        if objs is None:
            return False

        # static archive
        archive = od / "libcurl.a"
        if run([str(badc), "--ar", "-o", str(archive)] + [str(o) for o in objs],
               capture_output=True, text=True).returncode != 0:
            print(f"smoke FAIL: libcurl.a ({tag})", file=sys.stderr)
            return False
        static_exe = od / f"curl_client_static{EXE}"
        if not link_client(badc, od, static_exe, optimize, archive=archive):
            return False
        ok &= run_and_check(f"static-{tag}", static_exe, base_url)

        # shared library
        shared = od / f"libcurl{SHLIB}"
        if run([str(badc), "--shared", "--export-all", "-o", str(shared)]
               + [str(o) for o in objs], capture_output=True, text=True).returncode != 0:
            print(f"smoke FAIL: libcurl{SHLIB} ({tag})", file=sys.stderr)
            return False
        bind = od / "curl_shared_link.h"
        # PE imports resolve by DLL name (the loader searches the exe dir);
        # ELF/Mach-O record the full path we pass.
        write_binding_header(bind, shared.name if WIN else str(shared))
        shared_exe = od / f"curl_client_shared{EXE}"
        if not link_client(badc, od, shared_exe, optimize, binding_header=bind):
            return False
        env = dict(os.environ)
        env["LD_LIBRARY_PATH"] = str(od) + os.pathsep + env.get("LD_LIBRARY_PATH", "")
        ok &= run_and_check(f"shared-{tag}", shared_exe, base_url, env=env)

    # system libcurl (opt-independent; POSIX with a system libcurl only)
    if not WIN and system_libcurl_present():
        sys_exe = work / f"curl_client_system{EXE}"
        if not link_client(badc, work, sys_exe, False,
                           binding_header=CURL_DIR / "curl_syslink.h"):
            return False
        ok &= run_and_check("system", sys_exe, base_url)
    else:
        print("smoke SKIP: no system libcurl for the ABI-interop check")
    return ok


def main() -> int:
    badc = resolve_badc()
    subprocess.run([sys.executable, str(CURL_DIR / "setup.py")], check=True)
    with tempfile.TemporaryDirectory(prefix="curl-smoke-") as work_str:
        work = Path(work_str)
        ok = True
        with LoopbackServer() as srv:
            ok &= build_and_run(badc, work, srv.base_url)

        # HTTPS lane: the whole stack (libcurl + BearSSL TLS) is badc-built and
        # fetches over TLS from a loopback server with a self-signed cert.
        cert = make_self_signed_cert(work)
        if cert is None:
            print("smoke SKIP: openssl not found -- HTTPS (BearSSL) lane not run")
        else:
            bearssl = build_bearssl_archive(badc, work)
            if bearssl is None:
                ok = False
            else:
                with LoopbackServer(tls=cert) as tsrv:
                    ok &= build_tls_lane(badc, work, bearssl, tsrv.base_url)
        return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
