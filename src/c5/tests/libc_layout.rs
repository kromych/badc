//! Record layouts of the bundled headers against the declarations each target
//! uses: the kernel uapi of the release `demos/linux/setup.py` pins, glibc on
//! Linux and the SDK on macOS. Each check is a `_Static_assert` compiled for
//! its target, so a clean compile is the pass.

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

/// The includes of a check. An entry starting with `#` is a directive placed
/// as written, ahead of the entries after it.
fn prelude(headers: &[&str]) -> String {
    let mut s = String::new();
    for h in headers {
        if h.starts_with('#') {
            s += &format!("{h}\n");
        } else {
            s += &format!("#include <{h}>\n");
        }
    }
    s + "#include <stddef.h>\n"
}

/// Size, alignment and member offsets of the record, and of the second
/// element of an array of it placed after a byte.
fn source(l: &Layout) -> String {
    let (ty, size, align) = (l.ty, l.size, l.align);
    let mut s = prelude(l.headers);
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

/// Constant expressions the layouts leave open, each against its value.
fn check_values<E: AsRef<str>>(target: Target, headers: &[&str], values: &[(E, usize)]) {
    let mut s = prelude(headers);
    for (e, v) in values {
        let e = e.as_ref();
        s += &format!("_Static_assert(({e}) == {v}, \"{e}\");\n");
    }
    if let Err(err) = compile(&s, target) {
        panic!("{} on {}: {err}", headers.join(", "), target.id_str());
    }
}

/// Member widths that the offsets leave open: a member followed by padding
/// or a last member.
fn check_widths(target: Target, headers: &[&str], ty: &str, widths: &[(&str, usize)]) {
    let values: Vec<(String, usize)> = widths
        .iter()
        .map(|(m, w)| (format!("sizeof((({ty} *)0)->{m})"), *w))
        .collect();
    check_values(target, headers, &values);
}

/// glibc's `struct sigaction` ends in `sa_restorer`, 152 bytes; the macOS
/// SDK's is 16 bytes over a 4-byte `sigset_t`. Both hold the two handler
/// forms in one union at offset 0.
#[test]
fn sigaction_holds_both_handlers_in_one_union() {
    const H: &[&str] = &["signal.h"];
    const T: &str = "struct sigaction";
    const GLIBC: &[(&str, usize)] = &[
        ("sa_handler", 0),
        ("sa_sigaction", 0),
        ("sa_mask", 8),
        ("sa_flags", 136),
        ("sa_restorer", 144),
    ];
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        check(&[Layout {
            target,
            headers: H,
            ty: T,
            size: 152,
            align: 8,
            members: GLIBC,
        }]);
        check_values(target, H, &[("sizeof(sigset_t)", 128)]);
    }
    check(&[Layout {
        target: Target::MacOSAarch64,
        headers: H,
        ty: T,
        size: 16,
        align: 8,
        members: &[
            ("sa_handler", 0),
            ("sa_sigaction", 0),
            ("sa_mask", 8),
            ("sa_flags", 12),
        ],
    }]);
    check_values(
        Target::MacOSAarch64,
        H,
        &[("sizeof(sigset_t)", 4), ("_Alignof(sigset_t)", 4)],
    );
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

/// <linux/socket.h> `__kernel_sockaddr_storage`: 128 bytes aligned to a pointer.
#[test]
fn sockaddr_storage_is_pointer_aligned_on_linux() {
    let targets = [Target::LinuxX64, Target::LinuxAarch64];
    check(&targets.map(|target| Layout {
        target,
        headers: &["sys/socket.h"],
        ty: "struct sockaddr_storage",
        size: 128,
        align: 8,
        members: &[("ss_family", 0), ("ss_pad", 2)],
    }));
}

/// <linux/in6.h> `in6_addr` unions the address bytes with 16- and 32-bit words.
#[test]
fn in6_addr_is_int_aligned_on_linux() {
    const H: &[&str] = &["netinet/in.h"];
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        check(&[
            Layout {
                target,
                headers: H,
                ty: "struct in6_addr",
                size: 16,
                align: 4,
                members: &[("s6_addr", 0), ("s6_addr[15]", 15)],
            },
            Layout {
                target,
                headers: H,
                ty: "struct sockaddr_in6",
                size: 28,
                align: 4,
                members: &[
                    ("sin6_family", 0),
                    ("sin6_port", 2),
                    ("sin6_flowinfo", 4),
                    ("sin6_addr", 8),
                    ("sin6_scope_id", 24),
                ],
            },
        ]);
    }
}

/// <linux/if_ether.h> packs `struct ethhdr`, the same 14-byte header.
#[test]
fn ether_header_is_packed_on_linux() {
    let targets = [Target::LinuxX64, Target::LinuxAarch64];
    check(&targets.map(|target| Layout {
        target,
        headers: &["net/ethernet.h"],
        ty: "struct ether_header",
        size: 14,
        align: 1,
        members: &[("ether_dhost", 0), ("ether_shost", 6), ("ether_type", 12)],
    }));
}

/// <asm-generic/fcntl.h> `struct flock`, which neither architecture extends.
#[test]
fn flock_ends_after_l_pid_on_linux() {
    let targets = [Target::LinuxX64, Target::LinuxAarch64];
    check(&targets.map(|target| Layout {
        target,
        headers: &["fcntl.h"],
        ty: "struct flock",
        size: 32,
        align: 8,
        members: &[
            ("l_type", 0),
            ("l_whence", 2),
            ("l_start", 8),
            ("l_len", 16),
            ("l_pid", 24),
        ],
    }));
}

/// glibc's x86-64 context: 23 general registers in the order of the kernel's
/// sigcontext_64, then the FXSAVE area of its _fpstate_64. aarch64 keeps the
/// layout of the kernel's sigcontext.
#[test]
fn ucontext_follows_glibc_on_linux() {
    const H: &[&str] = &["ucontext.h"];
    check(&[
        Layout {
            target: Target::LinuxX64,
            headers: H,
            ty: "ucontext_t",
            size: 968,
            align: 8,
            members: &[
                ("uc_flags", 0),
                ("uc_link", 8),
                ("uc_stack", 16),
                ("uc_mcontext", 40),
                ("uc_sigmask", 296),
                ("__fpregs_mem", 424),
                ("__ssp", 936),
            ],
        },
        Layout {
            target: Target::LinuxX64,
            headers: H,
            ty: "mcontext_t",
            size: 256,
            align: 8,
            members: &[("gregs", 0), ("fpregs", 184), ("__reserved1", 192)],
        },
        Layout {
            target: Target::LinuxX64,
            headers: H,
            ty: "struct _libc_fpstate",
            size: 512,
            align: 8,
            members: &[
                ("cwd", 0),
                ("swd", 2),
                ("ftw", 4),
                ("fop", 6),
                ("rip", 8),
                ("rdp", 16),
                ("mxcsr", 24),
                ("mxcr_mask", 28),
                ("_st", 32),
                ("_xmm", 160),
                ("__glibc_reserved1", 416),
            ],
        },
        Layout {
            target: Target::LinuxX64,
            headers: H,
            ty: "struct _libc_fpxreg",
            size: 16,
            align: 2,
            members: &[("significand", 0), ("exponent", 8)],
        },
        Layout {
            target: Target::LinuxX64,
            headers: H,
            ty: "struct _libc_xmmreg",
            size: 16,
            align: 4,
            members: &[("element", 0)],
        },
        Layout {
            target: Target::LinuxAarch64,
            headers: H,
            ty: "ucontext_t",
            size: 4560,
            align: 16,
            members: &[
                ("uc_flags", 0),
                ("uc_link", 8),
                ("uc_stack", 16),
                ("uc_sigmask", 40),
                ("uc_mcontext", 176),
            ],
        },
        Layout {
            target: Target::LinuxAarch64,
            headers: H,
            ty: "mcontext_t",
            size: 4384,
            align: 16,
            members: &[
                ("fault_address", 0),
                ("regs", 8),
                ("sp", 256),
                ("pc", 264),
                ("pstate", 272),
                ("__reserved", 288),
            ],
        },
    ]);
}

/// glibc's x86-64 register indices follow the kernel's sigcontext_64, so
/// `REG_RIP` indexes `gregs` at the saved instruction pointer.
#[test]
fn reg_rip_indexes_gregs_at_the_glibc_offset() {
    const REGS: [&str; 23] = [
        "R8", "R9", "R10", "R11", "R12", "R13", "R14", "R15", "RDI", "RSI", "RBP", "RBX", "RDX",
        "RAX", "RCX", "RSP", "RIP", "EFL", "CSGSFS", "ERR", "TRAPNO", "OLDMASK", "CR2",
    ];
    let mut values: Vec<(String, usize)> = REGS
        .iter()
        .enumerate()
        .map(|(i, r)| (format!("REG_{r}"), i))
        .collect();
    values.push(("NGREG".into(), 23));
    values.push(("sizeof(greg_t)".into(), 8));
    values.push((
        "offsetof(ucontext_t, uc_mcontext.gregs[REG_RIP])".into(),
        168,
    ));
    check_values(
        Target::LinuxX64,
        &["#define _GNU_SOURCE", "ucontext.h"],
        &values,
    );
}

/// glibc declares `sched_priority` alone; the macOS SDK follows it with 4
/// opaque bytes.
#[test]
fn sched_param_is_one_int_on_linux() {
    const H: &[&str] = &["sched.h"];
    const T: &str = "struct sched_param";
    const M: &[(&str, usize)] = &[("sched_priority", 0)];
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        check(&[Layout {
            target,
            headers: H,
            ty: T,
            size: 4,
            align: 4,
            members: M,
        }]);
    }
    check(&[Layout {
        target: Target::MacOSAarch64,
        headers: H,
        ty: T,
        size: 8,
        align: 4,
        members: M,
    }]);
}

/// The macOS SDK's `struct flock` ends after l_whence, 24 bytes.
#[test]
fn flock_ends_after_l_whence_on_macos() {
    check(&[Layout {
        target: Target::MacOSAarch64,
        headers: &["fcntl.h"],
        ty: "struct flock",
        size: 24,
        align: 8,
        members: &[
            ("l_start", 0),
            ("l_len", 8),
            ("l_pid", 16),
            ("l_type", 20),
            ("l_whence", 22),
        ],
    }]);
}

/// The macOS SDK's `sockaddr_storage` takes its alignment from a 64-bit
/// member at offset 8.
#[test]
fn sockaddr_storage_is_8_aligned_on_macos() {
    check(&[Layout {
        target: Target::MacOSAarch64,
        headers: &["sys/socket.h"],
        ty: "struct sockaddr_storage",
        size: 128,
        align: 8,
        members: &[
            ("ss_len", 0),
            ("ss_family", 1),
            ("__ss_pad1", 2),
            ("__ss_align", 8),
            ("__ss_pad2", 16),
        ],
    }]);
}

/// The macOS SDK's `in6_addr` unions the address bytes with 16- and 32-bit
/// words, as Linux does.
#[test]
fn in6_addr_is_int_aligned_on_macos() {
    check(&[Layout {
        target: Target::MacOSAarch64,
        headers: &["netinet/in.h"],
        ty: "struct in6_addr",
        size: 16,
        align: 4,
        members: &[("s6_addr", 0), ("s6_addr[15]", 15)],
    }]);
}

/// The macOS SDK's `fd_set` is 1024 bits in 32-bit words.
#[test]
fn fd_set_is_int_words_on_macos() {
    check(&[Layout {
        target: Target::MacOSAarch64,
        headers: &["sys/select.h"],
        ty: "fd_set",
        size: 128,
        align: 4,
        members: &[("fds_bits", 0), ("fds_bits[1]", 4)],
    }]);
}

/// glibc's `sigset_t` is 1024 bits in `unsigned long` words.
#[test]
fn sigset_t_is_unsigned_long_words_on_linux() {
    let targets = [Target::LinuxX64, Target::LinuxAarch64];
    check(&targets.map(|target| Layout {
        target,
        headers: &["signal.h"],
        ty: "sigset_t",
        size: 128,
        align: 8,
        members: &[("__val", 0), ("__val[1]", 8)],
    }));
}

/// <sys/ucontext.h> declares the context types without <ucontext.h>, as
/// glibc's does, and both parse on every target.
#[test]
fn sys_ucontext_declares_the_machine_context() {
    check_values(
        Target::LinuxX64,
        &["#define _GNU_SOURCE", "sys/ucontext.h"],
        &[
            ("REG_RIP", 16),
            ("offsetof(ucontext_t, uc_mcontext.gregs[REG_RIP])", 168),
            ("sizeof(gregset_t)", 184),
            ("sizeof(mcontext_t)", 256),
        ],
    );
    check_values(
        Target::LinuxAarch64,
        &["sys/ucontext.h"],
        &[
            ("sizeof(greg_t)", 8),
            ("sizeof(gregset_t)", 272),
            ("sizeof(ucontext_t)", 4560),
        ],
    );
    for target in [
        Target::LinuxX64,
        Target::LinuxAarch64,
        Target::MacOSAarch64,
        Target::WindowsX64,
    ] {
        check_values(
            target,
            &["signal.h", "ucontext.h", "sys/ucontext.h"],
            &[("sizeof(int)", 4)],
        );
    }
}

/// The macOS SDK's arm64 context: a 56-byte ucontext_t pointing at the
/// exception, thread and NEON state, with the state embedded only under
/// _XOPEN_SOURCE.
#[test]
fn ucontext_follows_the_sdk_on_macos() {
    const H: &[&str] = &["sys/ucontext.h"];
    const T: Target = Target::MacOSAarch64;
    const UC: &[(&str, usize)] = &[
        ("uc_onstack", 0),
        ("uc_sigmask", 4),
        ("uc_stack", 8),
        ("uc_link", 32),
        ("uc_mcsize", 40),
        ("uc_mcontext", 48),
    ];
    check(&[
        Layout {
            target: T,
            headers: H,
            ty: "ucontext_t",
            size: 56,
            align: 8,
            members: UC,
        },
        Layout {
            target: T,
            headers: &["#define _XOPEN_SOURCE 700", "sys/ucontext.h"],
            ty: "ucontext_t",
            size: 880,
            align: 16,
            members: &[("uc_mcontext", 48), ("__mcontext_data", 64)],
        },
        Layout {
            target: T,
            headers: H,
            ty: "struct __darwin_mcontext64",
            size: 816,
            align: 16,
            members: &[("__es", 0), ("__ss", 16), ("__ns", 288)],
        },
        Layout {
            target: T,
            headers: H,
            ty: "struct __darwin_arm_exception_state64",
            size: 16,
            align: 8,
            members: &[("__far", 0), ("__esr", 8), ("__exception", 12)],
        },
        Layout {
            target: T,
            headers: H,
            ty: "struct __darwin_arm_thread_state64",
            size: 272,
            align: 8,
            members: &[
                ("__x", 0),
                ("__fp", 232),
                ("__lr", 240),
                ("__sp", 248),
                ("__pc", 256),
                ("__cpsr", 264),
                ("__pad", 268),
            ],
        },
        Layout {
            target: T,
            headers: H,
            ty: "struct __darwin_arm_neon_state64",
            size: 528,
            align: 16,
            members: &[("__v", 0), ("__fpsr", 512), ("__fpcr", 516)],
        },
    ]);
    check_values(
        T,
        H,
        &[
            ("sizeof(mcontext_t)", 8),
            ("offsetof(struct __darwin_mcontext64, __ss.__pc)", 272),
        ],
    );
}

/// si_code values: glibc's are the codes of the kernel's
/// <asm-generic/siginfo.h>, the macOS SDK numbers its own, and Windows
/// declares none.
#[test]
fn si_code_values_follow_the_c_library() {
    const LINUX: &[(&str, usize)] = &[
        ("-(SI_ASYNCNL)", 60),
        ("-(SI_DETHREAD)", 7),
        ("-(SI_TKILL)", 6),
        ("-(SI_SIGIO)", 5),
        ("-(SI_ASYNCIO)", 4),
        ("-(SI_MESGQ)", 3),
        ("-(SI_TIMER)", 2),
        ("-(SI_QUEUE)", 1),
        ("SI_USER", 0),
        ("SI_KERNEL", 0x80),
        ("ILL_ILLOPC", 1),
        ("ILL_ILLOPN", 2),
        ("ILL_ILLADR", 3),
        ("ILL_ILLTRP", 4),
        ("ILL_PRVOPC", 5),
        ("ILL_PRVREG", 6),
        ("ILL_COPROC", 7),
        ("ILL_BADSTK", 8),
        ("ILL_BADIADDR", 9),
        ("FPE_INTDIV", 1),
        ("FPE_INTOVF", 2),
        ("FPE_FLTDIV", 3),
        ("FPE_FLTOVF", 4),
        ("FPE_FLTUND", 5),
        ("FPE_FLTRES", 6),
        ("FPE_FLTINV", 7),
        ("FPE_FLTSUB", 8),
        ("FPE_FLTUNK", 14),
        ("FPE_CONDTRAP", 15),
        ("SEGV_MAPERR", 1),
        ("SEGV_ACCERR", 2),
        ("SEGV_BNDERR", 3),
        ("SEGV_PKUERR", 4),
        ("SEGV_ACCADI", 5),
        ("SEGV_ADIDERR", 6),
        ("SEGV_ADIPERR", 7),
        ("SEGV_MTEAERR", 8),
        ("SEGV_MTESERR", 9),
        ("SEGV_CPERR", 10),
        ("BUS_ADRALN", 1),
        ("BUS_ADRERR", 2),
        ("BUS_OBJERR", 3),
        ("BUS_MCEERR_AR", 4),
        ("BUS_MCEERR_AO", 5),
        ("TRAP_BRKPT", 1),
        ("TRAP_TRACE", 2),
        ("TRAP_BRANCH", 3),
        ("TRAP_HWBKPT", 4),
        ("TRAP_UNK", 5),
        ("TRAP_PERF", 6),
        ("CLD_EXITED", 1),
        ("CLD_KILLED", 2),
        ("CLD_DUMPED", 3),
        ("CLD_TRAPPED", 4),
        ("CLD_STOPPED", 5),
        ("CLD_CONTINUED", 6),
        ("POLL_IN", 1),
        ("POLL_OUT", 2),
        ("POLL_MSG", 3),
        ("POLL_ERR", 4),
        ("POLL_PRI", 5),
        ("POLL_HUP", 6),
        ("SYS_SECCOMP", 1),
        ("SYS_USER_DISPATCH", 2),
    ];
    const MACOS: &[(&str, usize)] = &[
        ("ILL_NOOP", 0),
        ("ILL_ILLOPC", 1),
        ("ILL_ILLTRP", 2),
        ("ILL_PRVOPC", 3),
        ("ILL_ILLOPN", 4),
        ("ILL_ILLADR", 5),
        ("ILL_PRVREG", 6),
        ("ILL_COPROC", 7),
        ("ILL_BADSTK", 8),
        ("FPE_NOOP", 0),
        ("FPE_FLTDIV", 1),
        ("FPE_FLTOVF", 2),
        ("FPE_FLTUND", 3),
        ("FPE_FLTRES", 4),
        ("FPE_FLTINV", 5),
        ("FPE_FLTSUB", 6),
        ("FPE_INTDIV", 7),
        ("FPE_INTOVF", 8),
        ("SEGV_NOOP", 0),
        ("SEGV_MAPERR", 1),
        ("SEGV_ACCERR", 2),
        ("BUS_NOOP", 0),
        ("BUS_ADRALN", 1),
        ("BUS_ADRERR", 2),
        ("BUS_OBJERR", 3),
        ("TRAP_BRKPT", 1),
        ("TRAP_TRACE", 2),
        ("CLD_NOOP", 0),
        ("CLD_EXITED", 1),
        ("CLD_KILLED", 2),
        ("CLD_DUMPED", 3),
        ("CLD_TRAPPED", 4),
        ("CLD_STOPPED", 5),
        ("CLD_CONTINUED", 6),
        ("POLL_IN", 1),
        ("POLL_OUT", 2),
        ("POLL_MSG", 3),
        ("POLL_ERR", 4),
        ("POLL_PRI", 5),
        ("POLL_HUP", 6),
        ("SI_USER", 0x10001),
        ("SI_QUEUE", 0x10002),
        ("SI_TIMER", 0x10003),
        ("SI_ASYNCIO", 0x10004),
        ("SI_MESGQ", 0x10005),
    ];
    for target in [Target::LinuxX64, Target::LinuxAarch64] {
        check_values(target, &["#define _GNU_SOURCE", "signal.h"], LINUX);
        // glibc's visibility: SEGV_BNDERR with the POSIX set, the SIGTRAP
        // codes for XSI and GNU sources, SYS_SECCOMP for GNU sources only.
        check_values(
            target,
            &[
                "signal.h",
                "#if defined(SYS_SECCOMP) || defined(TRAP_BRKPT)",
                "#error a GNU or XSI code is declared without its feature macro",
                "#endif",
            ],
            &[("SEGV_BNDERR", 3)],
        );
        check_values(
            target,
            &[
                "#define _XOPEN_SOURCE 700",
                "signal.h",
                "#ifdef SYS_SECCOMP",
                "#error SYS_SECCOMP is declared for an XSI source",
                "#endif",
            ],
            &[("TRAP_BRKPT", 1), ("SEGV_BNDERR", 3)],
        );
        check_values(
            target,
            &["#define _GNU_SOURCE", "signal.h"],
            &[("SYS_SECCOMP", 1), ("TRAP_BRKPT", 1), ("SEGV_BNDERR", 3)],
        );
    }
    check_values(Target::MacOSAarch64, &["signal.h"], MACOS);
    check_values(
        Target::WindowsX64,
        &[
            "signal.h",
            "#if defined(SI_USER) || defined(FPE_INTDIV) || defined(SEGV_MAPERR)",
            "#error si_code values are declared",
            "#endif",
        ],
        &[("sizeof(int)", 4)],
    );
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

/// The Windows SDK's base types and handles as `<windows.h>` spells them:
/// `DWORD` is `unsigned long`, the string pointers are const-correct, and
/// under `STRICT` each handle points at a struct of its own. The PE image
/// records take winnt.h's packing.
#[test]
fn windows_h_spells_the_sdk_types() {
    const H: &[&str] = &["windows.h"];
    let same =
        |ty: &str, spelled: &str| (format!("_Generic(({ty})0, {spelled}: 1, default: 0)"), 1);
    let size = |expr: &str, n: usize| (expr.to_string(), n);
    for target in [Target::WindowsX64, Target::WindowsAarch64] {
        check_values(
            target,
            H,
            &[
                same("DWORD", "unsigned long"),
                same("LONG", "long"),
                same("ULONG", "unsigned long"),
                same("HRESULT", "long"),
                same("NTSTATUS", "long"),
                same("LSTATUS", "long"),
                same("REGSAM", "unsigned long"),
                same("BOOL", "int"),
                same("UINT", "unsigned int"),
                same("WCHAR", "wchar_t"),
                same("LPDWORD", "unsigned long *"),
                same("LPCSTR", "const char *"),
                same("LPCWSTR", "const wchar_t *"),
                same("LPCVOID", "const void *"),
                same("SIZE_T", "unsigned long long"),
                same("LPARAM", "long long"),
                same("WPARAM", "unsigned long long"),
                same("HANDLE", "void *"),
                same("HMODULE", "struct HINSTANCE__ *"),
                same("HINSTANCE", "struct HINSTANCE__ *"),
                same("HWND", "struct HWND__ *"),
                same("HDC", "struct HDC__ *"),
                same("HKEY", "struct HKEY__ *"),
                same("HCURSOR", "struct HICON__ *"),
                same("HGDIOBJ", "void *"),
                same("HGLOBAL", "void *"),
                same("HCRYPTPROV", "unsigned long long"),
                same("LPSECURITY_ATTRIBUTES", "struct _SECURITY_ATTRIBUTES *"),
                same("LPOVERLAPPED", "struct _OVERLAPPED *"),
                same("LPTHREAD_START_ROUTINE", "unsigned long (*)(void *)"),
                same("FARPROC", "long long (*)()"),
                size("sizeof(struct HINSTANCE__)", 4),
                size("sizeof(IMAGE_DOS_HEADER)", 64),
                size("sizeof(IMAGE_FILE_HEADER)", 20),
                size("sizeof(IMAGE_OPTIONAL_HEADER64)", 240),
                size("sizeof(IMAGE_NT_HEADERS64)", 264),
                size("sizeof(IMAGE_SECTION_HEADER)", 40),
                size("sizeof(IMAGE_IMPORT_DESCRIPTOR)", 20),
                size("sizeof(IMAGE_THUNK_DATA64)", 8),
                size("sizeof(IMAGE_BASE_RELOCATION)", 8),
                size("sizeof(IMAGE_RESOURCE_DIRECTORY_ENTRY)", 8),
                size("sizeof(IMAGE_TLS_DIRECTORY64)", 40),
                size("offsetof(IMAGE_NT_HEADERS64, OptionalHeader)", 24),
                size("offsetof(IMAGE_OPTIONAL_HEADER64, ImageBase)", 24),
                size("offsetof(IMAGE_OPTIONAL_HEADER64, DataDirectory)", 112),
                size("IMAGE_NT_SIGNATURE", 0x4550),
                size("sizeof(OVERLAPPED)", 32),
                size("offsetof(OVERLAPPED, OffsetHigh)", 20),
                size("offsetof(OVERLAPPED, hEvent)", 24),
                size("sizeof(SYSTEM_INFO)", 48),
                size("offsetof(SYSTEM_INFO, wProcessorArchitecture)", 0),
                size("offsetof(SYSTEM_INFO, dwPageSize)", 4),
                size("sizeof(INPUT_RECORD)", 20),
                size("sizeof(CHAR_INFO)", 4),
                size("sizeof(STARTUPINFOA)", 104),
                size("sizeof(CRITICAL_SECTION)", 40),
                size("sizeof(REASON_CONTEXT)", 32),
            ],
        );
    }
    check_values(
        Target::WindowsX64,
        H,
        &[
            ("sizeof(RUNTIME_FUNCTION)", 12),
            ("offsetof(RUNTIME_FUNCTION, UnwindData)", 8),
        ],
    );
    check_values(
        Target::WindowsAarch64,
        H,
        &[
            ("sizeof(RUNTIME_FUNCTION)", 8),
            ("offsetof(RUNTIME_FUNCTION, UnwindData)", 4),
        ],
    );
}
