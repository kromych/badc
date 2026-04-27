//! Tiny bench harness for badc's execution pipelines. Runs a few
//! workloads through the VM, the optimized VM, and the in-process
//! JIT, and reports wall-clock timings so successive commits have a
//! number to point at.
//!
//! Run from the repo root:
//!
//!     cargo run --release --example bench
//!     cargo run --release --example bench -- --iter 10
//!     cargo run --release --example bench -- fib       # just fib
//!
//! Each workload is compiled once per pipeline (compile time isn't
//! the thing we're optimizing) and then run `iter` times; we report
//! min / median / mean of the run-time samples.
//!
//! Stdout from the JIT'd program would interleave with our own
//! output, so the workloads here are pure computation -- no printf,
//! no syscalls. The c4 self-host is excluded for the same reason;
//! for that path use `cargo test --lib c4::tests::jit::original_c4`
//! which runs under cargo's stdout-capture.

use std::time::{Duration, Instant};

use badc::{Compiler, NativeOptions, Program, Vm, jit_run_with_options, optimize};

/// One pipeline = one column in the output table.
struct Pipeline {
    label: &'static str,
    /// Whether `jit_run` is supported on this host. The bench skips
    /// JIT pipelines on hosts that don't support it (Windows, old
    /// macOS Intel, ...) instead of crashing.
    needs_jit: bool,
    run: fn(&Program, &[String]) -> i32,
}

const PIPELINES: &[Pipeline] = &[
    Pipeline {
        label: "vm",
        needs_jit: false,
        run: run_vm,
    },
    Pipeline {
        label: "vm-O",
        needs_jit: false,
        run: run_vm,
    },
    Pipeline {
        label: "jit",
        needs_jit: true,
        run: run_jit,
    },
    Pipeline {
        label: "jit-O",
        needs_jit: true,
        run: run_jit,
    },
    Pipeline {
        label: "jit-N",
        needs_jit: true,
        run: run_jit_native_optimized,
    },
    Pipeline {
        label: "jit-ON",
        needs_jit: true,
        run: run_jit_native_optimized,
    },
];

/// VM run. Pre-cloned by `measure` so the timed region excludes
/// the program clone.
fn run_vm(program: &Program, args: &[String]) -> i32 {
    Vm::new(program.clone())
        .with_args(args.iter().cloned())
        .run()
        .expect("vm run") as i32
}

/// JIT run with default (no register pool) options.
fn run_jit(program: &Program, args: &[String]) -> i32 {
    jit_run_with_options(program, args, NativeOptions::default()).expect("jit run")
}

/// JIT run with `--native-optimize` (register pool on).
fn run_jit_native_optimized(program: &Program, args: &[String]) -> i32 {
    jit_run_with_options(program, args, NativeOptions::new().with_register_alloc())
        .expect("jit run")
}

/// Inline workloads. Each is a (name, source, argv, expected exit)
/// tuple. The expected exit is asserted so a regression that breaks
/// correctness shows up as a panic, not a silently-wrong number.
struct Workload {
    name: &'static str,
    source: &'static str,
    args: &'static [&'static str],
    expected: i32,
}

const WORKLOADS: &[Workload] = &[
    Workload {
        name: "fib32",
        // fib(32) = 2_178_309. Returned mod 256 (low 8 bits = 5).
        // Recursion-heavy, no memory allocation, no syscalls.
        source: r#"
            int fib(int n) {
                if (n < 2) return n;
                return fib(n - 1) + fib(n - 2);
            }
            int main() {
                int x;
                x = fib(32);
                return x & 255;
            }
        "#,
        args: &["fib32"],
        expected: 5, // 2178309 & 0xff = 5
    },
    Workload {
        name: "quicksort-50k",
        // Sort 50_000 LCG-generated ints. Memory access + comparisons
        // + recursion. No printf, no syscall load.
        source: r#"
            void swap(int *a, int *b) {
                int t;
                t = *a; *a = *b; *b = t;
            }

            int partition(int *arr, int low, int high) {
                int pivot;
                int i;
                int j;
                pivot = arr[high];
                i = low - 1;
                j = low;
                while (j < high) {
                    if (arr[j] <= pivot) {
                        i = i + 1;
                        swap(&arr[i], &arr[j]);
                    }
                    j = j + 1;
                }
                swap(&arr[i + 1], &arr[high]);
                return i + 1;
            }

            void quicksort(int *arr, int low, int high) {
                int pi;
                if (low < high) {
                    pi = partition(arr, low, high);
                    quicksort(arr, low, pi - 1);
                    quicksort(arr, pi + 1, high);
                }
            }

            int main() {
                int *arr;
                int n;
                int i;
                int seed;
                n = 50000;
                arr = malloc(n * sizeof(int));
                seed = 12345;
                i = 0;
                while (i < n) {
                    seed = seed * 1103515245 + 12345;
                    arr[i] = (seed / 65536) & 32767;
                    i = i + 1;
                }
                quicksort(arr, 0, n - 1);
                i = 1;
                while (i < n) {
                    if (arr[i - 1] > arr[i]) return 1;
                    i = i + 1;
                }
                return 0;
            }
        "#,
        args: &["quicksort-50k"],
        expected: 0,
    },
    Workload {
        name: "matmul-50",
        // 50x50 matrix multiplication, three nested loops, ~125k
        // multiplies. Tight numeric kernel.
        source: r#"
            int main() {
                int *a;
                int *b;
                int *c;
                int n;
                int i;
                int j;
                int k;
                int sum;
                n = 50;
                a = malloc(n * n * sizeof(int));
                b = malloc(n * n * sizeof(int));
                c = malloc(n * n * sizeof(int));
                i = 0;
                while (i < n * n) {
                    a[i] = (i * 13) & 255;
                    b[i] = (i * 7) & 255;
                    c[i] = 0;
                    i = i + 1;
                }
                i = 0;
                while (i < n) {
                    j = 0;
                    while (j < n) {
                        sum = 0;
                        k = 0;
                        while (k < n) {
                            sum = sum + a[i * n + k] * b[k * n + j];
                            k = k + 1;
                        }
                        c[i * n + j] = sum;
                        j = j + 1;
                    }
                    i = i + 1;
                }
                // Return c[0] & 255 as a result-fingerprint.
                return c[0] & 255;
            }
        "#,
        args: &["matmul-50"],
        // Computed by running the workload through the VM at bench
        // bring-up time. If the lowering breaks in a way that
        // changes the result, the panic point makes the regression
        // easy to find.
        expected: 54,
    },
];

fn measure(pipeline: &Pipeline, program: &Program, args: &[String], iter: usize) -> Vec<Duration> {
    // VM and VM-O pre-prepare so the timed region is execution
    // only. JIT pipelines call jit_run inside the timed region,
    // which includes lowering + mmap + dlsym -- realistic per-run
    // overhead. For long-running workloads (>1ms) this asymmetry
    // is well under the run-to-run noise, but it's worth flagging
    // when comparing across pipelines.
    let argv: Vec<String> = args.to_vec();
    let prepared: Program = match pipeline.label {
        // Pipelines whose label implies the bytecode optimizer ran first.
        "vm-O" | "jit-O" | "jit-ON" => optimize(program.clone()).expect("optimize"),
        _ => program.clone(),
    };
    let mut samples = Vec::with_capacity(iter);
    for _ in 0..iter {
        let t = Instant::now();
        let _ = (pipeline.run)(&prepared, &argv);
        samples.push(t.elapsed());
    }
    samples
}

fn min(samples: &[Duration]) -> Duration {
    *samples.iter().min().unwrap()
}

fn median(samples: &[Duration]) -> Duration {
    let mut s = samples.to_vec();
    s.sort();
    s[s.len() / 2]
}

fn mean(samples: &[Duration]) -> Duration {
    let total: Duration = samples.iter().sum();
    total / samples.len() as u32
}

fn fmt_dur(d: Duration) -> String {
    let ms = d.as_secs_f64() * 1000.0;
    if ms >= 1000.0 {
        format!("{:>8.2}s ", ms / 1000.0)
    } else if ms >= 1.0 {
        format!("{ms:>8.2}ms")
    } else {
        format!("{:>8.2}us", ms * 1000.0)
    }
}

fn jit_supported() -> bool {
    cfg!(any(
        all(target_os = "linux", target_arch = "aarch64"),
        all(target_os = "linux", target_arch = "x86_64"),
        all(target_os = "macos", target_arch = "aarch64"),
    ))
}

fn parse_argv() -> (usize, Vec<String>) {
    let mut iter = 5usize;
    let mut filters: Vec<String> = Vec::new();
    let raw: Vec<String> = std::env::args().skip(1).collect();
    let mut it = raw.into_iter();
    while let Some(a) = it.next() {
        match a.as_str() {
            "--iter" => {
                iter = it
                    .next()
                    .and_then(|n| n.parse().ok())
                    .expect("--iter wants an integer");
            }
            "-h" | "--help" => {
                eprintln!("usage: bench [--iter N] [workload-name...]");
                eprintln!("workloads: fib32, quicksort-50k, matmul-50");
                std::process::exit(0);
            }
            other => filters.push(other.to_string()),
        }
    }
    (iter, filters)
}

fn main() {
    let (iter, filters) = parse_argv();
    let host_jit = jit_supported();

    println!(
        "host: {} {}, jit={}, iter={}",
        std::env::consts::OS,
        std::env::consts::ARCH,
        host_jit,
        iter,
    );

    let active: Vec<&Pipeline> = PIPELINES
        .iter()
        .filter(|p| !p.needs_jit || host_jit)
        .collect();

    // Header.
    print!("{:<18}{:<8}", "workload", "stat");
    for p in &active {
        print!(" {:>10}", p.label);
    }
    println!();

    for w in WORKLOADS {
        if !filters.is_empty() && !filters.iter().any(|f| w.name.contains(f)) {
            continue;
        }
        let program = Compiler::new(w.source.to_string())
            .compile()
            .expect("compile workload");
        let args: Vec<String> = w.args.iter().map(|s| s.to_string()).collect();

        // Sanity-check exit code once before we time anything. If
        // any pipeline disagrees, the timings would be measuring
        // unrelated work.
        let exit_vm = run_vm(&program, &args);
        assert_eq!(
            exit_vm, w.expected,
            "{}: vm exit {} != expected {}",
            w.name, exit_vm, w.expected
        );

        // Take the iter samples once per pipeline, then print
        // min/median/mean from those same samples (rather than
        // re-running the workload three times for three stats).
        let mut by_pipeline: Vec<Vec<Duration>> = Vec::new();
        for p in &active {
            by_pipeline.push(measure(p, &program, &args, iter));
        }

        for (label, f) in [
            ("min", min as fn(&[Duration]) -> Duration),
            ("median", median),
            ("mean", mean),
        ] {
            print!(
                "{:<18}{:<8}",
                if label == "min" { w.name } else { "" },
                label,
            );
            for samples in &by_pipeline {
                print!(" {}", fmt_dur(f(samples)));
            }
            println!();
        }
    }
}
