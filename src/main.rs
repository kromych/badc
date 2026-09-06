mod cli;

fn main() {
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
