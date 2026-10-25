//! Test suite split by phase.
//!
//! - [`lexer`]    -- drives `Lexer::next` directly and inspects the token stream.
//! - [`parser`]   -- feeds malformed C to the compiler and asserts on errors.
//! - [`codegen`]  -- compiles valid C and inspects post-link program metadata.
//! - [`programs`] -- end-to-end: load a `.c` fixture, compile, run, assert exit code.
//!
//! Tests that contain meaningful C source load it from `tests/fixtures/c/<name>.c`
//! via [`load_fixture`] / [`run_fixture`] / [`compile_fixture`]. Lexer- and
//! parser-error tests use small inline strings since the snippets are tiny
//! and tightly coupled to the assertion.

use std::path::PathBuf;
use std::sync::atomic::{AtomicUsize, Ordering};
use std::sync::{Condvar, Mutex, OnceLock};

use super::lexer::{self as lex_helpers, Lexer};
use super::symbol::Symbol;
use super::token::{Tok, Token};
use super::{C5Error, Compiler, Program, Vm};

// These modules emit / link native images (via `emit_native*` and the
// `link_*` helpers below), which require `native-emit` -- pulled in by
// `full`. The host-only `--features std` build gates them out.
#[cfg(feature = "full")]
mod atomics;
mod auto_var_init;
#[cfg(feature = "full")]
mod block_plan;
#[cfg(feature = "full")]
mod branch_reach;
#[cfg(feature = "full")]
mod codegen;
mod compound_assign;
#[cfg(feature = "full")]
mod computed_goto;
mod deferred;
mod divmod;
#[cfg(feature = "full")]
mod dwarf;
#[cfg(feature = "full")]
mod fixed_regs;
mod fixture_tables;
mod frame_slot_fuzz;
mod inline_asm;
#[cfg(feature = "full")]
mod inline_linkage;
mod intrinsics;
mod jit;
mod lexer;
mod libc_layout;
#[cfg(feature = "full")]
mod linker;
mod loop_idiom;
#[cfg(feature = "full")]
mod native;
#[cfg(feature = "full")]
mod native_elf;
#[cfg(feature = "full")]
mod native_elf_x64;
#[cfg(feature = "full")]
mod native_pe_arm64;
#[cfg(feature = "full")]
mod native_pe_x64;
#[cfg(feature = "full")]
mod overflow;
mod parser;
#[cfg(feature = "full")]
mod patchable_entry;
#[cfg(feature = "full")]
mod perf_codegen;
mod pointer_tracking;
mod programs;
mod redeclaration;
#[cfg(feature = "full")]
mod reloc_golden;
#[cfg(feature = "full")]
mod relocatable;
#[cfg(feature = "full")]
mod stack_guard;
#[cfg(feature = "full")]
mod static_init;
mod types;
mod vla;
#[cfg(feature = "full")]
mod x64_frame;
mod x86_simd;

/// Absolute path of `tests/fixtures/c/<name>` relative to the crate root.
fn fixture_path(name: &str) -> PathBuf {
    let mut p = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    p.push("tests");
    p.push("fixtures");
    p.push("c");
    p.push(name);
    p
}

/// Read a C source fixture from `tests/fixtures/c/<name>`.
pub fn load_fixture(name: &str) -> String {
    let path = fixture_path(name);
    std::fs::read_to_string(&path)
        .unwrap_or_else(|e| panic!("failed to load fixture {}: {}", path.display(), e))
}

/// The `-ffixed-` registers a fixture's leading `// snapshot-flags` line
/// names, for a test that compiles the fixture as its snapshot does.
pub fn fixture_fixed_regs(name: &str, target: crate::Target) -> crate::FixedRegs {
    let src = load_fixture(name);
    let mut out = crate::FixedRegs::NONE;
    let flags = src.lines().next().unwrap_or("").split_whitespace();
    for reg in flags.filter_map(|w| w.strip_prefix("-ffixed-")) {
        out.insert(crate::fixed_register(target, reg).unwrap_or_else(|e| panic!("{e}")));
    }
    out
}

/// `<tmp>/<prefix>-<pid>-<n>-<stem><ext>`: unique per process and call.
/// Concurrent `cargo test` processes share the temp directory, so a fixed
/// name lets one run clobber the other's file. Callers remove what they
/// create.
pub fn unique_temp_path(prefix: &str, stem: &str, ext: &str) -> PathBuf {
    use std::sync::atomic::{AtomicU64, Ordering};
    static COUNTER: AtomicU64 = AtomicU64::new(0);
    let n = COUNTER.fetch_add(1, Ordering::Relaxed);
    let pid = std::process::id();
    std::env::temp_dir().join(format!("{prefix}-{pid}-{n}-{stem}{ext}"))
}

/// The POSIX signal entry points the harness needs. Declared here
/// rather than taken from a crate: the library carries no `libc`
/// dependency.
#[cfg(unix)]
pub mod signals {
    use std::os::raw::c_int;

    /// Wider than `sigset_t` on every host the harness builds for (4
    /// bytes on Darwin, 128 on glibc); each entry point below writes
    /// only its own size.
    #[repr(C, align(8))]
    pub struct Set([u8; 256]);

    #[cfg(target_vendor = "apple")]
    const SIG_BLOCK: c_int = 1;
    #[cfg(target_vendor = "apple")]
    const SIG_SETMASK: c_int = 3;
    #[cfg(not(target_vendor = "apple"))]
    const SIG_BLOCK: c_int = 0;
    #[cfg(not(target_vendor = "apple"))]
    const SIG_SETMASK: c_int = 2;

    const SIG_IGN: usize = 1;
    const SIG_ERR: usize = usize::MAX;

    /// The signal a store into a read-only mapping raises: Darwin
    /// reports the protection failure as `SIGBUS`, Linux as `SIGSEGV`.
    #[cfg(target_vendor = "apple")]
    pub const STORE_TO_READ_ONLY: c_int = 10;
    #[cfg(not(target_vendor = "apple"))]
    pub const STORE_TO_READ_ONLY: c_int = 11;

    /// `SIGWINCH`, the same number on every unix host the harness
    /// builds for and ignored by default, so a test may set it to
    /// `SIG_IGN` without changing what the process does.
    pub const WINDOW_CHANGE: c_int = 28;

    unsafe extern "C" {
        fn sigemptyset(set: *mut Set) -> c_int;
        fn sigfillset(set: *mut Set) -> c_int;
        fn sigaddset(set: *mut Set, sig: c_int) -> c_int;
        fn sigismember(set: *const Set, sig: c_int) -> c_int;
        fn pthread_sigmask(how: c_int, set: *const Set, old: *mut Set) -> c_int;
        fn signal(sig: c_int, handler: usize) -> usize;
    }

    impl Set {
        pub fn empty() -> Self {
            let mut set = Set([0; 256]);
            unsafe { sigemptyset(&mut set) };
            set
        }

        pub fn full() -> Self {
            let mut set = Set([0; 256]);
            unsafe { sigfillset(&mut set) };
            set
        }

        pub fn with(sig: c_int) -> Self {
            let mut set = Self::empty();
            unsafe { sigaddset(&mut set, sig) };
            set
        }

        pub fn holds(&self, sig: c_int) -> bool {
            unsafe { sigismember(self, sig) == 1 }
        }
    }

    /// Block `sig` on the calling thread and return the previous mask.
    pub fn block_on_this_thread(sig: c_int) -> Set {
        let mut old = Set::empty();
        unsafe { pthread_sigmask(SIG_BLOCK, &Set::with(sig), &mut old) };
        old
    }

    /// Restore a mask taken from [`block_on_this_thread`].
    pub fn set_thread_mask(mask: &Set) {
        unsafe { pthread_sigmask(SIG_SETMASK, mask, core::ptr::null_mut()) };
    }

    /// The calling thread's blocked set.
    pub fn blocked() -> Set {
        let mut cur = Set::empty();
        unsafe { pthread_sigmask(SIG_BLOCK, core::ptr::null(), &mut cur) };
        cur
    }

    /// Set `sig` to `SIG_IGN` process-wide, returning the previous
    /// disposition for [`set_disposition`].
    pub fn ignore(sig: c_int) -> usize {
        unsafe { signal(sig, SIG_IGN) }
    }

    pub fn set_disposition(sig: c_int, handler: usize) {
        if handler != SIG_ERR {
            unsafe { signal(sig, handler) };
        }
    }

    /// Whether `sig` is ignored process-wide. Reinstalls what it found,
    /// so it must not race another thread changing the same signal.
    pub fn is_ignored(sig: c_int) -> bool {
        let prev = ignore(sig);
        set_disposition(sig, prev);
        prev == SIG_IGN
    }
}

/// `posix_spawn`, through which the harness runs every image it produces:
/// the child starts with an empty signal mask and every disposition at
/// `SIG_DFL`, set by the spawn itself.
///
/// `exec` keeps the signal mask and every `SIG_IGN` disposition (POSIX.1
/// 2.4.3), and `std::process::Command` resets neither -- it documents
/// that the mask is inherited and puts only `SIGPIPE` back to `SIG_DFL`.
/// A fixture that starts with `SIGBUS` or `SIGSEGV` blocked or ignored
/// does not die on a faulting store: the kernel leaves the signal
/// pending and restarts the instruction, so the fixture spins at 100%
/// CPU and the test that spawned it never returns. A reset in a
/// `pre_exec` closure needs `fork`, whose child in this many-threaded
/// process runs the C library's `atfork` handlers: on macOS one of them
/// aborts on a corrupt `os_once` gate, and the parent saw the abort as
/// the image's `SIGKILL`. A spawned child runs no code before `exec`, and
/// a failed `exec` is the spawn's error.
#[cfg(unix)]
pub mod spawn {
    use super::signals::Set;
    use std::ffi::{CString, OsString};
    use std::io::{Error, ErrorKind, Read, Result};
    use std::os::fd::AsRawFd;
    use std::os::raw::{c_char, c_int, c_short};
    use std::os::unix::ffi::OsStrExt;
    use std::os::unix::process::ExitStatusExt;
    use std::process::{Command, ExitStatus, Output};

    /// Wider than `posix_spawnattr_t` and `posix_spawn_file_actions_t` on
    /// every host the harness builds for (a pointer on Darwin, 336 and 80
    /// bytes on glibc).
    #[repr(C, align(8))]
    struct Opaque([u8; 512]);

    #[cfg(target_vendor = "apple")]
    type Mode = u16;
    #[cfg(not(target_vendor = "apple"))]
    type Mode = u32;

    const POSIX_SPAWN_SETSIGDEF: c_short = 0x04;
    const POSIX_SPAWN_SETSIGMASK: c_short = 0x08;
    const O_RDONLY: c_int = 0;
    const O_WRONLY: c_int = 1;
    const WNOHANG: c_int = 1;
    const SIGKILL: c_int = 9;
    const EINTR: i32 = 4;

    unsafe extern "C" {
        fn posix_spawnp(
            pid: *mut c_int,
            file: *const c_char,
            actions: *const Opaque,
            attr: *const Opaque,
            argv: *const *const c_char,
            envp: *const *const c_char,
        ) -> c_int;
        fn posix_spawnattr_init(attr: *mut Opaque) -> c_int;
        fn posix_spawnattr_destroy(attr: *mut Opaque) -> c_int;
        fn posix_spawnattr_setflags(attr: *mut Opaque, flags: c_short) -> c_int;
        fn posix_spawnattr_setsigmask(attr: *mut Opaque, mask: *const Set) -> c_int;
        fn posix_spawnattr_setsigdefault(attr: *mut Opaque, set: *const Set) -> c_int;
        fn posix_spawn_file_actions_init(actions: *mut Opaque) -> c_int;
        fn posix_spawn_file_actions_destroy(actions: *mut Opaque) -> c_int;
        fn posix_spawn_file_actions_addopen(
            actions: *mut Opaque,
            fd: c_int,
            path: *const c_char,
            flags: c_int,
            mode: Mode,
        ) -> c_int;
        fn posix_spawn_file_actions_adddup2(actions: *mut Opaque, fd: c_int, to: c_int) -> c_int;
        fn posix_spawn_file_actions_addchdir_np(actions: *mut Opaque, dir: *const c_char) -> c_int;
        fn waitpid(pid: c_int, status: *mut c_int, options: c_int) -> c_int;
        fn kill(pid: c_int, sig: c_int) -> c_int;
    }

    fn c_string(s: &[u8]) -> Result<CString> {
        CString::new(s).map_err(|e| Error::new(ErrorKind::InvalidInput, e))
    }

    fn check(rc: c_int) -> Result<()> {
        if rc == 0 {
            Ok(())
        } else {
            Err(Error::from_raw_os_error(rc))
        }
    }

    /// The program, arguments, environment and directory `cmd` names, run
    /// with its streams on `/dev/null` or, given `pipes`, its output on the
    /// write ends.
    fn start(cmd: &Command, pipes: Option<[&dyn AsRawFd; 2]>) -> Result<c_int> {
        let program = c_string(cmd.get_program().as_bytes())?;
        let mut argv = vec![program.clone()];
        for a in cmd.get_args() {
            argv.push(c_string(a.as_bytes())?);
        }
        let mut env: std::collections::BTreeMap<OsString, OsString> = std::env::vars_os().collect();
        for (k, v) in cmd.get_envs() {
            match v {
                Some(v) => env.insert(k.to_owned(), v.to_owned()),
                None => env.remove(k),
            };
        }
        let mut envp = Vec::with_capacity(env.len());
        for (k, v) in &env {
            envp.push(c_string(&[k.as_bytes(), b"=", v.as_bytes()].concat())?);
        }
        let dir = (cmd.get_current_dir())
            .map(|d| c_string(d.as_os_str().as_bytes()))
            .transpose()?;
        let null = c"/dev/null";
        let mut actions = Opaque([0; 512]);
        let mut attr = Opaque([0; 512]);
        let mut pid: c_int = 0;
        let argv_p: Vec<*const c_char> = argv
            .iter()
            .map(|a| a.as_ptr())
            .chain([core::ptr::null()])
            .collect();
        let envp_p: Vec<*const c_char> = envp
            .iter()
            .map(|e| e.as_ptr())
            .chain([core::ptr::null()])
            .collect();
        unsafe {
            check(posix_spawn_file_actions_init(&mut actions))?;
            if let Err(e) = check(posix_spawnattr_init(&mut attr)) {
                posix_spawn_file_actions_destroy(&mut actions);
                return Err(e);
            }
            let rc = (|| {
                check(posix_spawn_file_actions_addopen(
                    &mut actions,
                    0,
                    null.as_ptr(),
                    O_RDONLY,
                    0,
                ))?;
                for (fd, out) in [1, 2].into_iter().zip(pipes.into_iter().flatten()) {
                    check(posix_spawn_file_actions_adddup2(
                        &mut actions,
                        out.as_raw_fd(),
                        fd,
                    ))?;
                }
                if pipes.is_none() {
                    for fd in [1, 2] {
                        check(posix_spawn_file_actions_addopen(
                            &mut actions,
                            fd,
                            null.as_ptr(),
                            O_WRONLY,
                            0,
                        ))?;
                    }
                }
                if let Some(dir) = &dir {
                    check(posix_spawn_file_actions_addchdir_np(
                        &mut actions,
                        dir.as_ptr(),
                    ))?;
                }
                check(posix_spawnattr_setsigmask(&mut attr, &Set::empty()))?;
                check(posix_spawnattr_setsigdefault(&mut attr, &Set::full()))?;
                let flags = POSIX_SPAWN_SETSIGMASK | POSIX_SPAWN_SETSIGDEF;
                check(posix_spawnattr_setflags(&mut attr, flags))?;
                let (a, p) = (argv_p.as_ptr(), program.as_ptr());
                check(posix_spawnp(
                    &mut pid,
                    p,
                    &actions,
                    &attr,
                    a,
                    envp_p.as_ptr(),
                ))
            })();
            posix_spawnattr_destroy(&mut attr);
            posix_spawn_file_actions_destroy(&mut actions);
            rc?;
        }
        Ok(pid)
    }

    fn wait(pid: c_int, options: c_int) -> Result<Option<ExitStatus>> {
        let mut status: c_int = 0;
        loop {
            match unsafe { waitpid(pid, &mut status, options) } {
                0 => return Ok(None),
                r if r == pid => return Ok(Some(ExitStatus::from_raw(status))),
                _ => {
                    let e = Error::last_os_error();
                    if e.raw_os_error() != Some(EINTR) {
                        return Err(e);
                    }
                }
            }
        }
    }

    /// `cmd.output()`, run through `posix_spawn`: standard input on
    /// `/dev/null`, both output streams captured.
    pub fn output(cmd: &Command) -> Result<Output> {
        let (mut out_r, out_w) = std::io::pipe()?;
        let (mut err_r, err_w) = std::io::pipe()?;
        let pid = start(cmd, Some([&out_w, &err_w]));
        drop((out_w, err_w));
        let pid = pid?;
        let errs = std::thread::spawn(move || {
            let mut v = Vec::new();
            err_r.read_to_end(&mut v).map(|_| v)
        });
        let mut stdout = Vec::new();
        let read = out_r.read_to_end(&mut stdout);
        let stderr = errs.join().expect("read the image's stderr");
        let status = wait(pid, 0)?.expect("a blocking wait returns a status");
        read?;
        Ok(Output {
            status,
            stdout,
            stderr: stderr?,
        })
    }

    /// A running image from [`spawn`], its streams on `/dev/null`.
    pub struct Child {
        pid: c_int,
        status: Option<ExitStatus>,
    }

    #[allow(dead_code)] // the Mach-O suite alone stops a hung image
    impl Child {
        pub fn try_wait(&mut self) -> Result<Option<ExitStatus>> {
            if self.status.is_none() {
                self.status = wait(self.pid, WNOHANG)?;
            }
            Ok(self.status)
        }

        pub fn wait(&mut self) -> Result<ExitStatus> {
            if self.status.is_none() {
                self.status = wait(self.pid, 0)?;
            }
            Ok(self.status.expect("a blocking wait returns a status"))
        }

        pub fn kill(&mut self) -> Result<()> {
            if self.status.is_none() && unsafe { kill(self.pid, SIGKILL) } != 0 {
                return Err(Error::last_os_error());
            }
            Ok(())
        }
    }

    pub fn spawn(cmd: &Command) -> Result<Child> {
        let pid = start(cmd, None)?;
        Ok(Child { pid, status: None })
    }
}

/// A command for an image the harness runs, through [`spawn`] where the host
/// has it: only the settings it can carry there are offered.
pub struct ImageCommand(std::process::Command);

pub fn image_command(program: impl AsRef<std::ffi::OsStr>) -> ImageCommand {
    ImageCommand(std::process::Command::new(program))
}

#[allow(dead_code)] // each image suite uses a part, and a host compiles some out
impl ImageCommand {
    pub fn arg(&mut self, a: impl AsRef<std::ffi::OsStr>) -> &mut Self {
        self.0.arg(a);
        self
    }

    pub fn args<I: IntoIterator<Item = S>, S: AsRef<std::ffi::OsStr>>(
        &mut self,
        a: I,
    ) -> &mut Self {
        self.0.args(a);
        self
    }

    pub fn env(
        &mut self,
        k: impl AsRef<std::ffi::OsStr>,
        v: impl AsRef<std::ffi::OsStr>,
    ) -> &mut Self {
        self.0.env(k, v);
        self
    }

    pub fn current_dir(&mut self, dir: impl AsRef<std::path::Path>) -> &mut Self {
        self.0.current_dir(dir);
        self
    }

    pub fn output(&mut self) -> std::io::Result<std::process::Output> {
        #[cfg(unix)]
        return spawn::output(&self.0);
        #[cfg(not(unix))]
        return self.0.output();
    }

    #[cfg(unix)]
    pub fn spawn(&mut self) -> std::io::Result<spawn::Child> {
        spawn::spawn(&self.0)
    }
}

/// Wait for `child`, giving up after `limit`. `None` means it was still
/// running when the limit ran out; the caller decides what to do with it.
#[cfg(unix)]
#[allow(dead_code)]
pub fn wait_within(
    child: &mut spawn::Child,
    limit: std::time::Duration,
) -> Option<std::process::ExitStatus> {
    let deadline = std::time::Instant::now() + limit;
    loop {
        match child.try_wait() {
            Ok(Some(status)) => return Some(status),
            Ok(None) if std::time::Instant::now() < deadline => {
                std::thread::sleep(std::time::Duration::from_millis(10));
            }
            Ok(None) => return None,
            Err(e) => panic!("wait for the spawned image: {e}"),
        }
    }
}

/// Run a just-written image, retrying while the kernel reports it busy.
///
/// `exec` fails with `ETXTBSY` while any process holds the file open for
/// writing. The writer here closes it first, so the holder is another
/// test's `fork`: a child inherits every descriptor, and `O_CLOEXEC`
/// drops the inherited copy at its `exec`, not at the `fork`. A loaded
/// machine widens that window, which is why it surfaces on a shared
/// runner and not on an idle box. `sh` reports the condition as 126.
/// Reached only where a shell mediates the exec (the aarch64 ELF tests)
/// and on Mach-O; the x86-64 ELF tests carry their own errno-26 retry.
#[allow(dead_code)]
pub fn output_when_not_busy(build: impl Fn() -> ImageCommand) -> std::process::Output {
    let mut waited = std::time::Duration::ZERO;
    let mut delay = std::time::Duration::from_millis(5);
    loop {
        let spent = waited >= std::time::Duration::from_secs(5);
        // Direct exec reports the condition as errno 26; a shell in
        // between reports it as 126 with the message on stderr.
        let busy = match build().output() {
            Ok(out) => {
                let busy = out.status.code() == Some(126)
                    && String::from_utf8_lossy(&out.stderr).contains("Text file busy");
                if !busy || spent {
                    return out;
                }
                true
            }
            Err(e) if e.raw_os_error() == Some(26) && !spent => true,
            Err(e) => panic!("run the produced image: {e}"),
        };
        debug_assert!(busy);
        std::thread::sleep(delay);
        waited += delay;
        delay = (delay * 2).min(std::time::Duration::from_millis(250));
    }
}

/// Fixtures built and run at once, summed over every whole-corpus parity
/// test -- `cargo test` schedules those in parallel, so a per-test width
/// would multiply by the number live. The floor is what the serial loops
/// already reached, one fixture per live parity test; the ceiling bounds
/// memory on hosts whose RAM does not track their core count.
/// `BADC_TEST_JOBS` overrides both.
fn fixture_jobs() -> usize {
    static JOBS: OnceLock<usize> = OnceLock::new();
    *JOBS.get_or_init(|| {
        if let Some(n) = std::env::var("BADC_TEST_JOBS")
            .ok()
            .and_then(|v| v.parse::<usize>().ok())
        {
            return n.max(1);
        }
        let cpus = std::thread::available_parallelism().map_or(2, |n| n.get());
        (cpus / 2).clamp(cpus.min(4), 8)
    })
}

struct FixturePermits {
    free: Mutex<usize>,
    released: Condvar,
}

struct FixturePermit(&'static FixturePermits);

impl Drop for FixturePermit {
    fn drop(&mut self) {
        let mut free = self.0.free.lock().unwrap_or_else(|e| e.into_inner());
        *free += 1;
        self.0.released.notify_one();
    }
}

fn acquire_fixture_permit() -> FixturePermit {
    static POOL: OnceLock<FixturePermits> = OnceLock::new();
    let pool = POOL.get_or_init(|| FixturePermits {
        free: Mutex::new(fixture_jobs()),
        released: Condvar::new(),
    });
    let mut free = pool.free.lock().unwrap_or_else(|e| e.into_inner());
    while *free == 0 {
        free = pool.released.wait(free).unwrap_or_else(|e| e.into_inner());
    }
    *free -= 1;
    drop(free);
    FixturePermit(pool)
}

/// Check every entry of `corpus` on up to [`fixture_jobs`] threads and
/// return the messages `check` produced, ordered by corpus index so the
/// same regression reports the same text whatever order threads finish in.
pub fn parity_failures<T, F>(corpus: &[(&str, T)], check: F) -> Vec<String>
where
    T: Sync,
    F: Fn(&str, &T) -> Option<String> + Sync,
{
    let next = AtomicUsize::new(0);
    let failures: Mutex<Vec<(usize, String)>> = Mutex::new(Vec::new());
    let width = fixture_jobs().min(corpus.len().max(1));
    std::thread::scope(|scope| {
        for _ in 0..width {
            scope.spawn(|| {
                loop {
                    let i = next.fetch_add(1, Ordering::Relaxed);
                    let Some((name, expected)) = corpus.get(i) else {
                        break;
                    };
                    let _permit = acquire_fixture_permit();
                    if let Some(msg) = check(name, expected) {
                        failures
                            .lock()
                            .unwrap_or_else(|e| e.into_inner())
                            .push((i, msg));
                    }
                }
            });
        }
    });
    let mut failures = failures.into_inner().unwrap_or_else(|e| e.into_inner());
    failures.sort_by_key(|(i, _)| *i);
    failures.into_iter().map(|(_, msg)| msg).collect()
}

/// A spawned image starts from an empty signal mask with every
/// disposition at `SIG_DFL`, whatever the spawning thread carried.
/// `exec` keeps the mask and every `SIG_IGN`, so without the reset a
/// fixture that faults on purpose never dies: the kernel leaves the
/// blocked or discarded fault signal undelivered and restarts the
/// instruction. The child re-executes this test binary and reports what
/// it inherited, so the check fails rather than spinning.
#[cfg(unix)]
#[test]
fn spawned_image_starts_from_the_default_signal_state() {
    use signals::{STORE_TO_READ_ONLY, WINDOW_CHANGE};

    if std::env::var_os("BADC_TEST_SIGNAL_REPORT").is_some() {
        let inherited = u8::from(signals::blocked().holds(STORE_TO_READ_ONLY))
            | (u8::from(signals::is_ignored(WINDOW_CHANGE)) << 1);
        std::process::exit(i32::from(inherited));
    }

    let module = module_path!();
    let module = module.split_once("::").map_or(module, |(_, rest)| rest);
    let test_name = format!("{module}::spawned_image_starts_from_the_default_signal_state");

    // The mask is per-thread, so blocking here reaches only this test;
    // the disposition is process-wide, which is why the ignored signal
    // is one whose default action is already to ignore it.
    let saved_mask = signals::block_on_this_thread(STORE_TO_READ_ONLY);
    let saved_winch = signals::ignore(WINDOW_CHANGE);
    let spawned = image_command(std::env::current_exe().expect("current_exe"))
        .args(["--exact", &test_name, "--test-threads=1"])
        .env("BADC_TEST_SIGNAL_REPORT", "1")
        .output();
    signals::set_disposition(WINDOW_CHANGE, saved_winch);
    signals::set_thread_mask(&saved_mask);

    let out = spawned.expect("re-exec the test binary");
    assert_eq!(
        out.status.code(),
        Some(0),
        "child inherited signal state: bit 0 fault signal blocked, bit 1 SIGWINCH ignored"
    );
}

/// An image the harness cannot start is the spawn's error, never a status
/// the image would have exited with.
#[cfg(unix)]
#[test]
fn an_image_that_cannot_start_is_a_spawn_error() {
    let missing = unique_temp_path("badc-test", "missing", ".bin");
    let err = (image_command(&missing).output()).expect_err("there is no image to start");
    assert_eq!(err.kind(), std::io::ErrorKind::NotFound, "{err}");
}

/// Completion order is the reverse of corpus order here, so an unsorted
/// collection would report the same regression differently per run.
#[test]
fn parity_failures_report_in_corpus_order() {
    let corpus: Vec<(&str, u64)> = (0..32).map(|i| ("fixture", i)).collect();
    let got = parity_failures(&corpus, |name, i| {
        std::thread::sleep(std::time::Duration::from_millis(32 - *i));
        Some(format!("{name} {i}"))
    });
    let want: Vec<String> = (0..32).map(|i| format!("fixture {i}")).collect();
    assert_eq!(got, want);
}

/// The permit pool is process-wide, so no run of the corpus exceeds
/// [`fixture_jobs`] however many parity tests the harness has in flight.
#[test]
fn parity_failures_hold_the_concurrency_bound() {
    let live = AtomicUsize::new(0);
    let peak = AtomicUsize::new(0);
    let corpus: Vec<(&str, u64)> = (0..64).map(|i| ("fixture", i)).collect();
    let got = parity_failures(&corpus, |_, _| {
        peak.fetch_max(live.fetch_add(1, Ordering::SeqCst) + 1, Ordering::SeqCst);
        std::thread::sleep(std::time::Duration::from_millis(1));
        live.fetch_sub(1, Ordering::SeqCst);
        None
    });
    assert!(got.is_empty());
    let peak = peak.load(Ordering::SeqCst);
    assert!(
        (1..=fixture_jobs()).contains(&peak),
        "peak {peak} outside 1..={}",
        fixture_jobs()
    );
}

/// Standard-library prelude prepended to every inline-source test.
/// Replaces the auto-prepend the compiler used to do via the
/// per-target umbrella header. Keeping it in the test helper means
/// each test body stays focused on the behaviour under test instead
/// of repeating five `#include` lines per snippet. Idempotent:
/// fixtures that already pull headers in via their own
/// `#include` lines just re-enter `#pragma once` and emit nothing.
pub const TEST_PRELUDE: &str = "\
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#ifndef _WIN32
#include <sys/mman.h>
#endif
#include <dlfcn.h>
";

/// Concatenate [`TEST_PRELUDE`] with `src` so inline test snippets
/// don't have to spell every header out themselves.
pub fn with_prelude(src: &str) -> String {
    let mut out = String::with_capacity(TEST_PRELUDE.len() + src.len());
    out.push_str(TEST_PRELUDE);
    out.push_str(src);
    out
}

/// Inline asm naming the unit's data object, functions external, static and
/// weak, offsets before the first object and function, a `#pragma binding`
/// name it defines, and on x86-64 a field an immediate trails; exits 0 when
/// all are right. `FILE_SCOPE_ASM` adds a file-scope asm reference,
/// `ASM_DATA_END` a label at the end of a file-scope asm `.data` table, past
/// which a thread-local sits ahead of `.bss`.
#[allow(dead_code)] // the image suites a Windows host compiles out
pub fn asm_pcrel_unit_definitions_source() -> &'static str {
    r#"
#include <stdio.h>
const long ro_first = 5;
int first_fn(int x) { return x + 1; }
int data_obj = 42;
int f(void) { return 7; }
static int g(void) { return 9; }
__attribute__((weak)) int w(void) { return 5; }
__attribute__((aligned(16))) int vec4[4] = {1, 2, 3, 4};
#pragma binding(data libc::dup_env, "environ")
char **dup_env = 0;
#if defined(__x86_64__)
#define ADDR(r, sym) __asm__("lea " sym "(%%rip), %0" : "=r"(r))
#define F_OFF "f+1"
#define OFF 1
#else
#define ADDR(r, sym) __asm__("adrp %0, " sym "\n\tadd %0, %0, :lo12:" sym : "=r"(r))
#define F_OFF "f+4"
#define OFF 4
#endif
#ifdef FILE_SCOPE_ASM
int *fs_get(void);
int (*fs_fn(void))(void);
#if defined(__x86_64__)
__asm__(".text\n.globl fs_get\nfs_get:\n\tleaq data_obj(%rip), %rax\n\tret\n"
        ".globl fs_fn\nfs_fn:\n\tleaq f(%rip), %rax\n\tret\n");
#else
__asm__(".text\n.globl fs_get\nfs_get:\n\tadrp x0, data_obj\n\tadd x0, x0, :lo12:data_obj\n\tret\n"
        ".globl fs_fn\nfs_fn:\n\tadrp x0, f\n\tadd x0, x0, :lo12:f\n\tret\n");
#endif
#endif
#ifdef ASM_DATA_END
_Thread_local long tls_pad = 1;
long bss_obj[2];
__asm__(".data\n.globl asm_tbl, asm_tbl_end\n.p2align 3\nasm_tbl: .quad 3, 4\nasm_tbl_end:\n.text\n");
extern long asm_tbl[], asm_tbl_end[];
#endif
int main(void) {
    int *d;
    int (*pf)(void);
    int (*pg)(void);
    int (*pw)(void);
    char *f_off, *ro, *ff;
    char ***pb;
    ADDR(d, "data_obj");
    ADDR(pf, "f");
    ADDR(pg, "g");
    ADDR(pw, "w");
    ADDR(f_off, F_OFF);
    ADDR(ro, "ro_first-64");
    ADDR(ff, "first_fn-16");
    ADDR(pb, "dup_env");
    if (*d != 42) return 1;
    if (pf != f || pf() != 7) return 2;
    if (pg() != 9) return 3;
    if (f_off != (char *)f + OFF) return 4;
    if (pw != w || pw() != 5) return 5;
    if (ro != (char *)&ro_first - 64 || ff != (char *)first_fn - 16) return 6;
    if (pb != &dup_env || first_fn(1) != 2) return 7;
#if defined(__x86_64__)
    int out[4], r;
    __asm__ volatile("pshufd $0x1b, vec4(%%rip), %%xmm1\n\tmovdqu %%xmm1, %0" : "=m"(out) :: "xmm1");
    if (out[0] != 4 || out[3] != 1) return 8;
    __asm__ volatile("movl $0, %0\n\tcmpl $3, vec4+8(%%rip)\n\tsete %b0" : "=&q"(r) :: "cc");
    if (r != 1) return 9;
    __asm__ volatile("movl $77, vec4(%%rip)" ::: "memory");
    if (vec4[0] != 77) return 10;
#endif
#ifdef FILE_SCOPE_ASM
    if (fs_get() != &data_obj || fs_fn() != f) return 11;
#endif
#ifdef ASM_DATA_END
    char *e0, *e8;
    ADDR(e0, "asm_tbl_end");
    ADDR(e8, "asm_tbl_end-8");
    if (e0 != (char *)(asm_tbl + 2) || e8 != (char *)(asm_tbl + 1)) return 12;
    if (asm_tbl_end - asm_tbl != 2 || asm_tbl_end[-1] != 4 || tls_pad + bss_obj[1] != 1) return 13;
#endif
    return 0;
}
"#
}

/// A constructor and a destructor beside writable named sections, one from C
/// and one from file-scope asm: `main` returns 9 when the constructor ran and
/// the sections read back, and the destructor then exits with 0.
#[allow(dead_code)] // the image suites a Windows host compiles out
pub fn init_fini_beside_named_sections_source() -> &'static str {
    r#"
#include <stdlib.h>
static int ctor_ran;
__attribute__((section("rgkc"))) long long gv[2] = {1, 2};
__asm__(".section rgka,\"aw\"\n.globl ga\n.p2align 3\nga: .quad 3, 4\n.text\n");
extern long long ga[2];
__attribute__((constructor)) static void init(void) { ctor_ran = 1; }
__attribute__((destructor)) static void fini(void) { _Exit(ctor_ran == 1 ? 0 : 3); }
int main(void) {
    if (ctor_ran != 1)
        return 1;
    return gv[0] + gv[1] + ga[0] + ga[1] == 10 ? 9 : 2;
}
"#
}

/// Names inline asm defines, reached from C and from other asm: a function
/// in a file-scope block, a label in a function body and a word in a
/// file-scope data section. Exits 0 when each resolves.
#[allow(dead_code)] // the image suites a Windows host compiles out
pub fn asm_defined_names_source() -> &'static str {
    r#"
#include <stdint.h>
#if defined(__x86_64__)
__asm__(".text\n.globl fs_seven\n.p2align 4\nfs_seven:\n\tmovl $7, %eax\n\tret\n");
#define ADDR(r, sym) __asm__("lea " sym "(%%rip), %0" : "=r"(r))
#else
__asm__(".text\n.globl fs_seven\n.p2align 2\nfs_seven:\n\tmov w0, #7\n\tret\n");
#define ADDR(r, sym) __asm__("adrp %0, " sym "\n\tadd %0, %0, :lo12:" sym : "=r"(r))
#endif
__asm__(".data\n.globl fs_word\n.p2align 2\nfs_word:\n\t.long 0x1234\n.text\n");
int fs_seven(void);
extern int fs_word;
static int with_label(int x) {
    __asm__ volatile(".globl body_label\nbody_label:\n");
    return x + 1;
}
int main(void) {
    uintptr_t fn, label, word;
    ADDR(fn, "fs_seven");
    ADDR(label, "body_label");
    ADDR(word, "fs_word");
    int bad = 0;
    bad |= fs_seven() != 7;
    bad |= ((int (*)(void))fn)() != 7;
    bad |= label == 0 || with_label(1) != 2;
    bad |= fs_word != 0x1234 || *(int *)word != 0x1234;
    return bad;
}
"#
}

/// Static slots naming an asm table (at its start and past it) and function,
/// `optind` directly and through a binding of the program's own, and an
/// undefined weak object and function; one exit bit each.
#[allow(dead_code)] // the image suites a Windows host compiles out
pub fn named_slots_source() -> &'static str {
    r#"
#include <stdint.h>
#ifndef _WIN32
#include <unistd.h>
#endif
__asm__(".data\n.globl ns_words\n.p2align 3\nns_words:\n\t.quad 5, 6\n.text\n");
#if defined(__x86_64__)
__asm__(".text\n.globl ns_seven\n.p2align 4\nns_seven:\n\tmovl $7, %eax\n\tret\n");
#else
__asm__(".text\n.globl ns_seven\n.p2align 2\nns_seven:\n\tmov w0, #7\n\tret\n");
#endif
extern const long long ns_words[];
int ns_seven(void);
extern int ns_weak_obj[] __attribute__((weak));
extern void ns_weak_fn(void) __attribute__((weak));
const long long *const words = ns_words;
const long long *const second = &ns_words[1];
int (*const seven)(void) = ns_seven;
int *weak_obj = &ns_weak_obj[2];
void (*weak_fn)(void) = ns_weak_fn;
#ifndef _WIN32
#if defined(__APPLE__)
#pragma binding(data libc::ns_opt, "_optind")
#else
#pragma binding(data libc::ns_opt, "optind")
#endif
extern int ns_opt;
int *const opt = &optind;
int *const opt_bound = &ns_opt;
#endif
int main(void) {
    int bad = 0;
    bad |= (words != ns_words || *words != 5) << 0;
    bad |= (second != ns_words + 1 || *second != 6) << 1;
    bad |= (seven != ns_seven || seven() != 7) << 2;
    bad |= ((uintptr_t)weak_obj != 2 * sizeof(int)) << 3;
    bad |= (weak_fn != 0) << 4;
#ifndef _WIN32
    bad |= (opt != &optind || *opt != optind) << 5;
    bad |= (opt_bound != &optind) << 6;
#endif
    return bad;
}
"#
}

/// Inline asm naming the C library's `optind`, which the bundled headers
/// bind as an imported object: `form` 1 takes its address, 2 loads it in
/// place, 3 stores 7 to it in place. C reads of the object check each.
/// Exits 0 when every access reaches the library's object.
#[allow(dead_code)] // the image suites a Windows host compiles out
pub fn asm_library_object_source(form: u32) -> String {
    let body = r#"
#include <unistd.h>
int main(void) {
#if defined(__x86_64__)
#if T == 1
    int *p;
    __asm__("lea optind(%%rip), %0" : "=r"(p));
    return p != &optind || *p != optind;
#elif T == 2
    int v;
    __asm__("movl optind(%%rip), %0" : "=r"(v));
    return v != optind;
#else
    __asm__ volatile("movl $7, optind(%%rip)" ::: "memory");
    return optind != 7;
#endif
#else
#if T == 1
    int *p;
    __asm__("adrp %0, optind\n\tadd %0, %0, :lo12:optind" : "=r"(p));
    return p != &optind || *p != optind;
#elif T == 2
    long v;
    __asm__("adrp %0, optind\n\tldr %w0, [%0, :lo12:optind]" : "=r"(v));
    return (int)v != optind;
#else
    long t;
    __asm__ volatile("mov w1, #7\n\tadrp %0, optind\n\tstr w1, [%0, :lo12:optind]"
                     : "=&r"(t) :: "x1", "memory");
    return optind != 7;
#endif
#endif
}
"#;
    format!("#define T {form}\n{body}")
}

/// Inline asm naming objects at the edges of `.rodata`, relro, `.data` and
/// `.bss` with offsets before and past them, aliases of a function and an
/// object, and on x86-64 fields an immediate trails; `WITH_TLS` adds a
/// thread-local between `.data` and `.bss`, `WITH_WORDS` `.long sym - .`
/// words in `.text`. Exits with the count of wrong addresses and values.
#[allow(dead_code)] // the image suites a Windows host compiles out
pub fn asm_region_edges_source() -> &'static str {
    r#"
#include <stdio.h>
#include <stdint.h>
const long ro_first[2] = {0x1111, 0x2222};
const char *const relro_first[2] = {"p", "q"};
long data_first[2] = {0x3333, 0x4444};
long bss_first[2];
static const long ro_static[2] = {5, 6};
static long data_static[2] = {7, 8};
static long bss_static[2];
#ifdef WITH_TLS
_Thread_local long tls_obj = 9;
#endif
#ifdef WITH_WORDS
extern const int edge_words[2];
__asm__(".text\n.globl edge_words\n.p2align 2\nedge_words:\n"
        ".long ro_first-8-.\n.long bss_first+16-.\n");
#endif
int f(void) { return 7; }
int wfa(void) __attribute__((weak, alias("f")));
int sfa(void) __attribute__((alias("f")));
long wda[2] __attribute__((weak, alias("data_first")));
#if defined(__x86_64__)
#define ADDR(r, sym) __asm__("lea " sym "(%%rip), %0" : "=r"(r))
#else
#define ADDR(r, sym) __asm__("adrp %0, " sym "\n\tadd %0, %0, :lo12:" sym : "=r"(r))
#endif
static int bad;
#define AT(sym, want) do { uintptr_t u_; ADDR(u_, sym); if (u_ != (uintptr_t)(want)) bad++; } while (0)
#define EDGES(obj) do { AT(#obj "-8", (char *)obj - 8); AT(#obj "+16", (char *)obj + 16); } while (0)
int main(void) {
    EDGES(ro_first);
    EDGES(relro_first);
    EDGES(data_first);
    EDGES(bss_first);
    EDGES(ro_static);
    EDGES(data_static);
    EDGES(bss_static);
    AT("wfa", f);
    AT("sfa", f);
    AT("wda", data_first);
#if defined(__x86_64__)
    int r;
    __asm__ volatile("movl $0, %0\n\tcmpq $0x1111, ro_first(%%rip)\n\tsete %b0" : "=&q"(r) :: "cc");
    bad += r != 1;
    __asm__ volatile("movl $0, %0\n\tcmpq $0, relro_first(%%rip)\n\tsetne %b0" : "=&q"(r) :: "cc");
    bad += r != 1;
    __asm__ volatile("movl $0, %0\n\tcmpq $0x3333, data_first(%%rip)\n\tsete %b0" : "=&q"(r) :: "cc");
    bad += r != 1;
    __asm__ volatile("movq $0x5555, bss_first(%%rip)" ::: "memory");
    bad += bss_first[0] != 0x5555;
    __asm__ volatile("movq $0x6666, bss_static+8(%%rip)" ::: "memory");
    bad += bss_static[1] != 0x6666;
#endif
#ifdef WITH_TLS
    bad += tls_obj != 9;
#endif
#ifdef WITH_WORDS
    bad += (uintptr_t)&edge_words[0] + edge_words[0] != (uintptr_t)ro_first - 8;
    bad += (uintptr_t)&edge_words[1] + edge_words[1] != (uintptr_t)bss_first + 16;
#endif
    bad += ro_first[1] + ro_static[1] + data_static[0] != 0x2222 + 6 + 7;
    bad += relro_first[1][0] != 'q' || wfa() != 7 || sfa() != 7 || wda[1] != 0x4444;
    return bad;
}
"#
}

/// Inline asm naming a data object, a read-only one and a function 32 and
/// 64 KiB before themselves, which in a small PE image is below the image
/// base. Exits with the count of wrong addresses.
pub fn asm_below_image_base_source() -> &'static str {
    r#"
#include <stdint.h>
long d[2] = {1, 2};
const long r[2] = {3, 4};
static int f(void) { return 5; }
#if defined(__x86_64__)
#define ADDR(p, sym) __asm__("lea " sym "(%%rip), %0" : "=r"(p))
#else
#define ADDR(p, sym) __asm__("adrp %0, " sym "\n\tadd %0, %0, :lo12:" sym : "=r"(p))
#endif
static int bad;
#define BELOW(sym, obj, n) \
    do { uintptr_t p_; ADDR(p_, sym "-" #n); bad += p_ + n != (uintptr_t)(obj); } while (0)
int main(void) {
    BELOW("d", d, 32768);
    BELOW("d", d, 65536);
    BELOW("r", r, 32768);
    BELOW("r", r, 65536);
    BELOW("f", f, 32768);
    BELOW("f", f, 65536);
    return bad + (f() != 5) + (d[1] + r[1] != 6);
}
"#
}

/// A program whose fixed and variadic calls place stack arguments past the
/// scaled offsets of the outgoing area: a 3-byte aggregate above 4096, and
/// an 8-byte slot, a `double` and a 12-byte aggregate above 32768. The
/// region is filled with 16-byte aggregates, two eightbytes each, so the
/// far reaches take half the arguments a scalar fill would; eight leading
/// `double`s fill the FP argument registers. It exits 42 when both callees
/// receive every value.
// Used only by the release-only, aarch64 / macOS parity tests, so it is
// dead on a debug or linux-x64 test build.
#[allow(dead_code)]
pub fn far_stack_args_source() -> String {
    use core::fmt::Write;
    // 16-byte fillers before the t3 to put it past 4096, then on to past
    // 32768; both counts allow for the four fillers a fixed call's first
    // eight integer registers take before the stack, so the t3 and the
    // trailing scalars still clear the reach.
    const HEAD16: usize = 264;
    const TAIL16: usize = 1900;
    let mut params: Vec<String> = (0..8).map(|k| format!("double g{k}")).collect();
    let mut args: Vec<String> = (0..8).map(|k| format!("{k}.5")).collect();
    let mut body = String::new();
    for k in 0..8 {
        writeln!(body, "    h = mix(h, (unsigned long)(g{k} * 2.0));").unwrap();
    }
    for k in 0..HEAD16 + TAIL16 {
        if k == HEAD16 {
            params.push("struct t3 s".into());
            args.push("s".into());
            body.push_str("    h = mix(h, s.a); h = mix(h, s.b); h = mix(h, s.c);\n");
        }
        params.push(format!("struct t16 w{k}"));
        args.push(format!("v16({k})"));
        writeln!(body, "    h = mix(h, w{k}.a); h = mix(h, w{k}.b);").unwrap();
    }
    params.extend(
        [
            "unsigned long slot",
            "double f",
            "struct t12 m",
            "unsigned long last",
        ]
        .map(String::from),
    );
    args.extend([
        "val(90001)".into(),
        "gd + 0.25".into(),
        "m".into(),
        "val(90002)".into(),
    ]);
    let (params, args) = (params.join(", "), args.join(", "));
    format!(
        "#include <stdarg.h>
struct t3 {{ unsigned char a, b, c; }};
struct t12 {{ unsigned int a, b, c; }};
struct t16 {{ unsigned long a, b; }};
static double gd = 2.5;
static unsigned long mix(unsigned long h, unsigned long v) {{ return h * 1000003UL + v; }}
static unsigned long val(int k) {{ return (unsigned long)k * 0x9E3779B97F4A7C15UL + 17; }}
static struct t16 v16(int k) {{ struct t16 r = {{ val(2 * k), val(2 * k + 1) }}; return r; }}
__attribute__((noinline)) static unsigned long fixed_far({params}) {{
    unsigned long h = 0;
{body}    h = mix(h, slot);
    h = mix(h, (unsigned long)(f * 4.0));
    h = mix(h, m.a); h = mix(h, m.b); h = mix(h, m.c);
    return mix(h, last);
}}
__attribute__((noinline)) static unsigned long var_far(int n, ...) {{
    va_list ap;
    va_start(ap, n);
    unsigned long h = 0;
    for (int k = 0; k < 8; k++) h = mix(h, (unsigned long)(va_arg(ap, double) * 2.0));
    for (int k = 0; k < {HEAD16}; k++) {{
        struct t16 w = va_arg(ap, struct t16);
        h = mix(h, w.a); h = mix(h, w.b);
    }}
    struct t3 s = va_arg(ap, struct t3);
    h = mix(h, s.a); h = mix(h, s.b); h = mix(h, s.c);
    for (int k = 0; k < n; k++) {{
        struct t16 w = va_arg(ap, struct t16);
        h = mix(h, w.a); h = mix(h, w.b);
    }}
    h = mix(h, va_arg(ap, unsigned long));
    h = mix(h, (unsigned long)(va_arg(ap, double) * 4.0));
    struct t12 m = va_arg(ap, struct t12);
    h = mix(h, m.a); h = mix(h, m.b); h = mix(h, m.c);
    h = mix(h, va_arg(ap, unsigned long));
    va_end(ap);
    return h;
}}
int main(void) {{
    struct t3 s = {{0xA1, 0xB2, 0xC3}};
    struct t12 m = {{0x11111111u, 0x22222222u, 0x33333333u}};
    unsigned long want = 0;
    for (int k = 0; k < 8; k++) want = mix(want, 2 * k + 1);
    for (int k = 0; k < {HEAD16} + {TAIL16}; k++) {{
        if (k == {HEAD16}) {{ want = mix(want, 0xA1); want = mix(want, 0xB2); want = mix(want, 0xC3); }}
        want = mix(want, val(2 * k)); want = mix(want, val(2 * k + 1));
    }}
    want = mix(want, val(90001));
    want = mix(want, 11);
    want = mix(want, 0x11111111u); want = mix(want, 0x22222222u); want = mix(want, 0x33333333u);
    want = mix(want, val(90002));
    if (fixed_far({args}) != want) return 1;
    if (var_far({TAIL16}, {args}) != want) return 2;
    return 42;
}}
"
    )
}

/// Objects at 8 KiB and 16 KiB alignment in `.data`, `.bss`, a named
/// read-only section and the relro region, as the defining unit and the
/// checking one; the second holds a thread-local, whose template the
/// image places ahead of `.bss`. Its `main` returns a bitmask of the
/// misplaced objects, 128 for a wrong value. Concatenated, they form one
/// unit.
#[cfg(feature = "full")]
pub fn over_aligned_objects_units(target: crate::Target) -> (String, &'static str) {
    let section = match target.binary_format() {
        crate::BinaryFormat::Elf => ".rodata.overaligned",
        crate::BinaryFormat::Pe => ".rdovr",
        crate::BinaryFormat::MachO => "__DATA,__ovr",
    };
    let defs = format!(
        "_Alignas(8192) unsigned char d8[3] = {{1}};
_Alignas(16384) unsigned char d16[3] = {{2}};
_Alignas(8192) unsigned char b8[3];
_Alignas(16384) unsigned char b16[3];
_Alignas(8192) const unsigned char r8[3] __attribute__((section(\"{section}\"))) = {{3}};
_Alignas(16384) const unsigned char r16[3] __attribute__((section(\"{section}\"))) = {{4}};
_Alignas(16384) const char *const p16[2] = {{\"p\", \"q\"}};
"
    );
    let main = "#include <stdint.h>
extern unsigned char d8[], d16[], b8[], b16[];
extern const unsigned char r8[], r16[];
extern const char *const p16[];
static _Thread_local int tl = 5;
static int bad;
static void check(const void *p, uintptr_t align, int bit) {
    const void *volatile q = p;
    if ((uintptr_t)q % align)
        bad |= bit;
}
int main(void) {
    check(d8, 8192, 1);
    check(d16, 16384, 2);
    check(b8, 8192, 4);
    check(b16, 16384, 8);
    check(r8, 8192, 16);
    check(r16, 16384, 32);
    check(p16, 16384, 64);
    if (d8[0] + d16[0] + b8[0] + b16[0] + r8[0] + r16[0] + tl != 15 || p16[1][0] != 'q')
        bad |= 128;
    return bad;
}
";
    (defs, main)
}

/// Compile inline source.
pub fn compile_str(src: &str) -> Program {
    Compiler::new(with_prelude(src)).compile().unwrap()
}

/// Compile inline source WITHOUT the standard prelude. Used by the
/// codegen tests that assert byte-for-byte equality on the emitted
/// native code -- those tests can't tolerate the lazy-stream helper
/// (or any future prelude-only function) appearing in the output.
pub fn compile_str_bare(src: &str) -> Program {
    Compiler::new(src.to_string()).compile().unwrap()
}

/// `compile_str_bare` with an explicit target, for sources whose asm
/// constraints only parse for that target's family.
pub fn compile_str_bare_for(src: &str, target: crate::Target) -> Program {
    Compiler::with_target(src.to_string(), target)
        .compile()
        .unwrap()
}

/// Link a compiled program against the embedded startup runtime into
/// a complete, runnable native image, mirroring the CLI's native path
/// (`emit_native` -> relocatable objects -> `link_native_objects` ->
/// `write_native_image_from_merged`). The entry stub's `__c5_*`
/// helpers are defined by the runtime, so the produced executable is
/// self-sufficient. `subsystem` (from `program.subsystem`) gates the
/// runtime's console vs GUI startup helpers on Windows.
///
/// `program` must have been compiled for `target`. `compile_str` /
/// `compile_fixture` use `Compiler::new`, which targets the host, so a
/// test that links for a fixed non-host target (e.g. always
/// `Target::LinuxX64`) must compile for that target -- via
/// `Compiler::with_options(..., target, ..)` -- or use a prelude-free
/// source (`compile_str_bare`). A host/target skew preprocesses the
/// bundled headers under the wrong OS macros: on a Windows host the
/// `<stdlib.h>` `_WIN32` branch then contributes an `environ` symbol
/// that collides with the runtime's when the image is emitted as ELF.
#[cfg(feature = "full")]
pub fn link_executable_with_runtime(
    program: &Program,
    target: crate::Target,
    opts: crate::NativeOptions,
) -> Result<Vec<u8>, String> {
    link_executable_with_runtime_as(program, target, opts, crate::ExecForm::Pie)
}

/// [`link_executable_with_runtime`] for an executable of `form`.
#[cfg(feature = "full")]
pub fn link_executable_with_runtime_as(
    program: &Program,
    target: crate::Target,
    opts: crate::NativeOptions,
    form: crate::ExecForm,
) -> Result<Vec<u8>, String> {
    use crate::{
        CompileOptions, ImageOptions, OutputKind, embedded_runtime, emit_native_with_options,
        link_native_objects, parse_native_elf, write_native_image_from_merged_ex,
    };
    let mut reloc = opts;
    reloc.output_kind = OutputKind::Relocatable;

    let mut objs = Vec::new();
    let prog_bytes = emit_native_with_options(program, target, reloc.clone())
        .map_err(|e| format!("emit program object: {e}"))?;
    objs.push(parse_native_elf(&prog_bytes).map_err(|e| format!("parse program object: {e}"))?);

    // This helper always builds a hosted executable, so the runtime's
    // CRT and startup sections are both compiled in.
    // The entry shape follows the entry symbol: `__BADC_WIN_WINMAIN__`
    // for a `WinMain` entry, `__BADC_WIN_WIDE__` for `wmain`, else `main`
    // with argc/argv -- independent of the PE subsystem.
    let mut rt_defines: Vec<(String, String)> = vec![
        ("__BADC_C5_CRT__".to_string(), "1".to_string()),
        ("__BADC_C5_START__".to_string(), "1".to_string()),
    ];
    rt_defines.push((
        "__BADC_ENTRY__".to_string(),
        program
            .entry_name
            .clone()
            .unwrap_or_else(|| "main".to_string()),
    ));
    match program.entry_name.as_deref() {
        Some("WinMain") => rt_defines.push(("__BADC_WIN_WINMAIN__".to_string(), "1".to_string())),
        Some("wWinMain") => {
            rt_defines.push(("__BADC_WIN_WINMAIN__".to_string(), "1".to_string()));
            rt_defines.push(("__BADC_WIN_WIDE__".to_string(), "1".to_string()));
        }
        Some("wmain") => rt_defines.push(("__BADC_WIN_WIDE__".to_string(), "1".to_string())),
        _ => {}
    }
    for (name, body) in embedded_runtime().iter() {
        let copts = CompileOptions::default()
            .with_no_entry_point(true)
            .with_defines(rt_defines.clone());
        let rt_program = Compiler::with_options(body.to_string(), target, copts)
            .compile()
            .map_err(|e| format!("compile runtime {name}: {e}"))?;
        let rt_bytes = emit_native_with_options(&rt_program, target, reloc.clone())
            .map_err(|e| format!("emit runtime {name}: {e}"))?;
        objs.push(parse_native_elf(&rt_bytes).map_err(|e| format!("parse runtime {name}: {e}"))?);
    }

    append_on_demand_objects(&mut objs, target, reloc)?;

    let mut merged = link_native_objects(&objs).map_err(|e| format!("link: {e}"))?;
    let plt =
        crate::emit_plt_for(&mut merged, target, form.placed()).map_err(|e| format!("plt: {e}"))?;
    let entry_name = program.entry_name.as_deref().unwrap_or("main");
    write_native_image_from_merged_ex(
        &merged,
        &plt,
        entry_name,
        program.subsystem,
        OutputKind::Executable,
        target,
        None,
        &ImageOptions {
            exec_form: form,
            ..ImageOptions::default()
        },
    )
    .map_err(|e| format!("write image: {e}"))
}

/// Offer the compiler-runtime and C-library sources the way the CLI's
/// link does: each joins only when it defines a symbol the object set
/// still leaves undefined. Nothing is compiled when nothing is
/// undefined, which is the usual case for a fixture.
#[cfg(feature = "full")]
fn append_on_demand_objects(
    objs: &mut Vec<crate::NativeObject>,
    target: crate::Target,
    reloc: crate::NativeOptions,
) -> Result<(), String> {
    use crate::{
        CompileOptions, NativeSymSection, embedded_compiler_rt, embedded_libc,
        emit_native_with_options, parse_native_elf,
    };
    let unresolved = |objs: &[crate::NativeObject]| {
        let mut defined = alloc::collections::BTreeSet::new();
        let mut undefined = alloc::collections::BTreeSet::new();
        for o in objs {
            for s in &o.symbols {
                if s.binding == 0 {
                    continue;
                }
                if s.section == NativeSymSection::Undef {
                    if s.binding == 1 && !defined.contains(&s.name) {
                        undefined.insert(s.name.clone());
                    }
                } else {
                    defined.insert(s.name.clone());
                    undefined.remove(&s.name);
                }
            }
        }
        undefined
    };
    if unresolved(objs).is_empty() {
        return Ok(());
    }
    let mut pool = Vec::new();
    for (name, body) in embedded_compiler_rt().iter().chain(embedded_libc().iter()) {
        let copts = CompileOptions::default().with_no_entry_point(true);
        let p = Compiler::with_options(body.to_string(), target, copts)
            .compile()
            .map_err(|e| format!("compile {name}: {e}"))?;
        let bytes = emit_native_with_options(&p, target, reloc.clone())
            .map_err(|e| format!("emit {name}: {e}"))?;
        pool.push(Some(
            parse_native_elf(&bytes).map_err(|e| format!("parse {name}: {e}"))?,
        ));
    }
    loop {
        let undefined = unresolved(objs);
        let mut progress = false;
        for slot in pool.iter_mut() {
            let wanted = slot.as_ref().is_some_and(|o| {
                o.symbols.iter().any(|s| {
                    s.binding == 1
                        && !matches!(s.section, NativeSymSection::Undef | NativeSymSection::Abs)
                        && undefined.contains(&s.name)
                })
            });
            if wanted {
                objs.push(slot.take().expect("a wanted slot is occupied"));
                progress = true;
            }
        }
        if !progress {
            return Ok(());
        }
    }
}

/// Link one translation unit into a shared library, the way the CLI's
/// `--shared` does: no startup runtime, and an unresolved global becomes
/// a load-time import the host supplies.
#[cfg(feature = "full")]
#[allow(dead_code)] // used by the feature-gated shared-library tests
pub fn link_shared_library(
    program: &Program,
    target: crate::Target,
    opts: crate::NativeOptions,
) -> Result<Vec<u8>, String> {
    use crate::{
        OutputKind, emit_native_with_options, link_native_objects_with_options, parse_native_elf,
        write_native_image_from_merged,
    };
    let mut reloc = opts;
    reloc.output_kind = OutputKind::Relocatable;
    let bytes = emit_native_with_options(program, target, reloc)
        .map_err(|e| format!("emit program object: {e}"))?;
    let obj = parse_native_elf(&bytes).map_err(|e| format!("parse program object: {e}"))?;
    let mut merged =
        link_native_objects_with_options(&[obj], true).map_err(|e| format!("link: {e}"))?;
    let plt = crate::emit_plt_for(&mut merged, target, false).map_err(|e| format!("plt: {e}"))?;
    write_native_image_from_merged(
        &merged,
        &plt,
        program.entry_name.as_deref().unwrap_or("main"),
        program.subsystem,
        OutputKind::SharedLibrary,
        target,
        Some("libbadctest"),
    )
    .map_err(|e| format!("write image: {e}"))
}

/// Like [`link_executable_with_runtime`] but links several user
/// translation units into one image, mirroring a multi-`.o` CLI link.
/// `programs[0]` carries the entry point and subsystem. Used to exercise
/// cross-unit references the single-program helper can't, e.g. an
/// `extern _Thread_local` defined in one unit and read from another.
#[cfg(feature = "full")]
pub fn link_executable_with_runtime_multi(
    programs: &[&Program],
    target: crate::Target,
    opts: crate::NativeOptions,
) -> Result<Vec<u8>, String> {
    use crate::{
        CompileOptions, OutputKind, embedded_runtime, emit_native_with_options,
        link_native_objects, parse_native_elf, write_native_image_from_merged,
    };
    let entry = programs[0];
    let mut reloc = opts;
    reloc.output_kind = OutputKind::Relocatable;

    // Match the CLI's object order (the runtime precedes user inputs); the
    // PLT pass numbers trampolines in object order, so the order must be
    // stable across linkers.
    let mut objs = Vec::new();
    let mut rt_defines: Vec<(String, String)> = vec![
        ("__BADC_C5_CRT__".to_string(), "1".to_string()),
        ("__BADC_C5_START__".to_string(), "1".to_string()),
    ];
    rt_defines.push((
        "__BADC_ENTRY__".to_string(),
        entry
            .entry_name
            .clone()
            .unwrap_or_else(|| "main".to_string()),
    ));
    if entry.subsystem == Some(crate::Subsystem::Windows) {
        rt_defines.push(("__BADC_WIN_GUI__".to_string(), "1".to_string()));
    }
    if entry.entry_name.as_deref() == Some("wmain") {
        rt_defines.push(("__BADC_WIN_WIDE__".to_string(), "1".to_string()));
    }
    for (name, body) in embedded_runtime().iter() {
        let copts = CompileOptions::default()
            .with_no_entry_point(true)
            .with_defines(rt_defines.clone());
        let rt_program = Compiler::with_options(body.to_string(), target, copts)
            .compile()
            .map_err(|e| format!("compile runtime {name}: {e}"))?;
        let rt_bytes = emit_native_with_options(&rt_program, target, reloc.clone())
            .map_err(|e| format!("emit runtime {name}: {e}"))?;
        objs.push(parse_native_elf(&rt_bytes).map_err(|e| format!("parse runtime {name}: {e}"))?);
    }

    for (i, program) in programs.iter().enumerate() {
        let bytes = emit_native_with_options(program, target, reloc.clone())
            .map_err(|e| format!("emit user object {i}: {e}"))?;
        objs.push(parse_native_elf(&bytes).map_err(|e| format!("parse user object {i}: {e}"))?);
    }

    let mut merged = link_native_objects(&objs).map_err(|e| format!("link: {e}"))?;
    let plt = crate::emit_plt_for(&mut merged, target, false).map_err(|e| format!("plt: {e}"))?;
    let entry_name = entry.entry_name.as_deref().unwrap_or("main");
    write_native_image_from_merged(
        &merged,
        &plt,
        entry_name,
        entry.subsystem,
        OutputKind::Executable,
        target,
        None,
    )
    .map_err(|e| format!("write image: {e}"))
}

/// Link a program that supplies its own `__c5_entry` into a
/// freestanding executable: the embedded runtime is not linked and the
/// image entry is `__c5_entry`. Mirrors the CLI path when an input
/// object defines `__c5_entry`.
#[cfg(feature = "full")]
pub fn link_freestanding(
    program: &Program,
    target: crate::Target,
    opts: crate::NativeOptions,
) -> Result<Vec<u8>, String> {
    use crate::{
        OutputKind, emit_native_with_options, link_native_objects, parse_native_elf,
        write_native_image_from_merged,
    };
    let mut reloc = opts;
    reloc.output_kind = OutputKind::Relocatable;
    let prog_bytes = emit_native_with_options(program, target, reloc)
        .map_err(|e| format!("emit program object: {e}"))?;
    let objs = vec![parse_native_elf(&prog_bytes).map_err(|e| format!("parse: {e}"))?];
    let mut merged = link_native_objects(&objs).map_err(|e| format!("link: {e}"))?;
    let plt = crate::emit_plt_for(&mut merged, target, false).map_err(|e| format!("plt: {e}"))?;
    write_native_image_from_merged(
        &merged,
        &plt,
        "__c5_entry",
        program.subsystem,
        OutputKind::Executable,
        target,
        None,
    )
    .map_err(|e| format!("write image: {e}"))
}

/// Compile a fixture with the standard prelude.
pub fn compile_fixture(name: &str) -> Program {
    compile_str(&load_fixture(name))
}

/// The diagnostic levels `selectors` -- group names, diagnostic names,
/// aliases or `B` codes -- leave behind, as the matching `-W` options
/// would.
pub fn diag_config(selectors: &[&str]) -> crate::diag::Config {
    let mut config = crate::diag::Config::new();
    for sel in selectors {
        match crate::diag::Selector::parse(sel).expect("a catalogue selector") {
            crate::diag::Selector::Group(g) => config.enable_group(g),
            sel => {
                for c in sel.codes() {
                    config.set_level(c, crate::diag::Level::Warning);
                }
            }
        }
    }
    config
}

/// Compile inline source with the standard prelude and `selectors`
/// enabled, for the rows a group turns on rather than the default set.
pub fn compile_str_with_diags(src: &str, selectors: &[&str]) -> Program {
    compile_source_with_diags(with_prelude(src), selectors)
}

/// [`compile_str_with_diags`] without the standard prelude.
pub fn compile_str_bare_with_diags(src: &str, selectors: &[&str]) -> Program {
    compile_source_with_diags(src.to_string(), selectors)
}

/// [`compile_fixture`] with `selectors` enabled.
pub fn compile_fixture_with_diags(name: &str, selectors: &[&str]) -> Program {
    compile_str_with_diags(&load_fixture(name), selectors)
}

fn compile_source_with_diags(source: String, selectors: &[&str]) -> Program {
    Compiler::with_options(
        source,
        crate::Target::default_target(),
        crate::CompileOptions::default().with_diag(diag_config(selectors)),
    )
    .compile()
    .unwrap()
}

/// Compile a fixture WITHOUT the standard prelude.
pub fn compile_fixture_bare(name: &str) -> Program {
    compile_str_bare(&load_fixture(name))
}

/// Compile + run inline source. Pointer tracking is on by default so the
/// test suite catches use-after-free / double-free / OOB regressions for
/// free; tests that need to inspect a deliberate failure use
/// [`try_run_fixture`] instead.
pub fn run_str(src: &str) -> i64 {
    Vm::new(compile_str(src))
        .with_pointer_tracking()
        .run()
        .unwrap()
}

/// [`run_str`] for an explicit target, whose assembler syntax an inline
/// asm template is written in.
pub fn run_str_for(src: &str, target: crate::Target) -> i64 {
    let program = Compiler::with_options(with_prelude(src), target, Default::default())
        .compile()
        .unwrap();
    Vm::new(program).with_pointer_tracking().run().unwrap()
}

/// Compile + run a fixture.
pub fn run_fixture(name: &str) -> i64 {
    run_str(&load_fixture(name))
}

/// [`run_fixture`] for an explicit target. The interpreter reads the
/// target's type widths, so a fixture whose result turns on the data
/// model runs for LP64 and LLP64 alike from any host.
pub fn run_fixture_for(name: &str, target: crate::Target) -> i64 {
    run_fixture_with(name, target, crate::CompileOptions::default())
}

/// [`run_fixture_for`] with compile options, such as `-D` definitions.
pub fn run_fixture_with(name: &str, target: crate::Target, opts: crate::CompileOptions) -> i64 {
    let context = format!("{name} for {target:?} with {:?}", opts.defines);
    let program = Compiler::with_options(with_prelude(&load_fixture(name)), target, opts)
        .compile()
        .unwrap_or_else(|e| panic!("{context}: {e:?}"));
    Vm::new(program)
        .with_pointer_tracking()
        .run()
        .unwrap_or_else(|e| panic!("{context}: {e:?}"))
}

/// Compile + run a fixture with `args` exposed to `main(int argc, char **argv)`.
pub fn run_fixture_with_args<I, S>(name: &str, args: I) -> i64
where
    I: IntoIterator<Item = S>,
    S: Into<String>,
{
    let program = compile_fixture(name);
    Vm::new(program)
        .with_pointer_tracking()
        .with_args(args)
        .run()
        .unwrap()
}

/// Compile + run a fixture and return the raw `Result` so callers can
/// assert on either the exit code (no error) or the diagnostic message
/// (use-after-free / double-free / OOB). Pointer tracking is on, same as
/// the unwrapping helpers above.
pub fn try_run_fixture(name: &str) -> Result<i64, C5Error> {
    let program = compile_fixture(name);
    Vm::new(program).with_pointer_tracking().run()
}

/// Tiny harness that owns the `Lexer`, its symbol table, and the data
/// segment so lexer tests can step through tokens with one call. The symbol
/// table is pre-seeded with C keywords (so identifiers like `int` come back
/// as `Token::Int`, not `Token::Id`).
pub struct LexHarness {
    lex: Lexer,
    pub symbols: Vec<Symbol>,
    pub symbol_index: lex_helpers::SymbolIndex,
    pub data: Vec<u8>,
}

impl LexHarness {
    pub fn new(src: &str) -> Self {
        let mut symbols = Vec::new();
        let mut symbol_index = lex_helpers::SymbolIndex::new();
        // Lexer tests don't reach for `#pragma binding`s, so the
        // dynamic-binding seed is empty -- only keywords get
        // registered. Tests that want libc names should add their
        // own `Symbol` entries directly.
        lex_helpers::init_symbols(&mut symbols, &mut symbol_index, &[]);
        Self {
            lex: Lexer::new(src.to_string()),
            symbols,
            symbol_index,
            data: Vec::new(),
        }
    }

    /// Advance one token and return it as a [`Tok`]. Callers compare
    /// directly against `Token::X`, ASCII byte literals (`'('`,
    /// `';'`, ...), or bare `i64` thanks to the `PartialEq` impls on
    /// [`Tok`] -- no `as i64` cast at the call site.
    pub fn next(&mut self) -> Tok {
        self.lex
            .next(&mut self.symbols, &mut self.symbol_index, &mut self.data)
            .expect("lexer error");
        self.lex.tk
    }

    pub fn ival(&self) -> i64 {
        self.lex.ival
    }
    /// `(l_count, unsigned)` suffix record of the most recently lexed
    /// integer literal.
    pub fn int_suffix(&self) -> (u8, bool) {
        (self.lex.int_suffix_long, self.lex.int_suffix_unsigned)
    }
    pub fn line(&self) -> usize {
        self.lex.line
    }
    /// Name of the most recently lexed identifier.
    pub fn name(&self) -> &str {
        &self.symbols[self.lex.curr_id_idx].name
    }
}
