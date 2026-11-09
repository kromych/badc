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

mod common;
use common::TempDir;

/// Fixtures the sweep cannot build for *every* target in
/// [`SMOKE_TARGETS`]. An exclusion that applies to one target only
/// belongs in [`TARGET_SPECIFIC_ASM`], which keeps the other target
/// covered. Each entry names the diagnostic it stands for; when a
/// fixture is excluded for a different reason on each target, both
/// are named.
const COMPILE_SKIPLIST: &[&str] = &[
    // VLA fixtures that assert a C99 constraint's rejection
    // (6.7.5.2p2 file scope, 6.7.8p3 initializer); the diagnostics are
    // locked in `src/c5/tests/vla.rs`.
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
    // <sys/syslimits.h> and <xlocale.h> are the macOS SDK's; glibc ships
    // neither, so the include fails with B1010 on both swept targets.
    "syslimits_path_max.c",
    "xlocale_extended_functions_take_a_locale.c",
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
    "unroll_multi_exit_peel_guard.c",
    "inline_zero_frame_callee_past_gate.c",
    "ipa_const_param_guard.c",
    "ipa_const_param_after_fold.c",
    "addr_null_compare_inline_param.c",
    "addr_null_compare_past_a_subobject_size_query.c",
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

/// Fixtures whose body carries inline asm specific to one ISA, or
/// includes a header only that ISA's compiler installs. The paired
/// target lacks the instruction or the header and rejects the compile
/// by design; the native target still compiles and is checked. (TODO:
/// lower these recognized asm intrinsics on the foreign target so the
/// fixtures compile everywhere.)
const TARGET_SPECIFIC_ASM: &[(&str, &str)] = &[
    ("x86_simd_intrinsics.c", "linux-aarch64"), // x86 SIMD intrinsic surface
    ("file_scope_asm_a64_relocs.c", "linux-x64"), // aarch64 stp/adrp file-scope section
    ("file_scope_asm_a64_label_diff_operand.c", "linux-x64"), // aarch64 prfm/adr file-scope section
    ("cacheflush_asm.c", "linux-x64"),          // aarch64 cache-ops / barriers
    ("atomic128_ldaxp_stlxp.c", "linux-x64"),   // aarch64 128-bit ldaxp/stlxp
    ("atomic128_ldst.c", "linux-x64"),          // aarch64 128-bit ldp/stp, ldxp/stxp
    ("atomic128_cmpxchg_llsc.c", "linux-x64"),  // aarch64 128-bit ldxp/stxp CAS (generic encoder)
    ("inline_asm_a64_dp.c", "linux-x64"),       // aarch64 mul/csel (x86 mul is 1-operand)
    ("inline_asm_a64_sym_reloc.c", "linux-x64"), // aarch64 adrp/:lo12: symbol operands
    ("inline_asm_a64_sp_operand.c", "linux-x64"), // aarch64 sp-operand add/sub
    ("inline_asm_a64_labels.c", "linux-x64"),   // aarch64 local-label branches
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
    ("inline_asm_x64_stream_branches.c", "linux-aarch64"), // x86-64 stream-branch relaxation
    ("inline_asm_x64_paren_disp.c", "linux-aarch64"),  // x86-64 rip-relative label address
    ("inline_asm_x64_seg_prefix_wrpkru.c", "linux-aarch64"), // x86-64 segment prefix / wrpkru
    ("inline_asm_x64_crc32.c", "linux-aarch64"),       // x86-64 SSE4.2 crc32
    ("inline_asm_x64_label_directive.c", "linux-aarch64"), // x86-64 label sharing a directive statement
    ("inline_asm_x64_setcc.c", "linux-aarch64"),           // x86-64 setcc
    ("inline_asm_x64_cmov.c", "linux-aarch64"),            // x86-64 cmovcc
    ("inline_asm_x64_bound_operands.c", "linux-aarch64"),  // x86-64 bound register operands
    ("inline_asm_x64_bound_scratch_pressure.c", "linux-aarch64"), // x86-64 bound operands
    ("inline_asm_x64_staged_operand_pool.c", "linux-aarch64"), // x86-64 staged `r` operand pool
    ("inline_asm_x64_cdqe.c", "linux-aarch64"),            // x86-64 cdqe
    ("inline_asm_x64_movnti.c", "linux-aarch64"),          // x86-64 movnti/sfence
    ("inline_asm_x64_raid6_syndrome.c", "linux-aarch64"),  // x86-64 AVX2 / AVX-512 RAID-6 syndrome
    ("inline_asm_x64_clflush.c", "linux-aarch64"),         // x86-64 clflush/prefetch
    ("inline_asm_x64_prefetch.c", "linux-aarch64"),        // x86-64 prefetch hint family
    ("inline_asm_x64_setjmp_label.c", "linux-aarch64"),    // x86-64 asm context switch
    ("inline_asm_x64_setjmp_region_slices.c", "linux-aarch64"), // x86-64 asm context switch
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
    ("inline_asm_x64_trap_site_org.c", "linux-aarch64"),       // x86-64 ud2 trap-table entry
    ("inline_asm_x64_patch_site.c", "linux-aarch64"),          // x86-64 jmp %l jump-table entry
    ("inline_asm_x64_m_global_call.c", "linux-aarch64"), // x86-64 indirect call through an "m" operand
    ("inline_asm_a64_trap_site_labels.c", "linux-x64"),  // aarch64 brk trap-table entry
    ("get_cpuid_leaf_checks.c", "linux-aarch64"),        // gcc's x86 <cpuid.h>, absent on aarch64
];

/// Targets the sweep below builds every fixture for. Also the set the
/// second column of `TARGET_SPECIFIC_ASM` must name.
const SMOKE_TARGETS: &[&str] = &["linux-aarch64", "linux-x64"];

/// Absolute path of `tests/fixtures/c`.
/// The flags a fixture pins for itself in a leading
/// `// snapshot-flags: ...` line, the same directive
/// `scripts/snapshots.py` reads. Empty when the fixture pins none.
fn snapshot_flags(fixture: &std::path::Path) -> Vec<String> {
    let Ok(text) = std::fs::read_to_string(fixture) else {
        return Vec::new();
    };
    text.lines()
        .find_map(|l| l.trim_start().strip_prefix("// snapshot-flags:"))
        .map(|rest| rest.split_whitespace().map(str::to_string).collect())
        .unwrap_or_default()
}

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

    let tmp_root = TempDir::new("badc-cli-smoke");

    let mut failures: Vec<String> = Vec::new();
    let mut attempts = 0usize;
    for fixture in &entries {
        let name = fixture.file_name().unwrap().to_str().unwrap();
        if COMPILE_SKIPLIST.contains(&name) || DEAD_BRANCH_NEEDS_OPTIMIZE.contains(&name) {
            continue;
        }
        // A fixture states the flags it is compiled under in the same
        // `snapshot-flags:` directive the snapshot generator reads, so
        // one declaration drives both and neither can drift. `-c` names
        // a unit that has no `main` to link, which this sweep cannot
        // build; those stay on the skiplist.
        let flags = snapshot_flags(fixture);
        if flags.iter().any(|f| f == "-c") {
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
                .args(&flags)
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
    ("neon_raid6_checksum.c", 0),
    ("goto_cleanup_scopes.c", 0),
    ("scope_exit_storage.c", 0),
    ("early_return_before_frame.c", 0),
    ("inline_asm_stack_switch_spill.c", 0),
    ("far_frame_slots.c", 0),
    ("overaligned_region_storage.c", 0),
    ("aggregate_copy_site_temps.c", 0),
    ("aggregate_register_parts.c", 0),
    ("call_result_in_place.c", 0),
    ("atomic_orders.c", 0),
    ("atomic_contention.c", 0),
    ("atomic_operators_two_threads.c", 0),
    ("data_reloc_one_past_end.c", 10),
    ("constant_set_again_after_call.c", 0),
    ("asm_register_outputs.c", 0),
    // An inline-asm section holding PC-relative fields against a text label
    // and a string operand, which only the object-then-link path relocates.
    ("inline_asm_section_symbol_minus_label.c", 42),
    ("static_init_cast_funcptr.c", 0),
    ("static_init_paren_relocation.c", 0),
    ("sys_addr_in_static_init.c", 42),
    ("variadic_libc_fnptr_static_init.c", 0),
    ("forward_fn_ptr_in_static_init.c", 0),
    ("attributed_aggregate_align_floor.c", 0),
    ("string_concat_encoding_prefix.c", 0),
    ("utf8_string_prefix_ucn.c", 0),
    ("extended_identifiers.c", 0),
    ("overaligned_data_placement.c", 0),
    ("overaligned_bss_placement.c", 0),
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
    ("attribute_alias_keeps_declared_type.c", 0),
    ("c99_float_math_and_vsscanf.c", 0),
    ("weak_definition_not_inlined.c", 42),
    ("weak_alias_call_not_inlined.c", 42),
    ("weak_extern_data_address.c", 0),
    ("tentative_array_definition.c", 0),
    ("tentative_deferred_array_grows.c", 0),
    ("tentative_definition_completed_later.c", 0),
    ("thread_local_basic.c", 0),
    ("thread_local_gnu.c", 0),
    ("thread_local_initializer.c", 0),
    ("thread_local_address_init.c", 0),
    ("thread_local_per_thread.c", 0),
    ("thread_local_address_per_thread.c", 0),
    ("thread_local_image_alignment.c", 0),
    ("thread_local_tentative_array.c", 0),
    ("thread_local_tentative_completed_later.c", 0),
    ("thread_local_aggregate_initializers.c", 0),
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
    ("pragma_pack_bitfield_layout.c", 0),
    ("pragma_pack_push_pop_forms.c", 0),
    ("bitnot_promoted_compare.c", 0),
    ("packed_bitfield_struct_by_value.c", 0),
    ("addr_compare_disjoint_blocks.c", 0),
    ("unsigned_bitwise_mixed_sign.c", 0),
    ("dead_arm_static_callee.c", 0),
    ("param_incoming_reg_constant_clobber.c", 0),
    ("forward_enum_tag_redeclaration.c", 0),
    ("seh_context_record.c", 0),
    ("unwind_restores_callee_saved.c", 0),
    ("unwind_from_epilogue.c", 0),
    ("seh_except_constant_filter.c", 0),
    ("seh_except_filter.c", 0),
    ("seh_finally.c", 0),
    ("seh_nested_funclets.c", 0),
    ("seh_in_named_code_section.c", 0),
    ("named_code_section_bounds.c", 0),
    ("named_data_section_bounds.c", 0),
    ("unsigned_constant_to_floating.c", 0),
    ("string_literal_address_constant.c", 0),
    ("address_constant_through_cast.c", 0),
    ("local_byte_array_init_converts.c", 0),
    ("address_to_bool_initializer.c", 0),
    ("address_constant_array_strides.c", 0),
    ("const_object_address_read.c", 0),
    ("const_bit_field_read.c", 0),
    ("induction_variable_steps.c", 0),
    ("wrap_signed.c", 0),
    ("long_double_parameter_shapes.c", 0),
    ("long_double_usual_conversions.c", 0),
    ("long_double_call_shapes.c", 0),
    ("long_double_math.c", 0),
    ("declared_object_copied_whole.c", 0),
    ("merged_chain_empty_edge_block.c", 0),
    ("address_retested_after_calls.c", 0),
    ("inlined_struct_return_lifetime.c", 0),
    // Stores to the C library's getopt state, a data import, which only the
    // object-then-link path writes correctly on ELF.
    ("getopt_long_permutes_operands.c", 0),
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
    let tmp_root = TempDir::new("badc-cli-run");

    let mut failures: Vec<String> = Vec::new();
    for (name, expected) in LINKED_IMAGE_RUN_FIXTURES {
        let pinned = snapshot_flags(&dir.join(name));
        for (tag, flags) in [("-O0", &[][..]), ("-O", &["-O"][..])] {
            let stem = name.trim_end_matches(".c");
            let out = tmp_root.join(format!("{stem}{tag}"));
            let built = Command::new(badc)
                .arg(format!("--target={target}"))
                .args(flags)
                .args(&pinned)
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
/// `-fsyntax-only` as gcc 16 runs it: each unit through the front end (an
/// assembler unit through the assembler) with its diagnostics and status,
/// no output written whatever `-o` or `-c` asks for, and `-E` taking
/// precedence.
#[test]
fn syntax_only_checks_units_and_writes_nothing() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-syntax-only");
    for (name, body) in [
        ("ok.c", "int main(void) { return 0; }\n"),
        ("bad.c", "int main(void) { return x; }\n"),
        ("warn.c", "int main(void) { int unused; return 0; }\n"),
        ("good.s", "\t.text\n\tnop\n"),
        ("bad.s", "garbage instruction here\n"),
    ] {
        std::fs::write(dir.join(name), body).expect("write unit");
    }
    let run = |args: &[&str]| {
        Command::new(badc)
            .arg("-fsyntax-only")
            .args(args)
            .current_dir(&dir)
            .output()
            .expect("run badc")
    };
    for args in [
        &["ok.c"][..],
        &["-o", "out.o", "ok.c"],
        &["-c", "ok.c"],
        &["good.s"],
    ] {
        let out = run(args);
        assert!(
            out.status.success(),
            "{args:?}: {}",
            String::from_utf8_lossy(&out.stderr)
        );
    }
    for written in ["out.o", "ok.o", "a.out", "good.o"] {
        assert!(!dir.join(written).exists(), "{written} written");
    }
    for (args, needle) in [
        (&["bad.c"][..], "undefined variable x"),
        (&["-Wall", "-Werror", "warn.c"], "unused variable"),
        (&["ok.c", "bad.c"], "undefined variable x"),
        (&["bad.s"], "garbage instruction here"),
    ] {
        let out = run(args);
        let err = String::from_utf8_lossy(&out.stderr);
        assert!(
            !out.status.success() && err.contains(needle),
            "{args:?}: {err}"
        );
    }
    let out = run(&["-E", "ok.c"]);
    assert!(String::from_utf8_lossy(&out.stdout).contains("int main(void)"));
}

#[test]
fn quoted_include_resolves_relative_to_including_file() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-qinc");
    let sub = dir.join("sub");
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
    let dir = TempDir::new("badc-deadbr");
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
}

// A 16-byte read-modify-write is atomic under contention: four threads
// adding to one `unsigned __int128` whose sum carries into the high half
// lose no update, at -O0 and -O.
#[cfg(unix)]
#[test]
fn int128_atomics_hold_under_contention() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-atomic128");
    let src = dir.join("a.c");
    std::fs::write(
        &src,
        "#include <pthread.h>\ntypedef unsigned __int128 u128;\n\
         static u128 counter = ((u128)1 << 64) - 100000;\n\
         static void *work(void *arg) {\n\
           (void)arg;\n\
           for (int i = 0; i < 100000; i++) __atomic_fetch_add(&counter, 1, __ATOMIC_SEQ_CST);\n\
           return 0;\n\
         }\n\
         int main(void) {\n\
           pthread_t t[4];\n\
           for (int i = 0; i < 4; i++) pthread_create(&t[i], 0, work, 0);\n\
           for (int i = 0; i < 4; i++) pthread_join(t[i], 0);\n\
           return counter == ((u128)1 << 64) + 300000 ? 0 : 1;\n\
         }\n",
    )
    .expect("write a.c");
    let exe = dir.join("a");
    for level in ["-O0", "-O"] {
        let out = Command::new(badc)
            .args(["-q", level])
            .arg(&src)
            .arg("-o")
            .arg(&exe)
            .output()
            .expect("run badc");
        assert!(
            out.status.success(),
            "{level}: {}",
            String::from_utf8_lossy(&out.stderr)
        );
        let run = Command::new(&exe).output().expect("run program");
        assert_eq!(run.status.code(), Some(0), "{level}: an update was lost");
    }
}

// `-E` output keeps the builtins as calls, as gcc's does, and the `.i`
// unit takes them. `__builtin_nan` of an operand other than a literal
// spelling a number calls `nan` (C99 7.12.11.2), which the bundled
// <math.h> binds on every target; the payload is the library's, which
// the Universal CRT ignores. The exit status has bit 0 for a wrong
// runtime NaN and bit 1 for a wrong literal one.
#[test]
fn a_preprocessed_unit_calls_nan_for_a_runtime_payload() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-builtin-nan");
    let src = dir.join("n.c");
    std::fs::write(
        &src,
        "#include <math.h>\n\
         #ifdef _WIN32\n#define LIBRARY_PAYLOAD 0\n#else\n#define LIBRARY_PAYLOAD 0x10\n#endif\n\
         static unsigned long long bits(double d) {\n\
           union { double d; unsigned long long u; } v = { d }; return v.u; }\n\
         int main(int argc, char **argv) {\n\
           const char *s = __builtin_expect(argc > 5, 0) ? argv[0] : \"0x10\";\n\
           unsigned long long lib = LIBRARY_PAYLOAD;\n\
           return (bits(__builtin_nan(s)) != (0x7ff8000000000000ull | lib))\n\
             | (bits(__builtin_nan(\"0x10\")) != 0x7ff8000000000010ull) << 1;\n\
         }\n",
    )
    .expect("write n.c");
    let unit = dir.join("n.i");
    let out = Command::new(badc)
        .args(["-q", "-E"])
        .arg(&src)
        .arg("-o")
        .arg(&unit)
        .output()
        .expect("run badc -E");
    assert!(
        out.status.success(),
        "{}",
        String::from_utf8_lossy(&out.stderr)
    );
    let text = std::fs::read_to_string(&unit).expect("read n.i");
    assert!(text.contains("__builtin_nan(s)"), "{text}");
    let exe = dir.join(format!("n{}", std::env::consts::EXE_SUFFIX));
    for level in ["-O0", "-O"] {
        let out = Command::new(badc)
            .args(["-q", level])
            .arg(&unit)
            .arg("-o")
            .arg(&exe)
            .output()
            .expect("run badc");
        assert!(
            out.status.success(),
            "{level}: {}",
            String::from_utf8_lossy(&out.stderr)
        );
        let run = Command::new(&exe).output().expect("run program");
        assert_eq!(run.status.code(), Some(0), "{level}");
    }
}

// A `#pragma binding` declares nothing: with msvc_compat.h's bindings in
// scope, a call to `malloc` the unit has not declared takes <stdlib.h>'s
// prototype, and the pointer it returns from above 4 GiB survives. Built for
// windows-x64 and windows-arm64 from every host at -O0 and -O, and run on
// the Windows host of either. Where the header cannot be auto-included the
// call is refused, not lowered as an `int` function.
#[test]
fn a_binding_alone_leaves_a_library_call_its_prototype() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-binding-prototype");
    let src = fixtures_dir().join("undeclared_library_call_keeps_a_high_pointer.c");
    let host = match (std::env::consts::OS, std::env::consts::ARCH) {
        ("windows", "aarch64") => Some("windows-arm64"),
        ("windows", _) => Some("windows-x64"),
        _ => None,
    };
    for target in ["windows-x64", "windows-arm64"] {
        let flag = format!("--target={target}");
        for level in ["-O0", "-O"] {
            let exe = dir.join(format!("{target}{level}.exe"));
            let out = Command::new(badc)
                .args(["-q", &flag, level, "-include", "msvc_compat.h"])
                .arg(&src)
                .arg("-o")
                .arg(&exe)
                .output()
                .expect("run badc");
            let err = String::from_utf8_lossy(&out.stderr);
            assert!(out.status.success(), "{target} {level}: {err}");
            assert!(!err.contains("B2005"), "{target} {level}: {err}");
            if host == Some(target) {
                let run = Command::new(&exe).output().expect("run the program");
                assert_eq!(run.status.code(), Some(0), "{target} {level}");
            }
        }
        let out = Command::new(badc)
            .args([
                "-q",
                &flag,
                "-ffreestanding",
                "-include",
                "msvc_compat.h",
                "-c",
            ])
            .arg(&src)
            .arg("-o")
            .arg(dir.join(format!("{target}.o")))
            .output()
            .expect("run badc");
        let err = String::from_utf8_lossy(&out.stderr);
        assert!(!out.status.success(), "{target} -ffreestanding");
        assert!(err.contains("unknown function `malloc`"), "{target}: {err}");
    }
}

/// Run `exe`, its exit code; `None` once it has run `secs` seconds, when the
/// process is killed.
fn run_with_deadline(exe: &std::path::Path, secs: u64) -> Option<i32> {
    let mut child = Command::new(exe).spawn().expect("start the program");
    let deadline = std::time::Instant::now() + std::time::Duration::from_secs(secs);
    loop {
        if let Some(status) = child.try_wait().expect("wait for the program") {
            return status.code();
        }
        if std::time::Instant::now() > deadline {
            let _ = child.kill();
            let _ = child.wait();
            return None;
        }
        std::thread::sleep(std::time::Duration::from_millis(20));
    }
}

// C17 7.17.2.2: `atomic_init` gives allocated storage a valid state without
// taking the lock word its 0xff bytes hold. Freestanding on every host, the
// layout every target then takes, and hosted on Windows, at -O0 and -O.
#[test]
fn atomic_init_gives_allocated_storage_a_valid_state() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-atomic-init");
    let src = fixtures_dir().join("atomic_init_gives_allocated_storage_a_valid_state.c");
    let mut modes = vec!["-ffreestanding"];
    if cfg!(windows) {
        modes.push("-fhosted");
    }
    for mode in modes {
        for level in ["-O0", "-O"] {
            let exe = dir.join(format!("init{mode}{level}.exe"));
            let out = Command::new(badc)
                .args(["-q", mode, level])
                .arg(&src)
                .arg("-o")
                .arg(&exe)
                .output()
                .expect("run badc");
            let err = String::from_utf8_lossy(&out.stderr);
            assert!(out.status.success(), "{mode} {level}: {err}");
            assert_eq!(run_with_deadline(&exe, 30), Some(0), "{mode} {level}");
        }
    }
}

// strtod and printf called with no header included. For windows-x64 and
// windows-arm64 the bundled C library defines both and no header binds them
// to a DLL, so the link resolves the calls without compiling the unit again.
// Built from every host at -O0 and -O, and run on the Windows host of either.
#[test]
fn undeclared_library_calls_keep_the_header_types_on_windows() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-undeclared-library-calls");
    let src = fixtures_dir().join("undeclared_library_calls_keep_the_header_types.c");
    let host = match (std::env::consts::OS, std::env::consts::ARCH) {
        ("windows", "aarch64") => Some("windows-arm64"),
        ("windows", _) => Some("windows-x64"),
        _ => None,
    };
    for target in ["windows-x64", "windows-arm64"] {
        let flag = format!("--target={target}");
        for level in ["-O0", "-O"] {
            let exe = dir.join(format!("{target}{level}.exe"));
            let out = Command::new(badc)
                .args([&flag, level])
                .arg(&src)
                .arg("-o")
                .arg(&exe)
                .output()
                .expect("run badc");
            let err = String::from_utf8_lossy(&out.stderr);
            assert!(out.status.success(), "{target} {level}: {err}");
            assert!(
                err.contains("auto-including <stdlib.h>"),
                "{target} {level}: {err}"
            );
            assert!(!err.contains("rebinding"), "{target} {level}: {err}");
            if host == Some(target) {
                let run = Command::new(&exe).output().expect("run the program");
                assert_eq!(run.status.code(), Some(0), "{target} {level}");
                let stdout = String::from_utf8_lossy(&run.stdout).replace('\r', "");
                assert_eq!(stdout, "1.50\n", "{target} {level}");
            }
        }
    }
}

// gcc and clang give each `__builtin_` library function its prototype with
// no declaration in scope. Under `-nostdinc`, `-ffreestanding` and for a
// preprocessed unit no header can be auto-included; the fixture still links
// for linux-x64 and windows-x64 from every host, at -O0 and -O, and runs to
// 0 for the host's own target.
#[test]
fn builtin_library_functions_link_without_a_declaration() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-builtin-prototypes");
    let src = fixtures_dir().join("builtin_library_functions_need_no_declaration.c");
    let host = match (std::env::consts::OS, std::env::consts::ARCH) {
        ("macos", _) => "macos-aarch64",
        ("windows", "aarch64") => "windows-arm64",
        ("windows", _) => "windows-x64",
        (_, "aarch64") => "linux-aarch64",
        _ => "linux-x64",
    };
    let mut targets = vec!["linux-x64", "windows-x64"];
    if !targets.contains(&host) {
        targets.push(host);
    }
    let build = |args: &[&std::ffi::OsStr], what: &str| {
        let out = Command::new(badc).arg("-q").args(args).output();
        let out = out.expect("run badc");
        let err = String::from_utf8_lossy(&out.stderr);
        assert!(out.status.success(), "{what}: {err}");
    };
    let suffix = std::env::consts::EXE_SUFFIX;
    for target in targets {
        let flag = format!("--target={target}");
        let unit = dir.join(format!("{target}.i"));
        let preprocess = [
            flag.as_ref(),
            "-nostdinc".as_ref(),
            "-E".as_ref(),
            src.as_ref(),
            "-o".as_ref(),
            unit.as_ref(),
        ];
        build(&preprocess, target);
        for (mode, input) in [("-nostdinc", &src), ("-ffreestanding", &src), (".i", &unit)] {
            for level in ["-O0", "-O"] {
                let what = format!("{target} {mode} {level}");
                let exe = dir.join(format!("{target}{mode}{level}{suffix}"));
                let mut args = vec![flag.as_ref(), level.as_ref()];
                if mode != ".i" {
                    args.push(mode.as_ref());
                }
                args.extend([input.as_os_str(), "-o".as_ref(), exe.as_os_str()]);
                build(&args, &what);
                if target == host {
                    let run = Command::new(&exe).output().expect("run the program");
                    assert_eq!(run.status.code(), Some(0), "{what}");
                }
            }
        }
    }
}

// C99 6.10.8p1: `__STDC_HOSTED__` is 1 for a hosted implementation and 0
// for a freestanding one. As under gcc, `-ffreestanding` (`-fno-hosted`)
// selects the latter for `-E`, `-dM -E` and a compiled unit, a later
// `-fhosted` (`-fno-freestanding`) restores the former, and `-fbuiltin` /
// `-fno-builtin` leave it alone. A freestanding unit gets no auto-included
// header for an undeclared library call, and `<xmmintrin.h>` declares
// `_mm_malloc` from `<mm_malloc.h>` only when hosted.
#[test]
fn ffreestanding_makes_stdc_hosted_zero() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-stdc-hosted");
    let src = dir.join("h.c");
    std::fs::write(
        &src,
        "int hosted = __STDC_HOSTED__;\n\
         int main(void) {\n\
         #if __STDC_HOSTED__\n  return 3;\n#else\n  return 4;\n#endif\n}\n",
    )
    .expect("write h.c");
    let badc_out = |args: &[&str], input: &std::path::Path| {
        let out = Command::new(badc).arg("-q").args(args).arg(input).output();
        let out = out.expect("run badc");
        let text = String::from_utf8_lossy(&out.stdout).into_owned();
        let err = String::from_utf8_lossy(&out.stderr).into_owned();
        (out.status.success(), text, err)
    };
    let exe = dir.join(format!("h{}", std::env::consts::EXE_SUFFIX));
    let exe_arg = exe.to_str().expect("path");
    for (flags, hosted) in [
        (&[][..], 1),
        (&["-ffreestanding"][..], 0),
        (&["-fno-hosted"][..], 0),
        (&["-ffreestanding", "-fbuiltin"][..], 0),
        (&["-ffreestanding", "-fhosted"][..], 1),
        (&["-ffreestanding", "-fno-freestanding"][..], 1),
        (&["-fno-builtin"][..], 1),
    ] {
        let (ok, text, err) = badc_out(&[flags, &["-E"]].concat(), &src);
        let line = format!("int hosted = {hosted};");
        assert!(ok && text.contains(&line), "{flags:?}: {err}");
        let (ok, text, err) = badc_out(&[flags, &["-dM", "-E"]].concat(), &src);
        let line = format!("#define __STDC_HOSTED__ {hosted}\n");
        assert!(ok && text.contains(&line), "{flags:?} -dM: {err}");
        let (ok, _, err) = badc_out(&[flags, &["-o", exe_arg]].concat(), &src);
        assert!(ok, "{flags:?}: {err}");
        let run = Command::new(&exe).output().expect("run h");
        assert_eq!(run.status.code(), Some(4 - hosted), "{flags:?}");
    }
    let call = dir.join("call.c");
    std::fs::write(&call, "int main(void) { return puts(\"x\") < 0; }\n").expect("write");
    let (ok, _, err) = badc_out(&["-ffreestanding", "-fbuiltin", "-c", "-o", exe_arg], &call);
    assert!(!ok && err.contains("puts"), "{err}");
    let sse = dir.join("sse.c");
    std::fs::write(&sse, "#include <xmmintrin.h>\n").expect("write sse.c");
    for (flags, declared) in [(&[][..], true), (&["-ffreestanding"][..], false)] {
        let args = [flags, &["--target=linux-x64", "-E"]].concat();
        let (ok, text, err) = badc_out(&args, &sse);
        assert!(ok, "{flags:?}: {err}");
        assert_eq!(text.contains("mm_malloc.h"), declared, "{flags:?}");
        assert_eq!(text.contains("_mm_malloc"), declared, "{flags:?}");
    }
}

// gcc and clang print the preprocessor's diagnostics under `-E` to stderr as
// a compile does, under the same `-W` controls, `-Werror` and `-w`; stdout
// carries the same text whatever they report, and an error among them, or an
// `#error`, fails the run. `-dM -E`, `-M`, `-MM` and `-fsyntax-only` report
// the same rows.
/// The compiler's own headers are one set on the `#include` search, as
/// gcc's and clang's: `-nostdinc` drops them with the C library's,
/// `-isystem $(badc -print-file-name=include)` restores them, and
/// `-nostdlibinc` keeps them. Each outcome is clang 22's for the same unit
/// and flags on Linux x86_64 and aarch64, and Apple clang 21's on macOS.
/// On x86-64 a hosted `<xmmintrin.h>` includes `<mm_malloc.h>`, which
/// reaches for `<stdlib.h>`; that is the C library's, and not found.
#[test]
fn nostdinc_takes_the_compiler_headers_off_and_its_include_dir_restores_them() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let out = Command::new(badc)
        .arg("-print-file-name=include")
        .output()
        .expect("run badc");
    let inc = String::from_utf8(out.stdout).expect("utf-8 path");
    let inc = inc.trim_end();
    let tail = std::path::Path::new("lib").join("badc").join("include");
    assert!(std::path::Path::new(inc).ends_with(&tail), "{inc}");
    let dir = TempDir::new("badc-nostdinc-modes");
    let body = "#include <stdarg.h>\n#include <stdint.h>\n\
                int f(int n, ...) { va_list ap; va_start(ap, n); int v = va_arg(ap, int); \
                va_end(ap); return v; }\nint32_t g(void) { return 1; }\n";
    // The target, the header ahead of that body, the flags, and what the
    // run reports missing (`None`: it compiles). The directory serves the
    // compiler's headers and nothing else, so `<stdio.h>` stays missing.
    type Case<'a> = (&'a str, &'a str, &'a [&'a str], Option<&'a str>);
    let (x64, a64, io) = ("immintrin.h", "arm_neon.h", "stdio.h");
    #[rustfmt::skip]
    let cases: &[Case] = &[
        ("linux-x64", x64, &["-nostdinc"], Some(x64)),
        ("linux-x64", x64, &["-nostdinc", "-isystem", inc], Some("stdlib.h")),
        ("linux-x64", x64, &["-nostdlibinc"], Some("stdlib.h")),
        ("linux-x64", x64, &["-nostdinc", "-isystem", inc, "-ffreestanding"], None),
        ("linux-x64", x64, &["-nostdlibinc", "-ffreestanding"], None),
        ("linux-x64", io, &["-nostdinc", "-isystem", inc], Some(io)),
        ("linux-x64", io, &["-nostdlibinc"], Some(io)),
        ("macos-aarch64", a64, &["-nostdinc"], Some(a64)),
        ("macos-aarch64", a64, &["-nostdinc", "-isystem", inc], None),
        ("macos-aarch64", a64, &["-nostdinc", "-I", inc], None),
        ("macos-aarch64", a64, &["-nostdlibinc"], None),
    ];
    let src = dir.join("unit.c");
    for &(target, header, flags, missing) in cases {
        std::fs::write(&src, format!("#include <{header}>\n{body}")).expect("write unit");
        let out = Command::new(badc)
            .arg(format!("--target={target}"))
            .args(flags)
            .arg("-fsyntax-only")
            .arg(&src)
            .output()
            .expect("run badc");
        let err = String::from_utf8_lossy(&out.stderr);
        let what = format!("{target} <{header}> {flags:?}: {err}");
        match missing {
            None => assert!(out.status.success(), "{what}"),
            Some(name) => assert!(
                !out.status.success() && err.contains(&format!("`{name}` not found")),
                "{what}"
            ),
        }
    }
}

#[test]
fn preprocessing_alone_reports_the_preprocessors_diagnostics() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-pp-diagnostics");
    let src = dir.join("w.c");
    std::fs::write(
        &src,
        "#warning hi\n#define A 1\n#define A 2\n#define D defined(X)\n#if D\n#endif\nint x = A;\n",
    )
    .expect("write w.c");
    let run = |flags: &[&str], input: &std::path::Path| {
        let mut cmd = Command::new(badc);
        cmd.arg("--target=linux-x64").args(flags).arg(input);
        cmd.output().expect("run badc")
    };
    let all = &["[B1002]", "[B1015]", "[B1016]"][..];
    // The rows each stderr line reports at `level`.
    let rows = |out: &std::process::Output, level: &str| -> Vec<&'static str> {
        let err = String::from_utf8_lossy(&out.stderr);
        let at = |code: &str| err.lines().any(|l| l.contains(level) && l.contains(code));
        all.iter().copied().filter(|c| at(c)).collect()
    };
    let text = run(&["-E", "-w"], &src).stdout;
    assert!(String::from_utf8_lossy(&text).contains("int x = 2;"));
    // The flags, whether the run succeeds, and the rows warned and failed.
    type Case<'a> = (&'a [&'a str], bool, &'a [&'a str], &'a [&'a str]);
    #[rustfmt::skip]
    let cases: &[Case] = &[
        (&["-E"], true, &["[B1002]", "[B1015]"], &[]),
        (&["-E", "-Wextra"], true, all, &[]),
        (&["-E", "-Wextra", "-Werror"], false, &[], all),
        (&["-E", "-Werror", "-Wno-error=#warnings"], false, &["[B1002]"], &["[B1015]"]),
        (&["-E", "-Wno-#warnings", "-Wno-macro-redefined"], true, &[], &[]),
        (&["-E", "-Wextra", "-w"], true, &[], &[]),
        (&["-E", "-dM", "-Wextra"], true, all, &[]),
        (&["-M", "-Wextra"], true, all, &[]),
        (&["-MM", "-Wextra", "-Werror"], false, &[], all),
        (&["-fsyntax-only", "-Wextra"], true, all, &[]),
    ];
    for &(flags, ok, warned, failed) in cases {
        let out = run(flags, &src);
        let what = format!("{flags:?}: {}", String::from_utf8_lossy(&out.stderr));
        assert_eq!(out.status.success(), ok, "{what}");
        assert_eq!(rows(&out, "warning: "), warned, "{what}");
        assert_eq!(rows(&out, "error: "), failed, "{what}");
        if flags[0] == "-E" && !flags.contains(&"-dM") {
            assert_eq!(out.stdout, text, "{what}");
        }
    }
    let stop = dir.join("e.c");
    std::fs::write(&stop, "#error stop here\nint x;\n").expect("write e.c");
    let out = run(&["-E"], &stop);
    let err = String::from_utf8_lossy(&out.stderr);
    let stopped = err.contains("#error stop here");
    assert!(!out.status.success() && stopped, "{err}");
}

/// `-E` past a preprocessor error, as gcc 16 does: an `#error` (each one
/// reported, from a header too) or an unterminated `#if` fails the run
/// after the whole unit is written; a missing include ends the unit there,
/// as gcc's fatal error does, after the text before it. An `#error` in a
/// skipped group is no error. The text is gcc 16's `-E -P` output with its
/// blank lines dropped; clang 22 writes the same, except that it goes on
/// past a missing include. `-dM -E` and `-M` go on past an `#error` too,
/// and a compile reports every `#error`.
#[test]
fn preprocessing_goes_past_an_error_directive_and_still_fails() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-pp-past-error");
    std::fs::write(dir.join("h.h"), "#error in header\nint h;\n").expect("write h.h");
    let run = |flags: &[&str], body: &str| {
        let src = dir.join("u.c");
        std::fs::write(&src, body).expect("write u.c");
        let out = Command::new(badc)
            .arg("--target=linux-x64")
            .args(flags)
            .arg(&src)
            .output()
            .expect("run badc");
        let text = String::from_utf8_lossy(&out.stdout);
        let lines: Vec<String> = text
            .lines()
            .filter(|l| !l.trim().is_empty())
            .map(str::to_string)
            .collect();
        let stderr = String::from_utf8_lossy(&out.stderr);
        let errors = stderr.matches("error:").count();
        (out.status.success(), lines, errors)
    };
    // The unit, gcc's text, and the errors it reports.
    type Case<'a> = (&'a str, &'a [&'a str], usize);
    #[rustfmt::skip]
    let cases: &[Case] = &[
        ("int a;\n#error first\nint b;\n", &["int a;", "int b;"], 1),
        ("int a;\n#if 0\n#error skipped\n#endif\nint b;\n", &["int a;", "int b;"], 0),
        ("int a;\n#error one\nint b;\n#error two\nint c;\n", &["int a;", "int b;", "int c;"], 2),
        ("int a;\n#include \"missing.h\"\nint b;\n", &["int a;"], 1),
        ("int a;\n#if 1\nint b;\n", &["int a;", "int b;"], 1),
        ("int a;\n#include \"h.h\"\nint b;\n", &["int a;", "int h;", "int b;"], 1),
        ("int a;\n#define X 1\n#error x is X\nint b = X;\n", &["int a;", "int b = 1;"], 1),
        ("int a;\n#include \"missing.h\"\nint b;\n#error after\nint c;\n", &["int a;"], 1),
    ];
    for &(body, text, errors) in cases {
        let (ok, lines, got) = run(&["-E", "-P"], body);
        let same = ok == (errors == 0) && lines == text && got == errors;
        assert!(same, "{body}\n{lines:?}");
    }
    let two = "#define BEFORE 1\n#error one\n#define AFTER 2\n#error two\nint c;\n";
    let (ok, macros, errors) = run(&["-dM", "-E"], two);
    let after = macros.iter().any(|l| l == "#define AFTER 2");
    assert!(!ok && errors == 2 && after, "{macros:?}");
    let (ok, rule, errors) = run(&["-M"], two);
    let written = rule.iter().any(|l| l.contains("u.c"));
    assert!(!ok && errors == 2 && written, "{rule:?}");
    let (ok, _, errors) = run(&["-fsyntax-only"], two);
    assert!(!ok && errors == 2);
}

// `-ffp-contract=` selects where `-O` contracts a product with the add or
// subtract using it (C99 6.5p8): `on`, the default, within one
// expression; `fast` across statements too; `off` nowhere. With a = 1 +
// 2^-30 and c = 1 + 2^-29, a*a - c is 2^-60 contracted and 0 otherwise;
// the exit status has bit 0 for the one-expression form contracted and
// bit 1 for the form across a declaration.
#[test]
fn fp_contract_selects_where_products_contract() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-fp-contract");
    let src = dir.join("c.c");
    std::fs::write(
        &src,
        "volatile double va = 1.0 + 0x1p-30, vc = 1.0 + 0x1p-29;\n\
         double within(double a, double c) { return a * a - c; }\n\
         double across(double a, double c) { double p = a * a; return p - c; }\n\
         int main(void) { return (within(va, vc) != 0) | (across(va, vc) != 0) << 1; }\n",
    )
    .expect("write c.c");
    let exe = dir.join(format!("c{}", std::env::consts::EXE_SUFFIX));
    for (args, want) in [
        (&["-O0"][..], 0),
        (&["-O"][..], 1),
        (&["-O", "-ffp-contract=on"][..], 1),
        (&["-O", "-ffp-contract=fast"][..], 3),
        (&["-O", "-ffp-contract=off"][..], 0),
    ] {
        let out = Command::new(badc)
            .args(args)
            .arg(&src)
            .arg("-o")
            .arg(&exe)
            .output()
            .expect("run badc");
        assert!(
            out.status.success(),
            "{args:?}: {}",
            String::from_utf8_lossy(&out.stderr)
        );
        let run = Command::new(&exe).output().expect("run program");
        assert_eq!(run.status.code(), Some(want), "{args:?}");
    }
    let out = Command::new(badc)
        .args(["-ffp-contract=always", "-c"])
        .arg(&src)
        .output()
        .expect("run badc");
    assert!(
        !out.status.success()
            && String::from_utf8_lossy(&out.stderr).contains("unsupported argument `always`"),
        "{}",
        String::from_utf8_lossy(&out.stderr)
    );
}

// A callee marked `always_inline` / `__forceinline` that the inliner
// cannot substitute (here: a variadic body) draws a diagnostic naming
// the function and the reason, so a silently-unhonored mandatory inline
// request is visible, at every level. A body the inliner can substitute
// stays silent.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn always_inline_not_honored_warns() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-ai");

    for level in ["-O", "-O0"] {
        let compile = |src: &std::path::Path, obj: &str| {
            Command::new(badc)
                .arg("--target=linux-x64")
                .arg(level)
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
    }
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
    let dir = TempDir::new("badc-optlvl");
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
// the objects are identical.
#[test]
fn code_model_values_follow_the_target() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-cmodel");
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
}

// `-O` predefines `__OPTIMIZE__=1` and not `NDEBUG`, as gcc and clang do,
// so `assert` stays (C99 7.2p1). The predefine lands before the CLI `-D` /
// `-U` lists, which override it.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn optimize_flag_predefines_optimize_and_keeps_asserts() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let manifest = env!("CARGO_MANIFEST_DIR");
    let fixtures = PathBuf::from(manifest)
        .join("tests")
        .join("fixtures")
        .join("c");
    let dir = TempDir::new("badc-ndebug");

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

    // Exit codes: NDEBUG -> 101, else `__OPTIMIZE__`'s value, neither -> 100
    // (see the fixture).
    let probe = fixtures.join("optimize_predefines_optimize_not_ndebug.c");
    assert_eq!(run("plain", &[], &probe).code(), Some(100));
    assert_eq!(run("opt", &["-O"], &probe).code(), Some(1));
    assert_eq!(
        run("opt-ndebug", &["-O", "-DNDEBUG"], &probe).code(),
        Some(101)
    );
    assert_eq!(
        run("opt-dval", &["-O", "-D__OPTIMIZE__=7"], &probe).code(),
        Some(7)
    );
    assert_eq!(
        run("opt-undef", &["-O", "-U__OPTIMIZE__"], &probe).code(),
        Some(100)
    );

    // Under `-O` the assert(0) fires and the program traps; `-DNDEBUG`
    // compiles it out.
    let trap = fixtures.join("optimize_keeps_assert.c");
    let fired = run("assert-on", &["-O"], &trap);
    assert!(!fired.success(), "-O must keep assert (got {fired:?})");
    assert_eq!(
        run("assert-off", &["-O", "-DNDEBUG"], &trap).code(),
        Some(0)
    );
}

// `-fstrict-flex-arrays=N` selects which trailing array members
// `__builtin_object_size` treats as unbounded through a pointer. The
// fixture's exit code sets one bit per member the closest-subobject form
// bounds; the expected codes are gcc 16's at -O2. The interpreter must
// agree with the native image, and the bare form is level 3.
#[test]
fn strict_flex_arrays_level_selects_the_bounded_members() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let src = fixtures_dir().join("strict_flex_arrays.c");
    let dir = TempDir::new("badc-flexarr");

    let native = |tag: &str, flags: &[&str]| -> Option<i32> {
        let exe = dir.join(tag);
        let mut cmd = Command::new(badc);
        cmd.args(flags);
        let out = cmd
            .arg(&src)
            .arg("-o")
            .arg(&exe)
            .output()
            .expect("run badc");
        assert!(
            out.status.success(),
            "compile {flags:?} failed: {}",
            String::from_utf8_lossy(&out.stderr)
        );
        Command::new(&exe).output().expect("run prog").status.code()
    };
    let interp = |flags: &[&str]| -> Option<i32> {
        let mut cmd = Command::new(badc);
        cmd.arg("--interp").args(flags);
        cmd.arg(&src)
            .output()
            .expect("run badc --interp")
            .status
            .code()
    };

    let levels: [(&str, &[&str], i32); 6] = [
        ("default", &[], 16),
        ("l0", &["-fstrict-flex-arrays=0"], 16),
        ("l1", &["-fstrict-flex-arrays=1"], 24),
        ("l2", &["-fstrict-flex-arrays=2"], 28),
        ("l3", &["-fstrict-flex-arrays=3"], 30),
        ("bare", &["-fstrict-flex-arrays"], 30),
    ];
    for (tag, flags, code) in levels {
        assert_eq!(native(tag, flags), Some(code), "native {flags:?}");
        assert_eq!(interp(flags), Some(code), "interp {flags:?}");
    }

    let out = Command::new(badc)
        .arg("-fstrict-flex-arrays=4")
        .arg(&src)
        .arg("-o")
        .arg(dir.join("bad"))
        .output()
        .expect("run badc");
    assert!(
        !out.status.success(),
        "-fstrict-flex-arrays=4 must be rejected"
    );
    assert!(
        String::from_utf8_lossy(&out.stderr).contains("-fstrict-flex-arrays="),
        "the rejection names the option"
    );
}

// The interpreter holds the standard streams and `errno` itself, where the
// host would resolve the C library's data symbol or `__iob_func()` outside its
// memory. Each write lands on its stream's descriptor, in order, and the
// streams carry only what the program wrote.
#[test]
fn interp_writes_to_the_standard_streams() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let src = fixtures_dir().join("standard_streams_and_errno.c");
    let out = Command::new(badc)
        .arg("--interp")
        .arg(&src)
        .output()
        .expect("run badc --interp");
    assert_eq!(
        String::from_utf8_lossy(&out.stderr),
        "err: fputs\nerr: fprintf 2\n!\nerr: fwrite\n"
    );
    assert_eq!(
        String::from_utf8_lossy(&out.stdout),
        "out: fputs\nout: puts\nout: x\n"
    );
    assert_eq!(out.status.code(), Some(0));
}

// `--interp` exits with the program's status, as `--jit` and the native
// image do, and appends nothing to what the program wrote, a last line it
// left unterminated included.
#[test]
fn interp_exits_with_the_program_status() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-interp-status");
    let src = dir.join("r3.c");
    std::fs::write(
        &src,
        "#include <stdio.h>\nint main(void) { printf(\"partial\"); return 3; }\n",
    )
    .expect("write source");
    let run = |mode: &str| {
        Command::new(badc)
            .arg(mode)
            .arg(&src)
            .output()
            .expect("run badc")
    };
    let interp = run("--interp");
    assert_eq!(interp.status.code(), Some(3));
    assert_eq!(String::from_utf8_lossy(&interp.stdout), "partial");
    assert_eq!(run("--jit").status.code(), Some(3));
}

// The address constants a function designator builds keep their offsets in
// the image `-o` writes, under `--jit` and under `--interp`.
#[test]
fn function_designator_address_constants_keep_their_offsets() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let src = fixtures_dir().join("function_designator_address_constants.c");
    let dir = TempDir::new("badc-fn-address-constants");
    for opt in ["-O0", "-O"] {
        let exe = dir.join(format!("p{opt}{}", std::env::consts::EXE_SUFFIX));
        let out = Command::new(badc)
            .arg(opt)
            .arg(&src)
            .arg("-o")
            .arg(&exe)
            .output()
            .expect("run badc");
        assert!(
            out.status.success(),
            "-o {opt}: {}",
            String::from_utf8_lossy(&out.stderr)
        );
        let run = Command::new(&exe).output().expect("run image");
        assert_eq!(run.status.code(), Some(0), "-o {opt}");
        for mode in ["--jit", "--interp"] {
            let out = Command::new(badc)
                .arg(mode)
                .arg(opt)
                .arg(&src)
                .output()
                .expect("run badc");
            assert_eq!(out.status.code(), Some(0), "{mode} {opt}");
        }
    }
}

// A `--jit` / `--interp` program receives the arguments after its input,
// options and `--` included, and a shebang script without an extension
// receives its own.
#[test]
fn a_run_passes_option_like_arguments_to_the_program() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-run-args");
    let body = "#include <stdio.h>\n\
                int main(int argc, char **argv) {\n\
                \x20   for (int i = 1; i < argc; i++)\n\
                \x20       printf(\"[%s]\", argv[i]);\n\
                \x20   return argc;\n\
                }\n";
    let src = dir.join("args.c");
    std::fs::write(&src, body).expect("write source");
    let script = dir.join("args");
    std::fs::write(&script, format!("#!/usr/bin/env -S badc --interp\n{body}"))
        .expect("write script");
    for mode in ["--jit", "--interp"] {
        let run = |before: &[&str], input: &std::path::Path, after: &[&str]| {
            let out = Command::new(badc)
                .arg(mode)
                .args(before)
                .arg(input)
                .args(after)
                .output()
                .expect("run badc");
            let text = String::from_utf8_lossy(&out.stdout).into_owned();
            (out.status.code(), text)
        };
        let after = ["-v", "--", "x y", "-o"];
        assert_eq!(
            run(&[], &src, &after),
            (Some(5), "[-v][--][x y][-o]".into()),
            "{mode}"
        );
        assert_eq!(
            run(&["--"], &src, &["-h"]),
            (Some(2), "[-h]".into()),
            "{mode}"
        );
        assert_eq!(
            run(&[], &script, &["-x"]),
            (Some(2), "[-x]".into()),
            "{mode}"
        );
    }
}

// `--interp --trace` prints each executed SSA instruction to stderr, its
// function and block first, and leaves stdout to the program.
#[test]
fn interp_trace_prints_each_instruction_to_stderr() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-interp-trace");
    let src = dir.join("t.c");
    std::fs::write(
        &src,
        "#include <stdio.h>\nint main(void) { puts(\"out\"); return 3; }\n",
    )
    .expect("write source");
    let run = |trace: bool| {
        let mut cmd = Command::new(badc);
        cmd.arg("-q").arg("--interp");
        if trace {
            cmd.arg("--trace");
        }
        cmd.arg(&src).output().expect("run badc")
    };
    let plain = run(false);
    let traced = run(true);
    assert_eq!(plain.status.code(), Some(3));
    assert_eq!(traced.status.code(), Some(3));
    assert_eq!(traced.stdout, plain.stdout, "the trace leaves stdout alone");
    assert!(
        plain.stderr.is_empty(),
        "{}",
        String::from_utf8_lossy(&plain.stderr)
    );
    let err = String::from_utf8_lossy(&traced.stderr);
    assert!(
        err.lines()
            .next()
            .is_some_and(|l| l.starts_with("main b0 v0 ")),
        "{err}"
    );
    assert!(err.lines().count() > 2, "{err}");
}

// `--jit` exits with the status a program passes to `exit` from a nested
// call, after the output the program wrote (C99 7.20.4.3).
#[test]
fn jit_exits_with_the_status_exit_was_given() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-jit-exit");
    let src = dir.join("e3.c");
    std::fs::write(
        &src,
        "#include <stdio.h>\n#include <stdlib.h>\n\
         static void f(void) { printf(\"partial\"); exit(3); }\n\
         int main(void) { f(); return 4; }\n",
    )
    .expect("write source");
    let out = Command::new(badc)
        .arg("--jit")
        .arg(&src)
        .output()
        .expect("run badc");
    assert_eq!(out.status.code(), Some(3));
    if !cfg!(windows) {
        assert_eq!(String::from_utf8_lossy(&out.stdout), "partial");
    }
}

// A program run in process takes the C-library sources its image links:
// `strchrnul`, `memrchr`, and on Windows libc/lib's printf and strtod.
#[test]
fn in_process_runs_join_the_on_demand_sources() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-on-demand");
    let src = dir.join("od.c");
    std::fs::write(
        &src,
        "#include <math.h>\n#include <stdio.h>\n#include <stdlib.h>\n#include <string.h>\n\
         int main(void) {\n\
           const char *s = \"abc\";\n\
           char buf[64];\n\
           if (strchrnul(s, 'z') != s + 3 || memrchr(s, 'a', 3) != s) return 1;\n\
           snprintf(buf, sizeof buf, \"%hhd %.1f %g\", 300, INFINITY, strtod(\"0x1p3\", NULL));\n\
           if (strcmp(buf, \"44 inf 8\") != 0) { fputs(buf, stderr); return 2; }\n\
           return 0;\n\
         }\n",
    )
    .expect("write source");
    let exe = dir.join(format!("od{}", std::env::consts::EXE_SUFFIX));
    let out = Command::new(badc)
        .arg(&src)
        .arg("-o")
        .arg(&exe)
        .output()
        .expect("run badc");
    assert!(
        out.status.success(),
        "{}",
        String::from_utf8_lossy(&out.stderr)
    );
    let run = Command::new(&exe).output().expect("run image");
    assert_eq!(
        run.status.code(),
        Some(0),
        "image: {}",
        String::from_utf8_lossy(&run.stderr)
    );
    let out = Command::new(badc)
        .arg("--jit")
        .arg(&src)
        .output()
        .expect("run badc");
    let err = String::from_utf8_lossy(&out.stderr);
    assert_eq!(out.status.code(), Some(0), "--jit: {err}");
    // The interpreter runs the C library of the target it interprets, its
    // own printf and, where that library lacks them, `string_ext.c`'s.
    let sc = dir.join("sc.c");
    std::fs::write(
        &sc,
        "#include <stdio.h>\n#include <string.h>\n\
         int main(void) {\n\
           const char *s = \"abc\";\n\
           char *p = strchrnul(s, 'z'), *q = memrchr(s, 'a', 3);\n\
           printf(\"%d %d\\n\", (int)(p - s), (int)(q - s));\n\
           return 0;\n\
         }\n",
    )
    .expect("write source");
    for target in ["--target=macos-aarch64", "--target=windows-x64"] {
        let out = Command::new(badc)
            .arg("--interp")
            .arg(target)
            .arg(&sc)
            .output()
            .expect("run badc");
        let err = String::from_utf8_lossy(&out.stderr);
        assert_eq!(out.status.code(), Some(0), "--interp {target}: {err}");
        assert_eq!(String::from_utf8_lossy(&out.stdout), "3 0\n", "{target}");
    }
}

// `--interp` compiles for the target it names and interprets that program:
// the target's data model and predefined macros, and a library whose `%l`
// reads the target's `long`. `--jit` runs host code and refuses any other
// target before compiling.
#[test]
fn interp_takes_the_target_and_jit_only_the_host() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-interp-target");
    let src = dir.join("types.c");
    std::fs::write(
        &src,
        "#include <stdio.h>\n#include <wchar.h>\n\
         int main(void) {\n\
           long m = -1L;\n\
           int win = 0;\n\
         #ifdef _WIN32\n\
           win = 1;\n\
         #endif\n\
           printf(\"%zu %zu %d %lx\\n\", sizeof(long), sizeof(wchar_t), win, m);\n\
           return 0;\n\
         }\n",
    )
    .expect("write source");
    for (target, want) in [
        ("macos-aarch64", "8 4 0 ffffffffffffffff\n"),
        ("linux-aarch64", "8 4 0 ffffffffffffffff\n"),
        ("linux-x64", "8 4 0 ffffffffffffffff\n"),
        ("windows-x64", "4 2 1 ffffffff\n"),
        ("windows-arm64", "4 2 1 ffffffff\n"),
    ] {
        let spec = format!("--target={target}");
        let out = Command::new(badc)
            .arg("--interp")
            .arg(&spec)
            .arg(&src)
            .output()
            .expect("run badc");
        let err = String::from_utf8_lossy(&out.stderr);
        assert_eq!(out.status.code(), Some(0), "--interp {spec}: {err}");
        assert_eq!(String::from_utf8_lossy(&out.stdout), want, "{spec}");
        let out = Command::new(badc)
            .arg("--jit")
            .arg(&spec)
            .arg(&src)
            .output()
            .expect("run badc");
        let err = String::from_utf8_lossy(&out.stderr);
        if out.status.success() {
            // The host C library's text-mode stdout ends a line with CR LF
            // on Windows.
            let stdout = String::from_utf8_lossy(&out.stdout).replace("\r\n", "\n");
            assert_eq!(stdout, want, "--jit {spec}");
        } else {
            assert!(
                err.contains("`--jit` runs the program in this process") && out.stdout.is_empty(),
                "--jit {spec}: {err}"
            );
        }
    }
}

// The interpreter's printf reads a `long double` in the target's format --
// an x87 or binary128 image on the Linux targets, binary64 elsewhere -- and
// writes `%La` as the target's C library does: the expected text is what the
// native builds print with glibc, Apple's libc and the UCRT.
#[test]
fn interp_prints_long_double_in_the_target_format() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-interp-long-double");
    let src = dir.join("ld.c");
    std::fs::write(
        &src,
        "#include <stdio.h>\n\
         static const long double half[] = {4.5L, -0.25L, 0.5L, 2.5L, 3.5L, -1.5L};\n\
         static const long double wide[] = {1.96875L, 0x1p+1000L, 1e300, 0x1p-1000L,\n\
                                            0x1p-1074L, -1e-300};\n\
         int main(void) {\n\
           for (int i = 0; i < 6; i++)\n\
             printf(\"%Lf %.0Lf %Lg %d\\n\", half[i], half[i], half[i], i);\n\
           for (int i = 0; i < 6; i++)\n\
             printf(\"%.6Le %.17Lg\\n\", wide[i], wide[i]);\n\
           for (int i = 0; i < 6; i++)\n\
             printf(\"%La %.0La|\", wide[i], wide[i]);\n\
           printf(\"%La %+010.1LA\\n\", half[1], wide[0]);\n\
           return 0;\n\
         }\n",
    )
    .expect("write source");
    let decimal = "4.500000 4 4.5 0\n-0.250000 -0 -0.25 1\n0.500000 0 0.5 2\n\
                   2.500000 2 2.5 3\n3.500000 4 3.5 4\n-1.500000 -2 -1.5 5\n\
                   1.968750e+00 1.96875\n1.071509e+301 1.0715086071862673e+301\n\
                   1.000000e+300 1.0000000000000001e+300\n9.332636e-302 9.3326361850321888e-302\n\
                   4.940656e-324 4.9406564584124654e-324\n-1.000000e-300 -1e-300\n";
    let x87 = "0xf.cp-3 0x1p+1|0x8p+997 0x8p+997|0xb.f21e44003acep+993 0xcp+993|\
               0x8p-1003 0x8p-1003|0x8p-1077 0x8p-1077|-0xa.b70fe17c79ac8p-1000 -0xbp-1000|\
               -0x8p-5 +0X0F.CP-3\n";
    let ieee = |tail: &str| {
        format!(
            "0x1.f8p+0 0x2p+0|0x1p+1000 0x1p+1000|0x1.7e43c8800759cp+996 0x1p+996|\
             0x1p-1000 0x1p-1000|0x1p-1074 0x1p-1074|-0x1.56e1fc2f8f359p-997 -0x1p-997|\
             -0x1p-2 {tail}\n"
        )
    };
    let ucrt = "0x1.f800000000000p+0 0x2p+0|0x1.0000000000000p+1000 0x1p+1000|\
                0x1.7e43c8800759cp+996 0x1p+996|0x1.0000000000000p-1000 0x1p-1000|\
                0x0.0000000000001p-1022 0x0p-1022|-0x1.56e1fc2f8f359p-997 -0x1p-997|\
                -0x1.0000000000000p-2 +0X02.0P+0\n";
    for (target, hex) in [
        ("linux-x64", x87.to_string()),
        ("linux-aarch64", ieee("+0X02.0P+0")),
        // Apple's libc rounds a tail of 8 followed by an even digit down.
        ("macos-aarch64", ieee("+0X01.FP+0")),
        ("windows-x64", ucrt.to_string()),
        ("windows-arm64", ucrt.to_string()),
    ] {
        let spec = format!("--target={target}");
        let out = Command::new(badc)
            .arg("--interp")
            .arg(&spec)
            .arg(&src)
            .output()
            .expect("run badc");
        let err = String::from_utf8_lossy(&out.stderr);
        assert_eq!(out.status.code(), Some(0), "--interp {spec}: {err}");
        assert_eq!(
            String::from_utf8_lossy(&out.stdout),
            format!("{decimal}{hex}"),
            "{spec}"
        );
    }
}

// C99 7.6 and Annex F under `--interp`: each operation rounds in the current
// direction and raises what the target raises, and the environment
// functions save and restore it. The expected text is what the native builds
// print with glibc, Apple's libc and the UCRT; AArch64 detects tininess
// before rounding, and only glibc on x86-64 raises overflow and underflow
// without inexact.
#[test]
fn interp_rounds_and_raises_as_the_target() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let src = fixtures_dir().join("fenv_rounding_and_exceptions.c");
    let x64 = FENV_LINUX_X64.to_string();
    let tiny_before = |t: &str| {
        t.replace(
            "\ntiny-after 0010000000000000 x\n",
            "\ntiny-after 0010000000000000 ux\n",
        )
        .replace("\nftiny-after 00800000 x\n", "\nftiny-after 00800000 ux\n")
    };
    let raise_inexact = |t: &str| {
        t.replace("\nraise2 o\n", "\nraise2 ox\n")
            .replace("\nraise3 u\n", "\nraise3 ux\n")
    };
    let aarch64 = raise_inexact(&tiny_before(&x64));
    for (target, want) in [
        ("linux-x64", x64.clone()),
        ("linux-aarch64", aarch64.clone()),
        ("macos-aarch64", aarch64.clone()),
        ("windows-x64", raise_inexact(&x64)),
        ("windows-arm64", aarch64),
    ] {
        let spec = format!("--target={target}");
        let out = Command::new(badc)
            .arg("--interp")
            .arg(&spec)
            .arg(&src)
            .output()
            .expect("run badc");
        let err = String::from_utf8_lossy(&out.stderr);
        assert_eq!(out.status.code(), Some(0), "--interp {spec}: {err}");
        assert_eq!(String::from_utf8_lossy(&out.stdout), want, "{spec}");
    }
}

/// What a native build of `fenv_rounding_and_exceptions.c` prints on Linux
/// x86_64.
const FENV_LINUX_X64: &str = "\
nearest 0 1
div 3fd5555555555555 x
div- bfd5555555555555 x
add 3ff0000000000000 x
sum0 0000000000000000 -
sum-0 0000000000000000 -
ovf 7ff0000000000000 ox
ovf- fff0000000000000 ox
max+ 7fefffffffffffff x
tiny/2 0000000000000000 ux
-tiny/2 8000000000000000 ux
subprod 0000000000000000 ux
subquot 0005555555555555 ux
subdiff 0000000000000017 -
sqrt 3ffbb67ae8584caa x
fma bc90000000000000 x
fmasub 0000000000000004 -
fdiv 3eaaaaab x
fovf 7f800000 ox
fsub 002aaaab ux
fsqrt 3fddb3d7 x
ffma 33000000 x
i2f 4b800000 x
ll2d 4340000000000000 x
ll2f 5a000000 x
ull2d 43e0000000000001 x
d2f 3dcccccd x
d2fovf 7f800000 ox
d2fsub 00000000 ux
ld 3fb999999999999a -
ld+ 3ff199999999999a x
d2i 2 x
d2u 3 x
rint 4000000000000000 x
rint- c000000000000000 x
nearbyint c000000000000000 -
rintf 40000000 x
lrint -2 x
llrint 2 x
lrintf 2 x
printf 0.2 2 -0.2 3.333e-01 -0.3333 0x1.55p-2 0.33333333333333331483
upward 0 1
div 3fd5555555555556 x
div- bfd5555555555555 x
add 3ff0000000000001 x
sum0 0000000000000000 -
sum-0 0000000000000000 -
ovf 7ff0000000000000 ox
ovf- ffefffffffffffff ox
max+ 7ff0000000000000 ox
tiny/2 0000000000000001 ux
-tiny/2 8000000000000000 ux
subprod 0000000000000001 ux
subquot 0005555555555556 ux
subdiff 0000000000000017 -
sqrt 3ffbb67ae8584cab x
fma 3ca0000000000000 x
fmasub 0000000000000004 -
fdiv 3eaaaaab x
fovf 7f800000 ox
fsub 002aaaab ux
fsqrt 3fddb3d8 x
ffma 33000000 x
i2f 4b800001 x
ll2d 4340000000000001 x
ll2f 5a000001 x
ull2d 43e0000000000002 x
d2f 3dcccccd x
d2fovf 7f800000 ox
d2fsub 00000001 ux
ld 3fb999999999999a -
ld+ 3ff199999999999a x
d2i 2 x
d2u 3 x
rint 4008000000000000 x
rint- c000000000000000 x
nearbyint c000000000000000 -
rintf 40400000 x
lrint -2 x
llrint 3 x
lrintf 3 x
printf 0.3 3 -0.2 3.334e-01 -0.3333 0x1.56p-2 0.33333333333333337035
downward 0 1
div 3fd5555555555555 x
div- bfd5555555555556 x
add 3ff0000000000000 x
sum0 8000000000000000 -
sum-0 8000000000000000 -
ovf 7fefffffffffffff ox
ovf- fff0000000000000 ox
max+ 7fefffffffffffff x
tiny/2 0000000000000000 ux
-tiny/2 8000000000000001 ux
subprod 0000000000000000 ux
subquot 0005555555555555 ux
subdiff 0000000000000017 -
sqrt 3ffbb67ae8584caa x
fma bc90000000000000 x
fmasub 0000000000000004 -
fdiv 3eaaaaaa x
fovf 7f7fffff ox
fsub 002aaaaa ux
fsqrt 3fddb3d7 x
ffma b3800000 x
i2f 4b800000 x
ll2d 4340000000000000 x
ll2f 5a000000 x
ull2d 43e0000000000001 x
d2f 3dcccccc x
d2fovf 7f7fffff ox
d2fsub 00000000 ux
ld 3fb999999999999a -
ld+ 3ff1999999999999 x
d2i 2 x
d2u 3 x
rint 4000000000000000 x
rint- c008000000000000 x
nearbyint c008000000000000 -
rintf 40000000 x
lrint -3 x
llrint 2 x
lrintf 2 x
printf 0.2 2 -0.3 3.333e-01 -0.3334 0x1.55p-2 0.33333333333333331482
towardzero 0 1
div 3fd5555555555555 x
div- bfd5555555555555 x
add 3ff0000000000000 x
sum0 0000000000000000 -
sum-0 0000000000000000 -
ovf 7fefffffffffffff ox
ovf- ffefffffffffffff ox
max+ 7fefffffffffffff x
tiny/2 0000000000000000 ux
-tiny/2 8000000000000000 ux
subprod 0000000000000000 ux
subquot 0005555555555555 ux
subdiff 0000000000000017 -
sqrt 3ffbb67ae8584caa x
fma bc90000000000000 x
fmasub 0000000000000004 -
fdiv 3eaaaaaa x
fovf 7f7fffff ox
fsub 002aaaaa ux
fsqrt 3fddb3d7 x
ffma b3800000 x
i2f 4b800000 x
ll2d 4340000000000000 x
ll2f 5a000000 x
ull2d 43e0000000000001 x
d2f 3dcccccc x
d2fovf 7f7fffff ox
d2fsub 00000000 ux
ld 3fb999999999999a -
ld+ 3ff1999999999999 x
d2i 2 x
d2u 3 x
rint 4000000000000000 x
rint- c000000000000000 x
nearbyint c000000000000000 -
rintf 40000000 x
lrint -2 x
llrint 2 x
lrintf 2 x
printf 0.2 2 -0.2 3.333e-01 -0.3333 0x1.55p-2 0.33333333333333331482
tiny-after 0010000000000000 x
to-min 0010000000000000 ux
ftiny-after 00800000 x
fegetenv 0 x
fesetenv 0 1 x
feholdexcept 0 1 -
feupdateenv 0 vz
fegetexceptflag 0 vz
fesetexceptflag 0 z
fesetenv-dfl 0 1 -
fesetround-bad 1 1 -
raise0 v
raise1 z
raise2 o
raise3 u
raise4 x
snan+1 v
snan== 0 v
qnan 0 1 v
1/0 7ff0000000000000 z
inf-inf v
sqrt-1 v
d2ll-ovf v
";

// A unit run in process keeps a 64 KiB alignment; a Mach-O image refuses it.
#[test]
fn in_process_runs_keep_a_64k_alignment() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-align-64k");
    let src = dir.join("a64k.c");
    std::fs::write(
        &src,
        "#include <stdint.h>\n\
         _Alignas(65536) unsigned char d[3] = {1};\n\
         _Alignas(65536) unsigned char b[3];\n\
         static _Alignas(65536) const unsigned char r[3] = {2};\n\
         int main(void) {\n\
         static _Alignas(65536) unsigned char s[3];\n\
         uintptr_t all = (uintptr_t)d | (uintptr_t)b | (uintptr_t)r | (uintptr_t)s;\n\
         return all % 65536 != 0 || d[0] + r[0] + b[0] + s[0] != 3;\n\
         }\n",
    )
    .expect("write source");
    for mode in ["--jit", "--interp"] {
        let out = Command::new(badc)
            .arg(mode)
            .arg(&src)
            .output()
            .expect("run badc");
        let err = String::from_utf8_lossy(&out.stderr);
        assert_eq!(out.status.code(), Some(0), "{mode}: {err}");
    }
    if cfg!(target_os = "macos") {
        let out = Command::new(badc)
            .arg("-o")
            .arg(dir.join("a64k"))
            .arg(&src)
            .output()
            .expect("run badc");
        let err = String::from_utf8_lossy(&out.stderr);
        assert!(
            !out.status.success()
                && err.contains("exceeds the 16384-byte boundary a Mach-O image keeps at load"),
            "{err}"
        );
    }
}

// `--install <dir>` writes every embedded header under <dir>/include
// (recreating subdirectories) and the runtime source under <dir>/lib.
#[test]
fn install_writes_header_and_runtime_tree() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-install");
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
}

// The installed overlay under $BADC_HOME takes precedence over the
// embedded headers and runtime: editing an installed copy changes the
// build without rebuilding badc, and removing the override falls back
// to the embedded copy.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn installed_overlay_overrides_embedded() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-overlay");
    let home = dir.join("home");
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
    // defined and the program builds and exits 0.
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
}

// An implicit `~/.badc/lib/runtime.c` does not shadow the runtime a
// source build carries, on the same terms as the header overlay: a stale
// `--install` would otherwise change every link made on that host.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn implicit_home_runtime_does_not_shadow_embedded() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-implicit-rt");
    let home = dir.join("home");
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
}

// The include search path must not depend on the working directory: a
// build system that runs the compiler from a project root whose
// `./include` holds that project's own headers would otherwise have them
// shadow the standard ones.
#[test]
fn working_directory_include_is_not_searched() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-cwdinc");
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
}

// `#include_next` under the driver's search configuration: `-nostdinc`
// leaves nothing past a wrapper's `-I` directory, a name with a directory
// component resumes past the `-I` directory it was found through, and a
// `--badc-home` header resumes past the own set to the `--sysroot`
// directories, on Windows as on Linux.
#[test]
fn include_next_resumes_through_the_driver_search() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-incnext");
    for (path, body) in [
        ("w/stdio.h", "#include_next <stdio.h>\n#define WRAPPED 1\n"),
        ("a.c", "#include <stdio.h>\nint r = WRAPPED;\n"),
        ("d1/sys/x.h", "#define FROM_D1 1\n#include_next <sys/x.h>\n"),
        ("d2/sys/x.h", "#define FROM_D2 2\n"),
        ("b.c", "#include <sys/x.h>\nint v = FROM_D1 + FROM_D2;\n"),
        ("home/include/a.h", "#include <b.h>\n"),
        ("home/include/b.h", "int b_own;\n#include_next <b.h>\n"),
        (
            "home/include/stdio.h",
            "int own_stdio;\n#include_next <stdio.h>\n",
        ),
        ("user/b.h", "int b_user;\n"),
        ("root/usr/include/b.h", "int b_sys;\n"),
        ("c.c", "#include <a.h>\n"),
    ] {
        let path = dir.join(path);
        std::fs::create_dir_all(path.parent().unwrap()).expect("create dir");
        std::fs::write(path, body).expect("write file");
    }
    let run = |args: &[&str]| {
        let out = Command::new(badc)
            .args(["-q", "-E"])
            .args(args)
            .env_remove("BADC_HOME")
            .env_remove("SDKROOT")
            .current_dir(&dir)
            .output()
            .expect("run badc");
        let text = |b: &[u8]| String::from_utf8_lossy(b).into_owned();
        (out.status.success(), text(&out.stdout), text(&out.stderr))
    };
    let message = |stderr: &str| stderr.split_once("error: ").map(|(_, m)| m.to_string());
    let linux = "--target=linux-x64";

    let wrapped = run(&[linux, "-nostdinc", "-I", "w", "a.c"]);
    let plain = run(&[linux, "-nostdinc", "a.c"]);
    assert!(!wrapped.0 && !plain.0, "{wrapped:?} {plain:?}");
    assert!(wrapped.2.contains("`stdio.h` not found"), "{}", wrapped.2);
    assert_eq!(message(&wrapped.2), message(&plain.2));
    let bundled = run(&[linux, "-I", "w", "a.c"]);
    assert!(bundled.0 && bundled.1.contains("int r = 1;"), "{bundled:?}");

    let nested = run(&[linux, "-I", "d1", "-I", "d2", "b.c"]);
    assert!(
        nested.0 && nested.1.contains("int v = 1 + 2;"),
        "{nested:?}"
    );

    let home = ["--badc-home=home", "--sysroot=root"];
    let own = run(&[linux, home[0], home[1], "-I", "user", "c.c"]);
    assert!(own.0, "{own:?}");
    assert!(
        own.1.contains("b_own") && own.1.contains("b_sys") && !own.1.contains("b_user"),
        "{}",
        own.1
    );
    for target in [linux, "--target=windows-x64"] {
        let last = run(&[target, home[0], home[1], "a.c"]);
        assert!(
            !last.0 && last.2.contains("`stdio.h` not found"),
            "{target}: {last:?}"
        );
    }
}

// The source tree a badc was built from is not an input: a header
// edited in the checkout's `libc` beside the executable changes
// nothing until badc is rebuilt or the tree is named through
// `--badc-home`, so the image does not follow where the binary sits.
#[test]
fn the_source_tree_beside_the_executable_is_not_read() {
    let badc = std::path::Path::new(env!("CARGO_BIN_EXE_badc"));
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
    let header = root.join("libc/compiler/include/stdalign.h");
    let original = std::fs::read(&header).expect("read bundled header");
    let mut patched = original.clone();
    patched.extend_from_slice(b"\n#define BADC_SOURCE_TREE_OVERLAY 1\n");
    std::fs::write(&header, &patched).expect("patch bundled header");

    let dir = TempDir::new("badc-srctree");
    std::fs::write(
        dir.join("m.c"),
        "#include <stdalign.h>\n#ifdef BADC_SOURCE_TREE_OVERLAY\n\
         #error \"the source tree's libc was searched\"\n#endif\n\
         int main(void){ return 0; }\n",
    )
    .expect("write source");
    let built = Command::new(badc)
        .env_remove("BADC_HOME")
        .arg("-q")
        .arg("-c")
        .arg("m.c")
        .arg("-o")
        .arg("m.o")
        .current_dir(&dir)
        .output()
        .expect("run badc");
    std::fs::write(&header, &original).expect("restore bundled header");
    assert!(
        built.status.success(),
        "the source tree beside the executable must not be read: {}",
        String::from_utf8_lossy(&built.stderr)
    );
}

// A `#pragma entrypoint` an object file cannot carry is a catalogue
// row, so `-Wno-link-pragma-ignored` silences it and `-Werror` fails
// the unit on it.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn a_dropped_link_pragma_is_a_controllable_diagnostic() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-linkpragma");
    let src = dir.join("main.c");
    std::fs::write(
        &src,
        "#pragma entrypoint(custom_entry)\nint custom_entry(void) { return 0; }\n",
    )
    .expect("write main");
    let compile = |extra: &[&str]| {
        Command::new(badc)
            .args(extra)
            .arg("-c")
            .arg(&src)
            .arg("-o")
            .arg(dir.join("main.o"))
            .output()
            .expect("run badc")
    };
    let plain = compile(&[]);
    assert!(plain.status.success());
    let stderr = String::from_utf8_lossy(&plain.stderr);
    assert!(
        stderr.contains("[B7008] [-Wlink-pragma-ignored]"),
        "expected the row's brackets, got: {stderr}"
    );
    let off = compile(&["-Wno-link-pragma-ignored"]);
    assert!(off.status.success());
    assert!(
        !String::from_utf8_lossy(&off.stderr).contains("link-pragma-ignored"),
        "-Wno- must silence the row"
    );
    let raised = compile(&["-Werror=link-pragma-ignored"]);
    assert!(!raised.status.success(), "-Werror= must fail the unit");
}

// A declined `inline` is a catalogue row the codegen tier reports
// through the diagnostic sink: off by default, `-Winline` prints it
// with its code and name, `-Werror=inline` fails the unit and
// `-Wno-inline` silences it.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn the_inline_report_is_a_controllable_diagnostic() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-winline");
    let src = dir.join("main.c");
    // Self-recursive, so the candidate filter declines it whatever the
    // body-size cap is.
    std::fs::write(
        &src,
        "static inline int rec(int n) { return n <= 1 ? 1 : n * rec(n - 1); }\n\
         int main(void) { return rec(5) & 1; }\n",
    )
    .expect("write main");
    let compile = |extra: &[&str]| {
        Command::new(badc)
            .arg("-O")
            .args(extra)
            .arg("-c")
            .arg(&src)
            .arg("-o")
            .arg(dir.join("main.o"))
            .output()
            .expect("run badc")
    };
    let plain = compile(&[]);
    assert!(plain.status.success());
    assert!(
        !String::from_utf8_lossy(&plain.stderr).contains("B4003"),
        "the row is off by default, as in gcc"
    );
    let on = compile(&["-Winline"]);
    assert!(on.status.success());
    let stderr = String::from_utf8_lossy(&on.stderr);
    assert!(
        stderr.contains("`rec` is declared inline but was not inlined")
            && stderr.contains("[B4003] [-Winline]"),
        "expected the row's text, code and name, got: {stderr}"
    );
    let raised = compile(&["-Werror=inline"]);
    assert!(!raised.status.success(), "-Werror= must fail the unit");
    assert!(
        String::from_utf8_lossy(&raised.stderr).contains("error: `rec` is declared inline"),
        "the raised row prints as an error"
    );
    let off = compile(&["-Winline", "-Wno-inline"]);
    assert!(off.status.success());
    assert!(
        !String::from_utf8_lossy(&off.stderr).contains("B4003"),
        "-Wno- must silence the row"
    );
}

// The `always_inline` decline is its own row, reported without an
// option asking for it, and controllable by the same grammar.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn the_always_inline_report_is_a_controllable_diagnostic() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-walwaysinline");
    let src = dir.join("main.c");
    std::fs::write(
        &src,
        "__attribute__((always_inline)) static int rec(int n) {\n\
         \treturn n <= 1 ? 1 : n * rec(n - 1);\n\
         }\n\
         int main(void) { return rec(5) & 1; }\n",
    )
    .expect("write main");
    let compile = |extra: &[&str]| {
        Command::new(badc)
            .arg("-O")
            .args(extra)
            .arg("-c")
            .arg(&src)
            .arg("-o")
            .arg(dir.join("main.o"))
            .output()
            .expect("run badc")
    };
    let plain = compile(&[]);
    assert!(plain.status.success());
    let stderr = String::from_utf8_lossy(&plain.stderr);
    assert!(
        stderr.contains("`rec` is marked always_inline but was not inlined")
            && stderr.contains("[B4004] [-Walways-inline]"),
        "expected the row's text, code and name, got: {stderr}"
    );
    let raised = compile(&["-Werror=always-inline"]);
    assert!(!raised.status.success(), "-Werror= must fail the unit");
    let off = compile(&["-Wno-always-inline"]);
    assert!(off.status.success());
    assert!(
        !String::from_utf8_lossy(&off.stderr).contains("B4004"),
        "-Wno- must silence the row"
    );
}

// `-Werror` fails the unit at the phase boundary, not at the first
// raised warning: the whole source is parsed, so every diagnostic is
// reported before the driver gives up.
// A frame over the `-Wframe-larger-than=` bound is a catalogue row the
// codegen tier reports on both architectures, naming the function, the
// size and the bound at the function's definition -- in the header that
// holds it, past a prototype ahead of it; `-Werror=` fails the unit,
// `-Wno-` silences it, and a frame under the bound stays silent.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn the_frame_size_report_is_a_controllable_diagnostic() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-wframe-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");
    let src = dir.join("main.c");
    std::fs::write(
        dir.join("big.h"),
        "int fill(char *p, int n);\n\
         static inline int hbig(void) { char buf[4096]; return fill(buf, sizeof buf); }\n",
    )
    .expect("write header");
    std::fs::write(
        &src,
        "#include \"big.h\"\n\
         int big(void);\n\
         int big(void) { char buf[4096]; return fill(buf, sizeof buf); }\n\
         int small(void) { char buf[64]; return fill(buf, sizeof buf); }\n\
         int main(void) { return big() + small() + hbig(); }\n",
    )
    .expect("write main");
    for target in ["linux-x64", "linux-aarch64"] {
        let compile = |extra: &[&str]| {
            Command::new(badc)
                .arg(format!("--target={target}"))
                .args(extra)
                .arg("-c")
                .arg(&src)
                .arg("-o")
                .arg(dir.join("main.o"))
                .output()
                .expect("run badc")
        };
        let plain = compile(&[]);
        assert!(plain.status.success());
        assert!(
            !String::from_utf8_lossy(&plain.stderr).contains("B4005"),
            "{target}: no bound, no report"
        );
        let on = compile(&["-Wframe-larger-than=2048"]);
        assert!(
            on.status.success(),
            "{}",
            String::from_utf8_lossy(&on.stderr)
        );
        let stderr = String::from_utf8_lossy(&on.stderr);
        let reports: Vec<&str> = stderr.lines().filter(|l| l.contains("B4005")).collect();
        assert_eq!(
            reports.len(),
            2,
            "{target}: `small` is under the bound: {stderr}"
        );
        let tail = " [B4005] [-Wframe-larger-than]";
        for (name, at) in [
            ("hbig", format!("{}:2", dir.join("big.h").display())),
            ("big", format!("{}:3", src.display())),
        ] {
            let head = format!("{at}: warning: function `{name}`: stack frame of ");
            let line = reports
                .iter()
                .find(|l| l.starts_with(&head))
                .unwrap_or_else(|| panic!("{target}: no report at {head:?} in {reports:?}"));
            assert!(line.ends_with(tail), "{target}: {line}");
            // The regions follow the bound, largest first: the 4096-byte
            // local, padded to the frame granule, leads.
            let first = line
                .split("-byte bound: ")
                .nth(1)
                .unwrap()
                .split(", ")
                .next()
                .unwrap();
            let (n, what) = first.split_once(' ').unwrap();
            assert_eq!(what, "in locals", "{target}: {line}");
            assert!(
                (4096..4096 + 64).contains(&n.parse::<u64>().unwrap()),
                "{target}: {line}"
            );
            let bytes: u64 = line[head.len()..]
                .split(' ')
                .next()
                .unwrap()
                .parse()
                .unwrap();
            assert!(
                (4096..4096 + 256).contains(&bytes),
                "{target}: the size is the 4096-byte local plus the frame's own bytes: {bytes}"
            );
        }
        let fatal = compile(&["-Wframe-larger-than=2048", "-Werror=frame-larger-than"]);
        assert!(!fatal.status.success(), "{target}");
        assert!(
            String::from_utf8_lossy(&fatal.stderr).contains("error: function `big`: stack frame"),
            "{target}: {}",
            String::from_utf8_lossy(&fatal.stderr)
        );
        let off = compile(&["-Wframe-larger-than=2048", "-Wno-frame-larger-than"]);
        assert!(off.status.success(), "{target}");
        assert!(
            !String::from_utf8_lossy(&off.stderr).contains("B4005"),
            "{target}"
        );
    }
    let _ = std::fs::remove_dir_all(&dir);
}

#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn warnings_as_errors_fail_the_unit_after_the_whole_parse() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-werror");
    let src = dir.join("main.c");
    std::fs::write(
        &src,
        "const int *c; int *p; int *q;\nint main(void) { p = c; q = c; return 0; }\n",
    )
    .expect("write main");
    let out = Command::new(badc)
        .arg("-Werror")
        .arg("-c")
        .arg(&src)
        .arg("-o")
        .arg(dir.join("main.o"))
        .output()
        .expect("run badc");
    assert!(!out.status.success(), "-Werror must fail the unit");
    let stderr = String::from_utf8_lossy(&out.stderr);
    assert_eq!(
        stderr.matches("error: discards `const` qualifier").count(),
        2,
        "both assignments must be reported, got: {stderr}"
    );
    assert!(
        stderr.contains("[B3031] [-Wdiscarded-qualifiers]"),
        "expected the code and option brackets, got: {stderr}"
    );
    assert!(
        stderr.contains("warnings treated as errors"),
        "expected the phase-boundary line, got: {stderr}"
    );
    // Without the option the same unit compiles, warnings and all.
    let ok = Command::new(badc)
        .arg("-c")
        .arg(&src)
        .arg("-o")
        .arg(dir.join("main2.o"))
        .output()
        .expect("run badc");
    assert!(ok.status.success(), "the unit compiles without -Werror");
    // `-w` drops them entirely.
    let quiet = Command::new(badc)
        .arg("-w")
        .arg("-c")
        .arg(&src)
        .arg("-o")
        .arg(dir.join("main3.o"))
        .output()
        .expect("run badc");
    assert!(quiet.status.success());
    assert!(
        !String::from_utf8_lossy(&quiet.stderr).contains("warning:"),
        "-w must report no warning"
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
    let dir = TempDir::new("badc-unkopt");
    let src = dir.join("main.c");
    std::fs::write(&src, "int main(void) { return 0; }\n").expect("write main");
    let out = Command::new(badc)
        .arg("--no-such-option")
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
}

#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn unrecognized_input_extension_is_rejected() {
    // A compile/link mode must diagnose an unrecognized input extension
    // rather than silently reclassifying it (and every input after it)
    // as the program's argv.
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-unkext");
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
    let root = TempDir::new("badc-jobs");
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
}

/// The host's own target triple, for the tests that execute what they
/// build. Unlike [`host_smoke_target`] this covers macOS, whose Mach-O
/// output is the only coverage that format's link path gets here.
fn host_native_target() -> Option<&'static str> {
    match (std::env::consts::OS, std::env::consts::ARCH) {
        ("linux", "x86_64") => Some("linux-x64"),
        ("linux", "aarch64") => Some("linux-aarch64"),
        ("macos", "aarch64") => Some("macos-aarch64"),
        _ => None,
    }
}

/// `-ftrivial-auto-var-init`: the fixture dirties the stack through a
/// callee and reads every uninitialized object shape back, exiting with
/// the count of bytes that miss the selected byte. Both values run at
/// both optimization levels on the host; `=pattern` passes the fixture the
/// byte it checks against. The unflagged build has to see the stale bytes,
/// which is what makes a zero exit the stores' doing.
#[test]
fn trivial_auto_var_init_fills_every_uninitialized_object() {
    let Some(target) = host_native_target() else {
        return;
    };
    let badc = env!("CARGO_BIN_EXE_badc");
    let root = TempDir::new("badc-auto-var-init");
    let fixture = fixtures_dir().join("trivial_auto_var_init.c");
    let build = |name: &str, flags: &[&str]| {
        let out = root.join(name);
        let built = Command::new(badc)
            .arg(format!("--target={target}"))
            .args(flags)
            .arg("-o")
            .arg(&out)
            .arg(&fixture)
            .output()
            .expect("run badc");
        assert!(
            built.status.success(),
            "{flags:?}: build failed -- {}",
            String::from_utf8_lossy(&built.stderr)
        );
        Command::new(&out)
            .output()
            .expect("run the image")
            .status
            .code()
    };
    for (name, flags) in [
        ("zero0", &["-ftrivial-auto-var-init=zero"][..]),
        ("zero1", &["-O", "-ftrivial-auto-var-init=zero"][..]),
        (
            "pattern0",
            &["-ftrivial-auto-var-init=pattern", "-DEXPECT=0xFE"][..],
        ),
        (
            "pattern1",
            &["-O", "-ftrivial-auto-var-init=pattern", "-DEXPECT=0xFE"][..],
        ),
    ] {
        assert_eq!(
            build(name, flags),
            Some(0),
            "{flags:?}: stale bytes read back"
        );
    }
    assert_ne!(
        build("none", &[]),
        Some(0),
        "the probes must see the stale bytes without the flag"
    );
}

/// Both flags take their gcc value sets and reject anything else by
/// name. `-fzero-init-padding-bits=` changes nothing: an automatic
/// aggregate initializer already zero-fills the object, which
/// `init_padding_zero.c` locks; every value has to compile a unit.
#[test]
fn auto_var_init_and_padding_flags_are_validated_by_name() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let root = TempDir::new("badc-auto-var-flags");
    let src = root.join("f.c");
    std::fs::write(
        &src,
        "int f(void) { struct { char c; int i; } s = { 1 }; int x; return s.i + x; }\n",
    )
    .expect("write source");
    let compile = |flag: &str| {
        Command::new(badc)
            .arg("--target=linux-x64")
            .arg(flag)
            .arg("-c")
            .arg("-o")
            .arg(root.join("f.o"))
            .arg(&src)
            .output()
            .expect("run badc")
    };
    for flag in [
        "-ftrivial-auto-var-init=uninitialized",
        "-ftrivial-auto-var-init=zero",
        "-ftrivial-auto-var-init=pattern",
        "-fzero-init-padding-bits=standard",
        "-fzero-init-padding-bits=unions",
        "-fzero-init-padding-bits=all",
    ] {
        let out = compile(flag);
        assert!(
            out.status.success(),
            "{flag}: {}",
            String::from_utf8_lossy(&out.stderr)
        );
    }
    for (flag, name) in [
        ("-ftrivial-auto-var-init=random", "-ftrivial-auto-var-init="),
        ("-fzero-init-padding-bits=none", "-fzero-init-padding-bits="),
    ] {
        let out = compile(flag);
        let stderr = String::from_utf8_lossy(&out.stderr);
        assert!(!out.status.success(), "{flag} must be rejected");
        assert!(
            stderr.contains(name),
            "{flag}: the rejection names the flag: {stderr}"
        );
    }
}

/// A build may name the guard's register and symbol without naming the
/// form, because gcc's x86 default for `-mstack-protector-guard=` is
/// `tls`. aarch64 has no such default and still requires it.
#[test]
fn the_x86_guard_form_defaults_the_way_gcc_does() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let root = TempDir::new("badc-ssp-guard");
    let src = root.join("g.c");
    std::fs::write(
        &src,
        "int f(int i){ char b[24]; b[0]=(char)i; return b[0]; }\n",
    )
    .expect("write source");
    let obj = root.join("g.o");
    let compile = |args: &[&str]| {
        std::process::Command::new(badc)
            .args(args)
            .arg("-fstack-protector-strong")
            .arg("-c")
            .arg("-o")
            .arg(&obj)
            .arg(&src)
            .output()
            .expect("run badc")
    };
    // A register and a symbol, with no `-mstack-protector-guard=`.
    let out = compile(&[
        "--target=linux-x64",
        "-mstack-protector-guard-reg=gs",
        "-mstack-protector-guard-symbol=__ref_stack_chk_guard",
    ]);
    assert!(
        out.status.success(),
        "the x86 guard register alone must select the tls form: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    // A symbol alone selects the form too, read through the code model's
    // segment: `mov %seg:sym(%rip), %r11`.
    for (model, seg, other) in [("small", 0x64u8, 0x65u8), ("kernel", 0x65, 0x64)] {
        let out = compile(&[
            "--target=linux-x64",
            &format!("-mcmodel={model}"),
            "-mstack-protector-guard-symbol=g",
        ]);
        let err = String::from_utf8_lossy(&out.stderr);
        assert!(out.status.success(), "{model}: {err}");
        let bytes = std::fs::read(&obj).expect("read the object");
        let reads = |prefix: u8| bytes.windows(4).any(|w| w == [prefix, 0x4C, 0x8B, 0x1D]);
        assert!(reads(seg) && !reads(other), "{model}: the guard's segment");
    }
    // The uniprocessor branch of the same Makefile still names its form.
    let out = compile(&["--target=linux-x64", "-mstack-protector-guard=global"]);
    assert!(out.status.success(), "`global` must stay accepted");
    // aarch64 has no default form, so naming only the register is an error.
    let out = compile(&[
        "--target=linux-aarch64",
        "-mstack-protector-guard-reg=sp_el0",
    ]);
    assert!(
        !out.status.success(),
        "aarch64 must still require the guard form"
    );
}

/// A protected image has to behave two ways: unchanged when nothing
/// overflows, and stopped at `__stack_chk_fail` when a frame is smashed.
/// The first is the fixture, run under every mode at both optimization
/// levels; the second overruns a local array by enough to reach past the
/// canary and asserts the process dies by signal rather than returning
/// through the overwritten address.
#[test]
fn stack_protector_canary_holds_and_catches_a_smashed_frame() {
    let Some(target) = host_native_target() else {
        return;
    };
    let badc = env!("CARGO_BIN_EXE_badc");
    let root = TempDir::new("badc-ssp-run");

    // `strong` runs at both optimization levels; the rest cover their own
    // selection at one.
    for (mode, opt) in [
        ("-fno-stack-protector", &[][..]),
        ("-fstack-protector", &[][..]),
        ("-fstack-protector-strong", &[][..]),
        ("-fstack-protector-strong", &["-O"][..]),
        ("-fstack-protector-all", &["-O"][..]),
    ] {
        {
            let out = root.join("canary");
            let built = Command::new(badc)
                .arg(format!("--target={target}"))
                .arg(mode)
                .args(opt)
                .arg("-o")
                .arg(&out)
                .arg(fixtures_dir().join("stack_protector_canary.c"))
                .output()
                .expect("run badc");
            assert!(
                built.status.success(),
                "{mode} {opt:?}: build failed -- {}",
                String::from_utf8_lossy(&built.stderr)
            );
            let run = Command::new(&out).output().expect("run the image");
            assert_eq!(
                run.status.code(),
                Some(0),
                "{mode} {opt:?}: the protected image must behave as the plain one"
            );
        }
    }

    // The overflow is passed at run time so no constant-folding path can
    // see it; `smash` overruns `b` by 48 bytes, past the canary region and
    // into the saved frame pointer and return address.
    let src = root.join("smash.c");
    std::fs::write(
        &src,
        "#include <stdio.h>\n\
         #include <string.h>\n\
         static void smash(const char *s) { char b[16]; strcpy(b, s); printf(\"%s\", b); }\n\
         int main(int argc, char **argv) {\n\
         \tchar big[64];\n\
         \tmemset(big, 'A', sizeof big);\n\
         \tbig[sizeof big - 1] = 0;\n\
         \tsmash(argc > 1 ? big : \"ok\");\n\
         \treturn 0;\n\
         }\n",
    )
    .expect("write the smashing source");
    let out = root.join("smash");
    let built = Command::new(badc)
        .arg(format!("--target={target}"))
        .arg("-fstack-protector-strong")
        .arg("-o")
        .arg(&out)
        .arg(&src)
        .output()
        .expect("run badc");
    assert!(
        built.status.success(),
        "smash build failed -- {}",
        String::from_utf8_lossy(&built.stderr)
    );
    let clean = Command::new(&out).output().expect("run the image");
    assert_eq!(
        clean.status.code(),
        Some(0),
        "no overflow, no check failure"
    );
    let smashed = Command::new(&out)
        .arg("overflow")
        .output()
        .expect("run the image");
    assert_eq!(
        smashed.status.code(),
        None,
        "a smashed frame must reach __stack_chk_fail, which does not return"
    );
}

/// `-fpatchable-function-entry=2,1` on the host, with `-pg -mfentry
/// -mrecord-mcount` on x86-64: the NOP after each symbol and the
/// `__fentry__` call execute, and the image links only if the records
/// do. `__fentry__` is file-scope asm because the contract is that it
/// keeps every register, which a C body does not.
#[test]
fn patchable_entries_and_fentry_calls_run_on_the_native_target() {
    let Some(target) = host_smoke_target() else {
        return;
    };
    let badc = env!("CARGO_BIN_EXE_badc");
    let root = TempDir::new("badc-pfe-run");
    let src = root.join("pfe.c");
    std::fs::write(
        &src,
        "long fentry_calls;\n\
         #ifdef __x86_64__\n\
         __asm__(\".text\\n.globl __fentry__\\n.type __fentry__, @function\\n\"\n\
                 \"__fentry__:\\n\\tincq fentry_calls(%rip)\\n\\tret\\n\");\n\
         #endif\n\
         __attribute__((noinline)) int add(int a, int b) { return a + b; }\n\
         __attribute__((noinline)) int mul(int a, int b) { return a * b; }\n\
         __attribute__((noinline, no_instrument_function)) int sub(int a, int b) { return a - b; }\n\
         int main(void) {\n\
             int r = add(2, 3) + mul(4, 5) + sub(30, 5);\n\
             if (r != 50) return 1;\n\
         #ifdef __x86_64__\n\
             /* main, add and mul; sub is not instrumented. */\n\
             if (fentry_calls != 3) return 2;\n\
         #endif\n\
             return 0;\n\
         }\n",
    )
    .expect("write source");
    let x86 = target == "linux-x64";
    for (tag, opt) in [("-O0", &[][..]), ("-O", &["-O"][..])] {
        let exe = root.join(format!("pfe{tag}"));
        let mut cmd = Command::new(badc);
        cmd.arg(format!("--target={target}"))
            .args(opt)
            .arg("-fpatchable-function-entry=2,1");
        if x86 {
            cmd.args(["-pg", "-mfentry", "-mrecord-mcount"]);
        }
        let built = cmd
            .arg("-o")
            .arg(&exe)
            .arg(&src)
            .output()
            .expect("run badc");
        assert!(
            built.status.success(),
            "{tag}: build failed: {}",
            String::from_utf8_lossy(&built.stderr)
        );
        let run = Command::new(&exe).output().expect("run image");
        assert_eq!(
            run.status.code(),
            Some(0),
            "{tag}: the instrumented image failed"
        );
    }
}

/// Sixteen integers and twenty doubles live across calls, more than either
/// callee-saved bank holds, so at `-O` every register of both banks and the
/// FP scratch see use; `fpr_leaf` fills the caller-saved FP bank of a
/// target with no callee-saved one. `clobbers` names a callee-saved
/// register in a clobber list, which the emitter otherwise saves around
/// the statement.
const FIXED_PRESSURE_SRC: &str = "\
long sink(long a, long b, long c, long d) { return a + b + c + d; }
__attribute__((noinline)) double fsink(double a, double b) { return a - b; }
long gpr_pressure(long *p) {
    long v0 = p[0], v1 = p[1], v2 = p[2], v3 = p[3], v4 = p[4], v5 = p[5];
    long v6 = p[6], v7 = p[7], v8 = p[8], v9 = p[9], v10 = p[10], v11 = p[11];
    long v12 = p[12], v13 = p[13], v14 = p[14], v15 = p[15];
    long r = sink(v0, v1, v2, v3);
    r += sink(v4, v5, v6, v7);
    return r + v0 * 3 + v1 * 5 + v2 * 7 + v3 * 11 + v4 * 13 + v5 * 17 + v6 * 19 + v7 * 23
        + v8 * 29 + v9 * 31 + v10 * 37 + v11 * 41 + v12 * 43 + v13 * 47 + v14 * 53 + v15 * 59;
}
double fpr_pressure(double *p) {
    double v0 = p[0], v1 = p[1], v2 = p[2], v3 = p[3], v4 = p[4], v5 = p[5];
    double v6 = p[6], v7 = p[7], v8 = p[8], v9 = p[9], v10 = p[10], v11 = p[11];
    double v12 = p[12], v13 = p[13], v14 = p[14], v15 = p[15], v16 = p[16], v17 = p[17];
    double v18 = p[18], v19 = p[19];
    double r = fsink(v0, v1);
    r += fsink(v2, v3);
    return r + v0 * 3 + v1 * 5 + v2 * 7 + v3 * 11 + v4 * 13 + v5 * 17 + v6 * 19 + v7 * 23
        + v8 * 29 + v9 * 31 + v10 * 37 + v11 * 41 + v12 * 43 + v13 * 47 + v14 * 53 + v15 * 59
        + v16 * 61 + v17 * 67 + v18 * 71 + v19 * 73;
}
double fpr_leaf(double *p) {
    double v0 = p[0], v1 = p[1], v2 = p[2], v3 = p[3], v4 = p[4], v5 = p[5];
    double v6 = p[6], v7 = p[7];
    return v0 * v1 + v2 * v3 + v4 * v5 + v6 * v7 + v0 * v7 + v1 * v6 + v2 * v5 + v3 * v4;
}
#ifdef __aarch64__
long clobbers(long a) { __asm__(\"nop\" ::: \"x20\"); return a; }
#else
long clobbers(long a) { __asm__(\"nop\" ::: \"r12\"); return a; }
#endif
";

/// A `main` over [`FIXED_PRESSURE_SRC`] that checks every function against
/// plain loops and exits 0 when all agree.
const FIXED_PRESSURE_MAIN: &str = "\
long add3(long a, long b, long c) { return a + b * 2 + c * 3; }
double mix(double a, double b) { return a * 2.0 + b; }
int main(void) {
    static const long gw[16] = {3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59};
    static const long fw[20] = {3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59,
                                61, 67, 71, 73};
    long p[16]; double q[20]; long i;
    for (i = 0; i < 16; i++) p[i] = i + 1;
    for (i = 0; i < 20; i++) q[i] = (double)(i + 1) * 0.5;
    long ge = (1 + 2 + 3 + 4) + (5 + 6 + 7 + 8);
    double fe = (0.5 - 1.0) + (1.5 - 2.0);
    for (i = 0; i < 16; i++) ge += p[i] * gw[i];
    for (i = 0; i < 20; i++) fe += q[i] * (double)fw[i];
    double le = 0.0;
    for (i = 0; i < 4; i++) le += q[2 * i] * q[2 * i + 1] + q[i] * q[7 - i];
    int bad = 0;
    if (gpr_pressure(p) != ge) bad |= 1;
    if (fpr_pressure(q) != fe) bad |= 2;
    if (fpr_leaf(q) != le) bad |= 4;
    if (clobbers(7) != 7) bad |= 8;
    if (add3(1, 2, 3) != 14 || mix(1.5, 2.0) != 5.0) bad |= 16;
    return bad;
}
";

/// Disassemble `obj` with the first of `llvm-objdump` / `objdump` on PATH
/// that decodes it, recognised by `marker` appearing in the output.
/// `None` when neither is installed or neither decodes the object's
/// architecture.
#[cfg(any(target_os = "linux", target_os = "macos"))]
fn disassemble_marked(obj: &std::path::Path, marker: &str) -> Option<String> {
    for tool in ["llvm-objdump", "objdump"] {
        let Ok(out) = Command::new(tool)
            .args(["-d", "--no-show-raw-insn"])
            .arg(obj)
            .output()
        else {
            continue;
        };
        let text = String::from_utf8_lossy(&out.stdout).into_owned();
        if out.status.success() && text.contains(marker) {
            return Some(text);
        }
    }
    None
}

#[cfg(any(target_os = "linux", target_os = "macos"))]
fn disassemble(obj: &std::path::Path) -> Option<String> {
    disassemble_marked(obj, "<gpr_pressure>:")
}

/// `(instructions, instructions naming one of `names`)` in the body of
/// `func`. Operands are split at every character outside `[A-Za-z0-9_]`,
/// so `%r12d`, `v16.2d` and `[x20, #8]` each yield their register as a
/// token.
#[cfg(any(target_os = "linux", target_os = "macos"))]
fn register_mentions(dis: &str, func: &str, names: &[&str]) -> (usize, usize) {
    let mut in_func = false;
    let (mut total, mut hits) = (0usize, 0usize);
    for line in dis.lines() {
        if line.contains('<') && line.trim_end().ends_with(">:") {
            in_func = line.contains(&format!("<{func}>:"));
            continue;
        }
        let Some((addr, body)) = line.split_once(':') else {
            continue;
        };
        let addr = addr.trim();
        if !in_func || addr.is_empty() || !addr.bytes().all(|b| b.is_ascii_hexdigit()) {
            continue;
        }
        total += 1;
        if body
            .split(|c: char| !c.is_ascii_alphanumeric() && c != '_')
            .any(|tok| names.contains(&tok))
        {
            hits += 1;
        }
    }
    (total, hits)
}

/// `-ffixed-REG` keeps the register out of the emitted text of a function
/// under register pressure, for a general and an FP register on both
/// targets, including a register the emitter would otherwise use as its
/// own FP scratch and one an inline-asm clobber list names. The plain
/// build is the control: the same functions use every one of them.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn ffixed_keeps_the_register_out_of_the_emitted_code() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let root = TempDir::new("badc-ffixed");
    let src = root.join("pressure.c");
    std::fs::write(&src, FIXED_PRESSURE_SRC).expect("write source");
    // The pressure caps of a `codegen_test` run would keep the control
    // build off the register under test; the banks are the full ones.
    let compile = |target: &str, flags: &[&str], obj: &std::path::Path| {
        let out = Command::new(badc)
            .env_remove("BADC_MAX_GPR")
            .env_remove("BADC_MAX_FPR")
            .arg(format!("--target={target}"))
            .args(["-O", "-c", "-o"])
            .arg(obj)
            .args(flags)
            .arg(&src)
            .output()
            .expect("run badc");
        assert!(
            out.status.success(),
            "{target} {flags:?}: {}",
            String::from_utf8_lossy(&out.stderr)
        );
    };
    let a64_v16: &[&str] = &["b16", "h16", "s16", "d16", "q16", "v16"];
    let a64_v10: &[&str] = &["b10", "h10", "s10", "d10", "q10", "v10"];
    let a64_x20: &[&str] = &["x20", "w20"];
    let x64_r12: &[&str] = &["r12", "r12d", "r12w", "r12b"];
    // Per function, the spellings that must vanish under the flags.
    type Mentions<'a> = &'a [(&'a str, &'a [&'a str])];
    let cases: [(&str, &[&str], Mentions); 2] = [
        (
            "linux-aarch64",
            &["-ffixed-x20", "-ffixed-q16", "-ffixed-d10"],
            &[
                ("gpr_pressure", a64_x20),
                ("fpr_pressure", a64_v16),
                ("fpr_pressure", a64_v10),
                ("clobbers", a64_x20),
            ],
        ),
        (
            "linux-x64",
            &["-ffixed-r12", "-ffixed-xmm14", "-ffixed-xmm5"],
            &[
                ("gpr_pressure", x64_r12),
                ("fpr_pressure", &["xmm14"]),
                ("fpr_leaf", &["xmm5"]),
                ("clobbers", x64_r12),
            ],
        ),
    ];
    let mut measured = 0usize;
    for (target, flags, checks) in cases {
        let plain = root.join(format!("{target}-plain.o"));
        compile(target, &[], &plain);
        let Some(control) = disassemble(&plain) else {
            eprintln!("{target}: no disassembler decodes the object; register check not run");
            continue;
        };
        let reserved = root.join(format!("{target}-fixed.o"));
        compile(target, flags, &reserved);
        let text = disassemble(&reserved).expect("the second object decodes like the first");
        for (func, names) in checks {
            let (n, used) = register_mentions(&control, func, names);
            assert!(n > 0, "{target}: `{func}` not found in the disassembly");
            assert!(
                used > 0,
                "{target}: `{func}` does not use {names:?} without the flag"
            );
            let (m, left) = register_mentions(&text, func, names);
            assert!(m > 0, "{target}: `{func}` missing from the reserved build");
            assert_eq!(
                left, 0,
                "{target}: `{func}` names {names:?} under {flags:?}"
            );
            measured += 1;
        }
    }
    if measured == 0 {
        eprintln!("ffixed: no disassembler on PATH; the emitted-code check was skipped");
    }
}

/// Functions whose AArch64 lowering borrows a register for a sequence of
/// its own: a binary128 `long double` load and store, a `-mstrict-align`
/// access split to its alignment, a 16-byte atomic load, `va_copy` and
/// `va_arg`; and two that keep argument values live across one.
const FIXED_BORROW_SRC: &str = "\
#include <stdarg.h>
struct __attribute__((packed)) P { char c; long v; };
double ld_load(long double *p) { return (double)p[0]; }
void ld_store(long double *p, double d) { p[1] = d; }
long narrow_load(struct P *p) { return p->v; }
void narrow_store(struct P *p, long v) { p->v = v; }
typedef struct { unsigned long long lo, hi; } u128;
void load16(const u128 *p, unsigned long long *l, unsigned long long *h) {
    unsigned long long a, b;
    __asm__(\"ldp %[l], %[h], %[mem]\" : [l] \"=r\"(a), [h] \"=r\"(b) : [mem] \"m\"(*p));
    *l = a;
    *h = b;
}
int second(int n, ...) {
    va_list a, b;
    va_start(a, n);
    va_copy(b, a);
    int r = va_arg(b, int);
    r += va_arg(b, int);
    va_end(b);
    va_end(a);
    return r;
}
long live_load(long double *p, long a, long b, long c, long d, long e, long f, long g) {
    double v = (double)p[0];
    return a + 2 * b + 3 * c + 4 * d + 5 * e + 6 * f + 7 * g + (long)v;
}
long live_store(struct P *p, long v, long a, long b) {
    p->v = v;
    return a - b;
}
";

/// A `main` over [`FIXED_BORROW_SRC`] that exits 0 when every function
/// returns what C says it does.
const FIXED_BORROW_MAIN: &str = "\
int main(void) {
    long double ld[2] = {1.5L, 0};
    struct P p = {1, 0x1122334455667788};
    u128 q = {7, 9};
    unsigned long long l = 0, h = 0;
    int bad = 0;
    if (ld_load(ld) != 1.5) bad |= 1;
    ld_store(ld, 2.25);
    if (ld[1] != 2.25L) bad |= 2;
    if (narrow_load(&p) != 0x1122334455667788) bad |= 4;
    narrow_store(&p, -5);
    if (p.v != -5) bad |= 8;
    load16(&q, &l, &h);
    if (l != 7 || h != 9) bad |= 16;
    if (second(2, 40, 2) != 42) bad |= 32;
    if (live_load(ld, 1, 2, 3, 4, 5, 6, 7) != 140 + 1) bad |= 64;
    if (live_store(&p, 3, 50, 8) != 42 || p.v != 3) bad |= 128;
    return bad;
}
";

/// `-ffixed-REG` keeps the register out of every sequence that borrows
/// one: under `-ffixed-x9` none names x9, which each takes first without
/// the flag, and with x9..x15 all reserved none names any of them.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn ffixed_keeps_the_register_out_of_borrowing_sequences() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let root = TempDir::new("badc-ffixed-borrow");
    let src = root.join("borrow.c");
    std::fs::write(&src, FIXED_BORROW_SRC).expect("write source");
    let compile = |flags: &[&str], obj: &std::path::Path| {
        let out = Command::new(badc)
            .args(["--target=linux-aarch64", "-O", "-mstrict-align", "-c", "-o"])
            .arg(obj)
            .args(flags)
            .arg(&src)
            .output()
            .expect("run badc");
        assert!(
            out.status.success(),
            "{flags:?}: {}",
            String::from_utf8_lossy(&out.stderr)
        );
    };
    let funcs = [
        "ld_load",
        "ld_store",
        "narrow_load",
        "narrow_store",
        "load16",
        "second",
        "live_load",
        "live_store",
    ];
    let plain = root.join("plain.o");
    compile(&[], &plain);
    let Some(control) = disassemble_marked(&plain, "<ld_load>:") else {
        eprintln!("ffixed borrow: no disassembler decodes the object; the check was skipped");
        return;
    };
    let x9: &[&str] = &["x9", "w9"];
    for func in funcs {
        let (n, used) = register_mentions(&control, func, x9);
        assert!(
            n > 0 && used > 0,
            "`{func}` does not use x9 without the flag"
        );
    }
    let all: Vec<String> = (9..=15)
        .flat_map(|r| [format!("x{r}"), format!("w{r}")])
        .collect();
    let all: Vec<&str> = all.iter().map(String::as_str).collect();
    let flags_all: Vec<String> = (9..=15).map(|r| format!("-ffixed-x{r}")).collect();
    let flags_all: Vec<&str> = flags_all.iter().map(String::as_str).collect();
    for (flags, names) in [(&["-ffixed-x9"][..], x9), (&flags_all[..], &all[..])] {
        let obj = root.join("fixed.o");
        compile(flags, &obj);
        let text = disassemble_marked(&obj, "<ld_load>:").expect("decodes like the control");
        for func in funcs {
            let (n, left) = register_mentions(&text, func, names);
            assert!(n > 0, "`{func}` missing under {flags:?}");
            assert_eq!(left, 0, "`{func}` names {names:?} under {flags:?}");
        }
    }
}

/// With x9..x15 reserved the borrowing sequences take argument registers,
/// some holding values live across them, and the image computes what C
/// says at both optimization levels.
#[test]
fn ffixed_borrowing_sequences_keep_live_values() {
    let Some(target) = host_native_target().filter(|t| t.ends_with("aarch64")) else {
        return;
    };
    let badc = env!("CARGO_BIN_EXE_badc");
    let root = TempDir::new("badc-ffixed-borrow-run");
    let src = root.join("run.c");
    std::fs::write(&src, format!("{FIXED_BORROW_SRC}{FIXED_BORROW_MAIN}")).expect("write");
    let fixed: Vec<String> = (9..=15).map(|r| format!("-ffixed-x{r}")).collect();
    for opt in [&[][..], &["-O"][..]] {
        let bin = root.join("run");
        let built = Command::new(badc)
            .arg(format!("--target={target}"))
            .args(opt)
            .arg("-mstrict-align")
            .args(&fixed)
            .arg("-o")
            .arg(&bin)
            .arg(&src)
            .output()
            .expect("run badc");
        assert!(
            built.status.success(),
            "{opt:?}: build failed -- {}",
            String::from_utf8_lossy(&built.stderr)
        );
        let run = Command::new(&bin).output().expect("run the image");
        assert_eq!(run.status.code(), Some(0), "{opt:?}: a result disagreed");
    }
}

/// An unknown name, a register the code generator cannot give up, and a
/// reservation that leaves no FP scratch are each refused with a
/// diagnostic that names the cause.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn ffixed_refuses_what_it_cannot_honour() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let root = TempDir::new("badc-ffixed-err");
    let src = root.join("pressure.c");
    std::fs::write(&src, FIXED_PRESSURE_SRC).expect("write source");
    let refused = |target: &str, flags: &[&str], expect: &[&str]| {
        let out = Command::new(badc)
            .arg(format!("--target={target}"))
            .args(["-c", "-o"])
            .arg(root.join("out.o"))
            .args(flags)
            .arg(&src)
            .output()
            .expect("run badc");
        let stderr = String::from_utf8_lossy(&out.stderr);
        assert!(!out.status.success(), "{target} {flags:?} must fail");
        for e in expect {
            assert!(
                stderr.contains(e),
                "{target} {flags:?}: expected `{e}` in: {stderr}"
            );
        }
    };
    refused(
        "linux-aarch64",
        &["-ffixed-bogus"],
        &["-ffixed-bogus", "unknown register name"],
    );
    refused(
        "linux-x64",
        &["-ffixed-bogus"],
        &["-ffixed-bogus", "unknown register name"],
    );
    refused(
        "linux-aarch64",
        &["-ffixed-"],
        &["requires a register name"],
    );
    refused("linux-aarch64", &["-ffixed-sp"], &["stack pointer"]);
    refused("linux-aarch64", &["-ffixed-x29"], &["frame pointer"]);
    refused("linux-aarch64", &["-ffixed-x16"], &["scratch register"]);
    refused("linux-x64", &["-ffixed-rsp"], &["stack pointer"]);
    refused("linux-x64", &["-ffixed-ebp"], &["frame pointer"]);
    refused("linux-x64", &["-ffixed-r10"], &["scratch register"]);
    // Every xmm outside the allocator's bank reserved: a function with FP
    // work has no scratch left and the diagnostic names it.
    let all_upper: Vec<String> = (8..16).map(|n| format!("-ffixed-xmm{n}")).collect();
    let flags: Vec<&str> = all_upper.iter().map(String::as_str).collect();
    refused(
        "linux-x64",
        &flags,
        &["no floating-point scratch register", "function `fsink`"],
    );
}

/// Reserving argument registers and the emitter's FP scratch changes no
/// result: the ABI still passes through them, and the image runs the
/// same at both optimization levels.
#[test]
fn ffixed_argument_registers_still_carry_the_call() {
    let Some(target) = host_native_target() else {
        return;
    };
    let badc = env!("CARGO_BIN_EXE_badc");
    let root = TempDir::new("badc-ffixed-run");
    let src = root.join("run.c");
    std::fs::write(&src, format!("{FIXED_PRESSURE_SRC}{FIXED_PRESSURE_MAIN}")).expect("write");
    let flags: &[&str] = if target.ends_with("aarch64") {
        &[
            "-ffixed-x1",
            "-ffixed-d1",
            "-ffixed-x20",
            "-ffixed-q16",
            "-ffixed-q17",
        ]
    } else {
        &[
            "-ffixed-rsi",
            "-ffixed-xmm1",
            "-ffixed-r12",
            "-ffixed-xmm14",
            "-ffixed-xmm15",
        ]
    };
    for opt in [&[][..], &["-O"][..]] {
        let bin = root.join("run");
        let built = Command::new(badc)
            .arg(format!("--target={target}"))
            .args(opt)
            .args(flags)
            .arg("-o")
            .arg(&bin)
            .arg(&src)
            .output()
            .expect("run badc");
        assert!(
            built.status.success(),
            "{opt:?}: build failed -- {}",
            String::from_utf8_lossy(&built.stderr)
        );
        let run = Command::new(&bin).output().expect("run the image");
        assert_eq!(
            run.status.code(),
            Some(0),
            "{opt:?}: a function disagreed with its reference"
        );
    }
}

/// `-mcpu=` sets the AArch64 feature macros the way gcc does and
/// refuses what badc does not implement: `+crypto` makes the AES
/// intrinsics compile for linux-aarch64, an unknown extension and an
/// x86-64 target are refused by name.
#[test]
fn mcpu_extensions_gate_the_feature_macros() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let root = TempDir::new("badc-mcpu");
    let src = root.join("aes.c");
    std::fs::write(
        &src,
        "#ifndef __ARM_FEATURE_CRYPTO\n#error crypto missing\n#endif\n\
         #include <arm_neon.h>\n\
         uint8x16_t r(uint8x16_t s, uint8x16_t k) { return vaesmcq_u8(vaeseq_u8(s, k)); }\n",
    )
    .expect("write source");
    let obj = root.join("aes.o");
    let ok = Command::new(badc)
        .args([
            "--gnu",
            "-q",
            "-c",
            "--target=linux-aarch64",
            "-mcpu=generic+crypto",
        ])
        .arg(&src)
        .arg("-o")
        .arg(&obj)
        .output()
        .expect("run badc");
    assert!(
        ok.status.success(),
        "{}",
        String::from_utf8_lossy(&ok.stderr)
    );
    for (args, want) in [
        (
            &["-c", "--target=linux-aarch64", "-mcpu=generic+bogus"][..],
            "extension `bogus`",
        ),
        (
            &["-c", "--target=linux-x64", "-mcpu=generic"][..],
            "AArch64",
        ),
    ] {
        let out = Command::new(badc)
            .args(args)
            .arg(&src)
            .args(["-o", "/dev/null"])
            .output()
            .expect("run badc");
        let err = String::from_utf8_lossy(&out.stderr);
        assert!(
            !out.status.success() && err.contains(want),
            "{args:?}: {err}"
        );
    }
}

/// The profiling options are refused where gcc has none, by name.
#[test]
fn profiling_options_are_refused_by_name_where_gcc_has_none() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let root = TempDir::new("badc-pfe-refuse");
    let src = root.join("f.c");
    std::fs::write(&src, "int f(void) { return 0; }\n").expect("write source");
    for (target, flag) in [
        ("linux-aarch64", "-pg"),
        ("linux-aarch64", "-mfentry"),
        ("linux-aarch64", "-mrecord-mcount"),
        ("linux-x64", "-fpatchable-function-entry=1,2"),
        ("windows-x64", "-fpatchable-function-entry=2,1"),
        ("macos-aarch64", "-pg"),
    ] {
        let out = Command::new(badc)
            .arg(format!("--target={target}"))
            .arg(flag)
            .arg("-c")
            .arg("-o")
            .arg(root.join("f.o"))
            .arg(&src)
            .output()
            .expect("run badc");
        assert!(!out.status.success(), "{target} {flag}: must be refused");
        let stderr = String::from_utf8_lossy(&out.stderr);
        let name = flag.split('=').next().unwrap_or(flag);
        assert!(
            stderr.contains(name),
            "{target} {flag}: the diagnostic must name the option: {stderr}"
        );
    }
}

/// The diagnostic pragmas decide whether a unit compiles: the same
/// source reports, is silent, or fails depending on the pragma in
/// force at the reporting position.
#[test]
fn a_diagnostic_pragma_decides_the_exit_code() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-diagprag");

    let compile = |name: &str, body: &str| {
        let src = dir.join(format!("{name}.c"));
        std::fs::write(&src, format!("{body}int main(void) {{ return 0; }}\n"))
            .expect("write source");
        Command::new(badc)
            .arg("--target=linux-x64")
            .arg("-c")
            .arg(&src)
            .arg("-o")
            .arg(dir.join(format!("{name}.o")))
            .output()
            .expect("run badc")
    };

    let plain = compile("plain", "#pragma frobnicate\n");
    assert!(plain.status.success(), "an unknown pragma is not an error");
    let stderr = String::from_utf8_lossy(&plain.stderr);
    assert!(
        stderr.contains("[B1004] [-Wunknown-pragmas]"),
        "expected the unknown-pragma diagnostic: {stderr}"
    );

    for silencer in [
        "#pragma warning(disable : 4068)\n",
        "#pragma GCC diagnostic ignored \"-Wunknown-pragmas\"\n",
        "#pragma clang diagnostic ignored \"-Wunknown-pragmas\"\n",
    ] {
        let quiet = compile("quiet", &format!("{silencer}#pragma frobnicate\n"));
        assert!(quiet.status.success(), "{silencer}: must still compile");
        let stderr = String::from_utf8_lossy(&quiet.stderr);
        assert!(
            !stderr.contains("B1004"),
            "{silencer}: expected silence, got: {stderr}"
        );
    }

    for raiser in [
        "#pragma warning(error : 4068)\n",
        "#pragma GCC diagnostic error \"-Wunknown-pragmas\"\n",
    ] {
        let failed = compile("raised", &format!("{raiser}#pragma frobnicate\n"));
        assert!(
            !failed.status.success(),
            "{raiser}: a raised diagnostic must fail the unit"
        );
        let stderr = String::from_utf8_lossy(&failed.stderr);
        assert!(
            stderr.contains("error:") && stderr.contains("B1004"),
            "{raiser}: expected the raised diagnostic: {stderr}"
        );
    }
}

/// The same pragmas decide the level of the parser's diagnostics, not
/// only the preprocessor's: the events are keyed on offsets into the
/// preprocessed unit, which is the text the lexer reads.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn a_diagnostic_pragma_governs_a_parser_diagnostic() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-diagprag-parse");

    let compile = |name: &str, body: &str, extra: &[&str]| {
        let src = dir.join(format!("{name}.c"));
        std::fs::write(&src, body).expect("write source");
        Command::new(badc)
            .arg("--target=linux-x64")
            .arg("-Wall")
            .args(extra)
            .arg("-c")
            .arg(&src)
            .arg("-o")
            .arg(dir.join(format!("{name}.o")))
            .output()
            .expect("run badc")
    };

    let unused = "int main(void) { int n = 5; return 0; }\n";
    let plain = compile("plain", unused, &[]);
    assert!(plain.status.success());
    let stderr = String::from_utf8_lossy(&plain.stderr);
    assert!(
        stderr.contains("[B2001] [-Wunused-variable]"),
        "expected the parser's row: {stderr}"
    );

    // Each spelling of `ignored` reaches the same row; 4101 is the
    // catalogue's MSVC alias for it.
    for silencer in [
        "#pragma GCC diagnostic ignored \"-Wunused-variable\"\n",
        "#pragma clang diagnostic ignored \"-Wunused-variable\"\n",
        "#pragma warning(disable : 4101)\n",
    ] {
        let quiet = compile("quiet", &format!("{silencer}{unused}"), &[]);
        assert!(quiet.status.success(), "{silencer}: must still compile");
        let stderr = String::from_utf8_lossy(&quiet.stderr);
        assert!(
            !stderr.contains("B2001"),
            "{silencer}: expected silence, got: {stderr}"
        );
    }

    for raiser in [
        "#pragma GCC diagnostic error \"-Wunused-variable\"\n",
        "#pragma warning(error : 4101)\n",
    ] {
        let failed = compile("raised", &format!("{raiser}{unused}"), &[]);
        assert!(
            !failed.status.success(),
            "{raiser}: a raised diagnostic must fail the unit"
        );
        let stderr = String::from_utf8_lossy(&failed.stderr);
        assert!(
            stderr.contains("error:") && stderr.contains("B2001"),
            "{raiser}: expected the raised diagnostic: {stderr}"
        );
    }

    // `push` / `pop` bound the region: the declarations outside it
    // report, the one inside does not.
    let scoped = compile(
        "scoped",
        "int a(void) { int x = 1; return 0; }\n\
         #pragma GCC diagnostic push\n\
         #pragma GCC diagnostic ignored \"-Wunused-variable\"\n\
         int b(void) { int y = 1; return 0; }\n\
         #pragma GCC diagnostic pop\n\
         int main(void) { int z = 1; return a() + b(); }\n",
        &[],
    );
    assert!(scoped.status.success());
    let stderr = String::from_utf8_lossy(&scoped.stderr);
    assert!(
        stderr.contains("scoped.c:1:") && stderr.contains("scoped.c:6:") && !stderr.contains(":4:"),
        "push/pop must bound the region: {stderr}"
    );

    // The pragma decides where it covers the position and the command
    // line where it does not: `-Werror` fails the first declaration and
    // leaves the second a warning.
    let mixed = compile(
        "mixed",
        "int a(void) { int x = 1; return 0; }\n\
         #pragma GCC diagnostic warning \"-Wunused-variable\"\n\
         int main(void) { int y = 1; return a(); }\n",
        &["-Werror"],
    );
    assert!(!mixed.status.success(), "-Werror must fail the unit");
    let stderr = String::from_utf8_lossy(&mixed.stderr);
    assert!(
        stderr.contains("mixed.c:1: error:") && stderr.contains("mixed.c:3: warning:"),
        "the pragma must override -Werror at its position only: {stderr}"
    );
}

/// A pragma is a position in the translation unit, so one left set in a
/// header applies to everything the include precedes; a header that
/// wraps it in `push` / `pop` scopes it to itself. gcc and clang behave
/// the same way.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn a_header_scopes_its_diagnostic_pragma_with_push_and_pop() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-diagprag-hdr");
    std::fs::write(
        dir.join("leak.h"),
        "#pragma GCC diagnostic ignored \"-Wunused-variable\"\n",
    )
    .expect("write header");
    std::fs::write(
        dir.join("scoped.h"),
        "#pragma GCC diagnostic push\n\
         #pragma GCC diagnostic ignored \"-Wunused-variable\"\n\
         #pragma GCC diagnostic pop\n",
    )
    .expect("write header");

    let compile = |name: &str, header: &str| {
        let src = dir.join(format!("{name}.c"));
        std::fs::write(
            &src,
            format!("#include \"{header}\"\nint main(void) {{ int n = 5; return 0; }}\n"),
        )
        .expect("write source");
        Command::new(badc)
            .arg("--target=linux-x64")
            .arg("-Wall")
            .arg("-Werror")
            .arg("-c")
            .arg(&src)
            .arg("-o")
            .arg(dir.join(format!("{name}.o")))
            .output()
            .expect("run badc")
    };

    let leaked = compile("leaked", "leak.h");
    assert!(
        leaked.status.success(),
        "an unpopped pragma covers what follows the include: {}",
        String::from_utf8_lossy(&leaked.stderr)
    );
    let scoped = compile("scoped", "scoped.h");
    assert!(
        !scoped.status.success(),
        "a popped pragma must not reach past the include"
    );
    let stderr = String::from_utf8_lossy(&scoped.stderr);
    assert!(
        stderr.contains("[B2001] [-Wunused-variable]"),
        "expected the row back at its command-line level: {stderr}"
    );
}

/// A link diagnostic has no position in a translation unit, so no
/// pragma governs one; the command line does. This links a script whose
/// `ENTRY` no input defines and drives the row through `-Wno-` and
/// `-Werror=`.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn a_command_line_selector_governs_a_link_diagnostic() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-linkdiag");
    let src = dir.join("main.c");
    std::fs::write(&src, "int _start(void) { return 0; }\n").expect("write source");
    let script = dir.join("t.lds");
    std::fs::write(
        &script,
        "ENTRY(nosuch) SECTIONS { . = 0x400000; .text : { *(.text*) } }\n",
    )
    .expect("write script");
    let obj = dir.join("main.o");
    let compiled = Command::new(badc)
        .arg("--target=linux-x64")
        .arg("-c")
        .arg(&src)
        .arg("-o")
        .arg(&obj)
        .output()
        .expect("run badc");
    assert!(compiled.status.success());

    let link = |extra: &[&str]| {
        Command::new(badc)
            .arg("--target=linux-x64")
            .args(extra)
            .arg("-T")
            .arg(&script)
            .arg(&obj)
            .arg("-o")
            .arg(dir.join("out"))
            .output()
            .expect("run badc")
    };

    let plain = link(&[]);
    assert!(plain.status.success());
    let stderr = String::from_utf8_lossy(&plain.stderr);
    assert!(
        stderr.contains("[B6002] [-Wmissing-entry]"),
        "expected the link row: {stderr}"
    );

    let off = link(&["-Wno-missing-entry"]);
    assert!(off.status.success());
    assert!(
        !String::from_utf8_lossy(&off.stderr).contains("B6002"),
        "-Wno- must silence the link row"
    );

    let raised = link(&["-Werror=missing-entry"]);
    assert!(!raised.status.success(), "-Werror= must fail the link");
    let stderr = String::from_utf8_lossy(&raised.stderr);
    assert!(
        stderr.contains("error:") && stderr.contains("B6002"),
        "expected the raised link row: {stderr}"
    );
}

/// A warning reported before a hard error is printed ahead of it, the
/// way gcc prints every diagnostic of a failed unit.
#[test]
fn a_failed_unit_prints_the_warnings_reported_before_the_error() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-warn-then-err");
    let src = dir.join("unit.c");
    std::fs::write(
        &src,
        "#pragma frobnicate\nint main(void) { int x = ; return 0; }\n",
    )
    .expect("write source");
    let out = Command::new(badc)
        .arg("--target=linux-x64")
        .arg("-c")
        .arg(&src)
        .arg("-o")
        .arg(dir.join("unit.o"))
        .output()
        .expect("run badc");
    assert!(!out.status.success(), "a syntax error fails the unit");
    let stderr = String::from_utf8_lossy(&out.stderr);
    let warning = stderr
        .find("[B1004] [-Wunknown-pragmas]")
        .unwrap_or_else(|| panic!("the warning is printed: {stderr}"));
    let error = stderr
        .find("[B2020] [syntax]")
        .unwrap_or_else(|| panic!("the error is printed: {stderr}"));
    assert!(warning < error, "the warning precedes the error: {stderr}");
}

/// A `return` that does not fit the function's return type is an error
/// the user can lower, as gcc 14's `-Wreturn-mismatch` is.
#[test]
fn a_return_mismatch_is_an_error_the_user_can_lower() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-return-mismatch");
    let src = dir.join("unit.c");
    std::fs::write(
        &src,
        "void f(void) { return 1; }\nint main(void) { f(); return 0; }\n",
    )
    .expect("write source");
    let compile = |flags: &[&str]| {
        Command::new(badc)
            .arg("--target=linux-x64")
            .arg("-c")
            .args(flags)
            .arg(&src)
            .arg("-o")
            .arg(dir.join("unit.o"))
            .output()
            .expect("run badc")
    };
    let plain = compile(&[]);
    assert!(!plain.status.success(), "an error by default");
    let stderr = String::from_utf8_lossy(&plain.stderr);
    assert!(
        stderr.contains("error:") && stderr.contains("[B3026] [-Wreturn-mismatch]"),
        "{stderr}"
    );
    let lowered = compile(&["-Wno-error=return-mismatch"]);
    let stderr = String::from_utf8_lossy(&lowered.stderr);
    assert!(lowered.status.success(), "lowered to a warning: {stderr}");
    assert!(
        stderr.contains("warning:") && stderr.contains("[B3026] [-Wreturn-mismatch]"),
        "{stderr}"
    );
    let silenced = compile(&["-Wno-return-mismatch"]);
    let stderr = String::from_utf8_lossy(&silenced.stderr);
    assert!(
        silenced.status.success() && !stderr.contains("B3026"),
        "{stderr}"
    );
}

/// An integer and a pointer exchanged with no cast, in an argument, an
/// assignment, an initializer and a return and in both directions, is an
/// error by default, as gcc 14's and clang 15's `-Wint-conversion` is; a
/// null pointer constant is none. `-Wno-error=int-conversion` and
/// `-fpermissive` lower it to a warning the unit compiles under, and
/// `-Wno-int-conversion` silences it.
#[test]
fn int_conversion_is_an_error_the_user_can_lower() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-int-conversion");
    let compile = |name: &str, body: &str, flags: &[&str]| {
        let src = dir.join(format!("{name}.c"));
        std::fs::write(&src, body).expect("write source");
        let out = Command::new(badc)
            .arg("--target=linux-x64")
            .arg("-c")
            .args(flags)
            .arg(&src)
            .arg("-o")
            .arg(dir.join(format!("{name}.o")))
            .output()
            .expect("run badc");
        let err = String::from_utf8_lossy(&out.stderr).into_owned();
        (out.status.success(), err)
    };
    #[rustfmt::skip]
    const CASES: &[(&str, &str, &str)] = &[
        ("arg_ptr", "void f(char *);\nvoid g(void) { f(42); }\n", "integer assigned to pointer in argument 1 of `f`"),
        ("arg_int", "void f(int);\nvoid g(int *p) { f(p); }\n", "pointer assigned to integer in argument 1 of `f`"),
        ("assign_ptr", "void g(int n) { int *q; q = n; (void)q; }\n", "integer assigned to pointer in assignment"),
        ("assign_int", "void g(int *p) { int x; x = p; (void)x; }\n", "pointer assigned to integer in assignment"),
        ("init_ptr", "int *q = 1;\n", "integer assigned to pointer in initializer"),
        ("init_int", "void g(int *p) { long x = p; (void)x; }\n", "pointer assigned to integer in initializer"),
        ("ret_ptr", "int *g(void) { return 1; }\n", "integer assigned to pointer in return"),
        ("ret_int", "int g(int *p) { return p; }\n", "pointer assigned to integer in return"),
    ];
    let row = "[B3001] [-Wint-conversion]";
    for &(name, body, text) in CASES {
        let (ok, err) = compile(name, body, &[]);
        let reported = err.contains("error:") && err.contains(text) && err.contains(row);
        assert!(!ok && reported, "{name}: {err}");
        for flag in ["-Wno-error=int-conversion", "-fpermissive"] {
            let (ok, err) = compile(name, body, &[flag]);
            let lowered = err.contains("warning:") && err.contains(text);
            assert!(ok && lowered, "{name} {flag}: {err}");
        }
        let (ok, err) = compile(name, body, &["-Wno-int-conversion"]);
        assert!(ok && !err.contains("B3001"), "{name}: {err}");
    }
    let nulls = "int *a = 0, *b = 0L, *c = '\\0', *d = (1 - 1), *e = (void *)0;\n\
                 int *g(void) { return 0; }\nvoid f(int *);\nvoid h(void) { f(0); a = 0; }\n";
    let (ok, err) = compile("nulls", nulls, &[]);
    assert!(ok && !err.contains("B3001"), "{err}");
}

/// A `void` expression used as a value fails the unit with a hard error at
/// the line that reads it; `return` of a `void` call from a function
/// returning `void` compiles with no diagnostic.
#[test]
fn a_void_value_read_as_a_value_is_an_error() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-void-value-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");
    let compile = |name: &str, body: &str| {
        let src = dir.join(format!("{name}.c"));
        let text = format!("void f(void) {{}}\nint g(int x) {{ return x; }}\n{body}\n");
        std::fs::write(&src, text).expect("write source");
        Command::new(badc)
            .arg("--target=linux-x64")
            .arg("-c")
            .arg(&src)
            .arg("-o")
            .arg(dir.join(format!("{name}.o")))
            .output()
            .expect("run badc")
    };
    for (name, body) in [
        ("use", "int use(void) { return g((void)0); }"),
        ("init", "int init(void) { int x = (void)0; return x; }"),
        ("ret", "int ret(void) { return f(); }"),
        ("cond", "int cond(int c) { return c ? f() : f(); }"),
    ] {
        let out = compile(name, body);
        let stderr = String::from_utf8_lossy(&out.stderr);
        assert!(!out.status.success(), "{name}: {stderr}");
        let expected =
            format!("{name}.c:3: error: `void` expression used as a value [B3027] [void-value]");
        assert!(stderr.contains(&expected), "{name}: {stderr}");
    }
    let out = compile("void_return", "void w(void) { return f(); }");
    let stderr = String::from_utf8_lossy(&out.stderr);
    assert!(
        out.status.success() && !stderr.contains("B3026") && !stderr.contains("B3027"),
        "{stderr}"
    );
    let _ = std::fs::remove_dir_all(&dir);
}

/// An operand outside the category a C99 constraint names fails the unit at
/// the operand's line with that constraint's code; the pointer, `_Bool` and
/// cast-to-`void` forms compile with no diagnostic.
#[test]
fn an_operand_outside_its_category_is_an_error() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-operand-category-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");
    let compile = |name: &str, body: &str| {
        let src = dir.join(format!("{name}.c"));
        std::fs::write(&src, format!("struct S {{ int a; }};\n{body}\n")).expect("write source");
        Command::new(badc)
            .arg("--target=linux-x64")
            .arg("-c")
            .arg(&src)
            .arg("-o")
            .arg(dir.join(format!("{name}.o")))
            .output()
            .expect("run badc")
    };
    let controlling = "[B3028] [controlling-expression]";
    let operands = "[B3020] [invalid-operands]";
    for (name, body, code) in [
        (
            "cond",
            "int cond(struct S s) { if (s) return 1; return 0; }",
            controlling,
        ),
        (
            "loop",
            "int loop(struct S s) { while (s) return 1; return 0; }",
            controlling,
        ),
        ("cast", "int cast(struct S s) { return (int)s; }", operands),
        (
            "sub",
            "int sub(int *a, struct S s) { return a[s]; }",
            operands,
        ),
        (
            "tern",
            "int tern(struct S s) { return s ? 1 : 0; }",
            operands,
        ),
        (
            "sw",
            "int sw(double d) { switch (d) { case 1: return 1; } return 0; }",
            controlling,
        ),
        ("neg", "int neg(struct S s) { return -s; }", operands),
    ] {
        let out = compile(name, body);
        let stderr = String::from_utf8_lossy(&out.stderr);
        assert!(!out.status.success(), "{name}: {stderr}");
        let at_operand = format!("{name}.c:2: error: ");
        assert!(
            stderr.contains(&at_operand) && stderr.contains(code),
            "{name}: {stderr}"
        );
    }
    let out = compile(
        "valid",
        "int valid(struct S *sp, int *a, _Bool b) {\n\
         \tif (sp) return a ? a[b] : 0;\n\
         \tswitch (b) { default: return ((void)*sp, 1); }\n\
         }",
    );
    let stderr = String::from_utf8_lossy(&out.stderr);
    assert!(
        out.status.success() && !stderr.contains("error"),
        "{stderr}"
    );
    let _ = std::fs::remove_dir_all(&dir);
}

/// `-fno-builtin-<name>` withdraws the auto-include recovery for that
/// name alone: an undeclared call to it is the undeclared-function
/// error, while every other library name still recovers.
#[test]
fn no_builtin_name_drops_the_auto_include_for_that_name() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-no-builtin-name");
    let src = dir.join("unit.c");
    std::fs::write(&src, "int main(void) { puts(\"x\"); return 0; }\n").expect("write source");
    let compile = |flags: &[&str]| {
        Command::new(badc)
            .arg("--target=linux-x64")
            .arg("-c")
            .args(flags)
            .arg(&src)
            .arg("-o")
            .arg(dir.join("unit.o"))
            .output()
            .expect("run badc")
    };
    let listed = compile(&["-fno-builtin-puts"]);
    let stderr = String::from_utf8_lossy(&listed.stderr);
    assert!(
        !listed.status.success(),
        "the listed name must not recover: {stderr}"
    );
    assert!(
        stderr.contains("error:")
            && stderr.contains("unknown function `puts`")
            && !stderr.contains("auto-including"),
        "{stderr}"
    );
    let other = compile(&["-fno-builtin-memcpy"]);
    let stderr = String::from_utf8_lossy(&other.stderr);
    assert!(
        other.status.success(),
        "an unlisted name keeps the recovery: {stderr}"
    );
    assert!(
        stderr.contains("auto-including <stdio.h> for undeclared `puts`"),
        "{stderr}"
    );
}

/// A prototyped `int` return is widened to 64 bits once. At `-O0` the
/// result of `atoi` bound to an `int` object reaches its 64-bit use
/// through the object's sign-extending reload, so the call site adds no
/// widening of its own; read at 64 bits with no object in between, the
/// call site is where the one widening goes. Both targets, since each
/// carries its own emitter.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn prototyped_int_return_is_widened_once() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let src = fixtures_dir().join("call_int_return_single_widening.c");
    let dir = TempDir::new("badc-retwiden");

    // The sign-extending load is a widening too: on x86_64 it shares the
    // `movslq` mnemonic, on aarch64 it is `ldursw` beside the register
    // form's `sxtw`.
    let cases: [(&str, &[&str]); 2] = [
        ("linux-x64", &["movslq", "movsxd"]),
        ("linux-aarch64", &["sxtw", "ldursw", "ldrsw"]),
    ];
    let mut measured = 0usize;
    for (target, widenings) in cases {
        let obj = dir.join(format!("{target}.o"));
        let out = Command::new(badc)
            .arg(format!("--target={target}"))
            .args(["-O0", "-c", "-o"])
            .arg(&obj)
            .arg(&src)
            .output()
            .expect("run badc");
        assert!(
            out.status.success(),
            "{target}: {}",
            String::from_utf8_lossy(&out.stderr)
        );
        let Some(text) = disassemble_marked(&obj, "<via_int_slot>:") else {
            eprintln!("{target}: no disassembler decodes the object; check not run");
            continue;
        };
        // The libc callers take pointer parameters, so every widening in
        // them is the return's; `via_user_slot`'s reload of its `int` adds
        // one on aarch64 (`ldursw`), none on x86-64 (`movl`).
        let user_slot = if target == "linux-x64" { 1 } else { 2 };
        for (func, want) in [
            ("via_int_slot", 1usize),
            ("direct_libc_use", 1),
            ("pointer_offset", 1),
            ("via_user_slot", user_slot),
        ] {
            let (n, hits) = register_mentions(&text, func, widenings);
            assert!(n > 0, "{target}: `{func}` not found in the disassembly");
            assert_eq!(hits, want, "{target}: `{func}` widens {hits} times");
            measured += 1;
        }
    }
    if measured == 0 {
        eprintln!("int-return widening: no disassembler on PATH; the check was skipped");
    }
}

/// Compile the `tests/fixtures/c` fixture `name` for linux-x64 at `-O`
/// under the flags its `// snapshot-flags:` line pins, as the snapshot
/// generator builds it, into `dir`, returning the object.
#[cfg(any(target_os = "linux", target_os = "macos"))]
fn compile_fixture_object(dir: &std::path::Path, name: &str) -> PathBuf {
    let badc = env!("CARGO_BIN_EXE_badc");
    let fixture = fixtures_dir().join(name);
    let obj = dir.join(format!("{}.o", name.trim_end_matches(".c")));
    let out = Command::new(badc)
        .env_remove("BADC_MAX_GPR")
        .env_remove("BADC_MAX_FPR")
        .args(["--target=linux-x64", "-O"])
        .args(snapshot_flags(&fixture))
        .arg("-o")
        .arg(&obj)
        .arg(&fixture)
        .output()
        .expect("run badc");
    assert!(
        out.status.success(),
        "{name}: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    obj
}

/// Disassemble `obj` with its relocations shown, with the first of
/// `llvm-objdump` / `objdump` on PATH that decodes it; `None` when
/// neither is installed or neither decodes the object.
#[cfg(any(target_os = "linux", target_os = "macos"))]
fn disassemble_relocs(obj: &std::path::Path) -> Option<String> {
    for tool in ["llvm-objdump", "objdump"] {
        let Ok(out) = Command::new(tool)
            .args(["-dr", "--no-show-raw-insn"])
            .arg(obj)
            .output()
        else {
            continue;
        };
        let text = String::from_utf8_lossy(&out.stdout).into_owned();
        if out.status.success() && text.contains(">:") {
            return Some(text);
        }
    }
    None
}

/// The disassembly lines of `func`: from its `<func>:` header to the
/// next header, blank lines dropped.
#[cfg(any(target_os = "linux", target_os = "macos"))]
fn function_lines(dis: &str, func: &str) -> Vec<String> {
    let header = format!("<{func}>:");
    let mut lines = Vec::new();
    let mut inside = false;
    for line in dis.lines() {
        if line.contains('<') && line.trim_end().ends_with(">:") {
            inside = line.contains(&header);
            continue;
        }
        if inside && !line.trim().is_empty() {
            lines.push(line.to_string());
        }
    }
    assert!(!lines.is_empty(), "`{func}` not found in the disassembly");
    lines
}

/// An indirect `call` / `jmp` through a register, in either objdump's
/// AT&T spelling (`call *%r10`, `callq *%r10`).
#[cfg(any(target_os = "linux", target_os = "macos"))]
fn has_indirect_branch(lines: &[String]) -> bool {
    lines
        .iter()
        .any(|l| (l.contains("call") || l.contains("jmp")) && l.contains("*%"))
}

/// A `call` / `jmp` whose target is an `"i"` operand naming a function
/// (`call %c[__func]`) is a direct branch
/// to the symbol: a call relocation against an external name, a
/// resolved displacement to a function of the unit. An indirect branch
/// through a register would bypass the retpoline thunks the fixture's
/// flags request.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn asm_call_of_a_function_operand_is_direct() {
    let dir = TempDir::new("badc-asm-call-const");
    let obj = compile_fixture_object(&dir, "asm_call_function_operand.c");
    let Some(dis) = disassemble_relocs(&obj) else {
        eprintln!("no disassembler on PATH; the emitted-code check was skipped");
        return;
    };
    let plt32_to = |lines: &[String], sym: &str| {
        lines
            .iter()
            .any(|l| l.contains("R_X86_64_PLT32") && l.contains(sym))
    };
    let run_external = function_lines(&dis, "run_external");
    assert!(
        !has_indirect_branch(&run_external),
        "{}",
        run_external.join("\n")
    );
    assert!(
        plt32_to(&run_external, "external_target"),
        "{}",
        run_external.join("\n")
    );
    let run_local = function_lines(&dis, "run_local");
    assert!(!has_indirect_branch(&run_local), "{}", run_local.join("\n"));
    assert!(
        run_local
            .iter()
            .any(|l| l.contains("call") && l.contains("<local_target>")),
        "{}",
        run_local.join("\n")
    );
    let jump = function_lines(&dis, "jump_external");
    assert!(!has_indirect_branch(&jump), "{}", jump.join("\n"));
    assert!(plt32_to(&jump, "external_target"), "{}", jump.join("\n"));
}

/// One disassembled instruction of a function: its offset within the
/// function, its mnemonic, and the in-function offset a branch names.
#[cfg(any(target_os = "linux", target_os = "macos"))]
struct DisInsn {
    at: u64,
    mnemonic: String,
    target: Option<u64>,
    /// The instruction returns: `ret`, or a `jmp` relocated against the
    /// return thunk.
    returns: bool,
}

/// Parse `lines` (one function, from [`function_lines`]) into
/// instructions. A branch target is the `<func+0xN>` offset; a
/// relocation line applies to the instruction before it.
#[cfg(any(target_os = "linux", target_os = "macos"))]
fn parse_function(lines: &[String], func: &str) -> Vec<DisInsn> {
    let mut out: Vec<DisInsn> = Vec::new();
    let marker = format!("<{func}+0x");
    for line in lines {
        // A relocation line (offset of the field, then the type) belongs
        // to the instruction before it.
        if line.contains("R_X86_64") {
            if line.contains("__x86_return_thunk")
                && let Some(last) = out.last_mut()
            {
                last.returns = true;
            }
            continue;
        }
        let Some((addr, body)) = line.split_once(':') else {
            continue;
        };
        let addr = addr.trim();
        if addr.is_empty() || !addr.bytes().all(|b| b.is_ascii_hexdigit()) {
            continue;
        }
        let at = u64::from_str_radix(addr, 16).expect("hex offset");
        let mut toks = body.split_whitespace();
        let mnemonic = toks.next().unwrap_or("").to_string();
        let target = body
            .find(&marker)
            .and_then(|i| body[i + marker.len()..].split('>').next())
            .and_then(|hex| u64::from_str_radix(hex, 16).ok());
        let returns = mnemonic.starts_with("ret");
        out.push(DisInsn {
            at,
            mnemonic,
            target,
            returns,
        });
    }
    out
}

/// Every path from each `stac` in `func` reaches a `clac` before an
/// instruction that returns; a `ud2` ends a path. Returns the offset
/// of an offending return, if any.
#[cfg(any(target_os = "linux", target_os = "macos"))]
fn return_inside_stac_region(dis: &str, func: &str) -> Option<u64> {
    let insns = parse_function(&function_lines(dis, func), func);
    let base = insns.first().map_or(0, |i| i.at);
    let index_of = |off: u64| insns.iter().position(|i| i.at == base + off);
    let mut stacs = 0usize;
    for (start, insn) in insns.iter().enumerate() {
        if insn.mnemonic != "stac" {
            continue;
        }
        stacs += 1;
        let mut seen = vec![false; insns.len()];
        let mut work = vec![start + 1];
        while let Some(i) = work.pop() {
            let Some(insn) = insns.get(i) else {
                continue;
            };
            if std::mem::replace(&mut seen[i], true) || insn.mnemonic == "clac" {
                continue;
            }
            if insn.returns {
                return Some(insn.at);
            }
            if insn.mnemonic == "ud2" {
                continue;
            }
            if let Some(t) = insn.target.and_then(index_of) {
                work.push(t);
            }
            if !insn.mnemonic.starts_with("jmp") {
                work.push(i + 1);
            }
        }
    }
    assert!(stacs > 0, "`{func}` has no `stac`");
    None
}

/// After inlining a helper that opens a `stac` region and returns whether
/// it did, the caller's branch on its result is a branch on a phi of
/// constants; threading each predecessor past the merge leaves no path
/// from `stac` to a return that skips `clac`. The check walks the
/// disassembly's edges, for the plain-store and the `asm goto` store
/// shapes.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn every_path_from_stac_reaches_clac_before_returning() {
    let dir = TempDir::new("badc-stac-phi");
    let obj = compile_fixture_object(&dir, "stac_region_phi_branch.c");
    let Some(dis) = disassemble_relocs(&obj) else {
        eprintln!("no disassembler on PATH; the emitted-code check was skipped");
        return;
    };
    for func in ["put_user_word", "put_user_pair"] {
        if let Some(at) = return_inside_stac_region(&dis, func) {
            panic!(
                "{func}: return at {at:#x} reachable from `stac` without `clac`\n{}",
                function_lines(&dis, func).join("\n")
            );
        }
    }
}

/// Accessors whose always_inline body is one asm indirect call through a
/// member of a function-pointer table, with a stack-pointer operand,
/// inline. The stack-pointer operand used to make badc decline the body,
/// leaving a 166-byte out-of-line copy called at every site that read or
/// wrote the interrupt flag. No copy of one may survive, `-Winline` may
/// not name one, and each site keeps the call folded onto the table
/// member the source named.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn asm_table_call_accessors_with_a_stack_pointer_operand_inline() {
    let dir = TempDir::new("badc-table-call");
    let fixture = fixtures_dir().join("asm_table_call_accessors.c");
    let obj = dir.join("asm_table_call_accessors.o");
    let out = Command::new(env!("CARGO_BIN_EXE_badc"))
        .env_remove("BADC_MAX_GPR")
        .env_remove("BADC_MAX_FPR")
        .args(["--target=linux-x64", "-O", "-Winline"])
        .args(snapshot_flags(&fixture))
        .arg("-o")
        .arg(&obj)
        .arg(&fixture)
        .output()
        .expect("run badc");
    let log = String::from_utf8_lossy(&out.stderr).into_owned();
    assert!(out.status.success(), "{log}");
    let accessors = ["save_flags", "irq_off", "irq_on", "irq_save", "irq_restore"];
    for name in accessors {
        assert!(!log.contains(name), "-Winline names {name}: {log}");
    }
    let Some(dis) = disassemble_relocs(&obj) else {
        eprintln!("no disassembler on PATH; the emitted-code check was skipped");
        return;
    };
    for name in accessors {
        assert!(
            !dis.contains(&format!("<{name}>:")),
            "{name} stayed out of line\n{dis}"
        );
    }
    // `ops_table.irq` holds save_fl, irq_disable and irq_enable in that
    // order, so a site's call reaches its member at +0, +8 and +16. The
    // RIP-relative addend is that offset less the four bytes from the
    // relocation to the end of the instruction.
    for (func, members) in [
        ("lock_irqsave", &["ops_table-0x4", "ops_table+0x4"][..]),
        ("unlock_irqrestore", &["ops_table+0xc"][..]),
        ("enable_irqs", &["ops_table+0xc"][..]),
        ("disable_irqs", &["ops_table+0x4"][..]),
    ] {
        let lines = function_lines(&dis, func);
        let text = lines.join("\n");
        for member in members {
            let folded = lines.windows(2).any(|w| {
                w[0].contains("call") && w[1].contains("R_X86_64_PC32") && w[1].ends_with(member)
            });
            assert!(folded, "{func}: no table call at {member}\n{text}");
        }
    }
}

/// A call through a function pointer that holds a known address is a
/// direct call, for an external target as for one of the unit: an
/// always_inline retry loop taking the entry function as an argument
/// inlines past its stack-pointer asm operand, and the call through
/// the substituted constant is a direct branch to the entry with a call
/// relocation -- a `jmp` where the caller returns the result unchanged.
/// No `mov $<entry>` remains, which under IBT is a reference to a
/// function without `endbr64` outside a direct branch.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn a_call_through_a_constant_function_address_is_direct() {
    let dir = TempDir::new("badc-const-fnptr");
    let obj = compile_fixture_object(&dir, "const_fnptr_arg_direct_call.c");
    let Some(dis) = disassemble_relocs(&obj) else {
        eprintln!("no disassembler on PATH; the emitted-code check was skipped");
        return;
    };
    assert!(
        !dis.contains("<retry_call>:"),
        "the always_inline retry loop stayed out of line"
    );
    for (func, entry) in [
        ("read_field", "entry_ret"),
        ("enter_entry", "entry_saved_ret"),
    ] {
        let lines = function_lines(&dis, func);
        let text = lines.join("\n");
        assert!(!has_indirect_branch(&lines), "{func}:\n{text}");
        assert!(
            !text.contains("__x86_indirect_thunk"),
            "{func}: calls through a thunk\n{text}"
        );
        assert!(
            !lines
                .iter()
                .any(|l| l.contains("R_X86_64_32S") && l.contains("entry_")),
            "{func}: takes the entry's address\n{text}"
        );
        let direct = lines.windows(2).any(|w| {
            (w[0].contains("call") || w[0].contains("jmp"))
                && w[1].contains("R_X86_64_PLT32")
                && w[1].contains(entry)
        });
        assert!(direct, "{func}: no direct branch to {entry}\n{text}");
    }
}

/// The offset of the first instruction of `func` no path from its entry
/// reaches, walking the disassembly's edges: a
/// conditional branch continues on both arms, `jmp` on its target only,
/// `call` past the call, and `ret`, a return-thunk `jmp` and `ud2` end
/// the path. A `ud2` or `nop` off every path is padding, not code.
#[cfg(any(target_os = "linux", target_os = "macos"))]
fn unreachable_instruction(dis: &str, func: &str) -> Option<u64> {
    let insns = parse_function(&function_lines(dis, func), func);
    let base = insns.first().map_or(0, |i| i.at);
    let index_of = |off: u64| insns.iter().position(|i| i.at == base + off);
    let mut seen = vec![false; insns.len()];
    let mut work = vec![0usize];
    while let Some(i) = work.pop() {
        let Some(insn) = insns.get(i) else {
            continue;
        };
        if std::mem::replace(&mut seen[i], true) || insn.returns || insn.mnemonic == "ud2" {
            continue;
        }
        if let Some(t) = insn.target.and_then(index_of) {
            work.push(t);
        }
        if !insn.mnemonic.starts_with("jmp") {
            work.push(i + 1);
        }
    }
    insns
        .iter()
        .zip(&seen)
        .find(|(insn, seen)| !**seen && insn.mnemonic != "ud2" && !insn.mnemonic.starts_with("nop"))
        .map(|(insn, _)| insn.at)
}

/// `__builtin_unreachable()` / `__builtin_trap()` as a statement seals
/// its block, so the code after a trap -- a `default:` arm's
/// `return`, the fall-off return of the inlined helper -- is not
/// emitted: no instruction of the fixture's functions is off every path
/// from the entry.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn no_instruction_follows_a_trap_unreached() {
    let dir = TempDir::new("badc-trap-tail");
    let obj = compile_fixture_object(&dir, "trap_seals_unreachable_tail.c");
    let Some(dis) = disassemble_relocs(&obj) else {
        eprintln!("no disassembler on PATH; the emitted-code check was skipped");
        return;
    };
    for func in ["redir", "run_request", "trap_then_return"] {
        if let Some(at) = unreachable_instruction(&dis, func) {
            panic!(
                "{func}: instruction at {at:#x} is reached by no path\n{}",
                function_lines(&dis, func).join("\n")
            );
        }
        assert!(
            function_lines(&dis, func).iter().any(|l| l.contains("ud2")),
            "{func}: no trap emitted"
        );
    }
}

/// `-mno-sse` and `-mgeneral-regs-only` keep a unit off the SIMD register
/// file, and the SSE feature macros go with it, as gcc and clang drop them;
/// `__MMX__` stays.
#[test]
fn no_sse_drops_the_sse_feature_macros() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-no-sse");
    let src = dir.join("e.c");
    std::fs::write(&src, "int x;\n").expect("write source");
    for (flags, sse) in [
        (&[][..], true),
        (&["-mno-sse"][..], false),
        (&["-mgeneral-regs-only"][..], false),
    ] {
        let out = Command::new(badc)
            .args(["--target=linux-x64", "-dM", "-E"])
            .args(flags)
            .arg(&src)
            .output()
            .expect("run badc");
        let text = String::from_utf8_lossy(&out.stdout);
        for name in ["__SSE__", "__SSE2__", "__SSE_MATH__", "__SSE2_MATH__"] {
            let defined = text.contains(&format!("#define {name} 1\n"));
            assert_eq!(defined, sse, "{flags:?}: {name}");
        }
        assert!(text.contains("#define __MMX__ 1\n"), "{flags:?}");
    }
}

/// Under `-mno-sse` / `-mgeneral-regs-only` a `float` or `double` copied
/// from memory to memory moves through a general register, and a value
/// the function computes is refused, as gcc refuses it.
#[test]
fn general_regs_only_copies_floating_values_and_refuses_arithmetic() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-general-regs");
    let copy = dir.join("copy.c");
    std::fs::write(
        &copy,
        "void h(double *p, double *q) { *p = *q; }\n\
         void k(float *p, const float *q, int i) { p[i] = q[i]; }\n",
    )
    .expect("write source");
    let math = dir.join("math.c");
    std::fs::write(&math, "double f(double x) { return x * 2; }\n").expect("write source");
    for (target, flag) in [
        ("--target=linux-x64", "-mno-sse"),
        ("--target=linux-aarch64", "-mgeneral-regs-only"),
    ] {
        for opt in ["-O0", "-O"] {
            let run = |src: &std::path::Path| {
                Command::new(badc)
                    .args([target, flag, opt, "-c", "-o"])
                    .arg(dir.join("out.o"))
                    .arg(src)
                    .output()
                    .expect("run badc")
            };
            let out = run(&copy);
            let err = String::from_utf8_lossy(&out.stderr);
            assert!(out.status.success(), "{target} {opt}: {err}");
            let out = run(&math);
            let err = String::from_utf8_lossy(&out.stderr);
            assert!(!out.status.success(), "{target} {opt}");
            assert!(
                err.contains("function `f` computes a floating-point value")
                    && err.contains("[general-regs-only]"),
                "{target} {opt}: {err}"
            );
        }
    }
}

/// Under `--interp`, printf writes a NaN as the target's C library does
/// (C99 7.19.6.1p8 "[-]nan"): the expectations are the native outputs of
/// the same program built for each target -- glibc's sign bit, Apple's
/// unsigned `nan`, the UCRT's `-nan(ind)` for the x86 default NaN -- and
/// the default NaN `0.0 / 0.0` yields is the target's own.
/// gcc's generic `__atomic_load` and `__atomic_store` move an object of a
/// size no instruction covers through the runtime's generic functions.
#[test]
fn generic_atomics_move_an_odd_size_object() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-atomic-odd");
    let src = dir.join("odd.c");
    std::fs::write(
        &src,
        "#include <stdio.h>\n\
         struct s3 { char c[3]; };\n\
         struct s12 { int a[3]; };\n\
         int main(void) {\n\
             struct s3 x = {{1, 2, 3}}, y, z = {{7, 8, 9}};\n\
             __atomic_load(&x, &y, __ATOMIC_ACQUIRE);\n\
             __atomic_store(&x, &z, __ATOMIC_RELEASE);\n\
             struct s12 p = {{10, 20, 30}}, q;\n\
             __atomic_load(&p, &q, __ATOMIC_SEQ_CST);\n\
             printf(\"%d %d %d\\n\", y.c[0] + y.c[1] + y.c[2], x.c[0] + x.c[2], q.a[2]);\n\
             return 0;\n\
         }\n",
    )
    .expect("write source");
    let mut runs: Vec<Vec<&str>> = ["linux-x64", "linux-aarch64", "macos-aarch64"]
        .iter()
        .map(|t| vec!["--interp", t])
        .collect();
    if !cfg!(windows) {
        runs.push(vec!["--jit"]);
    }
    for run in runs {
        let mut cmd = Command::new(badc);
        cmd.arg("-q");
        match run.as_slice() {
            ["--interp", t] => cmd.arg(format!("--target={t}")).arg("--interp"),
            _ => cmd.arg("--jit"),
        };
        let out = cmd.arg(&src).output().expect("run badc");
        assert!(out.status.success(), "{run:?}: {out:?}");
        assert_eq!(String::from_utf8_lossy(&out.stdout), "6 16 30\n", "{run:?}");
    }
}

/// `--jit` and `--interp` define `__BADC_JIT__` / `__BADC_INTERP__` for the
/// unit they run; `-U` removes it.
#[test]
fn run_modes_define_their_macro() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-run-macro");
    let src = dir.join("mode.c");
    std::fs::write(
        &src,
        "#include <stdio.h>\n\
         int main(void) {\n\
         #if defined(__BADC_JIT__) && !defined(__BADC_INTERP__)\n\
             puts(\"jit\");\n\
         #elif defined(__BADC_INTERP__) && !defined(__BADC_JIT__)\n\
             puts(\"interp\");\n\
         #else\n\
             puts(\"neither\");\n\
         #endif\n\
             return 0;\n\
         }\n",
    )
    .expect("write source");
    for (args, want) in [
        (&["--jit"][..], "jit\n"),
        (&["--interp"][..], "interp\n"),
        (&["--jit", "-U__BADC_JIT__"][..], "neither\n"),
    ] {
        let out = Command::new(badc)
            .arg("-q")
            .args(args)
            .arg(&src)
            .output()
            .expect("run badc");
        assert!(out.status.success(), "{args:?}: {out:?}");
        // `--jit` writes through the host C library, a text stream on Windows.
        let stdout = String::from_utf8_lossy(&out.stdout).replace("\r\n", "\n");
        assert_eq!(stdout, want, "{args:?}");
    }
}

#[test]
fn interp_printf_writes_a_nan_as_the_target_library_does() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = TempDir::new("badc-interp-nan");
    let src = dir.join("nan.c");
    std::fs::write(
        &src,
        "#include <stdio.h>\n#include <math.h>\n\
         int main(void) {\n\
             volatile double z = 0.0;\n\
             double n = z / z, p = fabs(n), m = -fabs(n);\n\
             printf(\"%f %E|%f %f %+f %+f % f\\n\", n, n, p, m, p, m, p);\n\
             return 0;\n\
         }\n",
    )
    .expect("write source");
    for (target, want) in [
        ("linux-x64", "-nan -NAN|nan -nan +nan -nan  nan\n"),
        ("linux-aarch64", "nan NAN|nan -nan +nan -nan  nan\n"),
        ("macos-aarch64", "nan NAN|nan nan nan nan nan\n"),
        (
            "windows-x64",
            "-nan(ind) -NAN(IND)|nan -nan(ind) +nan -nan(ind)  nan\n",
        ),
        (
            "windows-arm64",
            "nan NAN|nan -nan(ind) +nan -nan(ind)  nan\n",
        ),
    ] {
        let out = Command::new(badc)
            .args(["-q", &format!("--target={target}"), "--interp"])
            .arg(&src)
            .output()
            .expect("run badc");
        assert!(
            out.status.success(),
            "{target}: {}",
            String::from_utf8_lossy(&out.stderr)
        );
        assert_eq!(String::from_utf8_lossy(&out.stdout), want, "{target}");
    }
}

/// Run the fixture `name` under `--interp` for each target and compare its
/// standard output with the text given for that target.
fn interp_fixture_prints(name: &str, expected: &[(&str, &str)]) {
    interp_fixture_reads(name, "", expected);
}

/// [`interp_fixture_prints`] with `input` on the standard input.
fn interp_fixture_reads(name: &str, input: &str, expected: &[(&str, &str)]) {
    interp_fixture_runs(name, input, &[], expected);
}

/// [`interp_fixture_reads`] passing the program `args`.
fn interp_fixture_runs(
    name: &str,
    input: &str,
    args: &[&std::ffi::OsStr],
    expected: &[(&str, &str)],
) {
    use std::io::Write;
    let badc = env!("CARGO_BIN_EXE_badc");
    let src = fixtures_dir().join(name);
    for (target, want) in expected {
        let mut child = Command::new(badc)
            .args(["-q", &format!("--target={target}"), "--interp"])
            .arg(&src)
            .args(args)
            .stdin(std::process::Stdio::piped())
            .stdout(std::process::Stdio::piped())
            .stderr(std::process::Stdio::piped())
            .spawn()
            .expect("run badc");
        let mut stdin = child.stdin.take().expect("stdin");
        stdin.write_all(input.as_bytes()).expect("write stdin");
        drop(stdin);
        let out = child.wait_with_output().expect("wait for badc");
        assert!(
            out.status.success(),
            "{target}: {}",
            String::from_utf8_lossy(&out.stderr)
        );
        assert_eq!(String::from_utf8_lossy(&out.stdout), *want, "{target}");
    }
}

/// Under `--interp` the C99 7.20.1 conversions follow the target's C
/// library: `long` is 32 bits on Windows, msvcrt's atoi clamps to `int`,
/// Apple's libc sets EINVAL when there is no subject, and `%a` writes a
/// subnormal as the library does. The macOS text is the native build's.
#[test]
fn interp_converts_numbers_as_the_target_library_does() {
    let glibc = "-31 7|0 0 0|63 0|99999999999 0|18446744073709551615 0|\
                 -9223372036854775808 34|1295 0\n\
                 42 1|-7 123456789012|0 22\n\
                 1e-05 0x1.4f8b588e368f1p-17|0x1.8p+1 0x0.0000000000001p-1022|\
                 0.1000000015 0x1p-149|3.14159 -0.0025\n\
                 inf 34|0 34|0x0.0000000000001p-1022 0|-inf nan 0.500000|\
                 0x1.999999999999ap-4|1 1\n";
    let apple = "-31 7|0 0 22|63 0|99999999999 0|18446744073709551615 0|\
                 -9223372036854775808 34|1295 0\n\
                 42 1|-7 123456789012|0 22\n\
                 1e-05 0x1.4f8b588e368f1p-17|0x1.8p+1 0x1p-1074|\
                 0.1000000015 0x1p-149|3.14159 -0.0025\n\
                 inf 34|0 34|0x1p-1074 0|-inf nan 0.500000|0x1.999999999999ap-4|1 1\n";
    let ucrt = "-31 7|0 0 0|63 0|2147483647 34|4294967295 0|-9223372036854775808 34|1295 0\n\
                42 2147483647|-7 123456789012|0 22\n\
                1e-05 0x1.4f8b588e368f1p-17|0x1.8000000000000p+1 0x0.0000000000001p-1022|\
                0.1000000015 0x1.0000000000000p-149|3.14159 -0.0025\n\
                inf 34|0 34|0x0.0000000000001p-1022 0|-inf nan 0.500000|\
                0x1.999999999999ap-4|1 1\n";
    interp_fixture_prints(
        "numeric_conversions_follow_the_target_library.c",
        &[
            ("linux-x64", glibc),
            ("linux-aarch64", glibc),
            ("macos-aarch64", apple),
            ("windows-x64", ucrt),
            ("windows-arm64", ucrt),
        ],
    );
}

/// Under `--interp` the C99 7.21 string functions and the 7.4 character
/// functions run on every target; a comparison or a classification returns
/// what the target's C library returns. The macOS text is the native
/// build's.
#[test]
fn interp_runs_the_string_functions_as_the_target_library_does() {
    let text = |cmp: &str, classes: &str| {
        format!(
            "13 [hello, world!] {cmp} 0 1 4\n\
             [o, world!] [orld!] [world!] 4 2 [, world!]\n1 1 1\n\
             [Hello, world!] [hello, world!] [hell]\n\
             <a><b><c>{{x=1}}{{y=2}} 000z ab\ndef 1 bc\n\
             1 0 1 1 Qq -1 0|{classes}\n"
        )
    };
    let (glibc, apple, msvcrt) = (
        text("-2", "1024 2048 8192"),
        text("-2", "1 1 1"),
        text("-1", "258 4 8"),
    );
    interp_fixture_prints(
        "string_functions_follow_the_target_library.c",
        &[
            ("linux-x64", &glibc),
            ("linux-aarch64", &glibc),
            ("macos-aarch64", &apple),
            ("windows-x64", &msvcrt),
            ("windows-arm64", &msvcrt),
        ],
    );
}

/// Under `--interp` sprintf, snprintf and the `va_list` forms format as
/// printf does, a `long double` read from a `va_list` included; `%p` of a
/// null pointer and msvcrt's _snprintf follow the target's C library. The
/// macOS text is the native build's.
#[test]
fn interp_formats_to_buffers_and_from_va_lists() {
    let text = |null: &str| {
        format!(
            "12 [   42|ab  |z]\n6 [1234] #\n7\n26 [1 two 3.500000 4.5 z -5 44]\n\
             v=7;v=7;\n{null}\n"
        )
    };
    let (glibc, apple) = (text("(nil)"), text("0x0"));
    let msvcrt = text("0000000000000000") + "3 123#\n-1\n";
    interp_fixture_prints(
        "formatted_output_to_buffers_and_va_lists.c",
        &[
            ("linux-x64", &glibc),
            ("linux-aarch64", &glibc),
            ("macos-aarch64", &apple),
            ("windows-x64", &msvcrt),
            ("windows-arm64", &msvcrt),
        ],
    );
}

/// Under `--interp` sscanf reads back what printf wrote on every target,
/// `long double` through `%Lf`, `%Lg` and `%La` in the target's format
/// included, and returns the assignment count or EOF. The macOS text is the
/// native build's.
#[test]
fn interp_scans_what_printf_wrote() {
    let text = |la: &str, p: &str| {
        format!(
            "-100 -12345 -2147483647 -1234567890 9007199254740993 4000000000 deadbeef 755 \
             0.100000001 2.7182818284590451 3.250000 -1e-300 {la} word q {p}\n\
             16 1 same\n2 abc x\n-1 -1 0 2 1\n"
        )
    };
    let ieee = text("0x1.8p+0", "0x1234");
    let ucrt = text("0x1.8000000000000p+0", "0000000000001234");
    interp_fixture_prints(
        "scanf_reads_what_printf_wrote.c",
        &[
            ("linux-x64", &text("0xcp-3", "0x1234")),
            ("linux-aarch64", &ieee),
            ("macos-aarch64", &ieee),
            ("windows-x64", &ucrt),
            ("windows-arm64", &ucrt),
        ],
    );
}

/// Under `--interp` scanf and fscanf read the standard input through one
/// buffer, and localeconv describes the "C" locale.
#[test]
fn interp_scans_the_standard_input() {
    let want = "2 12 34 2 25 word -1\nC [.][] 127\n1\n";
    interp_fixture_reads(
        "scanf_reads_the_standard_input.c",
        " 12,34\n2.5e1  word\n",
        &[
            ("linux-x64", want),
            ("linux-aarch64", want),
            ("macos-aarch64", want),
            ("windows-x64", want),
            ("windows-arm64", want),
        ],
    );
}

/// Under `--interp` fopen opens a file of the host, the output functions
/// write to it and the input functions read it back; feof's true value is
/// msvcrt's `_IOEOF` bit on Windows. The macOS text is the native build's.
#[test]
fn interp_streams_write_and_read_back_a_file() {
    let dir = TempDir::new("badc-interp-streams");
    let text = |eof: &str| {
        format!(
            "[42 first\n][second][ line\n]xYy[z\n]2 3.5 7 30\n1 [\n] 0 4 [tail] {eof} -1\n\
             3 [42 fir] t 32\n0 0\n1 1\n"
        )
    };
    let (posix, msvcrt) = (text("1"), text("16"));
    for (target, want) in [
        ("linux-x64", &posix),
        ("linux-aarch64", &posix),
        ("macos-aarch64", &posix),
        ("windows-x64", &msvcrt),
        ("windows-arm64", &msvcrt),
    ] {
        let file = dir.join(format!("{target}.txt"));
        interp_fixture_runs(
            "streams_write_and_read_back_a_file.c",
            "",
            &[file.as_os_str()],
            &[(target, want)],
        );
    }
}

/// Under `--interp` qsort and bsearch call the program's comparison
/// function: glibc's merge sort keeps equal elements in order, Apple's
/// quicksort leaves them as the native build does, comparison count
/// included, and msvcrt's bsearch finds another of several equal elements.
#[test]
fn interp_sorts_and_searches_through_the_comparison_function() {
    let text = |order: &str, found: &str| {
        format!(
            "-8 -3 0 1 2 3 4 5 6 7 7 9 | apple banana fig kiwi pear\n1{order}\n\
             0:-1 1:0 2:2 3:4 4:-1 5:5 6:-1 7:-1 8:8 9:10 kiwi {found}\n"
        )
    };
    let glibc = text(
        " 164: 0 2 19 20 25 34 37 38 39 5 8 9 10 14 16 24 27 30 1 3 6 7 12 13 15 17 18 23 \
         28 29 31 32 33 4 11 21 22 26 35 36",
        "3",
    );
    let apple = text(
        " 108: 39 2 19 20 25 34 37 38 0 8 10 14 16 24 27 30 5 9 17 33 1 12 13 32 15 3 18 23 \
         7 28 29 6 31 36 21 22 11 4 35 26",
        "3",
    );
    let msvcrt = text("", "2");
    interp_fixture_prints(
        "qsort_and_bsearch_call_the_comparison_back.c",
        &[
            ("linux-x64", &glibc),
            ("linux-aarch64", &glibc),
            ("macos-aarch64", &apple),
            ("windows-x64", &msvcrt),
            ("windows-arm64", &msvcrt),
        ],
    );
}

/// Under `--interp` rand draws the target's C library's sequence, time and
/// clock read the host's clocks, and strerror gives the library's message.
/// The macOS text is the native build's.
#[test]
fn interp_draws_rand_and_reports_errors_as_the_target_library_does() {
    let glibc = "1 1 1804289383 846930886|71876166\n1 1 1 6\n\
                 No such file or directory|Numerical result out of range|Success\n";
    let apple = "1 1 16807 282475249|705894\n1 1 1 6\n\
                 No such file or directory|Result too large|Undefined error: 0\n";
    let msvcrt = "1 1 41 18467|175\n1 1 1 6\n\
                  No such file or directory|Result too large|No error\n";
    interp_fixture_prints(
        "rand_time_and_strerror_follow_the_target_library.c",
        &[
            ("linux-x64", glibc),
            ("linux-aarch64", glibc),
            ("macos-aarch64", apple),
            ("windows-x64", msvcrt),
            ("windows-arm64", msvcrt),
        ],
    );
}

/// The interpreter runs the C-library functions these fixtures reach,
/// through its own definitions and the on-demand sources, for every target:
/// `tmpfile`, `pread`/`pwrite`, `lseek` and its Windows spellings, Linux's
/// `copy_file_range`, the GNU string extensions, and the BSD string and XSI
/// character functions.
#[test]
fn interp_runs_the_file_and_string_extension_fixtures() {
    let targets = [
        "linux-x64",
        "linux-aarch64",
        "windows-x64",
        "windows-arm64",
        "macos-aarch64",
    ];
    for target in targets {
        for fixture in [
            "copy_file_range_posix.c",
            "string_gnu_ext.c",
            "self_declared_string_and_ctype_extensions.c",
        ] {
            let out = Command::new(env!("CARGO_BIN_EXE_badc"))
                .arg(format!("--target={target}"))
                .arg("--interp")
                .arg(fixtures_dir().join(fixture))
                .output()
                .expect("run badc --interp");
            let err = String::from_utf8_lossy(&out.stderr);
            assert_eq!(out.status.code(), Some(0), "{target} {fixture}: {err}");
        }
    }
}
