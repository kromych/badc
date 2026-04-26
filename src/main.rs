mod c4;

use c4::{Compiler, Vm};

fn main() {
    let raw: Vec<String> = std::env::args().collect();
    if raw.len() < 2 {
        eprintln!("usage: c4_rust [--track-pointers] <file> [args...]");
        return;
    }

    // Strip a leading `--track-pointers` flag (anywhere before the source
    // file) so the remaining argv looks like `c4_rust <file> [args...]`.
    let mut track_pointers = false;
    let args: Vec<String> = raw
        .into_iter()
        .filter(|a| {
            if a == "--track-pointers" {
                track_pointers = true;
                false
            } else {
                true
            }
        })
        .collect();

    if args.len() < 2 {
        eprintln!("usage: c4_rust [--track-pointers] <file> [args...]");
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

    // Pass everything from argv[1] onward to the C program — argv[0] of the
    // hosted program is the source file name, argv[1..] are its own args.
    let c_args: Vec<String> = args[1..].to_vec();

    let mut vm = Vm::new(program, false).with_args(c_args);
    if track_pointers {
        vm = vm.with_pointer_tracking();
    }

    match vm.run() {
        Ok(res) => println!("exit({})", res),
        Err(e) => {
            eprintln!("{}", e);
            std::process::exit(1);
        }
    }
}
