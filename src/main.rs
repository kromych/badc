mod cli;

fn main() {
    restore_sigpipe();
    // Run the driver on a thread with an explicit stack reservation:
    // the parser bounds nesting with a diagnostic, but a debug build
    // would overflow the platform-default stack before reaching the
    // bound.
    let driver = std::thread::Builder::new()
        .stack_size(cli::DRIVER_STACK_SIZE)
        .spawn(cli::run)
        .expect("spawn driver thread");
    if let Err(e) = driver.join() {
        std::panic::resume_unwind(e);
    }
}

/// A write to a closed pipe ends the process by `SIGPIPE`, as it ends a C
/// program; the Rust runtime ignores the signal before `main`, which turns
/// each such write into an error.
#[cfg(unix)]
fn restore_sigpipe() {
    unsafe extern "C" {
        fn signal(sig: i32, handler: usize) -> usize;
    }
    const SIGPIPE: i32 = 13;
    const SIG_DFL: usize = 0;
    // SAFETY: installs the default disposition before any thread starts.
    unsafe {
        signal(SIGPIPE, SIG_DFL);
    }
}

#[cfg(not(unix))]
fn restore_sigpipe() {}
