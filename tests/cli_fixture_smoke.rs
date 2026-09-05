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
    "unroll_multi_exit_peel_guard.c",
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
    ("inline_asm_x64_cdqe.c", "linux-aarch64"),            // x86-64 cdqe
    ("inline_asm_x64_movnti.c", "linux-aarch64"),          // x86-64 movnti/sfence
    ("inline_asm_x64_raid6_syndrome.c", "linux-aarch64"),  // x86-64 AVX2 / AVX-512 RAID-6 syndrome
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

    let tmp_root = std::env::temp_dir().join(format!("badc-cli-smoke-{}", std::process::id()));
    let _ = std::fs::create_dir_all(&tmp_root);

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
    ("thread_local_image_alignment.c", 0),
    ("thread_local_tentative_array.c", 0),
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

// `-fstrict-flex-arrays=N` selects which trailing array members
// `__builtin_object_size` treats as unbounded through a pointer. The
// fixture's exit code sets one bit per member the closest-subobject form
// bounds; the expected codes are gcc 16's at -O2. The interpreter must
// agree with the native image, and the bare form is level 3.
#[test]
fn strict_flex_arrays_level_selects_the_bounded_members() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let src = fixtures_dir().join("strict_flex_arrays.c");
    let dir = std::env::temp_dir().join(format!("badc-flexarr-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");

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
        let out = cmd.arg(&src).output().expect("run badc --interp");
        let stdout = String::from_utf8_lossy(&out.stdout);
        let line = stdout.lines().find(|l| l.starts_with("exit("))?;
        line.trim_start_matches("exit(")
            .trim_end_matches(')')
            .parse()
            .ok()
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

// A `#pragma entrypoint` an object file cannot carry is a catalogue
// row, so `-Wno-link-pragma-ignored` silences it and `-Werror` fails
// the unit on it.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn a_dropped_link_pragma_is_a_controllable_diagnostic() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-linkpragma-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");
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
    let _ = std::fs::remove_dir_all(&dir);
}

// `-Werror` fails the unit at the phase boundary, not at the first
// raised warning: the whole source is parsed, so every diagnostic is
// reported before the driver gives up.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn warnings_as_errors_fail_the_unit_after_the_whole_parse() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-werror-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");
    let src = dir.join("main.c");
    std::fs::write(
        &src,
        "int *p; int *q;\nint main(void) { p = 1; q = 2; return 0; }\n",
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
        stderr.matches("error: integer assigned to pointer").count(),
        2,
        "both assignments must be reported, got: {stderr}"
    );
    assert!(
        stderr.contains("[B3001] [-Wint-conversion]"),
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
    let _ = std::fs::remove_dir_all(&dir);
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
    let root = std::env::temp_dir().join(format!("badc-auto-var-init-{}", std::process::id()));
    let _ = std::fs::create_dir_all(&root);
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
    let _ = std::fs::remove_dir_all(&root);
}

/// Both flags take their gcc value sets and reject anything else by
/// name. `-fzero-init-padding-bits=` changes nothing: an automatic
/// aggregate initializer already zero-fills the object, which
/// `init_padding_zero.c` locks; every value has to compile a unit.
#[test]
fn auto_var_init_and_padding_flags_are_validated_by_name() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let root = std::env::temp_dir().join(format!("badc-auto-var-flags-{}", std::process::id()));
    let _ = std::fs::create_dir_all(&root);
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
    let _ = std::fs::remove_dir_all(&root);
}

/// The x86 kernel names the guard's register and symbol without naming
/// the form, because gcc's x86 default for `-mstack-protector-guard=` is
/// `tls`. Requiring the form stopped the defconfig build at the first
/// unit. aarch64 has no such default and still requires it.
#[test]
fn the_x86_guard_form_defaults_the_way_gcc_does() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let root = std::env::temp_dir().join(format!("badc-ssp-guard-{}", std::process::id()));
    std::fs::create_dir_all(&root).expect("create dir");
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
    // The SMP kernel's own pair, with no `-mstack-protector-guard=`.
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
    let _ = std::fs::remove_dir_all(&root);
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
    let root = std::env::temp_dir().join(format!("badc-ssp-run-{}", std::process::id()));
    let _ = std::fs::create_dir_all(&root);

    // `strong` is the mode the kernel selects, so it is the one run at
    // both optimization levels; the rest cover their own selection at one.
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
    let _ = std::fs::remove_dir_all(&root);
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
    let root = std::env::temp_dir().join(format!("badc-pfe-run-{}", std::process::id()));
    let _ = std::fs::create_dir_all(&root);
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
    let _ = std::fs::remove_dir_all(&root);
}

/// Sixteen integers and twenty doubles live across calls, more than either
/// callee-saved bank holds, so at `-O` every register of both banks and the
/// FP scratch see use; `fpr_leaf` fills the caller-saved FP bank of a
/// target with no callee-saved one. `clobbers` names a callee-saved
/// register in a clobber list, which the emitter otherwise saves around
/// the statement.
const FIXED_PRESSURE_SRC: &str = "\
long sink(long a, long b, long c, long d) { return a + b + c + d; }
double fsink(double a, double b) { return a - b; }
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
    let root = std::env::temp_dir().join(format!("badc-ffixed-{}", std::process::id()));
    std::fs::create_dir_all(&root).expect("create dir");
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
    let _ = std::fs::remove_dir_all(&root);
    if measured == 0 {
        eprintln!("ffixed: no disassembler on PATH; the emitted-code check was skipped");
    }
}

/// An unknown name, a register the code generator cannot give up, and a
/// reservation that leaves no FP scratch are each refused with a
/// diagnostic that names the cause.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn ffixed_refuses_what_it_cannot_honour() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let root = std::env::temp_dir().join(format!("badc-ffixed-err-{}", std::process::id()));
    std::fs::create_dir_all(&root).expect("create dir");
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
    let _ = std::fs::remove_dir_all(&root);
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
    let root = std::env::temp_dir().join(format!("badc-ffixed-run-{}", std::process::id()));
    std::fs::create_dir_all(&root).expect("create dir");
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
    let _ = std::fs::remove_dir_all(&root);
}

/// `-mcpu=` sets the AArch64 feature macros the way gcc does and
/// refuses what badc does not implement: `+crypto` makes the AES
/// intrinsics compile for linux-aarch64, an unknown extension and an
/// x86-64 target are refused by name.
#[test]
fn mcpu_extensions_gate_the_feature_macros() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let root = std::env::temp_dir().join(format!("badc-mcpu-{}", std::process::id()));
    std::fs::create_dir_all(&root).expect("create dir");
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
    let _ = std::fs::remove_dir_all(&root);
}

/// The profiling options are refused where gcc has none, by name.
#[test]
fn profiling_options_are_refused_by_name_where_gcc_has_none() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let root = std::env::temp_dir().join(format!("badc-pfe-refuse-{}", std::process::id()));
    let _ = std::fs::create_dir_all(&root);
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
    let _ = std::fs::remove_dir_all(&root);
}

/// The diagnostic pragmas decide whether a unit compiles: the same
/// source reports, is silent, or fails depending on the pragma in
/// force at the reporting position.
#[test]
fn a_diagnostic_pragma_decides_the_exit_code() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-diagprag-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");

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

    let _ = std::fs::remove_dir_all(&dir);
}

/// The same pragmas decide the level of the parser's diagnostics, not
/// only the preprocessor's: the events are keyed on offsets into the
/// preprocessed unit, which is the text the lexer reads.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn a_diagnostic_pragma_governs_a_parser_diagnostic() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-diagprag-parse-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");

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

    let _ = std::fs::remove_dir_all(&dir);
}

/// A pragma is a position in the translation unit, so one left set in a
/// header applies to everything the include precedes; a header that
/// wraps it in `push` / `pop` scopes it to itself. gcc and clang behave
/// the same way.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn a_header_scopes_its_diagnostic_pragma_with_push_and_pop() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-diagprag-hdr-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");
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

    let _ = std::fs::remove_dir_all(&dir);
}

/// A link diagnostic has no position in a translation unit, so no
/// pragma governs one; the command line does. This links a script whose
/// `ENTRY` no input defines and drives the row through `-Wno-` and
/// `-Werror=`.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn a_command_line_selector_governs_a_link_diagnostic() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-linkdiag-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");
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

    let _ = std::fs::remove_dir_all(&dir);
}

/// A warning reported before a hard error is printed ahead of it, the
/// way gcc prints every diagnostic of a failed unit.
#[test]
fn a_failed_unit_prints_the_warnings_reported_before_the_error() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-warn-then-err-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");
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
    let _ = std::fs::remove_dir_all(&dir);
}

/// A `return` that does not fit the function's return type is an error
/// the user can lower, as gcc 14's `-Wreturn-mismatch` is.
#[test]
fn a_return_mismatch_is_an_error_the_user_can_lower() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-return-mismatch-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");
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
    let _ = std::fs::remove_dir_all(&dir);
}

/// `-fno-builtin-<name>` withdraws the auto-include recovery for that
/// name alone: an undeclared call to it is the undeclared-function
/// error, while every other library name still recovers.
#[test]
fn no_builtin_name_drops_the_auto_include_for_that_name() {
    let badc = env!("CARGO_BIN_EXE_badc");
    let dir = std::env::temp_dir().join(format!("badc-no-builtin-name-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");
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
    let _ = std::fs::remove_dir_all(&dir);
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
    let dir = std::env::temp_dir().join(format!("badc-retwiden-{}", std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).expect("create temp dir");

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
        // them is the return's; `via_user_slot` takes an `int`, so its
        // entry conversion joins the one its object's reload performs.
        for (func, want) in [
            ("via_int_slot", 1usize),
            ("direct_libc_use", 1),
            ("pointer_offset", 1),
            ("via_user_slot", 2),
        ] {
            let (n, hits) = register_mentions(&text, func, widenings);
            assert!(n > 0, "{target}: `{func}` not found in the disassembly");
            assert_eq!(hits, want, "{target}: `{func}` widens {hits} times");
            measured += 1;
        }
    }
    let _ = std::fs::remove_dir_all(&dir);
    if measured == 0 {
        eprintln!("int-return widening: no disassembler on PATH; the check was skipped");
    }

/// Compile the `tests/fixtures/c` fixture `name` for linux-x64 under the
/// flags its `// snapshot-flags:` line pins -- the kbuild option set the
/// kernel-shaped fixtures state -- into `dir`, returning the object.

/// Compile the `tests/fixtures/c` fixture `name` for linux-x64 at `-O`
/// under the flags its `// snapshot-flags:` line pins -- the kbuild
/// option set the kernel-shaped fixtures state, as the snapshot
/// generator builds it -- into `dir`, returning the object.
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
/// (`call %c[__func]`, the kernel's `call_on_stack`) is a direct branch
/// to the symbol: a call relocation against an external name, a
/// resolved displacement to a function of the unit. An indirect branch
/// through a register would bypass the retpoline thunks the fixture's
/// flags request.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn asm_call_of_a_function_operand_is_direct() {
    let dir = std::env::temp_dir().join(format!("badc-asm-call-const-{}", std::process::id()));
    std::fs::create_dir_all(&dir).expect("create dir");
    let obj = compile_fixture_object(&dir, "kernel_asm_call_const_operand.c");
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
    let _ = std::fs::remove_dir_all(&dir);
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
fn return_with_uaccess_enabled(dis: &str, func: &str) -> Option<u64> {
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

/// After inlining `user_access_begin`, the caller's branch on its result
/// is a branch on a phi of constants; threading each predecessor past
/// the merge leaves no path from `stac` to a return that skips `clac`.
/// The check walks the disassembly's edges, as objtool's UACCESS rule
/// does, for the plain-store and the `asm goto` (`unsafe_put_user`)
/// shapes.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn every_path_from_stac_reaches_clac_before_returning() {
    let dir = std::env::temp_dir().join(format!("badc-uaccess-phi-{}", std::process::id()));
    std::fs::create_dir_all(&dir).expect("create dir");
    let obj = compile_fixture_object(&dir, "kernel_uaccess_phi_branch.c");
    let Some(dis) = disassemble_relocs(&obj) else {
        eprintln!("no disassembler on PATH; the emitted-code check was skipped");
        return;
    };
    for func in ["put_user_word", "put_user_pair"] {
        if let Some(at) = return_with_uaccess_enabled(&dis, func) {
            panic!(
                "{func}: return at {at:#x} reachable from `stac` without `clac`\n{}",
                function_lines(&dis, func).join("\n")
            );
        }
    }
    let _ = std::fs::remove_dir_all(&dir);
}
