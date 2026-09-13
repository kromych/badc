//! Record layouts of the bundled Linux headers against the kernel uapi
//! declarations of the release `demos/linux/setup.py` pins. Each check is a
//! `_Static_assert` compiled for its target, so a clean compile is the pass.

use crate::{CompileOptions, Compiler, Target};

struct Layout {
    target: Target,
    headers: &'static [&'static str],
    ty: &'static str,
    size: usize,
    align: usize,
    members: &'static [(&'static str, usize)],
}

fn compile(src: &str, target: Target) -> Result<(), String> {
    let opts = CompileOptions::default().with_no_entry_point(true);
    Compiler::with_options(src.to_string(), target, opts)
        .compile()
        .map(|_| ())
        .map_err(|e| e.to_string())
}

/// Size, alignment and member offsets of the record, and of the second
/// element of an array of it placed after a byte.
fn source(l: &Layout) -> String {
    let (ty, size, align) = (l.ty, l.size, l.align);
    let mut s = String::from("#include <stddef.h>\n");
    for h in l.headers {
        s += &format!("#include <{h}>\n");
    }
    s += &format!("struct probe {{ char c; {ty} a[2]; }};\n");
    s += &format!("_Static_assert(sizeof({ty}) == {size}, \"size\");\n");
    s += &format!("_Static_assert(_Alignof({ty}) == {align}, \"align\");\n");
    s += &format!("_Static_assert(offsetof(struct probe, a) == {align}, \"array\");\n");
    for (m, off) in l.members {
        s += &format!("_Static_assert(offsetof({ty}, {m}) == {off}, \"{m}\");\n");
        let second = align + size + off;
        s += &format!(
            "_Static_assert(offsetof(struct probe, a[1].{m}) == {second}, \"a[1].{m}\");\n"
        );
    }
    s
}

fn check(layouts: &[Layout]) {
    for l in layouts {
        if let Err(e) = compile(&source(l), l.target) {
            panic!("{} on {}: {e}", l.ty, l.target.id_str());
        }
    }
}

/// Member widths that the offsets leave open: a member followed by padding
/// or a last member.
fn check_widths(target: Target, headers: &[&str], ty: &str, widths: &[(&str, usize)]) {
    let mut s = String::new();
    for h in headers {
        s += &format!("#include <{h}>\n");
    }
    for (m, w) in widths {
        s += &format!("_Static_assert(sizeof((({ty} *)0)->{m}) == {w}, \"{m}\");\n");
    }
    if let Err(e) = compile(&s, target) {
        panic!("{ty} on {}: {e}", target.id_str());
    }
}

#[test]
fn epoll_event_is_packed_on_linux_x86_64() {
    const H: &[&str] = &["sys/epoll.h"];
    const T: &str = "struct epoll_event";
    check(&[
        Layout {
            target: Target::LinuxX64,
            headers: H,
            ty: T,
            size: 12,
            align: 1,
            members: &[("events", 0), ("data", 4), ("data.u64", 4)],
        },
        Layout {
            target: Target::LinuxAarch64,
            headers: H,
            ty: T,
            size: 16,
            align: 8,
            members: &[("events", 0), ("data", 8), ("data.u64", 8)],
        },
        Layout {
            target: Target::WindowsX64,
            headers: H,
            ty: T,
            size: 16,
            align: 8,
            members: &[("events", 0), ("data", 8)],
        },
    ]);
}

/// <linux/resource.h> declares every counter `__kernel_long_t`; the macOS
/// SDK's <sys/resource.h> gives the same layout.
#[test]
fn rusage_counters_are_long() {
    const M: &[(&str, usize)] = &[
        ("ru_utime", 0),
        ("ru_stime", 16),
        ("ru_maxrss", 32),
        ("ru_ixrss", 40),
        ("ru_idrss", 48),
        ("ru_isrss", 56),
        ("ru_minflt", 64),
        ("ru_majflt", 72),
        ("ru_nswap", 80),
        ("ru_inblock", 88),
        ("ru_oublock", 96),
        ("ru_msgsnd", 104),
        ("ru_msgrcv", 112),
        ("ru_nsignals", 120),
        ("ru_nvcsw", 128),
        ("ru_nivcsw", 136),
    ];
    let targets = [Target::LinuxX64, Target::LinuxAarch64, Target::MacOSAarch64];
    check(&targets.map(|target| Layout {
        target,
        headers: &["sys/time.h", "unistd.h"],
        ty: "struct rusage",
        size: 144,
        align: 8,
        members: M,
    }));
}

/// <linux/posix_types.h> `__kernel_fd_set`: 1024 bits in `unsigned long` words.
#[test]
fn fd_set_is_unsigned_long_words_on_linux() {
    let targets = [Target::LinuxX64, Target::LinuxAarch64];
    check(&targets.map(|target| Layout {
        target,
        headers: &["sys/select.h"],
        ty: "fd_set",
        size: 128,
        align: 8,
        members: &[("fds_bits", 0), ("fds_bits[1]", 8)],
    }));
}

/// <asm-generic/ipcbuf.h> `ipc64_perm` and <asm-generic/shmbuf.h> `shmid64_ds`.
#[test]
fn shm_records_are_the_kernel_ipc64_layout_on_linux() {
    const H: &[&str] = &["sys/shm.h"];
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        check(&[
            Layout {
                target,
                headers: H,
                ty: "struct ipc_perm",
                size: 48,
                align: 8,
                members: &[
                    ("__key", 0),
                    ("uid", 4),
                    ("gid", 8),
                    ("cuid", 12),
                    ("cgid", 16),
                    ("mode", 20),
                    ("__seq", 24),
                ],
            },
            Layout {
                target,
                headers: H,
                ty: "struct shmid_ds",
                size: 112,
                align: 8,
                members: &[
                    ("shm_perm", 0),
                    ("shm_segsz", 48),
                    ("shm_atime", 56),
                    ("shm_dtime", 64),
                    ("shm_ctime", 72),
                    ("shm_cpid", 80),
                    ("shm_lpid", 84),
                    ("shm_nattch", 88),
                ],
            },
        ]);
        check_widths(target, H, "struct ipc_perm", &[("mode", 4), ("__seq", 2)]);
        check_widths(target, H, "struct shmid_ds", &[("shm_nattch", 8)]);
    }
}

#[test]
fn a_mismatched_layout_is_rejected() {
    let l = Layout {
        target: Target::LinuxX64,
        headers: &["sys/epoll.h"],
        ty: "struct epoll_event",
        size: 16,
        align: 8,
        members: &[("data", 8)],
    };
    assert!(compile(&source(&l), l.target).is_err());
}
