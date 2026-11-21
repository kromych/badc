//! Compile C source in-process, map it with the JIT, and call into it.
//!
//!     cargo run --example jit_symbols
//!
//! The library's default features suffice: the source includes no header,
//! and the program has no `main`. `jit_load` runs its constructors, and
//! dropping the module runs its destructors.

use badc::{CompileOptions, Compiler, JitModule, NativeOptions, Target, jit_load};

const SOURCE: &str = "
    double scale = 1.0;
    long calls;

    double weighted_sum(const double *v, int n) {
        double s = 0;
        for (int i = 0; i < n; i++)
            s += v[i] * scale;
        calls++;
        return s;
    }

    __attribute__((constructor)) static void init(void) { scale = 2.0; }
";

fn load() -> Result<JitModule, badc::C5Error> {
    let front = CompileOptions::default().with_no_entry_point(true);
    let program = Compiler::with_options(SOURCE.into(), Target::host(), front).compile()?;
    jit_load(&program, NativeOptions::default(), &mut |d| {
        eprintln!("{d}")
    })
}

fn main() {
    let module = match load() {
        Ok(m) => m,
        Err(e) => {
            eprintln!("{e}");
            std::process::exit(1);
        }
    };
    for (name, addr) in module.symbols() {
        println!("{name:>14} at {addr:p}");
    }
    println!("{} bytes of code", module.code().len());

    let sum = module.symbol("weighted_sum").expect("defined");
    // SAFETY: the C definition has this signature under the host's C ABI.
    let sum: extern "C" fn(*const f64, i32) -> f64 = unsafe { std::mem::transmute(sum) };
    let v = [1.0, 2.0, 3.5];
    println!("weighted_sum = {}", sum(v.as_ptr(), v.len() as i32));

    let scale = module.symbol("scale").expect("defined") as *mut f64;
    // SAFETY: `scale` is a `double` the module defines and nothing else writes.
    unsafe { scale.write(10.0) };
    println!("weighted_sum = {}", sum(v.as_ptr(), v.len() as i32));

    let calls = module.symbol("calls").expect("defined") as *const i64;
    // SAFETY: `calls` is a `long`, 64 bits on every JIT host but Windows,
    // where it is 32 and its other half is padding the program never writes.
    println!("calls = {}", unsafe { calls.read() } as i32);
}
