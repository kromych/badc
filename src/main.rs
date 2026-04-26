mod c4;

use c4::{Compiler, Vm};

fn main() {
    let args: Vec<String> = std::env::args().collect();
    if args.len() < 2 {
        eprintln!("usage: c4_rust <file>");
        return;
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

    match Vm::new(program, false).with_args(c_args).run() {
        Ok(res) => println!("exit({})", res),
        Err(e) => {
            eprintln!("{}", e);
            std::process::exit(1);
        }
    }
}
