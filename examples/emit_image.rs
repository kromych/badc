//! Compile C source and write a native executable for any target.
//!
//!     cargo run --example emit_image --features full -- linux-x64 hello
//!
//! The target is one of `macos-aarch64`, `linux-aarch64`, `linux-x64`,
//! `windows-x64` and `windows-arm64`. The source includes `<stdio.h>`, which
//! the `headers` feature embeds, and the backend of an architecture other
//! than the host's is its `target-<arch>` feature.

use badc::{CompileOptions, Compiler, NativeOptions, Target, emit_native_with_options};

const SOURCE: &str = "
    #include <stdio.h>
    int main(int argc, char **argv) {
        printf(\"hello from %s with %d argument(s)\\n\", argv[0], argc - 1);
        return 0;
    }
";

fn main() {
    let mut args = std::env::args().skip(1);
    let (Some(target), Some(out)) = (args.next(), args.next()) else {
        eprintln!("usage: emit_image <target> <output>");
        std::process::exit(2);
    };
    let Some(target) = Target::parse(Some(&target)) else {
        eprintln!("unknown target `{target}`");
        std::process::exit(2);
    };
    let built = Compiler::with_options(SOURCE.into(), target, CompileOptions::default())
        .compile()
        .and_then(|p| emit_native_with_options(&p, target, NativeOptions::new().with_optimize()));
    match built {
        Ok(image) => {
            std::fs::write(&out, image).expect("write the image");
            println!("wrote {out} for {}", target.id_str());
        }
        Err(e) => {
            eprintln!("{e}");
            std::process::exit(1);
        }
    }
}
