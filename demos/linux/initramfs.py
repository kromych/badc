#!/usr/bin/env python3
"""Build the initramfs verify.py boots.

The image holds one file, ``/init``, plus the mount points it needs. It does
two things:

* Prints the boot marker, which says the kernel reached userspace, and then
  asks the machine to go away, so a boot ends there rather than at the boot
  timeout. A reset request is what ends it -- qemu's ``-no-reboot`` turns that
  into an exit, and unlike power-off it is wired on every machine tested
  (``-M virt`` halts on power-off instead of stopping the emulator). Power-off
  follows as a fallback; neither returns on a platform that implements it.

* Exercises the kernel it just booted, and reports that under a second marker.
  Reaching userspace only proves the boot path; a defect that leaves ``read()``
  on a procfs file spinning forever passes a marker-only boot. The checks read
  a fixed set of ``/proc`` and ``/sys`` files and assert their contents, in
  small requests so a file spans several ``read()`` calls, and once more from a
  non-zero offset. Each file is named on the console before it is opened, so a
  boot that stops reports which file it stopped on.

  The checks end at the vDSO, which is the one image in the build a loader
  has to search rather than just map. It is resolved the way a loader
  resolves it -- ``AT_SYSINFO_EHDR``, ``PT_DYNAMIC``, ``DT_SONAME``,
  ``DT_GNU_HASH`` or ``DT_HASH``, then ``DT_VERSYM``/``DT_VERDEF`` for the
  version the symbol is exported under -- and the function those tables
  hand back is called and required to keep time. Which hash table a vDSO
  carries is its ``--hash-style``: arm64 6.10 builds ``sysv`` only, so a
  probe that required ``.gnu.hash`` could not read it at all. A linker that
  got the dynamic metadata wrong fails here rather than producing an image
  that links and cannot be searched. Reported under ``BADC-VDSO-OK``.

The two markers are separate on purpose: a boot that prints the first and not
the second reached userspace and failed the checks, which is a different defect
from one that never got there.

``/init`` is freestanding: the image carries no C library and no loader, so
the program enters at ``_start``, makes its system calls itself and links as
a static executable. badc builds it for the boot's architecture (``--arch``,
the host's by default), so a cross boot needs no cross toolchain on the host.
``--cc`` names a host or cross C compiler instead, for a probe built outside
the compiler under test. Whichever built it, ``/init`` is checked before it is
packed: an executable for another machine, or one that asks for a loader, is
refused here with the reason, rather than reported by the kernel as no
working init a boot later.

    python3 demos/linux/initramfs.py --arch aarch64 -o initramfs.cpio.gz

The image can carry a guest. ``--guest-emulator`` names an emulator on this
host, carried under ``/guest`` with the shared libraries ``ldd`` lists and
its loader at the path its ``PT_INTERP`` names, with ``--guest-file`` files
beside it and ``--guest-args`` as its arguments. After its checks ``/init``
then mounts devtmpfs, reports the virtualization extension ``/proc/cpuinfo``
lists and whether ``/dev/kvm`` opens, and runs the emulator with its console
on this one, between ``BADC-NESTED-GUEST-BEGIN`` and
``BADC-NESTED-GUEST-END``; verify.py's nested boot runs the kernel's own
image that way under the kernel's own KVM.

The archive is written directly (newc, gzip) so no cpio binary is needed.
``--self-test`` runs the checks on the image inspection and the archive
writer; ``verify.py --self-test`` does not include them.
"""

from __future__ import annotations

import argparse
import gzip
import io
import os
import re
import shlex
import struct
import subprocess
import sys
import tempfile
from pathlib import Path
from typing import NamedTuple

import karch

LINUX_DIR = Path(__file__).resolve().parent
REPO_ROOT = LINUX_DIR.parents[1]

BOOT_MARKER = "BADC-VMLINUX-OK"
CHECK_MARKER = "BADC-SELFTEST-OK"
CHECK_FAIL = "BADC-SELFTEST-FAIL"
# Distinct from CHECK_MARKER: a per-file progress line must not read as the
# success marker to anything grepping the console.
CHECK_STEP = "BADC-SELFTEST-STEP"
# The guest stage's report lines, and the bracket around the guest's own
# console, which arrives on the same console as everything else.
NESTED_MARKER = "BADC-NESTED"
GUEST_BEGIN = "BADC-NESTED-GUEST-BEGIN"
GUEST_END = "BADC-NESTED-GUEST-END"
GUEST_DIR = "/guest"
GUEST_LIB = "/guest/lib"


class Arch(NamedTuple):
    target: str   # badc --target
    machine: int  # ELF e_machine


ARCHES = {
    "x86_64": Arch("linux-x64", 62),      # EM_X86_64
    "aarch64": Arch("linux-aarch64", 183),  # EM_AARCH64
}

INIT_C = r"""
/* Freestanding: the initramfs carries no C library and no loader. The entry
   and the system-call stub are the file-scope assembly at the end; a system
   call returns the negative errno on failure, as the kernel does. */
#include <elf.h>
#include <errno.h>
#include <fcntl.h>
#include <link.h>
#include <linux/auxvec.h>
#include <signal.h>
#include <stdarg.h>
#include <sys/mount.h>
#include <sys/reboot.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <time.h>

#define BOOT_MARKER  "@BOOT_MARKER@"
#define CHECK_MARKER "@CHECK_MARKER@"
#define CHECK_FAIL   "@CHECK_FAIL@"
#define CHECK_STEP   "@CHECK_STEP@"
#define NESTED       "@NESTED_MARKER@"
#define GUEST_BEGIN  "@GUEST_BEGIN@"
#define GUEST_END    "@GUEST_END@"
#define GUEST_LIB    "@GUEST_LIB@"

/* reboot(2) takes these ahead of the command; from linux/reboot.h. */
#define LINUX_REBOOT_MAGIC1 0xfee1dead
#define LINUX_REBOOT_MAGIC2 672274793

#ifndef SEEK_SET
#define SEEK_SET 0
#endif

/* Small enough that every file takes several read() calls, so a partial
   record has to survive between them. */
#define CHUNK 64
#define CAP   65536

long sys_call6(long a, long b, long c, long d, long e, long f, long nr);

static long sys_write(int fd, const void *p, unsigned long n)
{
    return sys_call6(fd, (long)p, (long)n, 0, 0, 0, SYS_write);
}

static long sys_read(int fd, void *p, unsigned long n)
{
    return sys_call6(fd, (long)p, (long)n, 0, 0, 0, SYS_read);
}

static long sys_open(const char *path, int flags)
{
    return sys_call6(AT_FDCWD, (long)path, flags, 0, 0, 0, SYS_openat);
}

static long sys_close(int fd)
{
    return sys_call6(fd, 0, 0, 0, 0, 0, SYS_close);
}

static long sys_lseek(int fd, long off, int whence)
{
    return sys_call6(fd, off, whence, 0, 0, 0, SYS_lseek);
}

static long sys_mkdir(const char *path, int mode)
{
    return sys_call6(AT_FDCWD, (long)path, mode, 0, 0, 0, SYS_mkdirat);
}

static long sys_mount(const char *src, const char *dst, const char *type)
{
    return sys_call6((long)src, (long)dst, (long)type, 0, 0, 0, SYS_mount);
}

static long sys_finit_module(int fd, const char *params, int flags)
{
    return sys_call6(fd, (long)params, flags, 0, 0, 0, SYS_finit_module);
}

static long sys_reboot(int cmd)
{
    return sys_call6(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, cmd, 0, 0, 0,
                     SYS_reboot);
}

/* clone with the child-exit signal and no other flag is fork; the
   remaining arguments are unused and zero on both architectures. */
static long sys_fork(void)
{
    return sys_call6(SIGCHLD, 0, 0, 0, 0, 0, SYS_clone);
}

static long sys_execve(const char *path, const char *const argv[],
                       const char *const envp[])
{
    return sys_call6((long)path, (long)argv, (long)envp, 0, 0, 0, SYS_execve);
}

static long sys_wait4(long pid, int *status)
{
    return sys_call6(pid, (long)status, 0, 0, 0, 0, SYS_wait4);
}

static void sys_exit(int code)
{
    sys_call6(code, 0, 0, 0, 0, 0, SYS_exit_group);
}

static void emit(const char *s, unsigned long n)
{
    static const struct timespec pause = { 0, 1000000 };

    while (n) {
        long r = sys_write(1, s, n);

        /* The guest emulator leaves the console non-blocking; a full
           output buffer is waited out rather than dropped. */
        if (r == -EAGAIN) {
            sys_call6((long)&pause, 0, 0, 0, 0, 0, SYS_nanosleep);
            continue;
        }
        if (r <= 0)
            return;
        s += r;
        n -= (unsigned long)r;
    }
}

/* printf for the conversions this file spells: %s, %d, %u, %ld, %lu and a
   zero-padded width as in %09ld. One write per call, so a line reaches the
   console whole. */
static void pr(const char *fmt, ...)
{
    static char out[1024];
    unsigned long n = 0;
    va_list ap;

    va_start(ap, fmt);
    while (*fmt && n < sizeof out) {
        char digits[24];
        const char *s;
        unsigned long u;
        int width = 0, zero = 0, is_long = 0, neg = 0, k = 0;

        if (*fmt != '%') {
            out[n++] = *fmt++;
            continue;
        }
        fmt++;
        if (*fmt == '0') {
            zero = 1;
            fmt++;
        }
        while (*fmt >= '0' && *fmt <= '9')
            width = width * 10 + (*fmt++ - '0');
        if (*fmt == 'l') {
            is_long = 1;
            fmt++;
        }
        switch (*fmt++) {
        case 's':
            for (s = va_arg(ap, const char *); *s && n < sizeof out; s++)
                out[n++] = *s;
            continue;
        case 'd': {
            long v = is_long ? va_arg(ap, long) : va_arg(ap, int);

            neg = v < 0;
            u = neg ? 0UL - (unsigned long)v : (unsigned long)v;
            break;
        }
        case 'u':
            u = is_long ? va_arg(ap, unsigned long) : va_arg(ap, unsigned);
            break;
        default:
            continue;
        }
        do
            digits[k++] = (char)('0' + u % 10);
        while ((u /= 10) != 0);
        if (neg)
            out[n++] = '-';
        for (; k < width && n < sizeof out; width--)
            out[n++] = zero ? '0' : ' ';
        while (k && n < sizeof out)
            out[n++] = digits[--k];
    }
    va_end(ap);
    emit(out, n);
}

static int str_eq(const char *a, const char *b)
{
    while (*a && *a == *b)
        a++, b++;
    return *a == *b;
}

/* Whether `needle' occurs in `hay'. */
static int str_has(const char *hay, const char *needle)
{
    for (; *hay; hay++) {
        unsigned long i = 0;

        while (needle[i] && hay[i] == needle[i])
            i++;
        if (!needle[i])
            return 1;
    }
    return 0;
}

struct probe {
    const char *path;
    const char *want;   /* substring the contents must hold; "" = non-empty */
};

/* Files present at defconfig on every architecture the gate covers. The
   procfs entries are seq_file readers, single-record and multi-record; the
   sysfs entries are kernfs, which is a separate path. */
static const struct probe PROBES[] = {
    { "/proc/cmdline",                    "console=" },
    { "/proc/version",                    "Linux version" },
    { "/proc/meminfo",                    "MemTotal" },
    { "/proc/mounts",                     "proc" },
    { "/proc/stat",                       "cpu" },
    { "/proc/uptime",                     "" },
    { "/proc/interrupts",                 "CPU0" },
    { "/proc/self/stat",                  "" },
    { "/proc/self/maps",                  "" },
    { "/proc/self/status",                "Name:" },
    { "/proc/filesystems",                "proc" },
    { "/sys/devices/system/cpu/online",   "0" },
    { "/sys/devices/system/cpu/possible", "0" },
    { "/sys/kernel/uevent_seqnum",        "" },
};

static char buf[CAP];

static void fail(const char *path, const char *why)
{
    pr("%s %s: %s\n", CHECK_FAIL, path, why);
}

/* Read the whole file in CHUNK-sized requests. Returns the byte count, or -1
   with the reason reported. Filling the buffer counts as a failure: every
   file read here is far smaller than CAP, so reaching it means the reader
   never reported the end. */
static long slurp(const char *path, long from)
{
    long n = 0, r = 0;
    long fd = sys_open(path, O_RDONLY);

    if (fd < 0) {
        fail(path, "open failed");
        return -1;
    }
    if (from && sys_lseek((int)fd, from, SEEK_SET) < 0) {
        fail(path, "lseek failed");
        sys_close((int)fd);
        return -1;
    }
    while (n < CAP - 1) {
        long want = CAP - 1 - n;

        if (want > CHUNK)
            want = CHUNK;
        r = sys_read((int)fd, buf + n, (unsigned long)want);
        if (r <= 0)
            break;
        n += r;
    }
    sys_close((int)fd);
    if (r < 0) {
        fail(path, "read failed");
        return -1;
    }
    if (n >= CAP - 1) {
        fail(path, "never reached end of file");
        return -1;
    }
    buf[n] = '\0';
    return n;
}

static int check(const struct probe *p)
{
    long n;

    /* Named before the open, so a read that never returns leaves the file it
       stopped on as the last line on the console. */
    pr("%s reading %s\n", CHECK_STEP, p->path);

    n = slurp(p->path, 0);
    if (n < 0)
        return 0;
    if (n == 0) {
        fail(p->path, "empty");
        return 0;
    }
    if (p->want[0] && !str_has(buf, p->want)) {
        fail(p->path, "contents did not match");
        return 0;
    }
    /* Once more from a non-zero offset: seq_file reaches one by replaying
       records rather than by continuing, which a sequential read never does. */
    if (n > 1 && slurp(p->path, 1) < 0)
        return 0;
    return 1;
}

static const char *const modules[] = { @MODULES@ };

/* Several passes, because a module whose dependency has not been loaded yet
   fails with ENOENT; the list carries no dependency order. */
static void load_modules(void)
{
    static char done[sizeof modules / sizeof modules[0]];
    static int last_err[sizeof modules / sizeof modules[0]];
    unsigned n, i, pass, loaded = 0, progress;
    long fd, len, at;

    for (n = 0; modules[n]; n++)
        ;
    if (!n)
        return;
    for (pass = 0; pass < 4; pass++) {
        progress = 0;
        for (i = 0; i < n; i++) {
            long rc;

            if (done[i])
                continue;
            /* Named before the load, so an init that never returns leaves
               the module it stopped in as the last line on the console. */
            pr("BADC-MODULE %s loading pass=%u\n", modules[i], pass);
            fd = sys_open(modules[i], O_RDONLY);
            if (fd < 0) {
                pr("BADC-MODULE %s open errno=%d\n", modules[i], (int)-fd);
                done[i] = 1;
                continue;
            }
            rc = sys_finit_module((int)fd, "", 0);
            sys_close((int)fd);
            if (rc == 0) {
                pr("BADC-MODULE %s loaded\n", modules[i]);
                done[i] = 1;
                loaded++;
                progress = 1;
            } else {
                last_err[i] = (int)-rc;
            }
        }
        if (!progress)
            break;
    }
    /* One line per module that never loaded, with the errno of its last
       attempt; printed after the passes so an early no-progress exit
       cannot swallow it. */
    for (i = 0; i < n; i++)
        if (!done[i] && last_err[i])
            pr("BADC-MODULE %s errno=%d\n", modules[i], last_err[i]);
    pr("BADC-MODULE-DONE loaded=%u of=%u\n", loaded, n);

    /* /proc/modules reports each module's state, which separates a module
       that loaded from one whose init function also completed. /proc is
       mounted by now; a kernel without module support has no such file. */
    fd = sys_open("/proc/modules", O_RDONLY);
    if (fd < 0)
        return;
    sys_close((int)fd);
    len = slurp("/proc/modules", 0);
    for (at = 0; at < len; at++) {
        long end = at;

        while (end < len && buf[end] != '\n')
            end++;
        buf[end] = '\0';
        pr("BADC-MODSTATE %s\n", buf + at);
        at = end;
    }
}

/* The auxiliary vector, from the initial stack: past argc, argv and its
   terminator, then envp and its terminator. */
static const unsigned long *auxv;

static unsigned long auxval(unsigned long type)
{
    const unsigned long *a;

    for (a = auxv; a[0] != AT_NULL; a += 2)
        if (a[0] == type)
            return a[1];
    return 0;
}

/* The vDSO the kernel mapped, resolved the way a loader resolves it:
   through PT_DYNAMIC, the hash table, and the version tables. A linker
   that got any of those wrong fails here rather than silently handing
   back a symbol nobody can find. */

#if defined(__x86_64__)
#define VDSO_SYM     "__vdso_clock_gettime"
#define VDSO_VERSION "LINUX_2.6"
#elif defined(__aarch64__)
#define VDSO_SYM     "__kernel_clock_gettime"
#define VDSO_VERSION "LINUX_2.6.39"
#else
/* An architecture the gate does not cover: the exported name and the
   version differ per architecture, and guessing them would fail a boot
   for the wrong reason. An empty name skips the check. */
#define VDSO_SYM     ""
#define VDSO_VERSION ""
#endif

#define VDSO_SONAME "linux-vdso.so.1"

static unsigned long gnu_hash_of(const char *s)
{
    unsigned long h = 5381;

    while (*s)
        h = h * 33 + (unsigned char)*s++;
    return h & 0xffffffffUL;
}

/* gABI ELF hash, the DT_HASH key. */
static unsigned long sysv_hash_of(const char *s)
{
    unsigned long h = 0, g;

    while (*s) {
        h = (h << 4) + (unsigned char)*s++;
        g = h & 0xf0000000UL;
        if (g)
            h ^= g >> 24;
        h &= ~g;
    }
    return h;
}

/* Look `name' up in the vDSO's .hash: bucket, then the chain, ending at
   STN_UNDEF. Returns the .dynsym index. The tables are 32-bit on both
   ELF classes. */
static int vdso_sysv_lookup(const unsigned int *h, const ElfW(Sym) *sym,
                            const char *str, const char *name)
{
    unsigned int nbucket = h[0], nchain = h[1];
    const unsigned int *bucket = &h[2];
    const unsigned int *chain = &bucket[nbucket];
    unsigned int i;

    if (!nbucket || !nchain)
        return -1;
    for (i = bucket[sysv_hash_of(name) % nbucket]; i; i = chain[i]) {
        if (i >= nchain)
            return -1;
        if (str_eq(str + sym[i].st_name, name))
            return (int)i;
    }
    return -1;
}

/* Look `name' up in the vDSO's .gnu.hash exactly as a loader does:
   Bloom filter, bucket, then the chain. Returns the .dynsym index. */
static int vdso_gnu_lookup(const unsigned int *h, const ElfW(Sym) *sym,
                           const char *str, const char *name)
{
    unsigned int nbuckets = h[0], symndx = h[1], maskwords = h[2], shift2 = h[3];
    const ElfW(Addr) *bloom = (const ElfW(Addr) *)&h[4];
    const unsigned int *buckets = (const unsigned int *)&bloom[maskwords];
    const unsigned int *chain = &buckets[nbuckets];
    unsigned long hash = gnu_hash_of(name);
    ElfW(Addr) word = bloom[(hash / (8 * sizeof(ElfW(Addr)))) % maskwords];
    unsigned int bits = 8 * sizeof(ElfW(Addr));
    unsigned int i;

    if (!(word >> (hash % bits) & 1) || !(word >> ((hash >> shift2) % bits) & 1))
        return -1;
    i = buckets[hash % nbuckets];
    if (i < symndx)
        return -1;
    for (;;) {
        unsigned int c = chain[i - symndx];

        if ((c | 1) == (hash | 1) && str_eq(str + sym[i].st_name, name))
            return (int)i;
        if (c & 1)
            return -1;
        i++;
    }
}

/* The version name `.gnu.version'/`.gnu.version_d' give symbol `n'. */
static const char *vdso_version_of(const unsigned short *versym,
                                   const ElfW(Verdef) *verdef,
                                   const char *str, int n)
{
    unsigned short want = versym ? (versym[n] & 0x7fff) : 0;
    const ElfW(Verdef) *v = verdef;

    if (!versym || !verdef)
        return 0;
    for (;;) {
        if ((v->vd_ndx & 0x7fff) == want) {
            const ElfW(Verdaux) *aux =
                (const ElfW(Verdaux) *)((const char *)v + v->vd_aux);
            return str + aux->vda_name;
        }
        if (!v->vd_next)
            return 0;
        v = (const ElfW(Verdef) *)((const char *)v + v->vd_next);
    }
}

static int check_vdso(void)
{
    unsigned long base = auxval(AT_SYSINFO_EHDR);
    const ElfW(Ehdr) *eh = (const ElfW(Ehdr) *)base;
    const ElfW(Phdr) *ph;
    const ElfW(Dyn) *dyn = 0;
    const char *str = 0, *soname = 0, *ver;
    const ElfW(Sym) *sym = 0;
    const ElfW(Verdef) *verdef = 0;
    const unsigned short *versym = 0;
    const unsigned int *gnu = 0, *sysv = 0;
    unsigned long soname_off = 0;
    struct timespec a, b;
    int (*fn)(clockid_t, struct timespec *);
    int n, i;

    if (!VDSO_SYM[0])
        return 1;   /* architecture the gate does not cover */
    pr("%s resolving %s in the vDSO\n", CHECK_STEP, VDSO_SYM);
    if (!base) {
        fail("vdso", "no AT_SYSINFO_EHDR");
        return 0;
    }
    ph = (const ElfW(Phdr) *)(base + eh->e_phoff);
    for (i = 0; i < eh->e_phnum; i++)
        if (ph[i].p_type == PT_DYNAMIC)
            dyn = (const ElfW(Dyn) *)(base + ph[i].p_vaddr);
    if (!dyn) {
        fail("vdso", "no PT_DYNAMIC");
        return 0;
    }
    for (; dyn->d_tag != DT_NULL; dyn++) {
        switch (dyn->d_tag) {
        case DT_STRTAB:   str = (const char *)(base + dyn->d_un.d_ptr); break;
        case DT_SYMTAB:   sym = (const ElfW(Sym) *)(base + dyn->d_un.d_ptr); break;
        case DT_GNU_HASH: gnu = (const unsigned int *)(base + dyn->d_un.d_ptr); break;
        case DT_HASH:     sysv = (const unsigned int *)(base + dyn->d_un.d_ptr); break;
        case DT_VERSYM:   versym = (const unsigned short *)(base + dyn->d_un.d_ptr); break;
        case DT_VERDEF:   verdef = (const ElfW(Verdef) *)(base + dyn->d_un.d_ptr); break;
        case DT_SONAME:   soname_off = dyn->d_un.d_val; break;
        }
    }
    if (!str) {
        fail("vdso", "PT_DYNAMIC names no string table (DT_STRTAB)");
        return 0;
    }
    if (!sym) {
        fail("vdso", "PT_DYNAMIC names no symbol table (DT_SYMTAB)");
        return 0;
    }
    /* Either hash table resolves the symbol. Which one is present is the
       vDSO's --hash-style, which differs per architecture and kernel
       version, not a property of the linker under test. A loader takes
       DT_GNU_HASH when it is there and falls back to DT_HASH. */
    if (!gnu && !sysv) {
        fail("vdso", "PT_DYNAMIC names no hash table (DT_GNU_HASH or DT_HASH)");
        return 0;
    }
    soname = str + soname_off;
    if (!str_eq(soname, VDSO_SONAME)) {
        fail("vdso", "DT_SONAME is not " VDSO_SONAME);
        return 0;
    }
    n = gnu ? vdso_gnu_lookup(gnu, sym, str, VDSO_SYM)
            : vdso_sysv_lookup(sysv, sym, str, VDSO_SYM);
    if (n < 0) {
        fail("vdso", gnu ? VDSO_SYM " is not in .gnu.hash"
                         : VDSO_SYM " is not in .hash");
        return 0;
    }
    ver = vdso_version_of(versym, verdef, str, n);
    if (!ver || !str_eq(ver, VDSO_VERSION)) {
        fail("vdso", VDSO_SYM " does not carry " VDSO_VERSION);
        return 0;
    }
    /* Call what the tables handed back and require it to keep time. */
    fn = (int (*)(clockid_t, struct timespec *))(base + sym[n].st_value);
    if (fn(CLOCK_MONOTONIC, &a) || fn(CLOCK_MONOTONIC, &b)) {
        fail("vdso", VDSO_SYM " returned an error");
        return 0;
    }
    if (b.tv_sec < a.tv_sec || (b.tv_sec == a.tv_sec && b.tv_nsec < a.tv_nsec)) {
        fail("vdso", "CLOCK_MONOTONIC went backwards");
        return 0;
    }
    if (!a.tv_sec && !a.tv_nsec) {
        fail("vdso", "CLOCK_MONOTONIC is zero");
        return 0;
    }
    pr("BADC-VDSO-OK %s@%s soname=%s t=%ld.%09ld\n",
       VDSO_SYM, ver, soname, (long)a.tv_sec, (long)a.tv_nsec);
    return 1;
}

/* The guest the image carries: the emulator's argument list, empty when
   there is none. It runs under this kernel's KVM with its console on this
   one, so what it prints arrives between GUEST_BEGIN and GUEST_END. */
static const char *const guest_argv[] = { @GUEST_ARGV@ };
static const char *const guest_envp[] = { "LD_LIBRARY_PATH=" GUEST_LIB,
                                          "HOME=/", 0 };

/* Whether `flag' is one of the blank-separated words in buf. */
static int has_flag(const char *flag)
{
    const char *s;

    for (s = buf; *s; s++) {
        unsigned long i = 0;

        if (s != buf && s[-1] != ' ' && s[-1] != '\t')
            continue;
        while (flag[i] && s[i] == flag[i])
            i++;
        if (!flag[i] && (s[i] == ' ' || s[i] == '\n' || !s[i]))
            return 1;
    }
    return 0;
}

/* The virtualization extension /proc/cpuinfo lists among the CPU flags,
   which x86 does and KVM there needs; other architectures list none. */
static const char *virt_flag(void)
{
    if (slurp("/proc/cpuinfo", 0) < 0)
        return "unreadable";
    if (has_flag("vmx"))
        return "vmx";
    if (has_flag("svm"))
        return "svm";
    return "-";
}

static void run_guest(void)
{
    long fd, pid, rc;
    int status = 0;

    if (!guest_argv[0])
        return;
    sys_mkdir("/dev", 0755);
    if (sys_mount("devtmpfs", "/dev", "devtmpfs") < 0)
        pr("%s dev=unmounted\n", NESTED);
    pr("%s cpuinfo=%s\n", NESTED, virt_flag());
    fd = sys_open("/dev/kvm", O_RDWR);
    if (fd < 0) {
        pr("%s kvm=absent errno=%d\n", NESTED, (int)-fd);
        return;
    }
    sys_close((int)fd);
    pr("%s kvm=open\n", NESTED);
    pr("%s %s\n", GUEST_BEGIN, guest_argv[0]);
    pid = sys_fork();
    if (pid == 0) {
        rc = sys_execve(guest_argv[0], guest_argv, guest_envp);
        pr("%s exec errno=%d\n", NESTED, (int)-rc);
        sys_exit(127);
    }
    if (pid < 0) {
        pr("%s fork errno=%d\n", NESTED, (int)-pid);
        return;
    }
    rc = sys_wait4(pid, &status);
    if (rc < 0)
        pr("%s wait errno=%d\n", NESTED, (int)-rc);
    else if (status & 0x7f)
        pr("%s signal=%d\n", GUEST_END, status & 0x7f);
    else
        pr("%s exit=%d\n", GUEST_END, (status >> 8) & 0xff);
}

void start_c(unsigned long *sp)
{
    static const struct timespec second = { 1, 0 };
    const unsigned long *p = sp + 1 + sp[0] + 1;
    unsigned i;
    int ok = 1;

    while (*p)
        p++;
    auxv = p + 1;

    sys_mkdir("/proc", 0755);
    sys_mkdir("/sys", 0755);
    if (sys_mount("proc", "/proc", "proc") < 0) {
        fail("/proc", "mount failed");
        ok = 0;
    }
    if (sys_mount("sysfs", "/sys", "sysfs") < 0) {
        fail("/sys", "mount failed");
        ok = 0;
    }

    for (i = 1; i <= 5; i++)
        pr("%s %u/5\n", BOOT_MARKER, i);

    if (ok)
        for (i = 0; i < sizeof PROBES / sizeof PROBES[0]; i++)
            ok &= check(&PROBES[i]);

    if (ok)
        ok &= check_vdso();

    if (ok)
        for (i = 1; i <= 5; i++)
            pr("%s %u/5\n", CHECK_MARKER, i);
    else
        pr("%s: one or more checks failed\n", CHECK_FAIL);

    load_modules();
    run_guest();

    sys_call6(0, 0, 0, 0, 0, 0, SYS_sync);
    sys_reboot(RB_AUTOBOOT);
    sys_reboot(RB_POWER_OFF);
    for (;;)
        sys_call6((long)&second, 0, 0, 0, 0, 0, SYS_nanosleep);
}

/* _start hands the initial stack pointer to start_c, which never returns.
   sys_call6 takes the six arguments in the C argument registers and the
   number seventh; on x86_64 the kernel's fourth argument register differs
   from the C ABI's. */
#if defined(__x86_64__)
__asm__(".text\n"
        ".globl _start\n"
        "_start:\n"
        "  xor %ebp, %ebp\n"
        "  mov %rsp, %rdi\n"
        "  and $-16, %rsp\n"
        "  call start_c\n"
        "  hlt\n"
        ".globl sys_call6\n"
        "sys_call6:\n"
        "  mov 8(%rsp), %rax\n"
        "  mov %rcx, %r10\n"
        "  syscall\n"
        "  ret\n");
#elif defined(__aarch64__)
__asm__(".text\n"
        ".globl _start\n"
        "_start:\n"
        "  mov x29, #0\n"
        "  mov x0, sp\n"
        "  bl start_c\n"
        "  brk #0\n"
        ".globl sys_call6\n"
        "sys_call6:\n"
        "  mov x8, x6\n"
        "  svc #0\n"
        "  ret\n");
#else
#error "no entry and system-call stub for this architecture"
#endif
"""


def c_string(s: str) -> str:
    """`s` as a C string literal."""
    return '"' + s.replace("\\", "\\\\").replace('"', '\\"') + '"'


def c_list(items) -> str:
    """`items` as the initializer of a null-terminated array of C strings."""
    return "".join(f"{c_string(s)}, " for s in items) + "0"


def init_source(modules: list[str], guest_argv=()) -> str:
    """The C source of /init, loading `modules` (paths inside the image)
    and running `guest_argv` after its checks when it is not empty."""
    src = INIT_C.replace("@MODULES@", c_list(modules))
    src = src.replace("@GUEST_ARGV@", c_list(guest_argv))
    for name, value in (("BOOT_MARKER", BOOT_MARKER), ("CHECK_MARKER", CHECK_MARKER),
                        ("CHECK_FAIL", CHECK_FAIL), ("CHECK_STEP", CHECK_STEP),
                        ("NESTED_MARKER", NESTED_MARKER), ("GUEST_BEGIN", GUEST_BEGIN),
                        ("GUEST_END", GUEST_END), ("GUEST_LIB", GUEST_LIB)):
        src = src.replace(f"@{name}@", value)
    return src


def cpio_newc(entries: list[tuple[str, int, bytes]]) -> bytes:
    """Serialize (name, mode, data) as a newc cpio archive."""
    buf = io.BytesIO()

    def put(name: str, mode: int, data: bytes, ino: int, nlink: int) -> None:
        raw = name.encode() + b"\0"
        fields = [ino, mode, 0, 0, nlink, 0, len(data), 0, 0, 0, 0, len(raw), 0]
        buf.write(b"070701" + b"".join(b"%08X" % f for f in fields))
        buf.write(raw)
        buf.write(b"\0" * (-(110 + len(raw)) % 4))
        buf.write(data)
        buf.write(b"\0" * (-len(data) % 4))

    for i, (name, mode, data) in enumerate(entries, start=1):
        put(name, mode, data, i, 1)
    put("TRAILER!!!", 0, b"", 0, 1)
    return buf.getvalue()


def cpio_entries(image: bytes) -> list[tuple[str, int, bytes]]:
    """The (name, mode, data) entries of a newc archive, trailer included."""
    out, at = [], 0
    while at < len(image):
        if image[at:at + 6] != b"070701":
            raise ValueError(f"no newc header at offset {at}")
        fields = [int(image[at + 6 + 8 * i:at + 14 + 8 * i], 16) for i in range(13)]
        mode, size, namesize = fields[1], fields[6], fields[11]
        name = image[at + 110:at + 110 + namesize - 1].decode()
        at += (110 + namesize + 3) & ~3
        out.append((name, mode, image[at:at + size]))
        at += (size + 3) & ~3
    return out


ELF_MAGIC = b"\x7fELF"
PT_INTERP = 3


class ElfIdent(NamedTuple):
    machine: int
    interp: str | None  # the PT_INTERP path when the image asks for a loader


def elf_ident(image: bytes) -> ElfIdent:
    """The machine of an ELF image and the loader it names, if any."""
    if image[:4] != ELF_MAGIC or len(image) < 52:
        raise ValueError("not an ELF image")
    cls, data = image[4], image[5]
    if cls not in (1, 2) or data not in (1, 2):
        raise ValueError(f"ELF class {cls}, data encoding {data}")
    order = "little" if data == 1 else "big"

    def field(off: int, size: int) -> int:
        return int.from_bytes(image[off:off + size], order)

    machine = field(18, 2)
    if cls == 2:
        phoff, phentsize, phnum = field(32, 8), field(54, 2), field(56, 2)
    else:
        phoff, phentsize, phnum = field(28, 4), field(42, 2), field(44, 2)
    interp = None
    for i in range(phnum):
        ph = phoff + i * phentsize
        if field(ph, 4) != PT_INTERP:
            continue
        if cls == 2:
            off, size = field(ph + 8, 8), field(ph + 32, 8)
        else:
            off, size = field(ph + 4, 4), field(ph + 16, 4)
        interp = image[off:off + size].split(b"\0", 1)[0].decode(errors="replace")
    return ElfIdent(machine, interp)


def machine_name(machine: int) -> str:
    return next((a for a, spec in ARCHES.items() if spec.machine == machine),
                f"e_machine {machine}")


def init_mismatch(image: bytes, arch: str) -> str:
    """Why `image` cannot serve as /init for an `arch` boot, or "" when it can."""
    try:
        ident = elf_ident(image)
    except ValueError as e:
        return f"/init is not an ELF executable ({e})"
    want = ARCHES[arch].machine
    if ident.machine != want:
        return (f"/init is built for {machine_name(ident.machine)} "
                f"(e_machine {ident.machine}), but the boot is {arch} "
                f"(e_machine {want}); the kernel would report no working init")
    if ident.interp is not None:
        return (f"/init asks for the loader {ident.interp} (PT_INTERP), which the "
                f"initramfs does not carry; it has to be linked statically")
    return ""


def build_init(src: Path, exe: Path, arch: str, cc: str | None,
               badc: Path) -> list[list[str]]:
    """Compile `src` into the static executable `exe`; returns the commands
    run. badc compiles for `arch` and links through its ld persona, which
    is what makes the image static (TODO: a one-step --freestanding link
    still writes a PIE naming ld-linux); a `--cc` toolchain is driven the
    way gcc and clang spell the same request and must target `arch`."""
    if cc:
        cmds = [[cc, "-static", "-nostdlib", "-ffreestanding",
                 "-fno-stack-protector", "-O2", "-o", str(exe), str(src)]]
    else:
        if not badc.is_file():
            sys.exit(f"linux initramfs: no badc at {badc}; build it "
                     f"(cargo build --release --features full) or pass "
                     f"--badc / --cc")
        obj = exe.with_suffix(".o")
        cmds = [[str(badc), "--gnu", "-q", "-c", f"--target={ARCHES[arch].target}",
                 "-O", "-o", str(obj), str(src)],
                [str(badc), "--ld", "-static", "-e", "_start", "-o", str(exe),
                 str(obj)]]
    for cmd in cmds:
        r = subprocess.run(cmd, capture_output=True, text=True)
        if r.returncode != 0:
            sys.exit(f"linux initramfs: {' '.join(cmd)} failed:\n{r.stderr.strip()}")
    return cmds


class Guest(NamedTuple):
    """A program /init runs after its checks: the emulator, the files it
    takes, carried under GUEST_DIR by name, and its argument list, whose
    first element is the emulator's path in the image."""
    emulator: Path
    files: dict[str, Path]
    argv: list[str]


def guest_path(name: str) -> str:
    return f"{GUEST_DIR}/{name}"


def shared_libraries(listing: str) -> tuple[list[str], list[str]]:
    """The paths an `ldd` listing resolves, the loader's among them, and
    the names it could not resolve. The vDSO line names no file."""
    found, missing = [], []
    for line in listing.splitlines():
        name, arrow, rest = line.strip().partition(" => ")
        if arrow and rest.startswith("not found"):
            missing.append(name)
        elif arrow or name.startswith("/"):
            found.append((rest if arrow else name).split(" (", 1)[0])
    return found, missing


def resolve_libraries(emulator: Path) -> list[Path]:
    """What `ldd` says `emulator` loads. A library not found here would
    not be found in the image either."""
    r = subprocess.run(["ldd", str(emulator)], capture_output=True, text=True)
    found, missing = shared_libraries(r.stdout)
    if r.returncode != 0 or missing:
        sys.exit(f"linux initramfs: ldd {emulator}: "
                 f"{', '.join(missing) or r.stderr.strip() or 'failed'}")
    return [Path(p) for p in found]


def guest_entries(guest: Guest, arch: str,
                  libraries: list[Path]) -> list[tuple[str, int, bytes]]:
    """The archive entries carrying the guest: the emulator and its
    libraries under GUEST_DIR, its loader at the path its PT_INTERP names,
    and the files. The kernel's unpacker creates no directory it is not
    given, so each one precedes what it holds."""
    image = guest.emulator.read_bytes()
    try:
        ident = elf_ident(image)
    except ValueError as e:
        sys.exit(f"linux initramfs: {guest.emulator} is not an ELF "
                 f"executable ({e})")
    if ident.machine != ARCHES[arch].machine:
        sys.exit(f"linux initramfs: {guest.emulator} is built for "
                 f"{machine_name(ident.machine)}, but the boot is {arch}")
    entries = [("dev", 0o040755, b""), (GUEST_DIR[1:], 0o040755, b""),
               (GUEST_LIB[1:], 0o040755, b""),
               (guest_path(guest.emulator.name)[1:], 0o100755, image)]
    loader = Path(ident.interp) if ident.interp else None
    if loader:
        parts = loader.parts[1:]
        entries += [("/".join(parts[:i]), 0o040755, b"")
                    for i in range(1, len(parts))]
        entries.append(("/".join(parts), 0o100755, loader.read_bytes()))
    for lib in libraries:
        if loader and lib.name == loader.name:
            continue
        entries.append((f"{GUEST_LIB[1:]}/{lib.name}", 0o100755,
                        lib.read_bytes()))
    for name, src in sorted(guest.files.items()):
        entries.append((guest_path(name)[1:], 0o100644, src.read_bytes()))
    return entries


def build_image(out: Path, arch: str, badc: Path, cc: str | None,
                modules: list[Path], guest: Guest | None) -> int:
    """Write the image: /init built for `arch`, the modules it loads and
    the guest it runs. Returns the size written."""
    names = [m.name for m in modules]
    with tempfile.TemporaryDirectory() as td:
        src = Path(td) / "init.c"
        exe = Path(td) / "init"
        src.write_text(init_source([f"/{n}" for n in names],
                                   guest.argv if guest else ()))
        cmds = build_init(src, exe, arch, cc, badc)
        image = exe.read_bytes()
    why = init_mismatch(image, arch)
    if why:
        sys.exit(f"linux initramfs: {why}\n  built by: {' '.join(cmds[-1])}")
    entries = [("proc", 0o040755, b""), ("sys", 0o040755, b""),
               ("init", 0o100755, image)]
    entries += [(n, 0o100644, m.read_bytes()) for n, m in zip(names, modules)]
    if guest:
        entries += guest_entries(guest, arch, resolve_libraries(guest.emulator))
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_bytes(gzip.compress(cpio_newc(entries), 9))
    return out.stat().st_size


def self_test() -> int:
    def elf64(machine: int, phdrs: bytes = b"") -> bytes:
        """An ELF64 header with `phdrs` (56 bytes each) right after it."""
        phnum = len(phdrs) // 56
        return struct.pack("<4sBBBBB7xHHIQQQIHHHHHH", ELF_MAGIC, 2, 1, 1, 0, 0,
                           2, machine, 1, 0x400000, 64 if phnum else 0, 0, 0,
                           64, 56, phnum, 64, 0, 0) + phdrs

    x64, a64 = elf64(62), elf64(183)
    assert elf_ident(x64) == (62, None) and elf_ident(a64) == (183, None)
    assert init_mismatch(x64, "x86_64") == "" and init_mismatch(a64, "aarch64") == ""
    m = init_mismatch(x64, "aarch64")
    assert "built for x86_64" in m and "boot is aarch64" in m, m
    m = init_mismatch(a64, "x86_64")
    assert "built for aarch64" in m and "boot is x86_64" in m, m
    assert "e_machine 3" in init_mismatch(elf64(3), "x86_64")

    # A PT_INTERP names a loader the initramfs does not carry.
    loader = b"/lib64/ld-linux-x86-64.so.2\0"
    ph = struct.pack("<IIQQQQQQ", PT_INTERP, 4, 64 + 56, 0, 0, len(loader),
                     len(loader), 1)
    dyn = elf64(62, ph) + loader
    assert elf_ident(dyn) == (62, "/lib64/ld-linux-x86-64.so.2"), elf_ident(dyn)
    m = init_mismatch(dyn, "x86_64")
    assert "PT_INTERP" in m and "ld-linux-x86-64.so.2" in m, m
    for junk in (b"", b"#!/bin/sh\n", b"MZ" + bytes(62), b"\xcf\xfa\xed\xfe" + bytes(60)):
        assert "not an ELF" in init_mismatch(junk, "x86_64")

    # The archive round-trips, the trailer last.
    entries = [("proc", 0o040755, b""), ("sys", 0o040755, b""),
               ("init", 0o100755, x64), ("a.ko", 0o100644, b"\x7fELF1234567")]
    assert cpio_entries(cpio_newc(entries)) == entries + [("TRAILER!!!", 0, b"")]
    assert '{ 0 }' in init_source([]) and '"/a.ko", "/b.ko", 0' in init_source(["/a.ko", "/b.ko"])
    assert not re.search(r"@[A-Z_]+@", init_source([])), "a placeholder was left in the source"

    # The guest's arguments reach the source as C strings; without a guest
    # the list is empty and the stage does nothing.
    src = init_source([], ["/guest/q", "-append", 'a "b" c\\d'])
    assert '{ "/guest/q", "-append", "a \\"b\\" c\\\\d", 0 }' in src, src
    assert "guest_argv[] = { 0 }" in init_source([])
    assert not re.search(r"@[A-Z_]+@", src)

    # An ldd listing: the vDSO names no file, the loader has no arrow, and
    # a library not found is reported by name.
    listing = ("\tlinux-vdso.so.1 (0x00007fff)\n"
               "\tlibglib-2.0.so.0 => /lib64/libglib-2.0.so.0 (0x00007f00)\n"
               "\t/lib64/ld-linux-x86-64.so.2 (0x00007f01)\n"
               "\tlibgone.so.9 => not found\n")
    assert shared_libraries(listing) == (
        ["/lib64/libglib-2.0.so.0", "/lib64/ld-linux-x86-64.so.2"],
        ["libgone.so.9"]), shared_libraries(listing)

    # The guest's archive layout: every directory ahead of what it holds,
    # the loader at its PT_INTERP path and once only, the libraries under
    # /guest/lib, and the files by name.
    with tempfile.TemporaryDirectory() as d:
        root = Path(d).resolve()
        (root / "lib64").mkdir()
        loader = root / "lib64" / "ld-fake.so"
        loader.write_bytes(b"LD")
        interp = str(loader).encode() + b"\0"
        ph = struct.pack("<IIQQQQQQ", PT_INTERP, 4, 64 + 56, 0, 0, len(interp),
                         len(interp), 1)
        emu = root / "qemu-system-x86_64"
        emu.write_bytes(elf64(62, ph) + interp)
        lib = root / "libz.so.1"
        lib.write_bytes(b"ZL")
        kernel = root / "bzImage"
        kernel.write_bytes(b"KI")
        g = Guest(emu, {"kernel": kernel},
                  [guest_path(emu.name), "-kernel", guest_path("kernel")])
        entries = guest_entries(g, "x86_64", [lib, loader])
        names = [e[0] for e in entries]
        above = ["/".join(loader.parts[1:i]) for i in range(2, len(loader.parts))]
        assert names == ["dev", "guest", "guest/lib", "guest/qemu-system-x86_64",
                         *above, str(loader)[1:], "guest/lib/libz.so.1",
                         "guest/kernel"], names
        for name in names:
            parent = name.rpartition("/")[0]
            assert not parent or names.index(parent) < names.index(name), name
        data = {e[0]: e[2] for e in entries}
        assert data[str(loader)[1:]] == b"LD" and data["guest/kernel"] == b"KI"
        assert data["guest/qemu-system-x86_64"] == emu.read_bytes()
        assert cpio_entries(cpio_newc(entries))[:-1] == entries
        # An emulator for another machine is refused with both sides named.
        other = root / "qemu-system-aarch64"
        other.write_bytes(elf64(183))
        try:
            guest_entries(Guest(other, {}, [guest_path(other.name)]), "x86_64", [])
        except SystemExit as e:
            assert "built for aarch64, but the boot is x86_64" in str(e), e
        else:
            raise AssertionError("an aarch64 emulator was accepted for x86_64")
    print("linux initramfs: self-test ok", flush=True)
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("-o", "--output", type=Path)
    ap.add_argument("--arch", choices=sorted(ARCHES), default=karch.host_arch(),
                    help="architecture of the boot (default: the host's)")
    ap.add_argument("--badc", type=Path,
                    default=os.environ.get("BADC", REPO_ROOT / "target/release/badc"),
                    help="badc building /init (default: $BADC or target/release/badc)")
    ap.add_argument("--cc", help="build /init with this C compiler instead of "
                                 "badc; it must produce --arch code itself")
    ap.add_argument("--module", type=Path, action="append", default=[],
                    help="module to carry and load with finit_module(2); "
                         "repeatable. Each load prints BADC-MODULE <name> "
                         "loaded or errno=<n>.")
    ap.add_argument("--guest-emulator", type=Path,
                    help="emulator to carry, with the shared libraries ldd "
                         "lists and its loader; /init runs it after the checks")
    ap.add_argument("--guest-file", action="append", default=[],
                    metavar="NAME=PATH",
                    help=f"file carried as {GUEST_DIR}/NAME beside the "
                         f"emulator; repeatable")
    ap.add_argument("--guest-args", default="",
                    help="the emulator's arguments, shell-quoted")
    ap.add_argument("--self-test", action="store_true")
    args = ap.parse_args()
    if args.self_test:
        return self_test()
    if not args.output:
        ap.error("-o is required")

    guest = None
    if args.guest_emulator:
        files = {}
        for spec in args.guest_file:
            name, sep, path = spec.partition("=")
            if not sep or not name or "/" in name:
                ap.error(f"--guest-file takes NAME=PATH, got {spec!r}")
            files[name] = Path(path)
        guest = Guest(args.guest_emulator, files,
                      [guest_path(args.guest_emulator.name),
                       *shlex.split(args.guest_args)])
    elif args.guest_file or args.guest_args:
        ap.error("--guest-file and --guest-args need --guest-emulator")
    size = build_image(args.output, args.arch, args.badc, args.cc, args.module,
                       guest)
    print(f"linux initramfs: wrote {args.output} ({size} bytes); /init for "
          f"{args.arch} by {args.cc or args.badc}"
          + (f"; guest {guest.emulator}" if guest else ""), flush=True)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
