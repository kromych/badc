//! CLI standalone smoke test.
//!
//! The lib-side fixture tests (`src/c5/tests/native.rs` and its
//! siblings) prepend `with_prelude()` (`src/c5/tests/mod.rs`) before
//! compiling, which hides whether a fixture builds through the badc
//! binary, where the user gets no auto-prelude and every header the
//! source needs must be in it.
//!
//! This runs the badc binary against every fixture for every supported
//! Linux target and asserts the build succeeds. The sweep itself is a
//! compile-and-link check: a fixture that runs into its own trap is
//! still swept, because the sweep does not execute the result.
//! [`LINKED_IMAGE_RUN_FIXTURES`] then executes a subset on a host whose
//! triple matches one of [`SMOKE_TARGETS`], which is the only coverage
//! any fixture gets through the CLI's object-then-link writer.

use std::path::PathBuf;
use std::process::Command;

/// Fixtures the sweep cannot build for *every* target in
/// [`SMOKE_TARGETS`]. An exclusion that applies to one target only
/// belongs in [`TARGET_SPECIFIC_ASM`], which keeps the other target
/// covered. Each entry names the diagnostic it stands for; when a
/// fixture is excluded for a different reason on each target, both
/// are named.
const COMPILE_SKIPLIST: &[&str] = &[
    // VLA fixtures that assert a clean rejection diagnostic rather
    // than compiling; the constructs are unsupported by design (C99
    // 6.7.6.2 corners left as TODO). The diagnostics are locked in
    // `src/c5/tests/vla.rs`.
    "vla_multidim_rejected.c",
    "vla_file_scope_rejected.c",
    "vla_initializer_rejected.c",
    // x86-64 asm on both counts: aarch64 rejects `%c1(%%rip)`, and on
    // x86-64 the `i`-class operand fed through an always_inline helper
    // resolves only once the fold runs, so `-O0` reports it as not a
    // constant or address (gcc parity). The -O run lives in
    // native_elf_x64.
    "inline_asm_x64_riprel_param.c",
    // x86-64 asm: aarch64 rejects the `sym(,%reg,8)` operand. On
    // x86-64 the absolute `R_X86_64_32S` displacement has no link-time
    // value in the position-independent image badc emits -- GNU ld and
    // clang reject the same object with "relocation R_X86_64_32S ...
    // can not be used when making a PIE object". The object-path
    // relocation shape is locked by a linker test.
    "file_scope_asm_sym_mem.c",
    // `-mcmodel=kernel` relocatable-object fixture: its externs have no
    // definition to link and the model itself requires `-c` on
    // linux-x64 only. Snapshotted via its `// snapshot-flags:`
    // directive; the relocation shape is locked by linker tests.
    "kernel_model_extern_data.c",
];

/// Each calls a declared-but-undefined function from a statically dead
/// branch, so the link succeeds only once the fold deletes the call --
/// an -O capability. gcc likewise fails to link these at -O0 and links
/// them at -O2. Excluded from the -O0 sweep below and built at -O by
/// `dead_branch_calls_are_eliminated_under_optimize`, which is the
/// assertion; one list drives both so neither can drift.
const DEAD_BRANCH_NEEDS_OPTIMIZE: &[&str] = &[
    "dead_arm_short_circuit_undefined.c",
    "always_inline_indirect_call_guard.c",
    "dead_arm_config_predicate_undefined.c",
    "select_operand_guard_folds.c",
    "const_scalar_load_folds.c",
    "unroll_const_trip_index_literal.c",
    "inline_zero_frame_callee_past_gate.c",
    "ipa_const_param_guard.c",
    "addr_null_compare_inline_param.c",
    "addr_compare_same_function_inline.c",
    "addr_fold_pruned_arm_dce.c",
    "const_struct_array_inline_accessor.c",
    "local_template_byte_probe.c",
    "range_guard_field_reload.c",
    "zero_fill_narrow_member_guard.c",
    "range_implied_dispatch_dead_arm.c",
    "range_minmax_constant_p_sign.c",
    "scoped_state_loop_dead_arm.c",
];

/// Fixtures whose body carries inline asm specific to one ISA. The
/// paired target lacks the instruction and rejects the compile by
/// design; the native target still compiles and is checked. (TODO:
/// lower these recognized asm intrinsics on the foreign target so the
/// fixtures compile everywhere.)
const TARGET_SPECIFIC_ASM: &[(&str, &str)] = &[
    ("file_scope_asm_a64_relocs.c", "linux-x64"), // aarch64 stp/adrp file-scope section
    ("file_scope_asm_a64_label_diff_operand.c", "linux-x64"), // aarch64 prfm/adr file-scope section
    ("cacheflush_asm.c", "linux-x64"),            // aarch64 cache-ops / barriers
    ("atomic128_ldaxp_stlxp.c", "linux-x64"),     // aarch64 128-bit ldaxp/stlxp
    ("atomic128_ldst.c", "linux-x64"),            // aarch64 128-bit ldp/stp, ldxp/stxp
    ("atomic128_cmpxchg_llsc.c", "linux-x64"),    // aarch64 128-bit ldxp/stxp CAS (generic encoder)
    ("inline_asm_a64_dp.c", "linux-x64"),         // aarch64 mul/csel (x86 mul is 1-operand)
    ("inline_asm_a64_sym_reloc.c", "linux-x64"),  // aarch64 adrp/:lo12: symbol operands
    ("inline_asm_a64_sp_operand.c", "linux-x64"), // aarch64 sp-operand add/sub
    ("inline_asm_a64_labels.c", "linux-x64"),     // aarch64 local-label branches
    ("inline_asm_a64_section_branches.c", "linux-x64"), // aarch64 branches into a pushed section
    ("inline_asm_a64_label_directive.c", "linux-x64"), // aarch64 label sharing a directive statement
    ("asm_goto_immediate_operand_no_frame.c", "linux-x64"), // aarch64 asm goto + .align 3
    ("inline_asm_a64_barriers.c", "linux-x64"),        // aarch64 dmb/dsb/isb/clrex
    ("inline_asm_a64_acqrel.c", "linux-x64"),          // aarch64 ldar/stlr via `Q`
    ("inline_asm_a64_llsc.c", "linux-x64"),            // aarch64 ldxr/stxr loop via `+Q`
    ("inline_asm_a64_llsc_prfm.c", "linux-x64"),       // aarch64 prfm + ldxr/stxr via `+Q`
    ("inline_asm_a64_lsui.c", "linux-x64"),            // aarch64 LSUI unprivileged atomics
    ("divq_udiv_qrnnd.c", "linux-aarch64"),            // x86-64 128/64 divq
    ("rdtsc_host_ticks.c", "linux-aarch64"),           // x86-64 rdtsc
    ("inline_asm_fixed_reg_output_width.c", "linux-aarch64"), // x86-64 rdtsc / fixed-reg outputs
    ("inline_asm_memory_operand.c", "linux-aarch64"),  // x86-64 lock cmpxchg/xadd
    ("inline_asm_x64_catalogue.c", "linux-aarch64"),   // x86-64 neg/not/xchg/rol/adc
    ("inline_asm_x64_paren_disp.c", "linux-aarch64"),  // x86-64 rip-relative label address
    ("inline_asm_x64_seg_prefix_wrpkru.c", "linux-aarch64"), // x86-64 segment prefix / wrpkru
    ("inline_asm_x64_crc32.c", "linux-aarch64"),       // x86-64 SSE4.2 crc32
    ("inline_asm_x64_label_directive.c", "linux-aarch64"), // x86-64 label sharing a directive statement
    ("inline_asm_x64_setcc.c", "linux-aarch64"),           // x86-64 setcc
    ("inline_asm_x64_cmov.c", "linux-aarch64"),            // x86-64 cmovcc
    ("inline_asm_x64_cdqe.c", "linux-aarch64"),            // x86-64 cdqe
    ("inline_asm_x64_movnti.c", "linux-aarch64"),          // x86-64 movnti/sfence
    ("inline_asm_x64_clflush.c", "linux-aarch64"),         // x86-64 clflush/prefetch
    ("inline_asm_x64_prefetch.c", "linux-aarch64"),        // x86-64 prefetch hint family
    ("inline_asm_x64_setjmp_label.c", "linux-aarch64"),    // x86-64 asm context switch
    ("inline_asm_x64_sp_callee_regions.c", "linux-aarch64"), // x86-64 rsp capture
    ("inline_asm_x64_mem_disp.c", "linux-aarch64"),        // x86-64 disp(%reg) memory operands
    ("inline_asm_x64_imm_mem.c", "linux-aarch64"),         // x86-64 byte/word imm-to-memory ALU
    ("inline_asm_x64_flags_push.c", "linux-aarch64"),      // x86-64 pushf/popf and word push/pop
    ("inline_asm_m_operand_array_cast.c", "linux-aarch64"), // x86-64 addq/adcq region operand
    ("inline_asm_x64_const_expr.c", "linux-aarch64"), // x86-64 addq/adcq const-expr displacements
    ("inline_asm_x64_callee_saved_operands.c", "linux-aarch64"), // x86-64 callee-saved operand pool
    ("inline_asm_x64_callee_saved_preserved.c", "linux-aarch64"), // x86-64 callee-saved survival across call
    ("inline_asm_x64_constraint_a.c", "linux-aarch64"), // x86-64 `A` accumulator constraint
    ("register_var_asm_operand_sp.c", "linux-aarch64"), // x86-64 rsp / rbp operand binding
    ("register_var_asm_operand_split.c", "linux-aarch64"), // x86-64 split-literal register name
    ("register_var_asm_operand_r11.c", "linux-aarch64"), // x86-64 r11 operand binding + %c call
    ("register_var_asm_operand_r10.c", "linux-aarch64"), // x86-64 r10 operand binding + staging fallback
    ("inline_asm_x64_sib.c", "linux-aarch64"),           // x86-64 scaled-index memory operands
    ("inline_asm_x64_sib_nobase.c", "linux-aarch64"), // x86-64 no-base scaled-index memory operands
    ("inline_asm_x64_port_dx.c", "linux-aarch64"),    // x86-64 `(%dx)` port in/out
    ("inline_asm_x64_c_mem.c", "linux-aarch64"),      // x86-64 `%c` RIP-relative memory forms
    ("inline_asm_x64_riprel_addr_const.c", "linux-aarch64"), // x86-64 `%c` RIP-relative address constants
    ("inline_asm_x64_seg_c_percpu.c", "linux-aarch64"), // x86-64 `%%gs:` percpu accessor shapes
    ("inline_asm_x64_sym_riprel.c", "linux-aarch64"),   // x86-64 sym(%rip) displacement forms
    ("inline_asm_x64_align.c", "linux-aarch64"),        // x86-64 `.align` in the code stream
    ("cpuid_partial_outputs.c", "linux-aarch64"),       // x86-64 cpuid
    ("cpuid_xgetbv_output_width.c", "linux-aarch64"),   // x86-64 cpuid / xgetbv output widths
    ("inline_asm_x64_flag_outputs.c", "linux-aarch64"), // x86-64 `=@cc` flag outputs
    ("inline_asm_x64_string_ops.c", "linux-aarch64"),   // x86-64 string primitives / prefixes
    ("inline_asm_x64_system_ext.c", "linux-aarch64"), // x86-64 invpcid/invvpid/invlpga/cmpxchg16b/fldl/fstpl/mxcsr/ljmp/fs-gs push
    ("inline_asm_x64_port_io.c", "linux-aarch64"),    // x86-64 string port-I/O (ins / outs)
    ("inline_asm_a64_comments.c", "linux-x64"),       // aarch64 comment syntax
    ("inline_asm_a64_sysreg_families.c", "linux-x64"), // aarch64 named/indexed sysregs + S-form
    ("inline_asm_a64_at_sys.c", "linux-x64"),         // aarch64 `at` / generic `sys`
    ("file_scope_asm_local_labels.c", "linux-aarch64"), // x86-64 div/ret fastop fragments
    ("file_scope_asm_local_label_branch.c", "linux-aarch64"), // x86-64 lock cmpxchg + jcc to a section label
    ("file_scope_asm_sym_riprel.c", "linux-aarch64"), // x86-64 `sym(%rip)` displacement expressions
    ("inline_asm_x64_align_above_section.c", "linux-aarch64"), // x86-64 alignment above the section default
    ("inline_asm_x64_mmx_fpu.c", "linux-aarch64"),             // x86-64 MMX movq + fwait
    ("inline_asm_x64_bug_table_org.c", "linux-aarch64"),       // x86-64 ud2 bug-table entry
    ("inline_asm_x64_jump_label.c", "linux-aarch64"),          // x86-64 jmp %l jump-table entry
    ("inline_asm_x64_m_global_call.c", "linux-aarch64"), // x86-64 indirect call through an "m" operand
    ("inline_asm_a64_bug_table_labels.c", "linux-x64"),  // aarch64 brk bug-table entry
];

/// Targets the sweep below builds every fixture for. Also the set the
/// second column of `TARGET_SPECIFIC_ASM` must name.
const SMOKE_TARGETS: &[&str] = &["linux-aarch64", "linux-x64"];

/// Absolute path of `tests/fixtures/c`.
fn fixtures_dir() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR"))
        .join("tests")
        .join("fixtures")
        .join("c")
}

/// An entry that excludes nothing fails nothing, so it survives the
/// condition it was written for. This rejects the three shapes that
/// go stale silently: an entry naming a fixture that is gone, a
/// duplicate, and a `TARGET_SPECIFIC_ASM` entry the all-target
/// `COMPILE_SKIPLIST` already short-circuits. The converse is normal:
/// the sweep below discovers unregistered fixtures from the directory.
/// The backend tables carry the existence check in
/// `src/c5/tests/fixture_tables.rs`.
#[test]
fn every_table_entry_names_a_fixture() {
    let dir = fixtures_dir();
    let mut bad: Vec<String> = Vec::new();
    let mut checked = 0usize;
    for (i, name) in COMPILE_SKIPLIST.iter().enumerate() {
        checked += 1;
        if !dir.join(name).exists() {
            bad.push(format!("COMPILE_SKIPLIST: {name}"));
        }
        if COMPILE_SKIPLIST[..i].contains(name) {
            bad.push(format!("COMPILE_SKIPLIST: {name} listed twice"));
        }
    }
    for (i, name) in DEAD_BRANCH_NEEDS_OPTIMIZE.iter().enumerate() {
        checked += 1;
        if !dir.join(name).exists() {
            bad.push(format!("DEAD_BRANCH_NEEDS_OPTIMIZE: {name}"));
        }
        if DEAD_BRANCH_NEEDS_OPTIMIZE[..i].contains(name) {
            bad.push(format!("DEAD_BRANCH_NEEDS_OPTIMIZE: {name} listed twice"));
        }
        if COMPILE_SKIPLIST.contains(name) {
            bad.push(format!(
                "DEAD_BRANCH_NEEDS_OPTIMIZE: {name} is also in COMPILE_SKIPLIST"
            ));
        }
    }
    for (i, (name, target)) in TARGET_SPECIFIC_ASM.iter().enumerate() {
        checked += 1;
        if !dir.join(name).exists() {
            bad.push(format!("TARGET_SPECIFIC_ASM: {name}"));
        }
        if !SMOKE_TARGETS.contains(target) {
            bad.push(format!(
                "TARGET_SPECIFIC_ASM: {name} names unswept target {target}"
            ));
        }
        if TARGET_SPECIFIC_ASM[..i].contains(&(name, target)) {
            bad.push(format!(
                "TARGET_SPECIFIC_ASM: {name} listed twice for {target}"
            ));
        }
        if COMPILE_SKIPLIST.contains(name) {
            bad.push(format!(
                "TARGET_SPECIFIC_ASM: {name} is inert -- COMPILE_SKIPLIST already \
                 excludes it from every target"
            ));
        }
    }
    for (i, (name, _)) in LINKED_IMAGE_RUN_FIXTURES.iter().enumerate() {
        checked += 1;
        if !dir.join(name).exists() {
            bad.push(format!("LINKED_IMAGE_RUN_FIXTURES: {name}"));
        }
        if LINKED_IMAGE_RUN_FIXTURES[..i]
            .iter()
            .any(|(n, _)| n == name)
        {
            bad.push(format!("LINKED_IMAGE_RUN_FIXTURES: {name} listed twice"));
        }
        // A fixture the sweep never builds cannot be run either.
        if COMPILE_SKIPLIST.contains(name) || DEAD_BRANCH_NEEDS_OPTIMIZE.contains(name) {
            bad.push(format!(
                "LINKED_IMAGE_RUN_FIXTURES: {name} is excluded from the sweep"
            ));
        }
        if let Some(target) = host_smoke_target()
            && TARGET_SPECIFIC_ASM.contains(&(name, target))
        {
            bad.push(format!(
                "LINKED_IMAGE_RUN_FIXTURES: {name} does not build for {target}"
            ));
        }
    }
    for (line, name) in disabled_entries(include_str!("cli_fixture_smoke.rs")) {
        checked += 1;
        if !dir.join(&name).exists() {
            bad.push(format!("disabled entry at line {line}: {name}"));
        }
    }
    assert!(
        bad.is_empty(),
        "{} of {} table entries are stale ({} holds the fixtures):\n  {}",
        bad.len(),
        checked,
        dir.display(),
        bad.join("\n  ")
    );
}

/// Fixture names in rows commented out of the tables above, in either
/// shape they take: a bare `"name.c",` or a `("name.c", ..)` tuple. The
/// compiler never sees a disabled row, so without this scan the fixture
/// it names can be renamed or deleted and the row rots in place.
fn disabled_entries(source: &str) -> Vec<(usize, String)> {
    let mut found = Vec::new();
    for (i, line) in source.lines().enumerate() {
        let Some(rest) = line.trim_start().strip_prefix("//") else {
            continue;
        };
        let rest = rest.trim_start();
        let Some(rest) = rest.strip_prefix("(\"").or_else(|| rest.strip_prefix('"')) else {
            continue;
        };
        let Some(name) = rest.split('"').next() else {
            continue;
        };
        if name.ends_with(".c") {
            found.push((i + 1, name.to_string()));
        }
    }
    found
}

#[test]
fn every_fixture_compiles_standalone_for_linux() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let fixtures_dir = fixtures_dir();
    let mut entries: Vec<PathBuf> = std::fs::read_dir(&fixtures_dir)
        .expect("read tests/fixtures/c")
        .filter_map(|e| e.ok().map(|e| e.path()))
        .filter(|p| p.extension().and_then(|s| s.to_str()) == Some("c"))
        // A hidden file is not a fixture; macOS sync tooling plants
        // AppleDouble `._*.c` companions next to the real ones.
        .filter(|p| {
            p.file_name()
                .and_then(|s| s.to_str())
                .is_some_and(|n| !n.starts_with('.'))
        })
        .collect();
    entries.sort();
    assert!(
        !entries.is_empty(),
        "no fixtures discovered under {}",
        fixtures_dir.display()
    );

    let tmp_root = std::env::temp_dir().join(format!("badc-cli-smoke-{}", std::process::id()));
    let _ = std::fs::create_dir_all(&tmp_root);

    let mut failures: Vec<String> = Vec::new();
    let mut attempts = 0usize;
    for fixture in &entries {
        let name = fixture.file_name().unwrap().to_str().unwrap();
        if COMPILE_SKIPLIST.contains(&name) || DEAD_BRANCH_NEEDS_OPTIMIZE.contains(&name) {
            continue;
        }
        for target in SMOKE_TARGETS.iter().copied() {
            if TARGET_SPECIFIC_ASM.contains(&(name, target)) {
                continue;
            }
            attempts += 1;
            let stem = name.trim_end_matches(".c");
            let out = tmp_root.join(format!("{stem}-{target}"));
            let status = Command::new(badc)
                .arg(format!("--target={target}"))
                .arg("-o")
                .arg(&out)
                .arg(fixture)
                .output();
            match status {
                Ok(o) if o.status.success() => {}
                Ok(o) => {
                    let stderr = String::from_utf8_lossy(&o.stderr);
                    failures.push(format!(
                        "[{target}] {name}: exit {} -- {}",
                        o.status.code().unwrap_or(-1),
                        stderr.lines().next().unwrap_or("(no stderr)").trim()
                    ));
                }
                Err(e) => failures.push(format!("[{target}] {name}: spawn failed: {e}")),
            }
        }
    }

    let _ = std::fs::remove_dir_all(&tmp_root);
    if !failures.is_empty() {
        panic!(
            "{} of {} fixture-compilation attempts failed:\n  {}",
            failures.len(),
            attempts,
            failures.join("\n  ")
        );
    }
}

/// Fixtures the sweep above additionally *runs*, with the exit code each
/// must produce.
///
/// The backend parity tables in `src/c5/tests/fixture_tables.rs` drive
/// `emit_native_with_options`, which lays out and writes one image in a
/// single pass. The CLI emits `ET_REL`, merges the objects and the
/// runtime with `link_native_objects`, runs the per-arch PLT pass, and
/// writes through `write_native_image_from_merged_ex`, so section
/// addresses, symbol values and relocation targets are decided by
/// different code. Only the two PE tables and the hand-written sources
/// in `cli_linker_smoke.rs` reached the second path before this list.
///
/// A defect there surfaces as a wrong section address, symbol value or
/// relocation, so the subset takes the shortest fixture that reads one
/// of those back at run time, per class: data relocations (including
/// one-past-the-end), static initializers holding a function or
/// libc-symbol address, over-aligned and page-aligned sections, named
/// sections and labels from file-scope `asm`, weak binding and aliases,
/// tentative definitions in `.bss`, `PT_TLS` built from merged `.tdata`
/// / `.tbss`, jump and computed-goto tables read as relocated label
/// differences, aggregates moved through the merged libc PLT, and
/// string-literal and flexible-array payloads in `.rodata`. Volume adds
/// nothing once a class is covered.
///
/// Values are these programs' own exit codes, checked here rather than
/// copied from another table, so a wrong one fails instead of drifting.
const LINKED_IMAGE_RUN_FIXTURES: &[(&str, i32)] = &[
    ("data_reloc_one_past_end.c", 10),
    ("static_init_cast_funcptr.c", 0),
    ("static_init_paren_relocation.c", 0),
    ("sys_addr_in_static_init.c", 42),
    ("variadic_libc_fnptr_static_init.c", 0),
    ("forward_fn_ptr_in_static_init.c", 0),
    ("attributed_aggregate_align_floor.c", 0),
    ("string_concat_encoding_prefix.c", 0),
    ("utf8_string_prefix_ucn.c", 0),
    ("overaligned_data_placement.c", 0),
    ("overaligned_type_placement.c", 0),
    ("page_multiple_alignment.c", 0),
    ("file_scope_asm_decls.c", 0),
    ("file_scope_asm_label_binding.c", 42),
    ("file_scope_asm_section_placement.c", 42),
    ("file_scope_asm_rept_type_size.c", 42),
    ("file_scope_asm_incbin.c", 0),
    ("file_scope_asm_weak_set.c", 0),
    ("inline_asm_section_label.c", 42),
    ("attribute_weak_alias.c", 0),
    ("weak_definition_not_inlined.c", 42),
    ("weak_alias_call_not_inlined.c", 42),
    ("weak_extern_data_address.c", 0),
    ("tentative_array_definition.c", 0),
    ("tentative_deferred_array_grows.c", 0),
    ("thread_local_basic.c", 0),
    ("thread_local_gnu.c", 0),
    ("thread_local_initializer.c", 0),
    ("thread_local_address_init.c", 0),
    ("thread_local_per_thread.c", 0),
    ("thread_local_address_per_thread.c", 0),
    ("switch_jump_table_dense.c", 0),
    ("switch_jump_table_sparse_kept.c", 0),
    ("computed_goto_static_table.c", 0),
    ("indirect_struct_return.c", 0),
    ("hfa_struct_return.c", 0),
    ("large_struct_copy.c", 0),
    ("array_compound_literal_static_init.c", 0),
    ("flex_array_member_static_init.c", 0),
    ("packed_bitfield_repack.c", 0),
    ("wide_string_literal_alignment.c", 0),
    ("computed_include_pp_number.c", 0),
];

/// The sweep's target for this host, or `None` when the host cannot
/// execute either of [`SMOKE_TARGETS`].
fn host_smoke_target() -> Option<&'static str> {
    if !cfg!(target_os = "linux") {
        return None;
    }
    match std::env::consts::ARCH {
        "x86_64" => Some("linux-x64"),
        "aarch64" => Some("linux-aarch64"),
        _ => None,
    }
}

/// Run [`LINKED_IMAGE_RUN_FIXTURES`] as the CLI builds them, at `-O0`
/// and at `-O`. Both levels matter: the merge sees a different set of
/// sections and symbols once the optimizer has folded and dropped code.
#[test]
fn linked_image_fixtures_run_on_the_native_target() {
    let Some(target) = host_smoke_target() else {
        return;
    };
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = fixtures_dir();
    // Per-process directory: this test writes and then executes each
    // image, so a concurrent run must not share the output paths.
    let tmp_root = std::env::temp_dir().join(format!("badc-cli-run-{}", std::process::id()));
    let _ = std::fs::create_dir_all(&tmp_root);

    let mut failures: Vec<String> = Vec::new();
    for (name, expected) in LINKED_IMAGE_RUN_FIXTURES {
        for (tag, flags) in [("-O0", &[][..]), ("-O", &["-O"][..])] {
            let stem = name.trim_end_matches(".c");
            let out = tmp_root.join(format!("{stem}{tag}"));
            let built = Command::new(badc)
                .arg(format!("--target={target}"))
                .args(flags)
                .arg("-o")
                .arg(&out)
                .arg(dir.join(name))
                .output()
                .expect("run badc");
            if !built.status.success() {
                let stderr = String::from_utf8_lossy(&built.stderr);
                failures.push(format!(
                    "{name} {tag}: build failed -- {}",
                    stderr.lines().next().unwrap_or("(no stderr)").trim()
                ));
                continue;
            }
            match Command::new(&out).output() {
                Ok(o) => match o.status.code() {
                    Some(code) if code == *expected => {}
                    Some(code) => failures.push(format!(
                        "{name} {tag}: expected exit {expected}, got {code}"
                    )),
                    None => failures.push(format!("{name} {tag}: killed by a signal")),
                },
                Err(e) => failures.push(format!("{name} {tag}: spawn failed: {e}")),
            }
        }
    }

    let _ = std::fs::remove_dir_all(&tmp_root);
    assert!(
        failures.is_empty(),
        "{} of {} linked-image runs failed on {target}:\n  {}",
        failures.len(),
        LINKED_IMAGE_RUN_FIXTURES.len() * 2,
        failures.join("\n  ")
    );
}

// A quoted `#include "header"` resolves against the directory of the
// including file, not the process working directory (C99 6.10.2p2).
// Compiling `sub/main.c` from the parent directory must still find
// `sub/helper.h`; a CWD-relative-only search would miss it.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn quoted_include_resolves_relative_to_including_file() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-qinc-{}", std::process::id()));
    let sub = dir.join("sub");
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&sub).expect("create temp dir");
    std::fs::write(sub.join("helper.h"), "int helper(void) { return 42; }\n")
        .expect("write header");
    std::fs::write(
        sub.join("main.c"),
        "#include \"helper.h\"\nint main(void) { return helper(); }\n",
    )
    .expect("write main");
    let exe = dir.join("prog");
    let out = Command::new(badc)
        .arg(sub.join("main.c"))
        .arg("-o")
        .arg(&exe)
        .current_dir(&dir) // CWD is the parent, not sub/.
        .output()
        .expect("run badc");
    assert!(
        out.status.success(),
        "compile failed: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    let run = Command::new(&exe).output().expect("run prog");
    assert_eq!(
        run.status.code(),
        Some(42),
        "quoted-include program returned wrong value"
    );
    let _ = std::fs::remove_dir_all(&dir);
}

// Each [`DEAD_BRANCH_NEEDS_OPTIMIZE`] fixture calls a declared-but-
// undefined function from a branch that is statically dead once the
// enclosing helper inlines and its guard folds. Linking is the
// assertion: a surviving call is an undefined reference. Both cross
// targets are built so the fold is exercised independently of the host,
// and the host-target build is executed to confirm the surviving code
// still computes the right answers.
//
// The same build at `-O0` must fail to link. Each of these is an
// optimization, not a front-end fold, and the two halves together say
// so: without the `-O0` half a fixture whose call the front end starts
// resolving would keep passing while asserting nothing. gcc likewise
// links every one of these at `-O1` and above and fails to at `-O0`.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn dead_branch_calls_are_eliminated_under_optimize() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-deadbr-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");
    let root = fixtures_dir();

    for name in DEAD_BRANCH_NEEDS_OPTIMIZE.iter().copied() {
        let src = root.join(name);
        let stem = name.trim_end_matches(".c");
        for target in ["linux-aarch64", "linux-x64"] {
            let out = dir.join(format!("{stem}-{target}"));
            let res = Command::new(badc)
                .arg(format!("--target={target}"))
                .arg("-O")
                .arg("-o")
                .arg(&out)
                .arg(&src)
                .output()
                .expect("run badc");
            assert!(
                res.status.success(),
                "[{target}] {name}: a statically dead call survived -O: {}",
                String::from_utf8_lossy(&res.stderr)
            );
        }

        let unopt = dir.join(format!("{stem}-O0"));
        let res = Command::new(badc)
            .arg("--target=linux-x64")
            .arg("-o")
            .arg(&unopt)
            .arg(&src)
            .output()
            .expect("run badc");
        assert!(
            !res.status.success(),
            "{name}: the dead call must survive -O0, or the fixture asserts nothing at -O"
        );

        let exe = dir.join(format!("{stem}-host"));
        let built = Command::new(badc)
            .arg("-O")
            .arg("-o")
            .arg(&exe)
            .arg(&src)
            .output()
            .expect("run badc");
        assert!(
            built.status.success(),
            "{name}: host build failed: {}",
            String::from_utf8_lossy(&built.stderr)
        );
        let run = Command::new(&exe).output().expect("run fixture");
        assert_eq!(
            run.status.code(),
            Some(0),
            "{name}: fixture reported failure"
        );
    }
    let _ = std::fs::remove_dir_all(&dir);
}

// A callee marked `always_inline` / `__forceinline` that the inliner
// cannot substitute (here: a variadic body) draws a diagnostic naming
// the function and the reason, so a silently-unhonored mandatory inline
// request is visible. A body the inliner can substitute stays silent.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn always_inline_not_honored_warns() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-ai-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");

    let compile = |src: &std::path::Path, obj: &str| {
        Command::new(badc)
            .arg("--target=linux-x64")
            .arg("-O")
            .arg("-c")
            .arg(src)
            .arg("-o")
            .arg(dir.join(obj))
            .output()
            .expect("run badc")
    };

    // Variadic always_inline: the inliner rejects it, so the request is
    // unhonored and must warn.
    let va = dir.join("va.c");
    std::fs::write(
        &va,
        "#include <stdarg.h>\n\
         static inline __attribute__((always_inline)) int s(int n, ...) {\n\
         \tva_list ap; va_start(ap, n); int t = 0;\n\
         \tfor (int i = 0; i < n; i++) t += va_arg(ap, int);\n\
         \tva_end(ap); return t; }\n\
         int main(void) { return s(2, 3, 4); }\n",
    )
    .expect("write va.c");
    let out = compile(&va, "va.o");
    assert!(
        out.status.success(),
        "compile failed: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    let stderr = String::from_utf8_lossy(&out.stderr);
    assert!(
        stderr.contains("always_inline") && stderr.contains("`s`"),
        "expected an always_inline diagnostic naming `s`, got: {stderr}"
    );

    // A body the inliner can substitute draws no warning.
    let ok = dir.join("ok.c");
    std::fs::write(
        &ok,
        "static inline __attribute__((always_inline)) int a(int x, int y) { return x + y; }\n\
         int main(void) { return a(2, 3); }\n",
    )
    .expect("write ok.c");
    let out2 = compile(&ok, "ok.o");
    assert!(
        out2.status.success(),
        "compile failed: {}",
        String::from_utf8_lossy(&out2.stderr)
    );
    assert!(
        !String::from_utf8_lossy(&out2.stderr).contains("always_inline"),
        "inlinable always_inline should be silent, got: {}",
        String::from_utf8_lossy(&out2.stderr)
    );

    let _ = std::fs::remove_dir_all(&dir);
}

// The optimizer has a single level; every `-O<n>` form selects it and
// `-O0` disables it. With an inline candidate present the optimizer
// changes the emitted object, so the byte image distinguishes
// "optimized" from "not". Compile for a fixed target for a
// deterministic image.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn opt_level_flags_map_to_the_single_level() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-optlvl-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");
    let src = dir.join("u.c");
    std::fs::write(
        &src,
        "static int helper(int x) { return x + 1; }\nint f(int v) { return helper(v) * 2; }\n",
    )
    .expect("write source");

    let compile = |tag: &str, flags: &[&str]| -> Vec<u8> {
        let obj = dir.join(format!("u{tag}.o"));
        let mut cmd = Command::new(badc);
        cmd.arg("--target=linux-x64").arg("-c");
        for f in flags {
            cmd.arg(f);
        }
        let out = cmd
            .arg(&src)
            .arg("-o")
            .arg(&obj)
            .output()
            .expect("run badc");
        assert!(
            out.status.success(),
            "compile {flags:?} failed: {}",
            String::from_utf8_lossy(&out.stderr)
        );
        std::fs::read(&obj).expect("read object")
    };

    let none = compile("none", &[]);
    let o0 = compile("o0", &["-O0"]);
    let o = compile("o", &["-O"]);
    let o2 = compile("o2", &["-O2"]);
    let o3 = compile("o3", &["-O3"]);
    let os = compile("os", &["-Os"]);
    let _ = std::fs::remove_dir_all(&dir);

    // The optimizer is observable here: the helper inlines under -O.
    assert_ne!(o, none, "-O produced the same object as no optimization");
    // -O0 and no flag both leave the optimizer off.
    assert_eq!(o0, none, "-O0 should match the unoptimized image");
    // Every other level selects the same single optimization level.
    assert_eq!(o2, o, "-O2 should match -O");
    assert_eq!(o3, o, "-O3 should match -O");
    assert_eq!(os, o, "-Os should match -O");
}

// `-mcmodel=` values follow the target the way gcc's do: aarch64 has
// tiny/small, x86-64 has small/kernel. `tiny` narrows the layout
// contract the small form already satisfies, so it lowers as small and
// the objects are identical (the arm64 vdso builds its units with it).
#[test]
fn code_model_values_follow_the_target() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-cmodel-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");
    let src = dir.join("u.c");
    std::fs::write(
        &src,
        "extern int ev;\nstatic int gv;\nint f(void) { return ev + gv; }\n",
    )
    .expect("write source");

    let compile = |target: &str, model: &str| -> Result<Vec<u8>, String> {
        let obj = dir.join(format!("u-{target}-{model}.o"));
        let out = Command::new(badc)
            .arg(format!("--target={target}"))
            .arg("-c")
            .arg(format!("-mcmodel={model}"))
            .arg(&src)
            .arg("-o")
            .arg(&obj)
            .output()
            .expect("run badc");
        if out.status.success() {
            Ok(std::fs::read(&obj).expect("read object"))
        } else {
            Err(String::from_utf8_lossy(&out.stderr).into_owned())
        }
    };

    let tiny = compile("linux-aarch64", "tiny").expect("aarch64 rejects -mcmodel=tiny");
    let small = compile("linux-aarch64", "small").expect("aarch64 rejects -mcmodel=small");
    assert_eq!(tiny, small, "tiny must lower as the small model");
    let err = compile("linux-x64", "tiny").expect_err("x86-64 accepts -mcmodel=tiny");
    assert!(
        err.contains("-mcmodel=tiny"),
        "unexpected diagnostic: {err}"
    );
    let err = compile("linux-aarch64", "kernel").expect_err("aarch64 accepts -mcmodel=kernel");
    assert!(
        err.contains("-mcmodel=kernel"),
        "unexpected diagnostic: {err}"
    );
    let err = compile("linux-x64", "medium").expect_err("x86-64 accepts -mcmodel=medium");
    assert!(
        err.contains("unsupported code model"),
        "unexpected diagnostic: {err}"
    );
    let _ = std::fs::remove_dir_all(&dir);
}

// `-O` predefines `NDEBUG=1` and `__OPTIMIZE__=1` (release semantics).
// The predefines land before the CLI `-D` / `-U` lists, so an explicit
// `-D NDEBUG=<v>` keeps the user's value and `-U NDEBUG` removes the
// implied one, re-enabling `assert`.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn optimize_flag_predefines_ndebug() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let manifest = env!("CARGO_MANIFEST_DIR");
    let fixtures = PathBuf::from(manifest)
        .join("tests")
        .join("fixtures")
        .join("c");
    let dir = std::env::temp_dir().join(format!("badc-ndebug-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");

    let run = |tag: &str, flags: &[&str], src: &std::path::Path| -> std::process::ExitStatus {
        let exe = dir.join(tag);
        let mut cmd = Command::new(badc);
        for f in flags {
            cmd.arg(f);
        }
        let out = cmd.arg(src).arg("-o").arg(&exe).output().expect("run badc");
        assert!(
            out.status.success(),
            "compile {tag} failed: {}",
            String::from_utf8_lossy(&out.stderr)
        );
        Command::new(&exe).output().expect("run prog").status
    };

    // Exit codes: both predefines -> NDEBUG's value, exactly one -> 101,
    // neither -> 100 (see the fixture).
    let probe = fixtures.join("ndebug_optimize_predefine.c");
    assert_eq!(run("plain", &[], &probe).code(), Some(100));
    assert_eq!(run("opt", &["-O"], &probe).code(), Some(1));
    assert_eq!(
        run("opt-dval", &["-O", "-DNDEBUG=7"], &probe).code(),
        Some(7)
    );
    assert_eq!(
        run("opt-undef", &["-O", "-UNDEBUG"], &probe).code(),
        Some(101)
    );

    // Under `-O` the assert(0) is compiled out; `-U NDEBUG` re-enables
    // it and the program traps instead of exiting 0.
    let trap = fixtures.join("ndebug_undef_reenables_assert.c");
    assert_eq!(run("assert-off", &["-O"], &trap).code(), Some(0));
    let fired = run("assert-on", &["-O", "-UNDEBUG"], &trap);
    assert!(
        !fired.success(),
        "-U NDEBUG under -O must re-enable assert (got {fired:?})"
    );
    let _ = std::fs::remove_dir_all(&dir);
}

// `--install <dir>` writes every embedded header under <dir>/include
// (recreating subdirectories) and the runtime source under <dir>/lib.
#[test]
fn install_writes_header_and_runtime_tree() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-install-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    let out = Command::new(badc)
        .arg("--install")
        .arg(&dir)
        .output()
        .expect("run badc --install");
    assert!(
        out.status.success(),
        "--install failed: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    // A flat header, a nested header (subdirectory recreated), and the
    // runtime source must all land on disk.
    for rel in ["include/stdio.h", "include/sys/socket.h", "lib/runtime.c"] {
        let p = dir.join(rel);
        assert!(p.is_file(), "missing installed file {}", p.display());
        assert!(
            !std::fs::read_to_string(&p).unwrap().is_empty(),
            "installed file {} is empty",
            p.display()
        );
    }
    let _ = std::fs::remove_dir_all(&dir);
}

// The installed overlay under $BADC_HOME takes precedence over the
// embedded headers and runtime: editing an installed copy changes the
// build without rebuilding badc, and removing the override falls back
// to the embedded copy.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn installed_overlay_overrides_embedded() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-overlay-{}", std::process::id()));
    let home = dir.join("home");
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");
    // Install the embedded set under `home`.
    let out = Command::new(badc)
        .arg("--install")
        .arg(&home)
        .current_dir(&dir)
        .output()
        .expect("run badc --install");
    assert!(out.status.success(), "--install failed");

    // Stamp a marker into the installed <stdbool.h>; the embedded copy
    // does not define it.
    std::fs::write(
        home.join("include/stdbool.h"),
        "#define bool _Bool\n#define true 1\n#define false 0\n#define BADC_OVERLAY_OK 1\n",
    )
    .expect("overwrite installed stdbool.h");
    std::fs::write(
        dir.join("m.c"),
        "#include <stdbool.h>\nint main(void){ return BADC_OVERLAY_OK ? 0 : 1; }\n",
    )
    .expect("write source");

    // With BADC_HOME set the overlay header is used, so the marker is
    // defined and the program builds and exits 0. The temp cwd has no
    // ./include or ./libc/include, so the overlay is the only one.
    let exe = dir.join("m");
    let built = Command::new(badc)
        .env("BADC_HOME", &home)
        .arg(dir.join("m.c"))
        .arg("-o")
        .arg(&exe)
        .current_dir(&dir)
        .output()
        .expect("run badc");
    assert!(
        built.status.success(),
        "overlay build failed: {}",
        String::from_utf8_lossy(&built.stderr)
    );
    assert_eq!(
        Command::new(&exe).output().expect("run prog").status.code(),
        Some(0),
        "overlay program returned non-zero"
    );

    // Without BADC_HOME the embedded <stdbool.h> (no marker) is used, so
    // the same source fails to compile -- the fallback path.
    let fallback = Command::new(badc)
        .arg(dir.join("m.c"))
        .arg("-o")
        .arg(dir.join("m-fallback"))
        .current_dir(&dir)
        .output()
        .expect("run badc");
    assert!(
        !fallback.status.success(),
        "expected the embedded stdbool.h (no marker) to fail compilation"
    );

    // A broken installed runtime is compiled in place of the embedded
    // one: a normal program that links the runtime then fails to build,
    // naming the installed runtime.c.
    std::fs::write(home.join("lib/runtime.c"), "this is not valid C @@@\n")
        .expect("overwrite installed runtime.c");
    std::fs::write(dir.join("h.c"), "int main(void){ return 0; }\n").expect("write source");
    let broken = Command::new(badc)
        .env("BADC_HOME", &home)
        .arg(dir.join("h.c"))
        .arg("-o")
        .arg(dir.join("h"))
        .current_dir(&dir)
        .output()
        .expect("run badc");
    assert!(
        !broken.status.success(),
        "expected the broken installed runtime to fail the build"
    );
    assert!(
        String::from_utf8_lossy(&broken.stderr).contains("runtime.c"),
        "build error should name the installed runtime.c: {}",
        String::from_utf8_lossy(&broken.stderr)
    );

    let _ = std::fs::remove_dir_all(&dir);
}

// An implicit `~/.badc/lib/runtime.c` does not shadow the runtime a
// source build carries, on the same terms as the header overlay: a stale
// `--install` would otherwise change every link made on that host.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn implicit_home_runtime_does_not_shadow_embedded() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-implicit-rt-{}", std::process::id()));
    let home = dir.join("home");
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(home.join(".badc/lib")).expect("create temp home");
    std::fs::write(
        home.join(".badc/lib/runtime.c"),
        "this is not valid C @@@\n",
    )
    .expect("write installed runtime.c");
    std::fs::write(dir.join("h.c"), "int main(void){ return 0; }\n").expect("write source");
    let out = Command::new(badc)
        .env("HOME", &home)
        .env_remove("BADC_HOME")
        .arg(dir.join("h.c"))
        .arg("-o")
        .arg(dir.join("h"))
        .current_dir(&dir)
        .output()
        .expect("run badc");
    assert!(
        out.status.success(),
        "the embedded runtime should have been used: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    let _ = std::fs::remove_dir_all(&dir);
}

// The include search path must not depend on the working directory: a
// build system that runs the compiler from a project root whose
// `./include` holds that project's own headers would otherwise have them
// shadow the standard ones.
#[test]
fn working_directory_include_is_not_searched() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-cwdinc-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(dir.join("include")).expect("create ./include");
    std::fs::write(
        dir.join("include/stdio.h"),
        "#error \"working-directory ./include was searched\"\n",
    )
    .expect("write decoy header");
    std::fs::write(
        dir.join("m.c"),
        "#include <stdio.h>\nint main(void){ return puts(\"\") < 0; }\n",
    )
    .expect("write source");
    let run = |extra: &[&str], out: &str| {
        let mut cmd = Command::new(badc);
        cmd.arg("-q").arg("-c");
        for a in extra {
            cmd.arg(a);
        }
        cmd.arg("m.c").arg("-o").arg(out).current_dir(&dir);
        cmd.output().expect("run badc")
    };
    let built = run(&[], "m.o");
    assert!(
        built.status.success(),
        "a ./include in the working directory must not shadow <stdio.h>: {}",
        String::from_utf8_lossy(&built.stderr)
    );
    // The same header reached explicitly through -I still wins, as in
    // every other compiler.
    assert!(
        !run(&["-I", "include"], "m2.o").status.success(),
        "an explicit -I include must still shadow the bundled header"
    );
    let _ = std::fs::remove_dir_all(&dir);
}

// A badc built from its own source tree searches that tree's
// `libc/include`, so editing a bundled header takes effect without a
// rebuild. The anchor is the executable, not the working directory.
#[test]
fn source_tree_headers_override_the_embedded_set() {
    let badc = std::path::Path::new(env!("CARGO_BIN_EXE_badc"));
    // Locate the tree the same way the driver does.
    let mut root = badc.parent();
    while let Some(d) = root {
        if d.join("Cargo.toml").is_file() && d.join("libc/include").is_dir() {
            break;
        }
        root = d.parent();
    }
    let Some(root) = root else {
        return; // an installed binary has no source tree
    };
    let overlay = root.join("libc/include/stdalign.h");
    let original = std::fs::read(&overlay).expect("read bundled header");
    let mut patched = original.clone();
    patched.extend_from_slice(b"\n#define BADC_SOURCE_TREE_OVERLAY 1\n");
    std::fs::write(&overlay, &patched).expect("patch bundled header");

    let dir = std::env::temp_dir().join(format!("badc-srctree-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create scratch");
    std::fs::write(
        dir.join("m.c"),
        "#include <stdalign.h>\n#ifndef BADC_SOURCE_TREE_OVERLAY\n\
         #error \"source-tree libc/include was not searched\"\n#endif\n\
         int main(void){ return 0; }\n",
    )
    .expect("write source");
    let built = Command::new(badc)
        .arg("-q")
        .arg("-c")
        .arg("m.c")
        .arg("-o")
        .arg("m.o")
        .current_dir(&dir)
        .output()
        .expect("run badc");
    std::fs::write(&overlay, &original).expect("restore bundled header");
    let _ = std::fs::remove_dir_all(&dir);
    assert!(
        built.status.success(),
        "the source tree's libc/include must be searched from any cwd: {}",
        String::from_utf8_lossy(&built.stderr)
    );
}

// An unrecognised dash-prefixed option must be rejected with a clear
// "unknown option" diagnostic, not silently reinterpreted as a source
// file (which produces a misleading `cannot read` error or, worse,
// compiles a same-named file).
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn unknown_option_is_rejected() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-unkopt-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");
    let src = dir.join("main.c");
    std::fs::write(&src, "int main(void) { return 0; }\n").expect("write main");
    let out = Command::new(badc)
        .arg("-Wall")
        .arg(&src)
        .arg("-o")
        .arg(dir.join("prog"))
        .output()
        .expect("run badc");
    assert!(!out.status.success(), "unknown option must fail the build");
    let stderr = String::from_utf8_lossy(&out.stderr);
    assert!(
        stderr.contains("unknown option"),
        "expected an 'unknown option' diagnostic, got: {stderr}"
    );
    // A valid build of the same source still succeeds.
    let ok = Command::new(badc)
        .arg(&src)
        .arg("-o")
        .arg(dir.join("prog2"))
        .output()
        .expect("run badc");
    assert!(ok.status.success(), "valid build must still succeed");
    let _ = std::fs::remove_dir_all(&dir);
}

#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn unrecognized_input_extension_is_rejected() {
    // A compile/link mode must diagnose an unrecognized input extension
    // rather than silently reclassifying it (and every input after it)
    // as the program's argv.
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-unkext-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");
    let a = dir.join("a.c");
    let b = dir.join("b.c");
    let cc = dir.join("foo.cc");
    std::fs::write(&a, "int helper(void); int main(void){ return helper(); }\n").expect("write a");
    std::fs::write(&b, "int helper(void){ return 0; }\n").expect("write b");
    std::fs::write(&cc, "int nope(void){ return 0; }\n").expect("write cc");
    let out = Command::new(badc)
        .arg(&a)
        .arg(&cc)
        .arg(&b)
        .arg("-o")
        .arg(dir.join("prog"))
        .output()
        .expect("run badc");
    assert!(
        !out.status.success(),
        "unrecognized input extension must fail the build"
    );
    let stderr = String::from_utf8_lossy(&out.stderr);
    assert!(
        stderr.contains("unrecognized input file extension") && stderr.contains("foo.cc"),
        "expected a diagnostic naming foo.cc, got: {stderr}"
    );
    // Two valid `.c` inputs still link (b.c is not silently dropped in
    // the valid case).
    let ok = Command::new(badc)
        .arg(&a)
        .arg(&b)
        .arg("-o")
        .arg(dir.join("prog2"))
        .output()
        .expect("run badc");
    assert!(
        ok.status.success(),
        "valid multi-input native link must succeed"
    );
    let _ = std::fs::remove_dir_all(&dir);
}

// `--jobs` must not change emitted bytes. A source compiled alone (one
// TU, sequential) and the same source compiled inside a parallel `-c`
// batch produce identical objects, and a parallel batch is stable
// across runs. The reloc byte-stability gate pins per-TU determinism;
// this drives it through the CLI's worker pool.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn jobs_object_bytes_match_sequential_and_are_stable() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let root = std::env::temp_dir().join(format!("badc-jobs-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&root);
    let srcs: [(&str, &str); 6] = [
        ("a.c", "int a(int x){ return x*x + 1; }"),
        (
            "b.c",
            "long b(long x,long y){ long s=0; for(long i=0;i<y;i++) s+=x; return s; }",
        ),
        ("c.c", "double c(double p,double q){ return p*q - p/q; }"),
        (
            "d.c",
            "int d(int*p,int n){ int s=0; for(int i=0;i<n;i++) s+=p[i]; return s; }",
        ),
        (
            "e.c",
            "struct S{int a;int b;}; int e(struct S s){ return s.a - s.b; }",
        ),
        ("f.c", "float f(float a,float b){ return a<b ? a : b; }"),
    ];
    let seq = root.join("seq");
    let par1 = root.join("par1");
    let par2 = root.join("par2");
    for d in [&seq, &par1, &par2] {
        std::fs::create_dir_all(d).expect("mkdir");
        for (name, body) in &srcs {
            std::fs::write(d.join(name), body).expect("write src");
        }
    }
    let target = "linux-x64";
    // Sequential baseline: each source in its own single-input
    // invocation (one TU -> one worker -> inline, no threads).
    for (name, _) in &srcs {
        let ok = Command::new(badc)
            .arg(format!("--target={target}"))
            .arg("-c")
            .arg(name)
            .current_dir(&seq)
            .status()
            .expect("run badc")
            .success();
        assert!(ok, "sequential compile of {name} failed");
    }
    // Parallel batch: every source in one `-j8 -c` invocation. The same
    // relative labels keep the (debug-info-off) bytes path-independent.
    let run_batch = |dir: &std::path::Path| {
        let mut cmd = Command::new(badc);
        cmd.arg(format!("--target={target}"))
            .arg("-j8")
            .arg("-c")
            .current_dir(dir);
        for (name, _) in &srcs {
            cmd.arg(name);
        }
        assert!(
            cmd.status().expect("run badc").success(),
            "parallel `-j8 -c` batch failed"
        );
    };
    run_batch(&par1);
    run_batch(&par2);
    for (name, _) in &srcs {
        let o = name.replace(".c", ".o");
        let s = std::fs::read(seq.join(&o)).expect("read seq .o");
        let p1 = std::fs::read(par1.join(&o)).expect("read par1 .o");
        let p2 = std::fs::read(par2.join(&o)).expect("read par2 .o");
        assert_eq!(s, p1, "`-j8` object for {name} differs from sequential");
        assert_eq!(p1, p2, "`-j8` object for {name} not stable across runs");
    }
    let _ = std::fs::remove_dir_all(&root);
}
