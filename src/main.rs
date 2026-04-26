use c4rs::{Compiler, PredefinedKind, Vm, optimize, predefined_symbols};

const USAGE: &str =
    "usage: c4rs [--track-pointers] [--trace] [--list-symbols] [--optimize|-O] <file> [args...]";

fn main() {
    let raw: Vec<String> = std::env::args().collect();

    // Strip leading flags (in any order, anywhere before the source file)
    // so the remaining argv looks like `c4rs <file> [args...]`.
    let mut track_pointers = false;
    let mut trace = false;
    let mut list_symbols = false;
    let mut optimize_flag = false;
    let args: Vec<String> = raw
        .into_iter()
        .filter(|a| match a.as_str() {
            "--track-pointers" => {
                track_pointers = true;
                false
            }
            "--trace" => {
                trace = true;
                false
            }
            "--list-symbols" => {
                list_symbols = true;
                false
            }
            "--optimize" | "-O" => {
                optimize_flag = true;
                false
            }
            _ => true,
        })
        .collect();

    if list_symbols {
        print_predefined_symbols();
        return;
    }

    if args.len() < 2 {
        eprintln!("{USAGE}");
        std::process::exit(1);
    }

    let path = &args[1];
    let mut file = std::fs::File::open(path).expect("Could not open file");
    let mut contents = String::new();
    std::io::Read::read_to_string(&mut file, &mut contents).expect("Could not read file");

    let program = match Compiler::new(contents).compile() {
        Ok(p) => p,
        Err(e) => {
            eprintln!("{}", e);
            std::process::exit(1);
        }
    };

    let program = if optimize_flag {
        match optimize(program) {
            Ok(p) => p,
            Err(e) => {
                eprintln!("{}", e);
                std::process::exit(1);
            }
        }
    } else {
        program
    };

    // Type-mismatch and arity warnings (if any) — print once, before
    // the program runs. They never fail the compile, but they do go to
    // stderr so a `2>/dev/null` user can suppress.
    for w in &program.warnings {
        eprintln!("{w}");
    }

    // Pass everything from argv[1] onward to the C program — argv[0] of the
    // hosted program is the source file name, argv[1..] are its own args.
    let c_args: Vec<String> = args[1..].to_vec();

    let mut vm = Vm::new(program).with_args(c_args);
    if track_pointers {
        vm = vm.with_pointer_tracking();
    }
    if trace {
        vm = vm.with_trace();
    }

    match vm.run() {
        Ok(res) => println!("exit({})", res),
        Err(e) => {
            eprintln!("{}", e);
            std::process::exit(1);
        }
    }
}

/// Print every name the compiler pre-binds before parsing — keywords,
/// library functions, and integer constants — grouped by kind. Useful
/// for scripting (`c4rs --list-symbols | grep PROT_`) and for spotting
/// what's available without `#include`.
fn print_predefined_symbols() {
    let symbols = predefined_symbols();

    let mut names: Vec<&str> = symbols
        .iter()
        .filter(|s| s.kind == PredefinedKind::Keyword)
        .map(|s| s.name)
        .collect();
    names.sort_unstable();
    println!("Keywords:");
    for name in names {
        println!("  {name}");
    }

    let mut names: Vec<&str> = symbols
        .iter()
        .filter(|s| s.kind == PredefinedKind::Syscall)
        .map(|s| s.name)
        .collect();
    names.sort_unstable();
    println!("\nLibrary calls:");
    for name in names {
        println!("  {name}");
    }

    let mut consts: Vec<(&str, i64)> = symbols
        .iter()
        .filter(|s| s.kind == PredefinedKind::Constant)
        .map(|s| (s.name, s.value))
        .collect();
    consts.sort_unstable_by_key(|(n, _)| *n);
    let max_name_width = consts.iter().map(|(n, _)| n.len()).max().unwrap_or(0);
    println!("\nConstants:");
    for (name, value) in consts {
        println!("  {name:<max_name_width$} = {value}");
    }
}
