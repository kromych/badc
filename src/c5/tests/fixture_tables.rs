//! The run fixtures, registered once for the backend test modules.
//!
//! [`FIXTURES`] has a row per fixture: its expected exit status, and the
//! runners it stays off. Each backend module (`native`, `native_elf`,
//! `native_elf_x64`, `native_pe_x64`, `native_pe_arm64`, `jit`) reads the
//! table derived for it, so two runners cannot disagree about a status.
//! The modules are `cfg`-gated to the hosts that run them; the manifest
//! lives here, outside those gates, so [`every_registered_fixture_exists`]
//! validates it on every host. `tests/cli_fixture_smoke.rs` is a separate crate and cannot
//! import these; it checks its own two tables the same way.
//!
//! An expected value is derived, never guessed: every registration
//! added from the compile-only sweep was first run under `cc` (Apple
//! clang) on macOS/arm64 and `gcc` on linux/aarch64 and linux/x86_64,
//! at `-O0` and `-O2`, twice each. A fixture that does not resolve to
//! one value across those runs is excluded here with its reason rather
//! than pinned to whatever the current host happens to produce:
//!
//!   * `syscall_ptr_table.c` -- writes a fixed path under `/tmp` and
//!     its result depends on what an earlier run left there (the
//!     reference compiler returns 0 then 1); it also calls variadic
//!     `open` / `fcntl` through non-variadic prototypes, undefined per
//!     C99 6.5.2.2p9.
//!   * `computed_include_pp_number.c` -- its computed `#include`
//!     resolves against the fixture's own directory, which these
//!     runners cannot offer: they pass the source as a string with no
//!     path. `tests/cli_fixture_smoke.rs` compiles and runs it as a
//!     file.
//!   * `getopt_unistd_globals.c` -- the exit code encodes each libc's
//!     unspecified startup value for `optopt` (0 on the BSD-derived
//!     libc, `'?'` on glibc), so no single value fits. TODO: on ELF,
//!     `emit_native_with_options` also faults on a store to a
//!     `#pragma binding(data ..)` import and reads one back wrong,
//!     where the object-then-link path is correct.
//!   * `inline_asm_section_label.c` -- a label defined inside a
//!     file-scope `asm` section resolves only once the objects are
//!     merged; direct lowering and the JIT loader both report the
//!     symbol the template names as undefined. It is registered in
//!     `NATIVE_PE_X64_FIXTURES`, which links, and run by the CLI list
//!     in `tests/cli_fixture_smoke.rs`.
//!   * `atomic_operators_two_threads.c` in the ELF tables -- on Linux its
//!     3-byte `_Atomic` structure calls the generic atomic functions, which
//!     the single-image writer links no runtime to define; the CLI list
//!     runs it.
//!   * `byteswap_glibc.c`, `sysexits_codes.c`, `fd_set_macros.c`,
//!     `posix_unix_headers.c`, `netinet_addr_class_macros.c`,
//!     `get_cpuid_leaf_checks.c` and
//!     `xlocale_extended_functions_take_a_locale.c` -- each includes a
//!     header only some targets ship (glibc's `<byteswap.h>`, the POSIX
//!     `<sysexits.h>`, `<sys/select.h>`, `<grp.h>` and `<netinet/in.h>`,
//!     gcc's x86 `<cpuid.h>`, the macOS SDK's `<xlocale.h>`), so the tables
//!     of the others leave it out.
//!   * `aarch64_hwcap_auxv.c` -- `<sys/auxv.h>` and the `HWCAP_*`
//!     macros are Linux-only: the macOS-hosted tables reject the
//!     compile, and on Windows every check sits behind `__linux__` /
//!     `__aarch64__`, leaving a row that asserts nothing.
//!   * `asm_template_names_renamed_static.c` -- TODO: the x86-64
//!     single-image ELF writer and the JIT report a function the unit
//!     defines and an inline-asm `sym(%rip)` names undefined.
//!   * the fixtures of [`BADC_FIXTURES`], whose values are badc's own.
//!
//! TODO: `NATIVE_PE_ARM64_FIXTURES` takes none of them -- it runs only
//! on a windows/aarch64 runner or linux/aarch64 under WINE, neither of
//! which was available to validate against.

/// A runner a fixture can be registered on, as a bit of a mask.
pub(super) const NATIVE: u8 = 1 << 0;
pub(super) const ELF: u8 = 1 << 1;
pub(super) const ELF_X64: u8 = 1 << 2;
pub(super) const PE_X64: u8 = 1 << 3;
pub(super) const PE_ARM64: u8 = 1 << 4;
pub(super) const JIT: u8 = 1 << 5;

/// One fixture: the exit status every runner expects of it, and the
/// runners it does not run on.
#[derive(Clone, Copy)]
pub(super) struct Fixture {
    pub name: &'static str,
    pub exit: i32,
    /// Runners it has not been run on: no one has shown the status holds
    /// there. [`UNVERIFIED`] pins how many there are.
    pub unverified: u8,
    /// Runners it is kept off, and why.
    pub skipped: (u8, &'static str),
}

pub(super) const fn row(name: &'static str, exit: i32) -> Fixture {
    Fixture {
        name,
        exit,
        unverified: 0,
        skipped: (0, ""),
    }
}

impl Fixture {
    pub(super) const fn unverified(mut self, runners: u8) -> Fixture {
        self.unverified = runners;
        self
    }

    pub(super) const fn skip(mut self, runners: u8, why: &'static str) -> Fixture {
        self.skipped = (runners, why);
        self
    }

    const fn runs_on(&self, runner: u8) -> bool {
        (self.unverified | self.skipped.0) & runner == 0
    }
}

/// Every run fixture, once. A row is `row(name, status)`, followed by
/// `.unverified(RUNNERS)` or `.skip(RUNNERS, why)` for the runners it stays
/// off.
pub(super) const FIXTURES: &[Fixture] = &[
    row("frame_without_pointer_borrows.c", 0),
    row("frame_slots_without_a_red_zone.c", 0),
    row("hfa_argument_ahead_of_narrow_stack_arguments.c", 0),
    row("byte_reversal_by_shifts.c", 0),
    row("fp_sign_bit_operations.c", 0),
    row("fp_compare_with_constants.c", 0),
    row("call_alignment_past_saved_registers.c", 0),
    row("floating_returns_joined_when_inlined.c", 0),
    row("chacha20_block_on_a_local_array.c", 0),
    row("mm_malloc_name_macros.c", 42).unverified(ELF | JIT),
    row("builtin_library_functions_need_no_declaration.c", 0).unverified(JIT),
    row("c99_comparison_macros_raise_no_invalid.c", 0).unverified(JIT),
    row("cpuid_h_reads_the_processor.c", 0).unverified(JIT),
    row("x86_system_builtins_read_the_processor.c", 0).unverified(JIT),
    row("x86_system_wrappers_execute.c", 0).unverified(JIT),
    row("msvc_string_intrinsics_execute.c", 0).unverified(JIT),
    row("interlocked_contention.c", 0).unverified(JIT),
    row("tokenizers_keep_state_in_the_caller.c", 0).unverified(JIT),
    row("windows_h_declares_the_string_functions.c", 0).unverified(JIT),
    row("windows_wide_strings_locales_and_l_conversions.c", 0).unverified(JIT),
    row("windows_ucrt_wide_sets_and_crt_double_conversions.c", 0).unverified(JIT),
    row("mmx_sse3_and_mm_malloc_intrinsics.c", 0).unverified(JIT),
    row("avx2_lanes_and_low_lane_transfers_follow_the_sdm.c", 0).unverified(JIT),
    row("bmi_lzcnt_and_adx_follow_the_sdm.c", 0).unverified(JIT),
    row("x86_cache_and_state_intrinsics.c", 0).unverified(JIT),
    row("x86_vaes_and_vpclmulqdq_act_per_lane.c", 0).unverified(JIT),
    row("x86_sha_extensions_match_the_instructions.c", 0).unverified(JIT),
    row("signaling_nan_float_copy_keeps_its_bits.c", 0).unverified(JIT),
    row("over_aligned_local_in_an_inlined_function.c", 0).unverified(JIT),
    row("function_slots_name_weak_and_asm_functions.c", 0).unverified(JIT),
    row("self_declared_library_names_resolve.c", 0).unverified(JIT),
    row("library_function_address_is_the_librarys.c", 0),
    row("aarch64_branch_word_in_a_data_section.c", 0).unverified(JIT),
    row("x86_f16c_conversions_match_the_instructions.c", 0).unverified(JIT),
    row("avx2_permutes_shifts_and_products_follow_the_sdm.c", 0).unverified(JIT),
    row("sse_floating_lanes_follow_the_sdm.c", 0).unverified(JIT),
    row("sse42_crc32_accumulates_castagnoli.c", 0).unverified(JIT),
    row("avx_floating_and_fma_follow_the_sdm.c", 0).unverified(JIT),
    row("x86_fma_nan_operands_keep_their_sign.c", 0).unverified(JIT),
    row("sse_saturating_sad_madd_and_ps_logic_follow_the_sdm.c", 0).unverified(JIT),
    row("sse_sse2_ssse3_m64_forms_follow_the_sdm.c", 0).unverified(JIT),
    row("avx2_arithmetic_compares_and_packs_follow_the_sdm.c", 0).unverified(JIT),
    row("avx2_shifts_shuffles_and_blends_follow_the_sdm.c", 0).unverified(JIT),
    row("avx2_gathers_and_masked_transfers_follow_the_sdm.c", 0).unverified(JIT),
    row("sse41_integer_lanes_follow_the_sdm.c", 0).unverified(JIT),
    row("sse41_rounding_dot_products_and_blends_follow_the_sdm.c", 0).unverified(JIT),
    row("sse42_string_compares_follow_the_sdm.c", 0).unverified(JIT),
    row("ssse3_abs_sign_horizontal_and_alignr_follow_the_sdm.c", 0).unverified(JIT),
    row("sse2_averages_minmax_and_count_shifts_follow_the_sdm.c", 0).unverified(JIT),
    row("vector_casts_keep_the_bits.c", 0),
    row("max_alignment_placement.c", 0),
    row("neon_raid6_checksum.c", 0),
    row("long_double_math.c", 0),
    row("long_double_call_shapes.c", 0),
    row("long_double_usual_conversions.c", 0),
    row("long_double_parameter_shapes.c", 0),
    row("induction_variable_steps.c", 0),
    row("static_object_pc_relative.c", 0),
    row("packed_nested_static_member.c", 0),
    row("goto_cleanup_asm.c", 0),
    row("goto_cleanup_scopes.c", 0),
    row("goto_cleanup_shared.c", 0),
    row("call_arg_low_word.c", 0),
    row("scope_exit_storage.c", 0),
    row("early_return_before_frame.c", 0),
    row("int128_divide_edges.c", 0),
    row("dead_phi_web.c", 0),
    row("far_frame_slots.c", 0),
    row("overaligned_region_storage.c", 0),
    row("static_local_shadows_file_scope.c", 0),
    // A declared `long double` object takes the target ABI's storage
    // format, and the compute path's binary64 round-trips through it.
    row("long_double_abi_storage.c", 0).unverified(PE_X64 | PE_ARM64),
    // A by-value aggregate argument in value form (the callee's declared
    // parameter list not in scope) must bind an address to the spliced
    // body's parameter cell. Native-only: the SSA interpreter's own call
    // path does not model the value form.
    row("anon_bitfield_reserves_bits.c", 0),
    row("attribute_mode.c", 0),
    row("transparent_union_call.c", 0),
    row("compound_literal_addr_call_arg.c", 0),
    row("flex_array_only_member.c", 0),
    row("post_inline_dead_data_repack.c", 0).unverified(PE_X64 | PE_ARM64),
    row("post_inline_import_survives_repack.c", 0).unverified(PE_X64 | PE_ARM64),
    row("section_static_table_dead_cascade.c", 0),
    row("attributed_aggregate_align_floor.c", 0).unverified(PE_X64 | PE_ARM64),
    row("overaligned_data_placement.c", 0).unverified(PE_X64 | PE_ARM64),
    row("overaligned_bss_placement.c", 0).unverified(PE_X64 | PE_ARM64),
    row("overaligned_type_placement.c", 0).unverified(PE_X64 | PE_ARM64),
    row("page_multiple_alignment.c", 0).unverified(PE_X64 | PE_ARM64),
    row("section_attr_aligned_placement.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("section_attr_bss_family_zero_fill.c", 0)
        .unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("section_attr_flexible_array_tail.c", 0)
        .unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("vla_basic_sum.c", 0).unverified(JIT),
    row("vla_runtime_sizeof.c", 0).unverified(JIT),
    row("vla_size_from_arg.c", 0).unverified(JIT),
    row("vla_scope_reclaim_loop.c", 0).unverified(JIT),
    row("alloca_large.c", 42),
    row("stack_probe_large_frames.c", 42),
    row("alloca_spill_arith.c", 42),
    row("alloca_far_spill_slots.c", 0),
    row("dynamic_frame_return_restores.c", 0),
    row("aggregate_return_from_alloca.c", 0),
    row("unread_narrowing_shift.c", 0),
    row("call_result_into_member.c", 0),
    row("long_double_binary128_conversion.c", 0),
    row("overaligned_automatic_beside_alloca.c", 0),
    row("overaligned_automatic_beside_sp_read.c", 0),
    row("overaligned_automatic_beside_callee_saved_clobbers.c", 0),
    row("overaligned_vla.c", 0),
    row("alloca_far_local_base_register.c", 0),
    row("call_stack_args_shared_area.c", 0),
    row("indirect_call_staged_target.c", 0),
    row("long_double_outgoing_area_borrow.c", 0),
    row("local_field_displacement.c", 0),
    row("wide_local_reread_after_byte_store.c", 0),
    row("alloca_call_args.c", 42),
    row("vla_large_runtime.c", 42),
    row("vla_loop_stack_restore.c", 42),
    row("vla_param_decay.c", 0).unverified(JIT),
    row("mem2reg_param_promoted.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("phi_class_for_loop_sum.c", 45).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("phi_class_nested_loops.c", 49).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("phi_class_diamond_join.c", 30).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("phi_group_dead_phi_interference.c", 0).unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("inline_by_value_aggregate_param_copy.c", 0).unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("arithmetic.c", 60),
    row("auto_type_inference.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("attribute_hot_cold.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("attribute_weak_alias.c", 0).unverified(PE_X64 | PE_ARM64 | JIT),
    row("alias_extern_redeclaration.c", 0).unverified(PE_X64 | PE_ARM64 | JIT),
    row("asm_label_rename.c", 0).unverified(PE_X64 | PE_ARM64 | JIT),
    row("asm_template_names_renamed_static.c", 0).unverified(ELF_X64 | JIT),
    row("alias_target_assembler_name.c", 0).unverified(PE_X64 | PE_ARM64 | JIT),
    row("overflow_builtin_result_pointer_operand.c", 0),
    row("builtin_overflow_mixed_signedness.c", 0),
    row("inline_asm_x64_call_local_label.c", 42),
    row("msvc_intrinsics_self_declared.c", 0),
    row("msvc_intrinsics_values.c", 0),
    row("msvc_va_start.c", 0),
    row("msvc_interlocked_nand_max_min.c", 0),
    row("msvc_intrinsics_instructions.c", 0),
    row("msvc_ptr32.c", 0),
    row("unevaluated_reference_unlowerable_static.c", 0),
    row("code_address_plus_offset_initializer.c", 0),
    row("code_slot_read_by_a_later_initializer.c", 0),
    row("function_address_arithmetic_counts_bytes.c", 0),
    row("function_address_offset_outside_the_text.c", 0),
    row("thread_local_reads_a_code_slot.c", 0).skip(JIT, "thread-local storage"),
    row("thread_local_slot_escapes_a_function.c", 0).skip(JIT, "thread-local storage"),
    // `function_slot_names_no_c_definition.c` and `weak_extern_data_address.c`
    // take a weak reference no input defines as 0, which a Mach-O link
    // refuses, as ld64 does; the ELF lists run them.
    row("function_slot_names_a_file_scope_asm_function.c", 0),
    row("weak_definition_references_by_symbol.c", 0),
    row("const_through_a_pointer_typedef.c", 0),
    row("sizeof_operand_takes_its_postfix.c", 0),
    row("compound_literal_of_pointer_type_is_an_object.c", 0),
    row("typeof_of_a_decayed_designator_is_a_pointer.c", 0),
    row("file_scope_array_compound_literal_address.c", 0),
    row("string_literal_initializes_every_character_array.c", 0),
    row("cast_to_union_initializes_its_member.c", 0),
    row("cast_to_union_in_a_constant_initializer.c", 0),
    row("unknown_size_array_takes_whole_rows.c", 0),
    row(
        "unknown_size_struct_array_counts_what_its_fill_reaches.c",
        0,
    ),
    row("pragma_weak_binds_names_and_aliases.c", 0),
    row("weak_thread_local_definition_by_symbol.c", 0).skip(JIT, "thread-local storage"),
    row("library_function_address_is_one_pointer.c", 0),
    row("attribute_section_placement.c", 0).unverified(PE_X64 | PE_ARM64 | JIT),
    row("named_code_section_bounds.c", 0).unverified(PE_X64 | PE_ARM64),
    row("named_data_section_bounds.c", 0).unverified(PE_X64 | PE_ARM64),
    row("inline_section_mandatory.c", 0).unverified(PE_X64 | PE_ARM64 | JIT),
    // TODO: `speculative_init_parse_data_rewind.c` is held off the host
    // native list -- its nested-compound-literal table is mis-relocated on
    // Mach-O and faults; it runs on the ELF native paths and the
    // interpreter.
    row("zero_length_array_decay.c", 0).unverified(PE_X64 | PE_ARM64 | JIT),
    row("register_var_stack_pointer.c", 0).unverified(PE_X64 | PE_ARM64 | JIT),
    row("register_var_typeof_stmt_expr.c", 0).unverified(PE_X64 | PE_ARM64 | JIT),
    row("compound_literal_struct_field.c", 0).unverified(JIT),
    row("goto.c", 5),
    row("switch_statement.c", 25).unverified(PE_X64 | PE_ARM64),
    row("switch_binary_search.c", 0).unverified(PE_X64 | PE_ARM64),
    row("switch_jump_table_dense.c", 0),
    row("switch_jump_table_sparse_kept.c", 0),
    row("switch_jumptable_dead_branch_prune.c", 12),
    row("switch_jump_table_phi_join.c", 0),
    row("switch_case_label_promoted.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("int_literal_boundary_types.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("const_expr_unsigned_fold.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("shift_result_promoted_type.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("ternary_arith_common_type.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("pointer_relational_unsigned.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("compound_assign_unsigned_div.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("decl_specifier_any_order.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("branch_relaxation.c", 21).unverified(PE_X64 | PE_ARM64),
    row("float_register_resident.c", 45).unverified(PE_X64 | PE_ARM64),
    row("variadic_struct_arg.c", 18).unverified(PE_X64 | PE_ARM64),
    row("struct_arg_value_form.c", 0).unverified(PE_X64 | PE_ARM64),
    row("variadic_struct_arg_16b.c", 51).unverified(PE_X64 | PE_ARM64),
    row("libc_div.c", 0).unverified(PE_X64 | PE_ARM64),
    row("strtof_parses_float.c", 0),
    row("snprintf_truncation_c99.c", 0),
    row("ioctl_fionread_pipe.c", 0).unverified(PE_X64 | PE_ARM64 | JIT),
    row("shm_open_mode_arg.c", 0).unverified(PE_X64 | PE_ARM64 | JIT),
    row("wide_string_literal_alignment.c", 0).unverified(PE_X64 | PE_ARM64),
    row("va_arg_through_pointer.c", 0).unverified(PE_X64 | PE_ARM64),
    row("pthread_key_once_width.c", 0),
    row("dev_t_width.c", 0).unverified(PE_X64 | PE_ARM64),
    row("libc_int_arith.c", 0).unverified(PE_X64 | PE_ARM64),
    row("switch_default_routing.c", 100).unverified(PE_X64 | PE_ARM64),
    row("control_flow.c", 1),
    row("do_while.c", 5),
    row("break_continue.c", 4),
    row("for_loop.c", 10),
    row("layout_bottom_test_loop.c", 45),
    row("layout_nested_loops.c", 27),
    row("layout_goto_block_addr.c", 16),
    row("unroll_const_trip_copy.c", 0),
    row("unroll_multi_exit_peel.c", 0),
    row("unroll_trip_17_stays_rolled.c", 0),
    row("unroll_volatile_stays_rolled.c", 0),
    row("sroa_const_index_local_array.c", 0).unverified(PE_X64),
    row("sroa_runtime_index_stays_memory.c", 0).unverified(PE_X64),
    row("sroa_struct_fields_promote.c", 0).unverified(PE_X64),
    row("sroa_aggregate_return_temp_stays.c", 0).unverified(PE_X64),
    row("sroa_one_cell_aggregate_promotes.c", 0).unverified(PE_X64),
    row("sroa_block_copies.c", 0).unverified(PE_X64),
    row("sroa_copies_between_objects.c", 0),
    row("register_aggregates_beside_copies.c", 0),
    row("address_phi_object_or_pointer.c", 0),
    row("zero_stored_through_an_index.c", 0),
    row("range_unproved_comparisons_stay.c", 0).unverified(PE_X64),
    row("recursion_factorial.c", 120),
    row("tail_recursion_constant_accumulator.c", 0),
    row("pointers.c", 200),
    // sizeof(int) = 4
    row("pointer_arithmetic_scaling.c", 104),
    row("expression_precedence.c", 1),
    row("variable_shadowing.c", 10),
    row("pointer_arithmetic.c", 3),
    row("predefined_constants.c", 0),
    row("c99_qualifiers.c", 0),
    row("integer_suffixes.c", 0),
    row("predefined_macros.c", 0),
    row("macro_multiline_comment_body.c", 0),
    row("compound_literal_paren_init.c", 0),
    row("alignof_operator.c", 0),
    row("typedef_aligned_attribute.c", 0),
    row("assign_expr_value_narrowed.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("struct_copy_comma_side_effect.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("struct_member_copy_from_global.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("inline_two_reg_struct_param.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("struct_param_stack_spill.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("struct_stack_arg_then_scalar.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("call_sp_adjust_imm12_overflow.c", 0).unverified(PE_X64 | PE_ARM64),
    row("callee_save_pair_fold.c", 17).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("callee_save_pair_large_frame.c", 18).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("indirect_call_target_scratch_exhausted.c", 0).unverified(PE_X64 | PE_ARM64),
    row("fp_load_folded_disp.c", 0).unverified(PE_X64 | PE_ARM64),
    row("far_field_copy_load.c", 42).unverified(PE_X64 | PE_ARM64),
    row("mixed_struct_gpr_abi.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("unary_plus_preserves_type.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("local_multidim_aggregate_array_init.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("nested_aggregate_brace_elision.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("const_addr_multidim_array_elem.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("unsigned_signed_relational_compare.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("return_void_expression.c", 0),
    row("macro_operators.c", 0),
    row("typedef_basic.c", 0),
    row("ptr_to_array_typedef.c", 42),
    row("local_init_and_block_scope.c", 0),
    row("block_lifetime_storage.c", 0),
    row("returned_aggregate_read_past_its_lifetime_marker.c", 0),
    row("stack_arguments_read_from_a_local_array.c", 0),
    row("stack_argument_int_local_widens_to_long.c", 0),
    row("aggregate_built_in_place.c", 0),
    row("arrays_basic.c", 0),
    row("function_pointer_typedefs.c", 0),
    row("unions_basic.c", 0),
    row("array_initializers.c", 0),
    row("double_int_initializer.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("tentative_definitions.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("hex_constant_unsigned_type.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("multi_declarator_prototypes.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("struct_tag_block_scope.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("local_array_partial_init_zero.c", 0),
    row("ssa_call_result_spill.c", 0),
    row("ssa_bail_fixup_rollback.c", 0),
    row("struct_field_assign_from_call.c", 0),
    row("struct_byval_param_followed_by_ptr.c", 0),
    row("tail_call_no_address_escape.c", 0),
    row("fib.c", 0),
    row("tailrec_narrow_param.c", 0),
    row("tailrec_void_accumulate.c", 0),
    row("tailrec_narrow_tail_wide_base.c", 0),
    row("tailrec_narrow_result_accumulates.c", 0),
    row("tailrec_bitwise_accumulates.c", 0),
    row("struct_conditional_reads_its_arm.c", 0),
    row("aggregate_conditional_reads_each_word.c", 0),
    row("inlined_struct_return_reads_its_object.c", 0),
    row("one_word_aggregate_argument_takes_its_value.c", 0),
    row("packed_object_keeps_its_offset_alignment.c", 0),
    row("packed_member_read_through_a_pointer.c", 0),
    row("always_inline_returns_an_aggregate_from_any_address.c", 0),
    row("noreturn_calls_end_their_block.c", 0),
    row("read_before_store_promotes.c", 0),
    row("queens.c", 0),
    row("inline_keyword_uncaps.c", 0),
    row("inline_transitive_body_cap.c", 0),
    row("ssa_fp_routing.c", 0),
    row("ssa_callee_saved_x19.c", 0),
    row("ssa_va_arg_loop.c", 0),
    row("builtin_va_list_typedef.c", 0),
    row("vsnprintf_prototype_va_list.c", 0),
    row("builtin_expect_no_header.c", 0),
    row("value_builtins.c", 0),
    row("ssa_variadic_fp_arg.c", 0),
    row("sysv_variadic_host_abi.c", 0).unverified(PE_X64 | PE_ARM64),
    row("aapcs64_variadic_host_abi.c", 0).unverified(PE_X64 | PE_ARM64),
    row("param_fp_before_int_pressure.c", 0).unverified(PE_X64 | PE_ARM64),
    row("ssa_fp_compare_nan.c", 0),
    row("ssa_c5_internal_fp_arg.c", 0),
    row("struct_initializers.c", 0),
    row("enum_tag_types.c", 0),
    row("enum_unsigned_value_cmp.c", 0),
    row("bitfields.c", 0),
    row("bound_import_arg_narrowing.c", 0),
    row("block_extern_shadows_local.c", 0),
    row("block_static_shadows_extern.c", 0),
    row("block_extern_unsized_array_decay.c", 0).unverified(PE_X64 | PE_ARM64),
    row("win64_xmm_callee_save_paths.c", 0),
    row("win64_fp_callee_saved_pressure.c", 0),
    row("ms_abi_calling_convention.c", 0),
    row("variadic_fnptr_proto_erased.c", 0),
    row("union_bitfield_layout.c", 0),
    row("init_float_to_int.c", 0),
    row("global_init_midexpr_cast_narrow.c", 0),
    row("init_brace_intermediate_cast.c", 0),
    row("dead_local_load_frame_elide.c", 0),
    row("narrow_param_entry_extend.c", 0),
    row("qsort_scan_extend_dedup.c", 0),
    row("cross_block_cse.c", 0),
    row("one_shape_at_two_widths_is_two_values.c", 0),
    row("divmod_pair_shared_quotient.c", 0),
    row("block_function_declaration_hides_outer_binding.c", 0),
    row("cleanup_handler_name_shadowed_at_exit.c", 0),
    row("block_scope_parenthesized_function_declarator.c", 0),
    row("divide_width.c", 0),
    row("mul_add_contraction.c", 0),
    row("tailcall_return_extension.c", 0),
    row("fnptr_array_call.c", 0),
    row("call_arg_extend_drop.c", 0),
    row("int_compare_narrow_width.c", 0),
    row("stacked_sign_extend_collapse.c", 0),
    row("indirect_call_narrow_scalar_args.c", 0),
    row("indirect_call_ten_scalar_args.c", 0),
    row("indirect_call_mixed_fp_int_args.c", 0),
    row("float_param_stack_overflow.c", 0),
    row("indirect_call_variadic_fp_control.c", 0),
    row("ternary_arith_conversion.c", 0),
    row("struct_layout.c", 0),
    row("const_expr_conditional.c", 27),
    row("comma_operator_in_loops.c", 3),
    row("size_t_via_stdio.c", 3),
    row("optimize_predefines_optimize_not_ndebug.c", 100),
    row("leading_dot_float_literal.c", 7),
    row("libc_fp_return_value.c", 11),
    row("libc_fp_classify.c", 0),
    row("libc_math_fdim_scalbn.c", 0),
    row("libc_fileno_isblank.c", 0),
    row("libc_math_minmax.c", 0).unverified(PE_X64 | PE_ARM64),
    row("libc_math_round.c", 0).unverified(PE_X64 | PE_ARM64),
    row("libc_math_libm.c", 0).unverified(PE_X64 | PE_ARM64),
    row("libc_math_hyperbolic.c", 0).unverified(PE_X64 | PE_ARM64),
    row("libc_math_special.c", 0).unverified(PE_X64 | PE_ARM64),
    row("libc_math_nextafter.c", 0).unverified(PE_X64 | PE_ARM64),
    row("libc_math_logb_lgamma_remquo_nexttoward.c", 0),
    row("asctime_r_copies_asctime_text.c", 0),
    row("libc_mlock_and_fmemopen.c", 0).unverified(PE_X64 | PE_ARM64),
    row("socket_type_peek_and_pktinfo.c", 0).unverified(PE_X64 | PE_ARM64),
    row("shm_ipc_segment_round_trip.c", 0).unverified(PE_X64 | PE_ARM64),
    row("xsi_semaphore_and_message_queue_round_trip.c", 0).unverified(PE_X64 | PE_ARM64),
    row("aio_read_write_completes.c", 0).unverified(PE_X64 | PE_ARM64),
    row("posix_message_queue_round_trip.c", 0).unverified(PE_X64 | PE_ARM64),
    row("math_classify_type_generic.c", 0).unverified(PE_X64 | PE_ARM64),
    row("posix_option_macros_name_their_interfaces.c", 0).unverified(PE_X64 | PE_ARM64),
    row("pthread_rwlock_spin_barrier_and_attributes.c", 0).unverified(PE_X64 | PE_ARM64 | JIT),
    row("sys_queue_and_timeval_macros.c", 0).unverified(PE_X64 | PE_ARM64),
    row("ipv6_v6only_round_trip.c", 0).unverified(PE_X64 | PE_ARM64),
    row("msghdr_control_messages_round_trip.c", 0).unverified(PE_X64 | PE_ARM64),
    row("statvfs_layout_and_call.c", 0).unverified(PE_X64 | PE_ARM64),
    row("sigsetjmp_restores_the_signal_mask.c", 0).unverified(PE_X64 | PE_ARM64),
    row("glob_flags_and_results.c", 0).unverified(PE_X64 | PE_ARM64),
    row("setjmp_posix_forms_return_twice.c", 0).unverified(PE_X64 | PE_ARM64 | JIT),
    row("macos_getattrlist_name_and_reuseport.c", 0)
        .unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("macos_chflags_file_flags.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("long_double_libc_return.c", 0).unverified(PE_X64 | PE_ARM64 | JIT),
    row("variadic_via_fnptr.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("pragma_entrypoint.c", 23),
    row("struct_field_enum_type.c", 13),
    row("compound_assign_fp_int_rhs.c", 17),
    row("optimizer_fp_arg_mask_remap.c", 19),
    row("many_args_host_stack_overflow.c", 0).unverified(ELF_X64),
    row("inline_stack_passed_params.c", 42).unverified(ELF_X64),
    row("inline_stack_param_assign.c", 42).unverified(ELF_X64),
    row("inline_indirect_call_region_share.c", 42).unverified(ELF_X64),
    row("indirect_call_imm_target_direct.c", 42).unverified(ELF_X64),
    row("variadic_optimizer_survives.c", 0).unverified(ELF_X64),
    row("struct_2d_array_field.c", 27),
    row("struct_deref_va_arg.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("switch_multilabel.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("switch_goto_label_into_case.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("switch_label_after_terminator.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("unsigned_div_in_assign.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("strength_reduce_pow2_divmod.c", 0).unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("strength_reduce_magic_divmod.c", 0).unverified(PE_X64 | PE_ARM64),
    row("strength_reduce_compound_divmod.c", 0).unverified(PE_X64 | PE_ARM64),
    row("strength_reduce_inlined_divmod.c", 0).unverified(PE_X64 | PE_ARM64),
    row("return_callee_saved_value.c", 0).unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("spill_slot_reuse_disjoint_calls.c", 0).unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("rotate_variable_count.c", 0).unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("rotate_32bit_words.c", 0).unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("bits_between_register_files.c", 0).unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("vector_lane_runs_keep_what_they_do_not_write.c", 0)
        .unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("vector_parts_of_wider_vectors.c", 0).unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("values_saved_around_calls.c", 0).unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("values_saved_around_loops.c", 0).unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("values_saved_around_branch_arms.c", 0).unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("values_in_the_scratch_pair.c", 0).unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("loop_carried_low_words.c", 0).unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("stepped_pointer_accesses.c", 0).unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("counted_loops_close_on_their_step.c", 0).unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("a_step_read_by_a_later_branch.c", 0).unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("a_step_tested_again_after_compares.c", 0).unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("memory_operands_updated_in_place.c", 0).unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("local_address_through_phi.c", 0).unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("stores_overwritten_before_a_read.c", 0).unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("register_aggregates_with_unions.c", 0).unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("rotate_inline_const_count.c", 0).unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("constfold_post_inline.c", 0).unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("bitwise_not_mvn.c", 0).unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("add_three_operand_lea.c", 0).unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("add_sub_negative_imm.c", 0).unverified(ELF_X64 | PE_X64 | PE_ARM64),
    row("logical_immediate_masks.c", 42).unverified(PE_X64 | PE_ARM64),
    row("perf_loop_shapes.c", 0).unverified(PE_X64 | PE_ARM64),
    row("mem2reg_call_ref_rekey.c", 0).unverified(PE_X64 | PE_ARM64),
    row("straight_line_block_merge.c", 0).unverified(PE_X64 | PE_ARM64),
    row("block_plan_edges.c", 42).unverified(PE_X64 | PE_ARM64),
    row("extend_range_wrap.c", 0).unverified(PE_X64 | PE_ARM64),
    row("return_low_word.c", 0),
    row("param_home_width.c", 0).unverified(PE_X64 | PE_ARM64),
    row("param_entry_conversion.c", 0).unverified(PE_X64 | PE_ARM64),
    row("zero_test_of_a_wrapped_result.c", 0).unverified(PE_X64 | PE_ARM64),
    row("division_under_contradictory_guards.c", 0).unverified(PE_X64 | PE_ARM64),
    row("pointer_difference_wide.c", 0).unverified(PE_X64 | PE_ARM64),
    row("byte_index_addressing.c", 0).unverified(PE_X64 | PE_ARM64),
    row("word_index_addressing.c", 0).unverified(PE_X64 | PE_ARM64),
    row("zero_test_of_memory.c", 0).unverified(PE_X64 | PE_ARM64),
    row("store_of_constant.c", 0).unverified(PE_X64 | PE_ARM64),
    row("two_address_operands.c", 0).unverified(PE_X64 | PE_ARM64),
    row("divide_operands.c", 0).unverified(PE_X64 | PE_ARM64),
    row("dead_reads_across_calls.c", 0).unverified(PE_X64 | PE_ARM64),
    row("fp_param_ternary.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_multiblock_phi_callee.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("constfold_branch_through_phi.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("constfold_or_dispatch_inline.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_pointer_write_helper.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_local_array_callee.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("hex_float_literal.c", 0),
    row("bool_normalize_c99.c", 0),
    row("branch_fuse_cmp.c", 0),
    row("branch_fuse_fp_nan.c", 0),
    row("branch_fuse_short_circuit.c", 0),
    row("compound_literal_block.c", 0),
    row("struct_arg_in_registers.c", 0),
    row("struct_arg_by_stack.c", 0),
    row("wide_char_utf8.c", 0),
    row("scanf_family_reads_percent_a_as_a_floating_conversion.c", 0),
    row("select_and_getrusage_have_the_posix_types.c", 0).unverified(PE_X64 | PE_ARM64),
    row("locale_objects_and_the_l_functions.c", 0).unverified(PE_X64 | PE_ARM64),
    row("xsi_interfaces_reach_the_c_library.c", 0).unverified(PE_X64 | PE_ARM64 | JIT),
    row("stat_and_at_functions_have_their_posix_types.c", 0).unverified(PE_X64 | PE_ARM64),
    row("xlocale_extended_functions_take_a_locale.c", 0)
        .unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("vfscanf_and_vscanf_take_a_va_list.c", 0),
    row("scanf_family_stores_c99_conversions_alike.c", 0),
    row("strtof_and_wcstof_report_range_errors.c", 0),
    row("strtod_family_reads_c99s_subject_sequences.c", 0).unverified(JIT),
    row("printf_family_formats_c99_conversions.c", 0).unverified(JIT),
    row("printf_sharp_flag_leaves_infinity_and_nan_alone.c", 0).unverified(JIT),
    row(
        "printf_sharp_flag_on_infinity_and_nan_keeps_width_sign_and_counts.c",
        0,
    )
    .unverified(JIT),
    row("fscanf_reads_whole_fields_across_threads.c", 0).unverified(JIT),
    // strtod_family_reads_c99s_subject_sequences.c and
    // printf_family_formats_c99_conversions.c set LC_NUMERIC, which is
    // process-wide, and the JIT fixtures share one process.
    row(
        "wide_formatted_and_character_io_through_a_file_and_a_buffer.c",
        0,
    ),
    row("local_aggregate_runtime_init.c", 0),
    row("aggregate_init_struct_member_copy.c", 0),
    row("member_name_space_keeps_object_shape.c", 0),
    row("prototype_param_keeps_object_shape.c", 0),
    row("inner_binding_keeps_outer_array_shape.c", 0),
    row("array_alias_param_outer_bracket.c", 0),
    row("attr_arg_keeps_declared_type.c", 0),
    row("string_literal_const_index_fold.c", 0),
    row("const_array_copy_member_fold.c", 0),
    row("case_label_const_object.c", 0),
    row("string_subscript_const_init.c", 0),
    row("init_subdesignator_multi_dim.c", 0),
    row("fn_ptr_typedef_param_no_leak.c", 0),
    row("init_paren_cond_operator_chain.c", 0),
    row("gcc_vector_size_attribute.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("gcc_vector_bitwise_ops.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("gcc_vector_arith_ops.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("gcc_vector_arith_float.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("gcc_vector_compare_ops.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("gcc_vector_subscript.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("gcc_vector_array_whole_value_init.c", 0)
        .unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("gcc_vector_state_array_update.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("vector_abi_arg_return.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("vector_abi_variadic.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("ioctl_request_encoding.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("computed_goto.c", 0),
    row("local_label.c", 0).unverified(PE_X64),
    row("label_addr_array_init.c", 0),
    row("label_addr_in_dead_branch.c", 0),
    row("same_operand_algebra.c", 0),
    row("branch_arms_converge.c", 0),
    row("fp_constant_conversion.c", 0),
    row("struct_stack_param_tail.c", 0),
    row("divide_in_loop_live_values.c", 0),
    row("return_cleanup_shared.c", 0),
    row("narrow_division_late_constant.c", 0),
    row("narrow_remainder_rebuilt.c", 0),
    row("zero_local_aggregate_no_template.c", 0),
    row("label_addr_table_relocation.c", 0).unverified(PE_X64 | PE_ARM64),
    row("static_init_once_guard.c", 0),
    row("computed_goto_static_table.c", 0),
    row("computed_goto_dispatch_phis.c", 0).unverified(PE_X64 | PE_ARM64),
    row("sieve_of_eratosthenes.c", 0),
    row("static_neg_infinity_init.c", 0),
    row("sub_word_return_narrow.c", 0),
    row("fp_const_return.c", 0),
    row("fp_const_forms.c", 0),
    row("struct_array_init_from_lvalue.c", 0),
    row("shift_result_type_signedness.c", 0),
    row("mixed_sign_word_equality.c", 0),
    row("float_relational_raises_invalid.c", 0),
    row("object_size_through_inline.c", 0),
    row("integer_negate_shift_overflow.c", 0),
    row("case_label_declaration.c", 0),
    row("char_constant_signedness.c", 0),
    row("func_name_in_initializer.c", 0),
    row("anon_union_braced_init.c", 0),
    row("array_2d_struct_init.c", 0),
    row("cast_abstract_fn_ptr.c", 0),
    row("decl_trailing_attribute.c", 0),
    row("winsock_netdb_protoent.c", 0),
    row("slot_coalesce_disjoint_temps.c", 0),
    row("overaligned_automatic16.c", 0),
    row("overaligned_vla_int128.c", 0),
    row("alloca_alignment.c", 0),
    row("alloca_arena_in_bounds.c", 0),
    row("slot_coalesce_declared.c", 0),
    row("slot_coalesce_block_arrays.c", 0),
    row("slot_coalesce_alloca.c", 0),
    row("fn_arg_decay_then_deref_assign.c", 0),
    row("array_range_designator.c", 0),
    row("runtime_range_designator.c", 0),
    row("runtime_range_designator_struct.c", 0),
    row("bitfield_mixed_base_packing.c", 0),
    row("flex_array_member_sizing.c", 0),
    row("variadic_struct_return.c", 0),
    row("variadic_union_struct_return.c", 0),
    row("union_fp_member_regs_return.c", 0),
    row("fn_ptr_float_return.c", 0),
    row("fn_ptr_float_arg.c", 0),
    row("variadic_fn_ptr_init.c", 0),
    row("flexible_array_member.c", 0),
    row("flex_array_member_static_init.c", 0),
    row("attribute_cleanup.c", 0),
    row("array_compound_literal_static_init.c", 0),
    row("const_address_cast_and_arith.c", 0),
    row("const_conditional_address_init.c", 0),
    row("sizeof_array_type_and_binding.c", 0),
    row("builtin_object_size.c", 0),
    row("strict_flex_arrays.c", 16),
    row("sizeof_abstract_fn_ptr.c", 0),
    row("type_name_forms.c", 0),
    row("binary_operator_order.c", 0),
    row("pragma_operator.c", 0),
    row("variadic_macro_named_rest.c", 0),
    row("stdatomic_c11.c", 0),
    row("atomic_rmw_ops.c", 0),
    row("fn_ptr_typedef_multi_declarator.c", 0),
    row("hfa_struct_return.c", 0),
    row("hfa_element_count.c", 0),
    row("sysv_eightbyte_classes.c", 0),
    row("homogeneous_vector_aggregates.c", 0),
    row("sysv_misaligned_members.c", 0),
    row("naked_callee_pointer_argument.c", 0),
    row("by_reference_arguments.c", 0),
    row("small_fp_aggregate_arguments.c", 0),
    row("variadic_callee_frame.c", 0),
    row("variadic_hidden_result_pointer.c", 0),
    row("aggregate_argument_bounds.c", 0),
    row("packed_bitfield_bounds.c", 0),
    row("variadic_fp_argument_registers.c", 0),
    row("sysv_x87_unions.c", 0),
    row("sysv_single_fp_vectors.c", 0),
    row("variadic_sysv_eightbytes.c", 0),
    row("aggregate_result_alignment.c", 0),
    row("bitfield_assign_value.c", 0),
    row("bool_bitfield_assign_normalizes.c", 0),
    row("struct_arg_indirect_subscript.c", 0),
    row("out_pointer_return_float_args.c", 0),
    row("compound_literal_tagged_address.c", 0),
    row("function_typed_parameter.c", 0),
    row("static_init_braced_scalar.c", 0),
    row("paren_string_char_array_init.c", 0),
    row("static_init_paren_relocation.c", 0),
    row("do_while_zero_returns.c", 0),
    row("self_referential_macro.c", 0),
    row("logical_not_float.c", 0),
    row("designator_override_and_braced_string.c", 0),
    row("multidim_array_init.c", 0),
    row("macro_paste_stringize_unexpanded.c", 0),
    row("line_directive.c", 0),
    row("float_global_init.c", 0),
    row("func_name_array.c", 0),
    row("unary_plus_init_and_param_shadow.c", 0),
    row("fn_ptr_multi_deref.c", 0),
    row("stringize_whitespace.c", 0),
    row("kr_old_style_def.c", 0),
    row("fn_ptr_return_type.c", 0),
    row("fn_ptr_return_via_fn_ptr_var.c", 0),
    row("fn_type_typedef_ptr.c", 0),
    row("fn_returning_fn_ptr.c", 0),
    row("duff_switch_into_loop.c", 0),
    row("empty_macro_arg_and_string_rows.c", 0),
    row("inline_arg_count_mismatch.c", 0),
    row("inline_into_computed_goto.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("inline_one_word_struct.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("inline_one_word_struct_return.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("inline_struct_return_reg.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("inline_two_word_struct_return.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("inline_struct_return_multi_block.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("struct_return_reg_computed_goto.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("store_forward_local_slot.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("inline_struct_return_escape.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("inline_struct_param_mutated.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("inline_memory_class_struct_param.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("inline_struct_param_write.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("inline_struct_param_returned.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("inline_mcpy_flat_path.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("inline_switch_jump_table.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("inline_fp_class_struct_param.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("inline_phi_caller_leaf_helper.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("inline_phi_narrow_param_return.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("block_scope_extern.c", 0),
    row("extern_incomplete_struct_completion.c", 0),
    row("const_member_address_init.c", 0),
    row("const_float_div_zero.c", 0),
    row("array_of_struct_brace_elision.c", 0),
    row("local_struct_array_runtime_init.c", 0),
    row("scanf_fscanf_binding.c", 0),
    row("builtin_bit_count.c", 0),
    row("builtin_bit_count_edges.c", 0),
    row("typeof_operator.c", 0).unverified(PE_X64 | PE_ARM64),
    row("attribute_packed.c", 0).unverified(PE_X64 | PE_ARM64),
    row("attribute_positions.c", 0).unverified(PE_X64 | PE_ARM64),
    row("attribute_declspec.c", 0).unverified(PE_X64 | PE_ARM64),
    row("attribute_c23.c", 0).unverified(PE_X64 | PE_ARM64),
    row("static_assert_in_struct.c", 0).unverified(PE_X64 | PE_ARM64),
    row("gnu_extension_keyword.c", 0).unverified(PE_X64 | PE_ARM64),
    row("variadic_struct_by_value_arg.c", 0).unverified(PE_X64 | PE_ARM64),
    row("fn_ptr_ternary_call_return.c", 0).unverified(PE_X64 | PE_ARM64),
    row("float_condition_negative_zero.c", 0).unverified(PE_X64 | PE_ARM64),
    row("tentative_array_definition.c", 0).unverified(PE_X64 | PE_ARM64),
    row("tentative_array_use_before_init.c", 0).unverified(PE_X64 | PE_ARM64),
    row("inline_result_as_a_later_site_argument.c", 0).unverified(PE_X64 | PE_ARM64),
    row("loop_edge_copy_over_every_register.c", 0).unverified(PE_X64 | PE_ARM64),
    row("tentative_array_sized_later.c", 0).unverified(PE_X64 | PE_ARM64),
    row("tentative_deferred_array_grows.c", 0).unverified(PE_X64 | PE_ARM64),
    row("tentative_deferred_array_ref_before_definition.c", 0).unverified(PE_X64 | PE_ARM64),
    row("directive_in_macro_argument.c", 0).unverified(PE_X64 | PE_ARM64),
    row("builtin_bswap_expect.c", 0),
    row("builtin_bswap_reversal.c", 0),
    row("byte_load_wide_merge.c", 0),
    row("byte_store_wide_merge.c", 0),
    row("sysexits_codes.c", 0).unverified(PE_X64 | PE_ARM64),
    row("builtin_frame_address.c", 0),
    row("builtin_frame_address_levels.c", 0),
    row("builtin_return_address_levels.c", 0),
    row("always_inline_frame_address.c", 0),
    row("zero_length_array.c", 0),
    row("nested_compound_literal.c", 0),
    row("indirect_struct_return.c", 0),
    row("indirect_struct_return_outptr.c", 0),
    row("bitfield_incdec.c", 0),
    row("c11_atomic_specifier.c", 0),
    row("c11_atomic_ops.c", 0),
    row("inline_asm_hint.c", 0),
    row("inline_asm_raw_bytes.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_operands.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_memory.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_call.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_ldr_reg.c", 30).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_ldr_sub.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_ldst_modes.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_ldrb_reg.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_sysop.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_adr.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_sym_reloc.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_ccmp.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_bitfield.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_prfm.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_fmov.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_w_constraint.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_fp_arith.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_fp_cvt.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_fcmp.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_fp_ldst.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_neon.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_fp_vector.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_vector_shift.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_lane_transfer.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_permute.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_ldr_str_q.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_vector_immediate.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_vector_unary.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_vector_arith2.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_crypto.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_widen_narrow.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_ld1_st1.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_abs_g_const.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_tbl.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_vector_w.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("arm_neon_intrinsics.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("arm_neon_halfword_lanes.c", 42).unverified(ELF_X64 | PE_X64 | JIT),
    row("arm_neon_word_lanes_and_structure_loads.c", 0).unverified(ELF_X64 | PE_X64 | JIT),
    row("arm_neon_aegis_round.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("arm_neon_aes_pmull.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("arm_acle_crc32_and_sha.c", 42).unverified(ELF_X64 | PE_X64 | JIT),
    row("arm_neon_lane_ext_pmull_high.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("arm_neon_float_vectors.c", 0).unverified(ELF_X64 | PE_X64 | JIT),
    row("arm_neon_lane_moves_and_reinterpretations.c", 0).unverified(ELF_X64 | PE_X64 | JIT),
    row("arm_neon_integer_arithmetic_bitwise_and_compares.c", 0).unverified(ELF_X64 | PE_X64 | JIT),
    row("arm_neon_widening_and_narrowing_lanes.c", 0).unverified(ELF_X64 | PE_X64 | JIT),
    row("arm_neon_reductions_and_reversals.c", 0).unverified(ELF_X64 | PE_X64 | JIT),
    row("arm_neon_permutes.c", 0).unverified(ELF_X64 | PE_X64 | JIT),
    row("arm_neon_immediate_shifts.c", 0).unverified(ELF_X64 | PE_X64 | JIT),
    row("arm_neon_integer_shifts_widening_and_reductions.c", 0).unverified(ELF_X64 | PE_X64 | JIT),
    row("arm_neon_float_estimates_and_steps.c", 0).unverified(ELF_X64 | PE_X64 | JIT),
    row("arm_neon_estimates_on_seeded_lanes.c", 0).unverified(ELF_X64 | PE_X64 | JIT),
    row("arm_neon_compares_against_zero_on_seeded_lanes.c", 0).unverified(ELF_X64 | PE_X64 | JIT),
    row("arm_neon_qshlu_shll_and_padal_on_seeded_lanes.c", 0).unverified(ELF_X64 | PE_X64 | JIT),
    row("arm_neon_saturating_narrowing_shifts_on_seeded_lanes.c", 0)
        .unverified(ELF_X64 | PE_X64 | JIT),
    row("arm_neon_float_pairwise_and_maxnum_on_seeded_lanes.c", 0)
        .unverified(ELF_X64 | PE_X64 | JIT),
    row("arm_neon_roundings_on_seeded_lanes.c", 0).unverified(ELF_X64 | PE_X64 | JIT),
    row("arm_neon_conversions_on_seeded_lanes.c", 0).unverified(ELF_X64 | PE_X64 | JIT),
    row("arm_neon_doubling_multiplies_on_seeded_lanes.c", 0).unverified(ELF_X64 | PE_X64 | JIT),
    row("arm_neon_lane_indexed_forms_on_seeded_lanes.c", 0).unverified(ELF_X64 | PE_X64 | JIT),
    row("arm_neon_dot_products_on_seeded_lanes.c", 0).unverified(ELF_X64 | PE_X64 | JIT),
    row(
        "arm_neon_magnitude_compares_high_narrowing_and_mixed_accumulates_on_seeded_lanes.c",
        0,
    )
    .unverified(ELF_X64 | PE_X64 | JIT),
    row("arm_neon_structure_loads_and_stores_on_seeded_bytes.c", 0)
        .unverified(ELF_X64 | PE_X64 | JIT),
    row("arm_neon_multi_register_table_lookups_on_seeded_lanes.c", 0)
        .unverified(ELF_X64 | PE_X64 | JIT),
    row(
        "arm_neon_qrshl_cvtx_recpx_and_poly_forms_on_seeded_lanes.c",
        0,
    )
    .unverified(ELF_X64 | PE_X64 | JIT),
    row("arm_neon_scalar_forms_on_seeded_values.c", 0).unverified(ELF_X64 | PE_X64 | JIT),
    row("aarch64_nan_operands_rank_signaling_and_addend_first.c", 0)
        .unverified(ELF_X64 | PE_X64 | JIT),
    row("inline_asm_a64_vector_w_d_view.c", 0).unverified(ELF_X64 | PE_X64 | JIT),
    row("inline_asm_a64_w_operand_widths.c", 0).unverified(ELF_X64 | PE_X64 | JIT),
    row("inline_asm_a64_w_values_keep_their_bits.c", 0).unverified(ELF_X64 | PE_X64 | JIT),
    row("vector_register_chain.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_rw_aggregate_param.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_ld1_postindex.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_reduce.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_ld1r.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_ld1_lane.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_st4_lane.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_pmull.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_fp_immediate.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_clobber.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_x19_clobber_dynamic_frame.c", 42)
        .unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_x19_operand_dynamic_frame.c", 42)
        .unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_x19_sp_switch.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("long_double_leaf_sp_asm_borrow.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_clobber_probe.c", 42).unverified(ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_clobber_live_values.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_high_byte_clobber.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_fp_modifier.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_dp.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_sp_operand.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_labels.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_label_directive.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_acqrel.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_llsc.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_llsc_prfm.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_if_over_operands.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_goto.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("asm_goto_operand_region_paths.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("asm_register_outputs.c", 0),
    row("asm_multiple_outputs.c", 0),
    row("inline_asm_goto_callee_saved_exits.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_reg_var.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_reg_var_inout.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_bl_here.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_sp_reg_var.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("declarator_list_forms.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_named_operands.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_const_modifier.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_branch_target_operand.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_segment.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_barriers.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_comments.c", 42).unverified(ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_pushsection.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_quoted_symbol_data.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_pushed_replacement.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("file_scope_asm_decls.c", 0).unverified(PE_X64 | PE_ARM64 | JIT),
    row("file_scope_asm_label_binding.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("file_scope_asm_section_placement.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("file_scope_asm_rept_type_size.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("file_scope_asm_string_operands.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_goto_output.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_goto_multiret.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_output_reg.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("inline_naked_not_inlined.c", 0).unverified(PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_constraint_alternatives.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_operand_modifiers.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_P_memory_operand.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_x_scalar.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_label_memory_operand.c", 42).unverified(PE_X64 | PE_ARM64 | JIT),
    row("compound_assign_int_fp.c", 0),
    row("signal_sig_t.c", 0),
    row("math_classify.c", 0),
    row("tgmath_selects_by_argument_type.c", 0),
    row("switch_unsigned_negative_case.c", 0),
    row("enum_bitfield_unsigned.c", 0),
    row("addr_of_intrinsic_math.c", 0),
    row("libc_struct_arg_by_value.c", 0).unverified(PE_X64 | PE_ARM64),
    row("posix_unix_headers.c", 0).unverified(PE_X64 | PE_ARM64),
    row("socket_headers_abi.c", 0),
    row("in6_address_predicates.c", 0),
    row("posix_utime_errno_headers.c", 0),
    row("cast_fn_typedef_ptr_in_initializer.c", 0),
    row("static_init_logical_and.c", 42),
    row("va_opt_initializer.c", 42),
    row("global_init_paren_operand.c", 0),
    row("function_type_typedef_declaration.c", 0),
    row("float_increment_decrement.c", 0),
    row("compound_assign_float_register_resident.c", 0),
    row("addr_of_libm_import.c", 0),
    row("addr_of_libc_strcmp.c", 0),
    row("libc_pread64_pwrite64.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("struct_stat_abi_size.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("block_scope_extern_forward_ref.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("uint64_to_float.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("double_to_uint64.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("sysconf_pagesize.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("strtoul_64bit_return.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("libc_time_widths.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("sigpipe_ignored.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("errno_socket_constants.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("gettimeofday_usec_range.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("lp64_predefine.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("pthread_static_init.c", 0).unverified(ELF | ELF_X64 | JIT),
    // Data binding (environ) read through the fake GOT; the site
    // patching is the JIT counterpart of the AOT flat-lookup import.
    row("environ_single_tu.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("fts_and_fd_set_headers.c", 0).unverified(PE_X64 | PE_ARM64),
    row("addr_of_intrinsic_math_float.c", 0),
    row("fn_ptr_float_arg_narrow.c", 0),
    row("struct_array_elided_runtime.c", 0),
    row("fn_type_typedef_field.c", 0),
    row("fn_type_typedef_local.c", 0),
    row("fn_ptr_array_pointer_call.c", 0),
    row("fn_type_typedef_cast.c", 0),
    row("nested_runtime_init.c", 0),
    row("anon_union_init.c", 0),
    row("packed_anon_struct_layout.c", 0),
    row("attribute_statement.c", 0),
    row("typeof_member_array_dims.c", 0),
    row("ptr_to_incomplete_array.c", 0),
    row("int128_return_scalar.c", 0),
    row("align16_arg_abi.c", 0),
    row("designator_chain_runtime_array.c", 0),
    row("designator_range_in_chain.c", 0),
    row("designator_multidim_scalar_array.c", 0),
    row("designator_positional_resume.c", 0),
    row("designator_chain_runtime_multidim.c", 0),
    row("macro_alias_tail_invocation.c", 0),
    row("anon_member_brace_nesting.c", 0),
    row("anon_member_inner_brace.c", 0),
    row("compound_literal_alignment.c", 0),
    row("designator_scopes.c", 0),
    row("overaligned_vector_object.c", 0),
    row("vector_object_alignment.c", 0),
    row("compound_literal_array_init.c", 0),
    row("compound_literal_multidim.c", 0),
    row("compound_literal_struct_array.c", 0),
    row("struct_array_brace_elision.c", 0),
    row("struct_array_designator_resume.c", 0),
    row("designator_resumes_in_subobject.c", 0),
    row("designator_completes_a_union.c", 0),
    row("member_qualifiers_stay_with_their_members.c", 0),
    row("fp_contract_stays_within_an_expression.c", 0),
    row("atomic_int128_operations.c", 0),
    row("function_alignment_attribute.c", 0),
    row("array_typedef_pointer_casts.c", 0),
    row("digraphs_spell_their_punctuators.c", 0),
    row("asm_pcrel_words_name_text_and_data.c", 0),
    row("packed_anon_union_layout.c", 0),
    row("packed_member_alignment.c", 0),
    row("packed_int128_odd_offset.c", 0),
    row("block_comment_star_newline_slash.c", 0),
    row("brace_elision_anon_and_automatic.c", 0),
    row("const_comma_void_operand.c", 0),
    row("atomic_pointer_fetch_scales.c", 0),
    row("c17_library_interfaces.c", 0),
    row("builtin_trap.c", 0),
    row("struct_multi_byval.c", 0),
    row("struct_arg_two_eightbyte.c", 0),
    row("struct_return_by_value.c", 0),
    row("struct_return_to_global.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("cast_fn_ptr_call.c", 0),
    row("paren_comma_side_effect.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("for_init_decl_in_loop.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("for_init_stmt_expr_nested_stmt.c", 6),
    row("stmt_expr_scope_exit_value.c", 0),
    row("int_times_double_into_local.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("ptr_diff_plus_ptr.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("fn_ptr_arith_byte_stride.c", 0),
    row("addr_of_array_lvalue.c", 0),
    row("anonymous_aggregates.c", 0),
    row("unnamed_field_tagged_type.c", 0),
    row("unnamed_field_typedef_name.c", 0),
    row("const_strlen_literal.c", 0),
    row("auto_type_declarator_attribute.c", 0),
    row("flex_array_in_union_init.c", 0),
    row("array_range_designator_unsized.c", 0),
    row("has_attribute_in_expression.c", 0),
    row("file_scope_compound_literal_forms.c", 0),
    row("static_locals.c", 0),
    row("static_local_array_init_bounds.c", 0),
    row("string_initializer_copy_rules.c", 0),
    row("large_stack_frame.c", 42),
    row("octal_literal.c", 42),
    row("short_types.c", 42),
    row("long_long_distinct.c", 0),
    row("signed_cast_extends.c", 0),
    row("fn_ptr_struct_return.c", 0),
    row("static_init_cast_funcptr.c", 0),
    row("static_init_struct_fp_call.c", 0),
    row("libc_data_globals.c", 0),
    row("stdint_widths.c", 0),
    row("fd_set_macros.c", 0).unverified(PE_X64 | PE_ARM64),
    row("fn_ptr_explicit_deref.c", 42),
    row("fn_ptr_decay_inside_block.c", 0),
    row("switch_nested_case_in_compound.c", 0),
    row("ternary_middle_comma.c", 0),
    row("local_init_int_to_float.c", 0),
    row("sys_addr_in_static_init.c", 42).unverified(PE_X64 | PE_ARM64),
    row("sys_addr_zero_arg.c", 42).unverified(PE_X64 | PE_ARM64),
    row("libc_struct_buf_size.c", 42).unverified(PE_X64 | PE_ARM64),
    row("libc_basic.c", 0),
    row("memset_mcmp.c", 42),
    row("memcpy_basic.c", 'A' as i32),
    row("aggregate_copy_site_temps.c", 0),
    row("aggregate_register_parts.c", 0),
    row("aggregate_arguments_past_the_registers.c", 0),
    row("call_result_in_place.c", 0),
    // C99 7.13 setjmp / longjmp round-trip. On macOS / Linux the
    // binding hits host libc; on Windows it routes through msvcrt,
    // except in an in-process image on AArch64, which takes the inline
    // `Intrinsic::SetjmpAArch64` / `Intrinsic::LongjmpAArch64` pair.
    row("setjmp_longjmp_roundtrip.c", 0).unverified(ELF | ELF_X64 | PE_X64 | JIT),
    // POSIX sigsetjmp / siglongjmp (savemask 0) mapped onto the same
    // per-target setjmp / longjmp machinery.
    row("sigsetjmp_roundtrip.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // A struct-based 128-bit integer fallback: 16-byte struct-by-value
    // returns / params and carry arithmetic across the two halves.
    row("int128_struct_fallback.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // C11 6.7.2.1: a designated initializer for a named aggregate member
    // inside an anonymous union/struct fills the member's own type.
    row("anon_member_designated_init.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // The runtime (non-constant) initializer path shares the constant
    // path's anonymous-struct / union / nested-aggregate handling.
    row("runtime_anon_struct_init.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // C99 6.7.8p6 `[N] =` designators in a runtime array initializer.
    row("runtime_array_designator.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // C99 6.7.8p7 `.member` designators inside a flattened anonymous-struct
    // region, constant and runtime store paths.
    row("anon_struct_designated_init.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // C99 6.7.8p15 wide string literal initializing a wchar_t-width array
    // member, constant and runtime store paths.
    row("wide_string_struct_member.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // C99 6.5.2.5 pointer field = array-of-struct compound literal in a
    // static initializer (a real-world descriptor-table shape).
    row("compound_literal_pointer_field.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // GNU C zero-length array `T x[0]` as a local (compile-time-assert idiom).
    row("zero_length_array_typedef.c", 0),
    row("zero_length_local_array.c", 0),
    // GNU C 128-bit integer as a 16-byte type: sizeof, struct/array layout
    // (asm/sigcontext.h shape), by-value copy.
    row("int128_type_layout.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // 128-bit integer arithmetic, expanded over the two 64-bit
    // halves: add / sub / neg / bitwise / increment with carry and
    // borrow, shifts across the halfway point, the widening 64x64
    // product, signed and unsigned comparison edges, and division /
    // remainder with the C99 6.5.5 truncation-toward-zero sign rules.
    row("int128_arith.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("int128_shift.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("int128_mul.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("int128_cmp.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("int128_divmod.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("int128_unary.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("int128_scalar_result.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("int128_struct_member.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("int128_overflow_builtin.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("int128_bitfield.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // C99 7.13.2.1p3 / 6.7.3p6 / 5.1.2.3p2: volatile objects keep
    // their post-longjmp value, are re-read through aliases, and
    // unused volatile reads still execute.
    row("volatile_setjmp_longjmp.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // C99 6.7.3p6 / 5.1.2.3p2 volatile access preservation (the
    // setjmp variant lives only in the native lists; setjmp is not
    // wired for the JIT lane).
    row("volatile_ptr_alias_loop.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("volatile_unused_read.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("volatile_param_classes.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("struct_basic.c", 25),
    row("struct_linked_list.c", 10),
    row("global_initializer_int.c", 141),
    row("global_initializer_pointer.c", 0),
    row("static_linked_list.c", 0),
    row("struct_sizeof.c", 0),
    row("memory_ops.c", 0),
    row("linked_list.c", 10),
    row("double_pointers.c", 0),
    // Data segment + function-pointer translation. Both flow through
    // the `data_imm_positions` side channel + ADRP+ADD / RIP-relative
    // fixups. The fixtures below stress one or both.
    row("printf.c", 0).unverified(PE_X64 | PE_ARM64),
    row("shebang.c", 7).unverified(PE_X64 | PE_ARM64),
    row("adjacent_strings.c", 'f' as i32).unverified(PE_X64 | PE_ARM64),
    row("string_concat_encoding_prefix.c", 0).unverified(PE_X64 | PE_ARM64),
    row("utf8_string_prefix_ucn.c", 0).unverified(PE_X64 | PE_ARM64),
    row("extended_identifiers.c", 0).unverified(PE_X64 | PE_ARM64),
    // 4 + 4 + 8
    row("sizeof_with_write.c", 16).unverified(PE_X64 | PE_ARM64),
    row("function_pointers.c", 150),
    row("nested_function_calls.c", 100),
    row("quicksort.c", 0),
    row("loop_iv_spill_priority.c", 40),
    row("loop_idiom_transfer.c", 0),
    row("loop_idiom_overlap.c", 0),
    row("loop_idiom_version.c", 0),
    row("split_spilled_reload_run.c", 229),
    row("hoist_loop_invariant_address.c", 42),
    row("binary_search_tree.c", 0),
    row("bst_free.c", 0),
    row("cast_to_struct_pointer.c", 42),
    // argc/argv plumbing -- the _start stub spills the platform's
    // first two arg registers into the c5 stack slots `int main(int
    // argc, char **argv)` expects.
    row("argc.c", 1).unverified(PE_X64 | PE_ARM64),
    row("argv_first_char.c", 0).unverified(PE_X64 | PE_ARM64),
    row("sizeof_basic.c", 0),
    row("sizeof_expr.c", 0),
    row("write_stdout.c", 0).unverified(PE_X64 | PE_ARM64),
    // Trivial fixtures that exit with the same code under both
    // backends. The type-warning fixtures emit warnings at compile
    // time but still run to a clean exit. `mprotect_allows_read`
    // exercises the success path (the VM-aborting "blocks_*" cases
    // intentionally diverge from native and live in the excluded set).
    row("ir_translation_simple.c", 42),
    row("ir_translation_if.c", 2),
    row("ir_translation_while.c", 0),
    row("type_warning_int_to_ptr.c", 0),
    row("type_warning_return.c", 0),
    row("type_warning_silenced_by_cast.c", 0),
    row("type_warning_arity.c", 0),
    row("redecl_composite_keeps_prototype.c", 0),
    row("forward_enum_tag_redeclaration.c", 0),
    row("seh_context_record.c", 0),
    row("unwind_restores_callee_saved.c", 0).unverified(JIT),
    row("unwind_from_epilogue.c", 0).unverified(JIT),
    row("unwind_from_a_fault_in_each_frame_shape.c", 0).unverified(JIT),
    row("seh_except_constant_filter.c", 0).unverified(JIT),
    row("seh_except_filter.c", 0).unverified(JIT),
    row("seh_finally.c", 0).unverified(JIT),
    row("seh_nested_funclets.c", 0).unverified(JIT),
    row("seh_in_named_code_section.c", 0).unverified(JIT),
    row("unsigned_constant_to_floating.c", 0),
    row("string_literal_address_constant.c", 0),
    row("address_constant_through_cast.c", 0),
    row("local_byte_array_init_converts.c", 0),
    row("address_to_bool_initializer.c", 0),
    row("address_constant_array_strides.c", 0),
    row("const_object_address_read.c", 0),
    row("const_bit_field_read.c", 0),
    row("dlfcn_errors.c", 0),
    row("dirent_stream.c", 0),
    row("utime_sets_times.c", 0),
    row("posix_clocks.c", 0),
    row("fenv_raise_test_clear.c", 0),
    row("wctype_mapping_round_trip.c", 0),
    row("chmod_mktemp_file_mode.c", 0),
    row("creat_creates_and_truncates.c", 0),
    row("object_size_of_a_dereferenced_pointer_variable.c", 0),
    row("object_size_of_an_array_completed_later.c", 0),
    row("self_declared_string_and_ctype_extensions.c", 0).unverified(ELF | ELF_X64),
    // `self_declared_string_and_ctype_extensions.c` takes `strlcpy` and
    // `strlcat` from the on-demand join, which one object and no link step
    // cannot reach; `string_extensions_join_the_linux_link` covers it.
    row("semaphore_counts_and_waits.c", 0),
    row("temp_files_truncate_sleep.c", 0),
    row("basename_dirname_split.c", 0),
    row("getopt_long_permutes_operands.c", 0).unverified(ELF | ELF_X64 | JIT),
    row("exit_from_nested_call.c", 3),
    row("constant_condition_unsigned_operands.c", 0),
    row("constant_conditional_result_type.c", 0),
    row("tag_scopes_of_blocks_and_parameter_lists.c", 0),
    row("enumerator_scopes_of_parameter_lists.c", 0),
    row("function_designator_address_constants.c", 0),
    row("type_name_paren_declarator_forms.c", 0),
    row("inline_asm_a64_pair_array_operand.c", 0),
    row("stdlib_exit_without_handlers.c", 7),
    row("quick_exit_runs_its_handlers.c", 5).unverified(PE_X64 | PE_ARM64 | JIT),
    row("popen_reads_command_output.c", 0),
    row("pthread_lifecycle.c", 0).unverified(JIT),
    // pthread_lifecycle.c and pthread_once_keys.c run only as executables:
    // the JIT unmaps a program once its main returns, while a detached
    // thread may still run the program's code, and runs main on a thread
    // whose exit runs the destructors main's keys leave set.
    row("pthread_mutex_cond.c", 0),
    row("pthread_once_keys.c", 0).unverified(JIT),
    row("setenv_then_get.c", 'Z' as i32).unverified(PE_X64 | PE_ARM64 | JIT),
    // POSIX setenv overwrite semantics, from the program's own setenv over
    // msvcrt's 2-parameter _putenv_s: the headers declare none.
    row("setenv_overwrite.c", 0).unverified(JIT),
    // On Native:
    // Runtime dynamic linking. Opens the global symbol table,
    // resolves libc atoi via dlsym, calls it through indirect call
    // (which loads args into x0..x7 in case the target is native),
    // exits with atoi("123") = 123.
    // On Elf:
    // Runtime dynamic linking through libdl (libdl.so.2 +
    // libc.so.6 are both DT_NEEDED). dlopen+dlsym+blr finds
    // libc atoi and the indirect call passes "123" in x0.
    // On Jit:
    // dlopen+dlsym+blr finds libc atoi and the indirect call passes
    // "123" in the System V argument register.
    row("dlopen_atoi.c", 123).unverified(PE_X64 | PE_ARM64),
    row("dlopen_strlen.c", 13),
    row("dlopen_null_searches_the_global_scope.c", 0),
    row("wint_t_is_the_platform_c_library_type.c", 0),
    row("fenv_exception_set_matches_the_platform.c", 0),
    // On Native:
    // Multi-arg dlsym call path: spawns a thread via pthread_create
    // (4 pointer-ish args), joins it, returns the thread's exit
    // status. macOS pthread is in libSystem so dlopen(NULL) finds it.
    // On Elf:
    // Multi-arg dlsym call path. glibc 2.34+ folded pthread into
    // libc and keeps libpthread.so.0 as a stub the loader pulls in
    // anyway, so dlopen(NULL) finds pthread_create in our scope.
    // On Jit:
    // Multi-arg dlsym call path: pthread_create + pthread_join.
    // POSIX-only fixture; the JIT is gated to POSIX hosts already.
    row("pthread_create.c", 11).unverified(PE_X64 | PE_ARM64),
    row("pthread_cond_timedwait.c", 0),
    row("posix_os_headers.c", 0).unverified(PE_X64 | PE_ARM64),
    row("termios_ioctl_requests.c", 0).unverified(PE_X64 | PE_ARM64),
    row("posix_legacy_and_gnu_names.c", 0).unverified(PE_X64 | PE_ARM64),
    row("posix_timers_and_conversion.c", 0).unverified(PE_X64 | PE_ARM64),
    row("dirent_readdir.c", 0).unverified(PE_X64 | PE_ARM64),
    row("ftw_walk.c", 0),
    // On PeX64:
    // fnmatch and the regex quartet: msvcrt has neither, so this lane
    // runs badc's own engine (`libc/lib/pattern.c`) rather than a
    // platform library.
    row("pattern_match_posix.c", 0).unverified(PE_ARM64),
    // On Native:
    // libSystem exports memmem / getline / getdelim / dprintf, so this
    // lane binds them. It has no `copy_file_range` and no GNU string
    // extensions, which `unistd_ext.c` and `string_ext.c` supply.
    // On Elf:
    // memmem / getline / getdelim / dprintf / copy_file_range: the
    // Linux C library exports all five, so this lane binds them.
    // On PeX64:
    // memmem / getline / getdelim / dprintf / copy_file_range: msvcrt
    // exports none of them, so this lane runs `libc/lib/string_ext.c`,
    // `stdio_ext.c` and `unistd_ext.c`.
    row("copy_file_range_posix.c", 0),
    // On PeX64:
    // strchrnul / memrchr / explicit_bzero / strndup: msvcrt exports
    // none of them, so this lane runs `libc/lib/string_ext.c`.
    // On Jit:
    // On macOS the run joins `string_ext.c` and `unistd_ext.c` on demand.
    row("string_gnu_ext.c", 0),
    // memmem / getline / getdelim / dprintf, bound on every host this
    // module runs on.
    row("stdio_line_input.c", 0),
    row("string_memmem.c", 0),
    row("stat_timespec.c", 0).unverified(PE_X64 | PE_ARM64),
    row("malloc_size.c", 0).unverified(PE_X64 | PE_ARM64),
    // On Native:
    // sprintf with two fixed args + four variadic. macOS arm64
    // variadic ABI puts variadic args on the stack while fixed
    // args ride registers; this guards against the lowering
    // regressing back to the printf-shape (one fixed arg)
    // assumption.
    // On Elf:
    // sprintf 2-fixed + 4-variadic; cross-checks the ABI's
    // variadic packing on Linux AAPCS64 (where it stays in
    // registers, unlike macOS).
    // On ElfX64:
    // sprintf 2-fixed + 4-variadic; SysV passes variadic in
    // registers but the call still needs `xor eax, eax` so AL
    // signals "no XMM regs used" -- the ABI plan's
    // variadic_zero_xmm_count flag drives that.
    // On Jit:
    // sprintf 2-fixed + 4-variadic; the JIT shares the lowering
    // with the AOT backends so this guards both at once.
    row("variadic_sprintf.c", 0).unverified(PE_X64 | PE_ARM64),
    // On Native:
    // c5-side vprintf walking the c5 va_list. macOS arm64 was
    // the worst-affected platform for the libc-bridged variant
    // (AAPCS64 variadic spills); this fixture sidesteps the
    // bridge and stays inside c5 stack semantics throughout.
    // Float / double basics -- declarations, pointer arithmetic,
    // sizeof.
    // On Elf:
    // c5-side vprintf walking the c5 va_list. Stays inside the
    // c5 stack convention; no libc va_list bridge involved.
    // Float / double frontend (decls, pointer arith, sizeof).
    // On ElfX64:
    // c5-side vprintf walking the c5 va_list (no libc va_list).
    // Float / double frontend deliverable.
    // On PeX64:
    // c5-side vprintf -- the variadic walk happens in c5 source,
    // so the call into msvcrt is just `_write`. No libc va_list
    // bridge involved, which is why this fixture is in even when
    // the libc-shape `variadic_sprintf` is not.
    // Float / double frontend deliverable.
    // On PeArm64:
    // c5-side vprintf -- variadic walking happens in c5 source
    // and the only Win32 call is `_write`, so this fixture stays
    // in even when the libc-shape variadic-sprintf path doesn't.
    // Float / double frontend deliverable.
    // On Jit:
    // Float / double scalars parse, sizeof reports 8, pointer
    // arithmetic and indexed loads/stores work.
    row("float_pointer_basics.c", 0),
    // On Native:
    // Full FP arithmetic + comparisons + casts on macOS arm64.
    // The aarch64 codegen lowers Fadd/.../Fcvtfi to FMOV +
    // FADD/FSUB/FMUL/FDIV/FCMP/FCVTZS/SCVTF; this fixture is the
    // host-platform smoke test for that pipeline.
    // On Elf:
    // Full FP arithmetic + comparisons + casts.
    // On ElfX64:
    // Full FP arithmetic + comparisons + casts on Linux x86_64
    // (SysV). The x86_64 codegen lowers Fadd/.../Fcvtfi via SSE2
    // (movq xmm/gpr; addsd/subsd/mulsd/divsd; ucomisd; cvtsi2sd;
    // cvttsd2si).
    // On PeX64:
    // Full FP arithmetic on Win64 -- same SSE2 lowering as the
    // ELF x64 path; the only thing that varies is the call site
    // ABI, which this fixture doesn't exercise (no FP libc calls).
    // On PeArm64:
    // Full FP arithmetic on Windows/AArch64 -- same NEON lowering
    // as the ELF arm64 / macOS arm64 paths.
    // On Jit:
    // Full FP arithmetic: add/sub/mul/div, comparisons, casts,
    // unary negation. Routes through Fadd/.../Fcvtfi opcodes the
    // VM and both codegens implement.
    row("float_arithmetic.c", 0),
    row("float_single_precision.c", 0),
    row("float_literal_f_suffix.c", 0),
    row("float_literal_arith_single_precision.c", 0),
    row("fp_direct_width_cast.c", 0),
    row("fp_const_fold_cast.c", 0),
    row("float_literal_variadic_printf.c", 0),
    row("fp_unary_intrinsic.c", 0),
    row("fp_arg_passed_in_fp_reg.c", 0),
    row("fp_param_float_before_double.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("float_arg_single_precision.c", 0),
    row("fp_return_value.c", 0),
    row("global_addr_multidim_index.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("global_addr_struct_member.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("local_array_runtime_nested_init.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("many_fp_args.c", 0),
    row("fp_volatile_bank_across_calls.c", 0),
    row("constant_set_again_after_call.c", 0),
    row("fp_param_after_int_overflow.c", 0),
    row("hfa_param_interleave.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("libc_struct_return.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("global_struct_return_indirect.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("init_scalar_conversion.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("fnptr_typedef_return_proto.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("asm_empty_barrier.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("inline_asm_frame_region_reuse.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("syslimits_path_max.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("libc_atoll_wcsrtombs.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("gcc_atomics.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("atomic_lock_free_widths.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_linkage.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("msvc_callconv.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("anon_struct_init.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("float_double_mix.c", 0),
    // On Native:
    // Variadic FP packer on macOS arm64. The Apple AAPCS64
    // quirk: variadic args spill to the stack regardless of
    // type, so `printf("%f\n", 1.5)` lands the double's bit
    // pattern in a stack slot rather than v0. Routes through
    // the macOS-specific variadic-on-stack path in
    // emit_libc_call.
    // On Elf:
    // Variadic FP packer: `printf("%f\n", 1.5)` -- on Linux
    // AAPCS64, FP variadic args ride d0..d7 the same as fixed
    // FP args. The all-int packer would land 1.5's bit pattern
    // in x1 and the formatter would print 0.0; the FP-aware
    // packer routes it to d0 and the test passes.
    // On ElfX64:
    // Variadic FP packer: `printf("%f\n", 1.5)`. SysV pulls FP
    // variadic args through xmm0..xmm7 with AL = XMM count; the
    // pre-packer code routed everything as 8-byte words via the
    // integer arg regs and the formatter printed 0.0.
    row("printf_float.c", 0).unverified(PE_X64 | PE_ARM64 | JIT),
    // On Native:
    // _Thread_local round-trip on macOS arm64. Routes through
    // the Apple TLV (Thread-Local Variables) ABI:
    // __DATA,__thread_vars descriptors + __DATA,__thread_bss
    // storage, with the loader binding `__tlv_bootstrap` from
    // libSystem to descriptor slot 0. The codegen emits an
    // `adrp+add` that materializes the descriptor's address,
    // then `ldr x16, [x0]; blr x16` to call into the getter.
    // On Elf:
    // `_Thread_local` round-trip in the main thread; exercises
    // PT_TLS + .tbss layout and the variant-1 (TPIDR_EL0 +
    // TCB_HEAD + offset) lowering. The loader copies p_filesz=0
    // bytes and zero-fills the rest; the test reads/writes the
    // resulting per-thread region.
    // On ElfX64:
    // `_Thread_local` round-trip via the variant-2 (FS_BASE -
    // (tls_total - offset)) sequence on x86_64. Requires PT_TLS
    // + .tbss to exist in the ELF.
    // On PeX64:
    // _Thread_local on Win64 -- TLS directory + _tls_index slot
    // wired into .data; the loader writes _tls_index at module
    // init and the codegen pulls per-thread storage out of
    // gs:[0x58]. The fixtures that spawn a thread take kernel32's
    // CreateThread here and pthreads elsewhere, so per-thread
    // isolation and the block's alignment are covered on both.
    // On PeArm64:
    // _Thread_local on Windows/AArch64 -- same TLS directory +
    // _tls_index plumbing as the x64 PE; the lowering pulls
    // tls_array out of `[x18 + 0x58]` (TEB->ThreadLocalStoragePointer)
    // instead of gs:[0x58].
    row("thread_local_basic.c", 0).skip(JIT, "thread-local storage"),
    row("msvc_decl_decorators.c", 0).unverified(JIT),
    row("msvc_pragma_operator.c", 0).unverified(JIT),
    row("thread_local_gnu.c", 0).skip(JIT, "thread-local storage"),
    row("wmem_functions.c", 0).unverified(PE_X64 | PE_ARM64),
    row("posix_module_headers.c", 0),
    row("library_name_defined_by_program.c", 0).unverified(PE_X64 | PE_ARM64),
    row("mmap_anonymous.c", 0).unverified(PE_X64 | PE_ARM64),
    row("struct_tm_tm_zone_offset.c", 0).unverified(PE_X64 | PE_ARM64),
    row("for_init_multiple_declarators.c", 0).unverified(PE_X64 | PE_ARM64),
    row("compound_literal_member_operand.c", 0).unverified(PE_X64 | PE_ARM64),
    row("signal_nsig.c", 0).unverified(PE_X64 | PE_ARM64),
    row("thread_local_initializer.c", 0).skip(JIT, "thread-local storage"),
    row("thread_local_address_init.c", 0).skip(JIT, "thread-local storage"),
    row("thread_local_fn_pointer_defined_later.c", 0).skip(JIT, "thread-local storage"),
    row("thread_local_library_function_slot.c", 0).skip(JIT, "thread-local storage"),
    // On Native:
    // Per-thread isolation -- spawns a pthread, has the child
    // mutate a TLS variable, joins, and verifies the main
    // thread's view is untouched. Apple's TLV implementation
    // ties the storage to a pthread key, so each thread sees
    // its own copy.
    // On Elf:
    // Per-thread isolation: spawn a pthread, mutate TLS in the
    // child, join, verify main's view is untouched. Fails in any
    // accidental "TLS lowered as a regular global" regression.
    // On ElfX64:
    // Per-thread isolation via pthread_create.
    row("thread_local_per_thread.c", 0)
        .unverified(PE_X64 | PE_ARM64)
        .skip(JIT, "thread-local storage"),
    row("thread_local_address_per_thread.c", 0)
        .unverified(PE_X64 | PE_ARM64)
        .skip(JIT, "thread-local storage"),
    row("thread_local_object_alignment.c", 0).skip(JIT, "thread-local storage"),
    row("thread_local_image_alignment.c", 0).skip(JIT, "thread-local storage"),
    row("thread_local_tentative_array.c", 0).skip(JIT, "thread-local storage"),
    row("thread_local_tentative_completed_later.c", 0).skip(JIT, "thread-local storage"),
    row("thread_local_block_static_shadow.c", 0).skip(JIT, "thread-local storage"),
    row("thread_local_zero_images.c", 0).skip(JIT, "thread-local storage"),
    // Every thread-local read folds at compile time; nothing reaches a
    // thread-local block at run time.
    row("thread_local_const_fold.c", 0),
    row("thread_local_aggregate_initializers.c", 0).skip(JIT, "thread-local storage"),
    // On Native:
    // Struct-value locals + `.` field access on macOS arm64.
    // On Elf:
    // Struct-value locals + `.` field access.
    row("struct_value_basics.c", 0),
    // On Native:
    // Whole-struct copy via Inst::Mcpy on macOS arm64. The aarch64
    // codegen unrolls the copy into ldur/stur word pairs.
    // On Elf:
    // Whole-struct copy via Inst::Mcpy.
    // On ElfX64:
    // Whole-struct copy via Inst::Mcpy. The x86_64 codegen
    // unrolls it into mov / mov word pairs.
    // On Jit:
    // Whole-struct copy via Inst::Mcpy. The walker emits it
    // for `a = b` where both are struct values; the VM and both
    // codegens unroll the byte-level copy at compile time.
    row("struct_value_copy.c", 0),
    // On Native:
    // Struct-by-value parameter / return. Both ride the existing
    // c5 calling convention (caller pushes addresses, callee
    // copies on entry; struct returns get a hidden out-pointer
    // at val=2).
    // On Elf:
    // Struct-by-value parameter / return.
    // On PeX64:
    // Struct-by-value parameter / return on Win64.
    // On PeArm64:
    // Struct-by-value parameter / return on Windows/AArch64.
    // On Jit:
    // Struct passed by value: callee's prologue copies the
    // struct out of the caller's slot into a local so callee
    // mutations don't leak.
    row("struct_by_value_param.c", 0),
    // Struct returned by value via the hidden out-pointer ABI.
    row("struct_by_value_return.c", 0),
    // On Native:
    // Unsigned-integer comparisons across char / int / long widths.
    // On Jit:
    // Unsigned-integer comparisons: pin that comparing a u32 / u64 /
    // u8 against a value with the high bit set uses unsigned
    // semantics (the dialect emits BinOp::Ult/Ugt/Ule/Uge for
    // those operands and reaches them through every backend).
    row("unsigned_compare.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    // On Native:
    // Static const unsigned char array indexed with 1-byte stride.
    // On Jit:
    // `static const unsigned char arr[]` with 1-byte stride. The
    // size_of_type / pointee scaling helpers strip the unsigned bit
    // before classifying, so indexing scales by 1 not 8.
    row("unsigned_char_array.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    // On Native:
    // Plain `char` follows the target's implementation-defined
    // signedness and the widening load agrees with it (C99 6.2.5p15).
    // On Jit:
    // Plain `char` follows the target's implementation-defined
    // signedness (C99 6.2.5p15) and the widening load agrees with the
    // `__CHAR_UNSIGNED__` predefine.
    row("plain_char_signedness.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    // <limits.h> CHAR_MIN/CHAR_MAX agree with that signedness (C99 5.2.4.2.1).
    row("char_limits_consistency.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    // Brace-wrapped string literal initializing a char-array struct
    // member (C99 6.7.9p14): copy the bytes, not the pointer.
    row("struct_member_brace_wrapped_string.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    // `&`/`^`/`|` result type is the common type (C99 6.5.10-12) so a
    // cast of `unsigned | int` to signed sign-extends on widening.
    row("bitop_common_type_sign_extend.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    // `~` result keeps the promoted operand type (C99 6.5.3.3p4):
    // `~(unsigned long)` stays unsigned so a following `>>` is logical.
    row("complement_preserves_type.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    // A decimal constant past the widest signed type takes the
    // unsigned type at that rank, the existing practice where C99
    // 6.4.4.1p5 lists no type.
    row("decimal_literal_over_signed_max.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    // Block-scope function declaration resolves to the file-scope
    // definition (C99 6.7p1 / 6.2.2p5).
    row("block_scope_function_declaration.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    // A struct tag in a function body has block scope (C99 6.2.1).
    row("block_scope_struct_tag.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    // On Native:
    // `+=` / `-=` on unsigned lvalues -- no pointer-style scaling.
    // On Jit:
    // Compound assignment (`+=`, `-=`) on unsigned int / long /
    // char: must NOT scale the RHS by element size (the
    // `lhs_ty > Ty::Ptr` heuristic tripped on the unsigned bit).
    row("unsigned_compound_assign.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    // On Native:
    // Exhaustive integer ops across widths + signedness.
    // On Jit:
    // Exhaustive coverage of integer ops across char/int/long
    // widths and signed/unsigned. Catches regressions in the
    // type-tag plumbing at one fixture.
    row("integer_ops_exhaustive.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64),
    // C99 6.6 leading-`-Num` in a struct-array brace entry. The
    // `parse_constant_init_value` fast-path now rewinds and uses
    // `parse_constant_int` for the whole expression so `-N * M`
    // / `-N + M` shapes fold in place instead of leaking the
    // trailing operator into the brace-list parser.
    row("init_leading_neg_arith.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // C99 6.7.8p7 array designator on a struct-array element.
    // The known-size constant-staging path now resolves
    // `[K] = {field, ...}` to element K and resumes positional
    // after the jump; missing indices stay zero (6.7.8p21).
    row("struct_array_designator.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // C99 6.7.8p6/p7 designators at every nested level of an array
    // initializer, across the top-level, deferred-size, member, and
    // compound-literal contexts (one shared struct-array walker).
    row("nested_array_designators.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // Multi-dimensional flexible array member rows filled through the
    // shared walker, sizing the object's tail per row.
    row("flexible_array_member_2d.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // C99 6.5.2.5 compound literals in constant expressions: scalar
    // literal values, subscripted array literals, `&literal.member`.
    row("compound_literal_const_exprs.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // C99 6.6p3: the not-taken arm of a constant initializer
    // conditional may hold a non-constant call; it is consumed
    // unevaluated and leaves no reference.
    row("init_cond_dead_arm.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // C99 6.5.6p9: constant pointer differences fold to the
    // element-subscript difference; a pointer cast retypes the stride.
    row("const_ptr_diff_fold.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // Constant-maximum dimension idiom: null-pointer-constant chooser
    // over a nested chooser with a statement-expression arm; nested
    // declarators must not clear the outer VLA permission.
    row("const_max_dim_stmt_expr.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // A 1024-label `case` run parses iteratively, not bounded by the
    // parser nesting limit.
    row("switch_case_label_run.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // `__builtin_has_attribute` folds to 0 with unevaluated operands.
    row("builtin_has_attribute_fold.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // `__builtin_abs` / `labs` / `llabs` fold in constant contexts.
    row("builtin_abs_const_fold.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // `strcmp` / `strncmp` / `memcmp` of two string literals fold, so a
    // literal selects a branch at translation time and the dead arms'
    // calls are never emitted.
    row("builtin_str_compare_fold.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // Constant-count `__builtin_memcpy` / `memmove` / `memset` expand
    // inline; a count past the cap falls back to the library.
    row("builtin_mem_transfer_inline.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // Every builtin equivalent to a library function keeps its meaning
    // when the unit defines a macro of that function's name, which is
    // the shape the fortified string headers compile to.
    row("builtin_library_alias_macro_shadow.c", 0)
        .unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // A trailing `packed` on a union body drops its tail padding; the
    // arms keep overlapping at offset 0.
    row("packed_union_tail_padding.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // An empty structure member contributes no storage but keeps its
    // alignment, so an `aligned(N)` empty type spaces what follows.
    row("empty_struct_member_align.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // A function designator initializes a static slot with its address
    // only when it is the whole initializer; a foldable call is a value.
    row("static_init_fn_designator.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // Deferred-size and rank-3 automatic struct arrays, constant and
    // runtime element values.
    row("auto_struct_array_multi_dim.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // C89 6.5.2 / C99 6.7.2p2 deprecated implicit-int: a decl
    // without a type specifier infers `int`. Honors
    // `f(int x) { ... }` / `g = 5;` / `main() { ... }`.
    row("implicit_int_decl.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // C99 6.10.1 + 6.5.15: `#if (cond ? then : else)` ternary in
    // a preprocessor constant expression, parenthesised + at the
    // top level. Right-associative chains (`cond ? a : b ? c : d`)
    // recurse through the else arm.
    row("pp_if_ternary.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // C99 6.7.8p7 array designator inside a struct's array-field
    // nested brace list: `.row = {[0] = 10, [2] = 30}`. Also
    // pins `__STDC_HOSTED__ == 1` per C99 6.10.8p2.
    row("array_field_designator.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // C99 6.7.5.3p7 + 6.7.5.2p1: `static` / `const` / `volatile`
    // / `restrict` inside a parameter declarator's `[`. The
    // keyword is a hint; badc skips it before parsing the
    // dimension and treats the parameter as a plain pointer
    // (matching the implicit decay rule).
    row("param_array_qualifier.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // C99 6.7.8p7 nested designator chain. `.outer.inner = v`
    // sets a sub-field at the cumulative byte offset; the
    // constant-staging path (file-scope / `static` locals) and
    // the runtime path (block-scope locals with a non-constant
    // entry) both walk the chain in one pass.
    row("nested_designator_init.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // A TU calls `printf` with no declaration in scope (C17
    // 6.5.1p2 requires one). The compiler hits the first-pass "unknown
    // function `printf`" error, looks the name up in the
    // build-time `BINDING_TO_HEADER` index, force-includes
    // `<stdio.h>` and re-runs the compile in one transparent
    // retry. Exits 0 when the auto-include path is wired up;
    // a `BuildError` on this entry means the retry regressed.
    row("auto_include_undeclared_libc.c", 0).unverified(ELF | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    // `thread_local_*.c` aren't here -- the JIT declines them, so
    // they carry an expected diagnostic in
    // `JIT_UNSUPPORTED_FIXTURES` instead of an exit code. The
    // native_elf and native_elf_x64 runners validate the Linux
    // paths once the built ELF lands on the orb VMs.
    row("packed_bitfield_repack.c", 0),
    row("nested_designator_string_member.c", 0),
    row("union_member_unbraced_init.c", 0),
    row("inline_multi_block_result_forward.c", 10),
    row("inline_multi_block_only_caller.c", 42),
    row("inline_nonleaf_const_switch.c", 0),
    row("inline_multi_block_phi_caller.c", 16),
    row("inline_const_array_field_nonnull.c", 43),
    row("addr_null_compare_defined.c", 0),
    row("enum_unsigned_compatible.c", 0),
    row("enum_wide_compatible_long.c", 0),
    row("types_compatible_fn_ptr_cast.c", 0),
    row("types_compatible_fn_ptr_object.c", 0),
    row("inline_noreturn_branch_single_return.c", 42),
    row("sxtw_fold_source_liveness.c", 18),
    row("data_reloc_one_past_end.c", 10),
    row("variadic_libc_fnptr_static_init.c", 0),
    row("block_scope_typedef_variadic_fnptr.c", 0),
    row("atomic_operand_in_working_regs.c", 0),
    row("atomic_orders.c", 0),
    row("atomic_contention.c", 0),
    row("atomic_operators_two_threads.c", 0).unverified(ELF | ELF_X64),
    row("setjmp_value_live_across.c", 0),
    row("setjmp_spill_slots_unshared.c", 0),
    row("mixed_sse_int_aggregate_args.c", 0),
    row("variadic_agg_return_classes.c", 0),
    row("va_copy_under_pressure.c", 0),
    row("variable_shift_rcx_loop.c", 0),
    row("va_arg_composite_straddle.c", 0),
    row("variadic_hfa_struct_arg.c", 0).unverified(PE_X64),
    row("variadic_hfa_va_arg.c", 0),
    row("variadic_cast_fnptr_dispatch.c", 0),
    row("fcntl_lock_via_cast_fnptr.c", 0).unverified(PE_X64 | PE_ARM64 | JIT),
    row("builtin_constant_p_deferred.c", 0),
    row("builtin_constant_p_value_kinds.c", 0),
    row("builtin_constant_p_choose_expr_init.c", 0),
    row("member_store_constant_readback.c", 0),
    row("store_bounds_readback.c", 0),
    row("inline_nested_aggregate_return.c", 0),
    row("switch_const_index_jump_table_fold.c", 0),
    row("computed_goto_label_only_target.c", 0),
    row("zero_length_array_member_marker.c", 0),
    // On Native:
    // Registered from the compile-only sweep; see the module comment.
    // On PeX64:
    // Registered from the compile-only sweep; see the module comment.
    // `syscall_ptr_table.c` has no Win32 binding for the entry point it
    // calls, and `getopt_unistd_globals.c` is out as the module comment says;
    // `sizeof_pointer_to_array_subscript.c` and
    // `zero_sign_extension_32bit.c` assert 64-bit `long`, which
    // LLP64 does not provide.
    // On Jit:
    // Registered from the compile-only sweep; see the module comment.
    row("alloca_basic.c", 0).unverified(PE_ARM64),
    row("asm_memory_barrier_forwarding.c", 0).unverified(PE_ARM64),
    row("binary_integer_literal.c", 0).unverified(PE_ARM64),
    row("call_arg_int_to_double_conversion.c", 0).unverified(PE_ARM64),
    row("call_indirect_target_scratch_collision.c", 0).unverified(PE_ARM64),
    row("clock_monotonic_advances.c", 0),
    row("compound_literal_file_scope.c", 0).unverified(PE_ARM64),
    row("compound_literal_nested_subexpr.c", 0).unverified(PE_ARM64),
    row("const_float_init_int_cast.c", 0).unverified(PE_ARM64),
    row("const_float_init_int_lead.c", 0).unverified(PE_ARM64),
    row("deferred_outer_2d_array_stride.c", 0).unverified(PE_ARM64),
    row("diagnostic_pragmas.c", 0).unverified(PE_ARM64),
    row("diagnostic_pragmas_parser.c", 0).unverified(PE_ARM64),
    row("file_scope_asm_incbin.c", 0).unverified(PE_ARM64),
    row("file_scope_asm_incbin_skip_count.c", 0).unverified(PE_ARM64),
    row("file_scope_asm_weak_set.c", 0).unverified(PE_ARM64),
    row("float_arith_in_static_init.c", 0).unverified(PE_ARM64),
    row("forward_fn_ptr_in_static_init.c", 0).unverified(PE_ARM64),
    row("function_type_typedef.c", 0).unverified(PE_ARM64),
    row("include_macro_operand.c", 0).unverified(PE_ARM64),
    row("inline_asm_a64_hvc_inout.c", 0).unverified(PE_ARM64),
    row("inline_recursive_frame_bound.c", 0).unverified(PE_ARM64),
    row("inline_volatile_callee.c", 0).unverified(PE_ARM64),
    row("int_to_float_assign_conversion.c", 0).unverified(PE_ARM64),
    row("large_struct_copy.c", 0).unverified(PE_ARM64),
    row("local_array_runtime_init.c", 0).unverified(PE_ARM64),
    row("negative_float_in_array_init.c", 0).unverified(PE_ARM64),
    row("netinet_addr_class_macros.c", 0).unverified(PE_X64 | PE_ARM64),
    row("object_macro_to_fn_macro_rescan.c", 0).unverified(PE_ARM64),
    row("pointer_to_array_struct_field.c", 0).unverified(PE_ARM64),
    row("predefined_macros_are_defined.c", 0).unverified(PE_ARM64),
    row("preinc_narrow_lvalue_wraps.c", 0).unverified(PE_ARM64),
    row("setlocale_decimal_point.c", 0)
        .unverified(PE_ARM64)
        .skip(
            JIT,
            "it runs in the test process, where its `setlocale(LC_ALL, ..)` outlives the run",
        ),
    row("sizeof_deref_array_clears_decay.c", 0).unverified(PE_ARM64),
    row("sizeof_function_call_truncation.c", 0).unverified(PE_ARM64),
    row("sizeof_pointer_to_array_subscript.c", 0).unverified(PE_X64 | PE_ARM64),
    row("static_assert_and_warning.c", 0).unverified(PE_ARM64),
    row("stdint_min_macros_type_and_value.c", 0).unverified(PE_ARM64),
    row("stdio_fgetpos_roundtrip.c", 0).unverified(PE_ARM64),
    row("symbol_inner_array_size_no_leak.c", 0).unverified(PE_ARM64),
    row("tail_call_args_from_spill.c", 0).unverified(PE_ARM64),
    row("three_dim_array_indexing.c", 0).unverified(PE_ARM64),
    row("two_d_array_param_indexing.c", 0).unverified(PE_ARM64),
    row("two_d_float_array_partial_init.c", 0).unverified(PE_ARM64),
    row("two_d_stride_no_leak_across_exprs.c", 0).unverified(PE_ARM64),
    row("unary_plus_preserves_float.c", 0).unverified(PE_ARM64),
    row("volatile_local_mem2reg.c", 0).unverified(PE_ARM64),
    row("mem2reg_escape_point.c", 0).unverified(PE_ARM64),
    row("volatile_member_store.c", 0).unverified(PE_ARM64),
    row("volatile_read_pair.c", 0).unverified(PE_ARM64),
    row("volatile_store_reload.c", 0).unverified(PE_ARM64),
    row("zero_sign_extension_32bit.c", 0).unverified(PE_X64 | PE_ARM64),
    row("const_pointer_object_fold.c", 0),
    row("const_object_member_fold.c", 0),
    row("typedef_name_label.c", 0),
    row("compound_literal_static_init.c", 1),
    row("init_padding_zero.c", 0).unverified(PE_ARM64),
    row("crit_edge_split_label_addr.c", 0),
    row("call_int_return_single_widening.c", 0),
    row("param_home_single_store.c", 42),
    row("narrow_phi_reads.c", 42),
    row("mul_add_wide_result.c", 42),
    row("sigaction_siginfo_handler.c", 0).unverified(PE_X64 | PE_ARM64 | JIT),
    row("pragma_pack_bitfield_layout.c", 0),
    row("pragma_pack_push_pop_forms.c", 0),
    row("pragma_operator_in_place.c", 0),
    row("param_named_like_function.c", 0),
    row("bitnot_promoted_compare.c", 0),
    row("packed_bitfield_struct_by_value.c", 0),
    row("addr_compare_disjoint_blocks.c", 0),
    row("unsigned_bitwise_mixed_sign.c", 0),
    row("dead_arm_static_callee.c", 0),
    row("param_incoming_reg_constant_clobber.c", 0),
    row("callee_function_types.c", 0),
    row("type_name_array_derivations.c", 0),
    row("typedef_member_types.c", 0),
    row("cast_function_pointer_to_object_pointer.c", 0),
    row("pointer_to_array_of_function_pointers.c", 0),
    row("generic_function_types.c", 0),
    row("function_returning_pointer_to_array.c", 0),
    row("array_typedef_derivations.c", 0),
    row("struct_array_member_brace_elision.c", 0),
    row("pointer_constant_arithmetic.c", 0),
    row("static_initializer_address_casts.c", 0),
    row("typeof_function_types.c", 0),
    row("comma_operator_decay.c", 0),
    row("typeof_row_bounds.c", 0),
    row("paren_array_declarator.c", 0),
    row("multidim_array_value.c", 0),
    row("enum_type_identity.c", 0),
    row("compound_assign_once.c", 0),
    row("int128_scalar_contexts.c", 0),
    row("variably_modified_type_names.c", 0),
    row("enum_used_before_definition.c", 0),
    row("tag_scopes.c", 0),
    row("empty_record_args.c", 0),
    row("tentative_definition_completed_later.c", 0),
    row("builtin_library_function_spellings.c", 0),
    row("type_name_function_of_function_pointer_typedef.c", 0),
    row("typeof_redeclaration_after_multidim_array.c", 0),
    row("inline_asm_a64_integer_ops.c", 0),
    row("inline_asm_a64_fmov_top_half.c", 42),
    row("inline_asm_a64_fmov_forms.c", 42),
    row("inline_asm_a64_sve_counts.c", 0),
    row("inline_asm_a64_sve_state.c", 0),
    row("inline_asm_a64_chained_replacements.c", 0),
    // Plain `char` is a type distinct from `signed char` and `unsigned
    // char` (C99 6.2.5p15) at the target's signedness.
    row("plain_char_distinct_type.c", 0),
    row("declared_object_copied_whole.c", 0),
    row("merged_chain_empty_edge_block.c", 0),
    row("address_retested_after_calls.c", 0),
    row("standard_streams_and_errno.c", 0),
    row("standard_streams_are_objects.c", 0),
    row("vector_arguments_and_results.c", 0),
    row("x86_simd_values_under_pressure.c", 0),
    row("vector_arithmetic_in_whole_registers.c", 0),
    row(
        "vector_comparisons_shifts_and_negation_in_whole_registers.c",
        0,
    ),
    row("vector_lanes_of_8_byte_vectors.c", 0),
    row("vector_arithmetic_in_ymm_registers.c", 0),
    row("vector_lanes_in_registers.c", 0),
    row("vector_wider_than_the_registers.c", 0),
    row("vector_shifts_by_a_vector_of_counts.c", 0),
    row("simd_rows_fold_over_constants.c", 0),
    row("vector_shufflevector_takes_the_indexed_lanes.c", 0),
    row("vector_splats.c", 0),
    row("vla_array_type.c", 0),
    row("vla_typedef_block_scope.c", 0),
    row("vla_pointer_block_scope.c", 0),
    row("vla_parameter.c", 0),
    row("vla_element_types.c", 0),
    row("vla_parameter_bounds.c", 0),
    row("packed_member_declaration.c", 0),
    row("bitfield_attribute_after_width.c", 0),
    row("bitfield_typedef_alignment.c", 0),
    row("inlined_struct_return_lifetime.c", 0),
    row("message_catalog_round_trip.c", 0).unverified(PE_X64 | PE_ARM64),
    row("strfmon_formats_in_the_c_locale.c", 0).unverified(PE_X64 | PE_ARM64),
    row("wordexp_splits_and_offsets_fields.c", 0).unverified(PE_X64 | PE_ARM64),
    row("search_tables_trees_and_queues.c", 0).unverified(JIT),
    row("fmtmsg_writes_standard_error.c", 0).unverified(PE_X64 | PE_ARM64 | JIT),
    row("ulimit_reports_the_file_size_limit.c", 0).unverified(PE_X64 | PE_ARM64 | JIT),
    row("utmpx_reads_the_accounting_database.c", 0).unverified(PE_X64 | PE_ARM64 | JIT),
    row("archive_format_constants.c", 0).unverified(PE_X64 | PE_ARM64),
    row("ndbm_store_fetch_round_trip.c", 0).unverified(PE_X64 | PE_ARM64),
    row("asm_label_names_the_assembler_symbol.c", 0),
    row("if_converted_arms.c", 0),
    row("owned_parameter_copies.c", 0),
    row("loop_invariant_loads_beside_stores.c", 0),
    row("block_scope_typedef_restores_the_outer_typedef.c", 0),
    row("attribute_alias_keeps_declared_type.c", 0).unverified(NATIVE | PE_X64 | PE_ARM64 | JIT),
    row("c99_float_math_and_vsscanf.c", 0).unverified(NATIVE | PE_X64 | PE_ARM64 | JIT),
    row("function_slot_names_no_c_definition.c", 0).unverified(NATIVE),
    row("weak_definition_not_inlined.c", 42).unverified(NATIVE | PE_X64 | PE_ARM64 | JIT),
    row("weak_alias_call_not_inlined.c", 42).unverified(NATIVE | PE_X64 | PE_ARM64 | JIT),
    row("nested_block_decl_alignment.c", 42).unverified(NATIVE | PE_X64 | PE_ARM64 | JIT),
    row("speculative_init_parse_data_rewind.c", 0).unverified(NATIVE | PE_X64 | PE_ARM64 | JIT),
    row("weak_extern_data_address.c", 0).unverified(NATIVE | PE_X64 | PE_ARM64 | JIT),
    row("stmt_expr_goto_label_value.c", 0).unverified(NATIVE),
    // Entry ParamRef placement must be a parallel copy when the
    // allocator's chosen home registers cycle with the incoming
    // argument registers (a parameter swap). The independent per-inst
    // `mov dst, arg_reg` order clobbered a source before it was read.
    row("param_reg_swap.c", 77).unverified(NATIVE | PE_X64 | PE_ARM64),
    row("tail_call_outside_return_block.c", 0)
        .unverified(NATIVE | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("fma_contraction.c", 0).unverified(NATIVE),
    row("overaligned_automatic.c", 0).unverified(NATIVE),
    row("const_addr_same_object_compare.c", 0).unverified(NATIVE),
    row("byteswap_glibc.c", 0).unverified(NATIVE | PE_X64 | PE_ARM64 | JIT),
    row("zero_length_array_sizeof.c", 0).unverified(NATIVE | ELF_X64),
    row("file_scope_asm_a64_relocs.c", 42).unverified(NATIVE | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("file_scope_asm_a64_label_diff_operand.c", 42)
        .unverified(NATIVE | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_a64_section_branches.c", 42)
        .unverified(NATIVE | ELF_X64 | PE_X64 | PE_ARM64 | JIT),
    row("clearenv_empties_the_environment.c", 0).unverified(NATIVE | PE_X64 | PE_ARM64 | JIT),
    row("fma_numeric_kernels.c", 0).unverified(NATIVE),
    row("param_incoming_reg_clobber.c", 0).unverified(NATIVE),
    row("indexed_load_store.c", 0).unverified(NATIVE),
    row("struct_field_displacement.c", 0).unverified(NATIVE),
    row("indexed_swap_shared_addr.c", 0).unverified(NATIVE),
    row("store_to_load_forward.c", 0).unverified(NATIVE),
    row("inc_dec_step_one.c", 0).unverified(NATIVE),
    row("logical_op_normalize.c", 0).unverified(NATIVE),
    // On Elf:
    // AAPCS64 returns binary128 in v0, which the caller stores whole and
    // reads back as its image; read as d0, `strtold` lands at 0.0 for any
    // power-of-two value (mantissa zero, the exponent in v0's high half).
    // On ElfX64:
    // SysV x86_64 returns `long double` in x87 st(0); c5 stores
    // it as FP64. The codegen emits an `fstp QWORD PTR [rsp]`
    // post-call to narrow st(0) to FP64. The fixture locks the
    // round-trip in -- regressions surface as `strtold` landing
    // on stale xmm0 garbage instead of the parsed value.
    row("strtold_aapcs_return.c", 0).unverified(NATIVE | PE_X64 | PE_ARM64 | JIT),
    row("vfork_shared_stack_slot_reuse.c", 0).unverified(NATIVE | PE_X64 | PE_ARM64 | JIT),
    // Registered from the compile-only sweep; see the module comment.
    row("aarch64_hwcap_auxv.c", 0).unverified(NATIVE | PE_X64 | PE_ARM64 | JIT),
    row("epoll_event_array_readback.c", 0).unverified(NATIVE | PE_X64 | PE_ARM64 | JIT),
    row("x86_simd_intrinsics.c", 0).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_catalog.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_paren_disp.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_seg_prefix_wrpkru.c", 42)
        .unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_crc32.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_label_directive.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_sse.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_setcc.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_cmov.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_bound_operands.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_bound_scratch_pressure.c", 42).unverified(NATIVE | ELF | PE_ARM64 | JIT),
    row("inline_asm_x64_cdqe.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_movnti.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_raid6_syndrome.c", 0).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_clflush.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_setjmp_label.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_setjmp_region_slices.c", 42)
        .unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_stream_branches.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_sp_callee_regions.c", 0).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_mem_disp.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_m_global_call.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("ms_abi_firmware_boundary.c", 0).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_riprel_addr_const.c", 42)
        .unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("cpuid_partial_outputs.c", 0).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("cpuid_xgetbv_output_width.c", 0).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("get_cpuid_leaf_checks.c", 0).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_imm_mem.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_flags_push.c", 0).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_m_operand_array_cast.c", 0).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_const_expr.c", 0).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_constraint_a.c", 0).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_string_ops.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_callee_saved_operands.c", 0)
        .unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_callee_saved_preserved.c", 0)
        .unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_staged_operand_pool.c", 0)
        .unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("register_var_asm_operand.c", 0).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("register_var_asm_operand_sp.c", 0).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("register_var_asm_operand_split.c", 0).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("register_var_asm_operand_r11.c", 0).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("register_var_asm_operand_r10.c", 0).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("attribute_alias_target_later.c", 0).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_sib.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_sib_nobase.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_port_dx.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_c_mem.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_seg_c_mem.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_seg_c_percpu.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_sym_riprel.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_seg_percpu_accessor.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("seg_gs_lvalue_spellings.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("seg_gs_aggregate_copy.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_align.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_align_above_section.c", 42)
        .unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("file_scope_asm_local_label_branch.c", 42)
        .unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_flag_outputs.c", 42).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("sysv_abi_call_clobbers.c", 0).unverified(NATIVE | ELF | PE_ARM64 | JIT),
    row("ms_abi_caller_of_sysv_pointer.c", 0).unverified(NATIVE | ELF | PE_ARM64 | JIT),
    row("ms_abi_caller_of_sysv_pointer_args.c", 0).unverified(NATIVE | ELF | PE_ARM64 | JIT),
    row("call_conv_block_scope.c", 0).unverified(NATIVE | ELF | PE_ARM64 | JIT),
    row("call_conv_declarator_positions.c", 0).unverified(NATIVE | ELF | PE_ARM64 | JIT),
    row("call_conv_of_result_types.c", 0).unverified(NATIVE | ELF | PE_ARM64 | JIT),
    row("call_conv_typedef_scopes.c", 0).unverified(NATIVE | ELF | PE_ARM64 | JIT),
    row("call_conv_of_derived_types.c", 0).unverified(NATIVE | ELF | PE_ARM64 | JIT),
    row("call_conv_derived_calls_keep_values.c", 0).unverified(NATIVE | ELF | PE_ARM64 | JIT),
    row("call_conv_across_scopes.c", 0).unverified(NATIVE | ELF | PE_ARM64 | JIT),
    row("sysv_abi_tail_call.c", 0).unverified(NATIVE | ELF | PE_ARM64 | JIT),
    row("x87_control_word.c", 0).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    // A dynamic import binds its library's default symbol version
    // (`.gnu.version_r`), not the oldest definition of the name. The
    // pthread_cond_init + CLOCK_MONOTONIC sequence returns EINVAL under
    // glibc's old @GLIBC_2.2.5 stub and 0 under the @@GLIBC_2.3.2
    // default.
    row("elf_symbol_version_default.c", 0).unverified(NATIVE | ELF | PE_X64 | PE_ARM64 | JIT),
    row("inline_asm_x64_pd_x87_moves.c", 0).unverified(NATIVE | ELF | PE_ARM64 | JIT),
    row("avx_halves_and_casts.c", 0).unverified(NATIVE | ELF | PE_ARM64 | JIT),
    row("crt_initializer_tables_run.c", 0).unverified(NATIVE | ELF | ELF_X64 | JIT),
    row("tls_callbacks_run.c", 0).unverified(NATIVE | ELF | ELF_X64 | JIT),
    row("constructor_table_entry_names_its_slot.c", 0).unverified(NATIVE | ELF | ELF_X64 | JIT),
    row("environ_address_names_the_vector.c", 0)
        .unverified(NATIVE | ELF | ELF_X64 | PE_ARM64 | JIT),
    row("isa_availability_follows_cpuid.c", 0).unverified(NATIVE | ELF | ELF_X64 | JIT),
    row("interlocked_functions_out_of_line.c", 0).unverified(NATIVE | ELF | ELF_X64 | JIT),
    row("ucrt_entry_point_without_its_header.c", 0).unverified(NATIVE | ELF | ELF_X64 | JIT),
    row("winmain_command_line.c", 0).unverified(NATIVE | ELF | ELF_X64 | JIT),
    row("wwinmain_command_line.c", 0).unverified(NATIVE | ELF | ELF_X64 | JIT),
    row("spawn_nowait_handle_is_pointer_sized.c", 0).unverified(NATIVE | ELF | ELF_X64 | JIT),
    row("ucrt_stdlib_declares_sort_types_and_errno.c", 0).unverified(NATIVE | ELF | ELF_X64 | JIT),
    row("windows_alloca_comes_from_malloc_h.c", 0).unverified(NATIVE | ELF | ELF_X64 | JIT),
    row("undeclared_library_calls_keep_the_header_types.c", 0)
        .unverified(NATIVE | ELF | ELF_X64 | JIT),
    row("windows_unwind_api_walks_to_the_caller.c", 0).unverified(NATIVE | ELF | ELF_X64 | JIT),
    row("intsafe_conversions_and_arithmetic.c", 0).unverified(NATIVE | ELF | ELF_X64 | JIT),
    row("crt_integer_strings_heap_locale_and_class_masks.c", 0)
        .unverified(NATIVE | ELF | ELF_X64 | JIT),
    row("wide_eof_returned_by_the_c_runtime.c", 0).unverified(NATIVE | ELF | ELF_X64 | JIT),
    row("stat_fills_the_runtime_layout.c", 0).unverified(NATIVE | ELF | ELF_X64 | JIT),
    row("gdi_draws_into_a_dib_section.c", 0).unverified(NATIVE | ELF | ELF_X64 | JIT),
    row("mbcs_strings_step_by_double_byte_characters.c", 0)
        .unverified(NATIVE | ELF | ELF_X64 | JIT),
    row("win32_generic_names_take_the_ansi_forms.c", 0).unverified(NATIVE | ELF | ELF_X64 | JIT),
    row("tchar_bounds_checked_names_reach_the_runtime.c", 0)
        .unverified(NATIVE | ELF | ELF_X64 | JIT),
    row("wide_string_functions_of_string_h_reach_the_runtime.c", 0)
        .unverified(NATIVE | ELF | ELF_X64 | JIT),
    row("stdlib_minmax_and_wcreate_locale_follow_the_ucrt.c", 0)
        .unverified(NATIVE | ELF | ELF_X64 | JIT),
    row("winsock_servent_and_hostent.c", 0).unverified(NATIVE | ELF | ELF_X64 | JIT),
    // On PeX64:
    // Windows x86_64 alignment of `_setjmp`: the header's macro
    // wrapper must align the env pointer up to 16 bytes so the
    // `movdqa` saves of xmm6..xmm15 don't AV. msvcrt's `longjmp`
    // unwinds to the frame `_setjmp` stored through each frame's
    // unwind record.
    // On PeArm64:
    // Windows AArch64 setjmp / longjmp: msvcrt's `_setjmpex` stores the
    // frame the unwinder reports for its caller, and its `longjmp`
    // unwinds to it through each frame's unwind record.
    row("setjmp_basic_stack.c", 0).unverified(NATIVE | ELF | ELF_X64 | JIT),
    row("setjmp_misaligned.c", 0).unverified(NATIVE | ELF | ELF_X64 | JIT),
    row("setjmp_longjmp.c", 0).unverified(NATIVE | ELF | ELF_X64 | JIT),
    row("inline_asm_section_label.c", 42).unverified(NATIVE | ELF | ELF_X64 | PE_ARM64 | JIT),
    row("msvc_pragma_operator_in_place.c", 0).unverified(NATIVE | ELF | ELF_X64 | JIT),
    row("struct_arg_value_form_inline.c", 0).unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("mem2reg_cross_block.c", 42).unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("mem2reg_addr_taken_neighbor.c", 42).unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("mem2reg_i64_local.c", 84).unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("mem2reg_narrow_store_trunc.c", 0).unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("mem2reg_unsigned_narrow.c", 0).unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("mem2reg_value_across_call.c", 33).unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("inline_forward_ref_value.c", 0).unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("natural_width_local.c", 0).unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("return_value_in_callee_saved.c", 7).unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("divmod_preserves_rdx.c", 0).unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("commutative_imm_lhs_swap.c", 0).unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("comparison_imm_lhs_swap.c", 0).unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("binop_imm_chain_fold.c", 0).unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("binop_spill_lhs_rhs_in_dst.c", 59).unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("mul_pow2_to_shift.c", 0).unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("int32_sign_extend_elision.c", 0).unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("arg_register_cycle.c", 0).unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("indirect_call_six_args_spilled_target.c", 0)
        .unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("scalar_compound_literal_lvalue.c", 0)
        .unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("static_function_pointer_identity.c", 0)
        .unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("file_scope_typeof.c", 0).unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
    // VaArg rd/ap register-aliasing fix: the dst register and the
    // `&ap` source register can land on the same physical reg;
    // without the fix the second and later va_arg reads return the
    // same garbage. `show` prints `first n=3 v[0]=11 v[1]=22
    // v[2]=33`, which the fixture's main does not check directly --
    // pin via the exit status (0).
    row("va_arg_int_seq.c", 0).unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
    // VaStart + VaCopy emit shapes where the allocator places
    // `&last` (VaStart) or `&src` / `&dst` (VaCopy) on r10. The
    // prior emit used SCRATCH_R10 as the staging register and
    // produced a load through a stale operand when r10 aliased
    // an operand; the fix routes through r13 (outside both
    // `caller_gprs` and `callee_gprs`).
    row("ssa_va_start_va_copy_aliasing.c", 0)
        .unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("volatile_pointee_not_pointer_cell.c", 0)
        .unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("volatile_pointer_object_cell.c", 0).unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("volatile_fn_pointer_declarator.c", 0)
        .unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
    row("generic_selection_volatile.c", 0).unverified(NATIVE | ELF | ELF_X64 | PE_X64 | PE_ARM64),
];

/// How many of [`FIXTURES`] run on `runner`.
const fn count(runner: u8) -> usize {
    let (mut i, mut n) = (0, 0);
    while i < FIXTURES.len() {
        if FIXTURES[i].runs_on(runner) {
            n += 1;
        }
        i += 1;
    }
    n
}

/// The rows of [`FIXTURES`] that run on `runner`, as the runners read them.
const fn on<const LEN: usize>(runner: u8) -> [(&'static str, i32); LEN] {
    let mut out = [("", 0); LEN];
    let (mut i, mut n) = (0, 0);
    while i < FIXTURES.len() {
        if FIXTURES[i].runs_on(runner) {
            out[n] = (FIXTURES[i].name, FIXTURES[i].exit);
            n += 1;
        }
        i += 1;
    }
    out
}

/// Native-runnable subset of the fixture suite. Each entry is the
/// fixture's filename plus the exit code it yields under the VM
/// (cross-checked in `tests::programs`).
///
/// Fixtures that need argv, a CWD-relative input file, or an env var
/// set by the harness are exercised by their own `*_natively` tests
/// (see `file_io_natively`, `getenv_value_natively`,
/// `original_c4_compiles_and_runs_hello_natively`). Everything else
/// that runs the same way on both backends lives in the table below.
///
/// The remaining excluded fixtures are the **safety-net checks**
/// (`oob_*`, `mprotect_blocks_*`, `forge_code_pointer`,
/// `use_after_free`, `double_free`, `negative_size_memset`,
/// `code_as_data`, `memcpy_oob_*`, `memset_oob`). The VM has dedicated
/// guards that exit -1 on a violation; the native binary either hits
/// the OS's protections (SIGSEGV / SIGABRT) or silently smashes
/// memory and exits 0, so the two backends genuinely diverge by
/// design.
///
/// String literals flow through __DATA via `DataFixup` and function
/// pointers resolve to native offsets via `FuncFixup`, so fixtures
/// that exercise those paths run end-to-end.
pub(super) const NATIVE_FIXTURES: &[(&str, i32)] = &on::<{ count(NATIVE) }>(NATIVE);

/// The fixtures the `native_elf` runner takes.
pub(super) const NATIVE_ELF_FIXTURES: &[(&str, i32)] = &on::<{ count(ELF) }>(ELF);

/// The fixtures the `native_elf_x64` runner takes.
pub(super) const NATIVE_ELF_X64_FIXTURES: &[(&str, i32)] = &on::<{ count(ELF_X64) }>(ELF_X64);

/// Subset of the cross-arch fixture corpus that doesn't lean on
/// POSIX-only semantics.
pub(super) const NATIVE_PE_X64_FIXTURES: &[(&str, i32)] = &on::<{ count(PE_X64) }>(PE_X64);

/// Same fixture set as `native_pe_x64`, since the Windows-flavored
/// limitations (POSIX-only setenv shape, dlopen-against-libc-soname)
/// are arch-independent.
pub(super) const NATIVE_PE_ARM64_FIXTURES: &[(&str, i32)] = &on::<{ count(PE_ARM64) }>(PE_ARM64);

/// The fixtures the `jit` runner takes.
pub(super) const JIT_FIXTURES: &[(&str, i32)] = &on::<{ count(JIT) }>(JIT);

/// Fixtures not yet run on each runner, in the order of the masks. A row
/// that adds one says so here; a row that is shown to run takes one away.
const UNVERIFIED: [(u8, usize); 6] = [
    (NATIVE, 160),
    (ELF, 311),
    (ELF_X64, 372),
    (PE_X64, 605),
    (PE_ARM64, 630),
    (JIT, 440),
];

/// Fixtures the JIT declines rather than runs, so the exit-code tables
/// above cannot express them. Each must fail to load with a diagnostic
/// naming the construct; `super::jit::unsupported_fixtures_are_refused`
/// drives them. A construct that gains JIT support moves to
/// [`JIT_FIXTURES`] with its expected exit code.
pub(super) const JIT_UNSUPPORTED_FIXTURES: &[(&str, &str)] = &[
    ("thread_local_reads_a_code_slot.c", "thread-local storage"),
    (
        "thread_local_slot_escapes_a_function.c",
        "thread-local storage",
    ),
    (
        "weak_thread_local_definition_by_symbol.c",
        "thread-local storage",
    ),
    // The executing thread's TLS block belongs to the host runtime, so a
    // thread-pointer-relative access has nothing to reach.
    ("block_scope_thread_local.c", "thread-local storage"),
    ("deferred_jit_thread_local.c", "thread-local storage"),
    ("thread_local_address_init.c", "thread-local storage"),
    (
        "thread_local_fn_pointer_defined_later.c",
        "thread-local storage",
    ),
    (
        "thread_local_library_function_slot.c",
        "thread-local storage",
    ),
    ("thread_local_address_per_thread.c", "thread-local storage"),
    ("thread_local_basic.c", "thread-local storage"),
    ("thread_local_gnu.c", "thread-local storage"),
    ("thread_local_initializer.c", "thread-local storage"),
    ("thread_local_object_alignment.c", "thread-local storage"),
    ("thread_local_image_alignment.c", "thread-local storage"),
    ("thread_local_tentative_array.c", "thread-local storage"),
    (
        "thread_local_tentative_completed_later.c",
        "thread-local storage",
    ),
    ("thread_local_block_static_shadow.c", "thread-local storage"),
    ("thread_local_zero_images.c", "thread-local storage"),
    (
        "thread_local_aggregate_initializers.c",
        "thread-local storage",
    ),
    ("block_scope_object_alignment.c", "thread-local storage"),
    ("thread_local_per_thread.c", "thread-local storage"),
];

/// Fixtures whose exit codes rest on behavior badc defines past GNU C, so no
/// reference compiler derives them. GNU C requires each `asm` statement to
/// leave sp as it found it; badc's frames follow one that leaves it moved
/// (`Frame::dynamic_sp`), a stack switch spanning statements or a statement
/// that lists sp as clobbered. badc's `math_errhandling` is `MATH_ERREXCEPT`
/// on every target, where glibc's adds `MATH_ERRNO`. Every backend runs
/// these at -O0 and -O.
pub(super) const BADC_FIXTURES: &[(&str, i32)] = &[
    ("inline_asm_stack_switch_spill.c", 0),
    ("inline_asm_declared_sp_clobber.c", 0),
    ("inline_asm_leaf_sp_clobber.c", 0),
    ("math_errhandling_is_floating_exceptions.c", 0),
];

/// Every table above, named so a failure points at the stale entry's table.
fn registration_tables() -> &'static [(&'static str, &'static [(&'static str, i32)])] {
    &[
        ("BADC_FIXTURES", BADC_FIXTURES),
        ("NATIVE_FIXTURES", NATIVE_FIXTURES),
        ("NATIVE_ELF_FIXTURES", NATIVE_ELF_FIXTURES),
        ("NATIVE_ELF_X64_FIXTURES", NATIVE_ELF_X64_FIXTURES),
        ("NATIVE_PE_X64_FIXTURES", NATIVE_PE_X64_FIXTURES),
        ("NATIVE_PE_ARM64_FIXTURES", NATIVE_PE_ARM64_FIXTURES),
        ("JIT_FIXTURES", JIT_FIXTURES),
    ]
}

/// A registration whose fixture is gone is otherwise inert, so a
/// fixture and its registration can both be lost unnoticed. The
/// converse is not an error: `tests/cli_fixture_smoke.rs` sweeps the
/// directory, so a fixture no table names is still compiled.
#[test]
fn every_registered_fixture_exists() {
    let mut missing: Vec<String> = Vec::new();
    let mut checked = 0usize;
    for (table, entries) in registration_tables() {
        assert!(!entries.is_empty(), "{table} is empty");
        for (name, _) in *entries {
            checked += 1;
            if !super::fixture_path(name).exists() {
                missing.push(format!("{table}: {name}"));
            }
        }
    }
    for (name, _) in JIT_UNSUPPORTED_FIXTURES {
        checked += 1;
        if !super::fixture_path(name).exists() {
            missing.push(format!("JIT_UNSUPPORTED_FIXTURES: {name}"));
        }
    }
    assert!(
        missing.is_empty(),
        "{} of {} fixture registrations name a file absent from tests/fixtures/c:\n  {}",
        missing.len(),
        checked,
        missing.join("\n  ")
    );
}

/// Names in a row commented out of a table above. A disabled row is
/// invisible to [`every_registered_fixture_exists`] -- the compiler
/// never sees it -- so the fixture it names can be renamed or deleted
/// while the row stays behind describing a file that no longer exists.
fn disabled_registrations(source: &str) -> Vec<(usize, String)> {
    let mut found = Vec::new();
    for (i, line) in source.lines().enumerate() {
        let Some(rest) = line.trim_start().strip_prefix("//") else {
            continue;
        };
        let rest = rest.trim_start();
        let Some(rest) = (rest.strip_prefix("row(\"")).or_else(|| rest.strip_prefix("(\"")) else {
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

/// Hold every disabled row to the same existence rule as a live one, so
/// a row parked for a known interaction cannot rot into one that names
/// nothing. Zero disabled rows is a valid state.
#[test]
fn every_disabled_registration_names_a_fixture() {
    let rows = disabled_registrations(include_str!("fixture_tables.rs"));
    let missing: Vec<String> = rows
        .iter()
        .filter(|(_, name)| !super::fixture_path(name).exists())
        .map(|(line, name)| format!("line {line}: {name}"))
        .collect();
    assert!(
        missing.is_empty(),
        "{} of {} disabled registrations name a file absent from tests/fixtures/c:\n  {}",
        missing.len(),
        rows.len(),
        missing.join("\n  ")
    );
}

/// A fixture has one row: a second would let two statuses stand.
#[test]
fn no_fixture_is_listed_twice() {
    let mut names: Vec<&str> = FIXTURES.iter().map(|f| f.name).collect();
    names.sort_unstable();
    let twice: Vec<&&str> = (names.windows(2).filter(|w| w[0] == w[1]).map(|w| &w[0])).collect();
    assert!(twice.is_empty(), "listed twice: {twice:?}");
}

/// A row keeps a fixture off a runner either for a stated reason or
/// because no one has run it there, and the second kind is counted: a new
/// row that adds to a count, or a fixture shown to run that takes from it,
/// changes [`UNVERIFIED`] in the same commit.
#[test]
fn the_unverified_counts_are_the_pinned_ones() {
    for (runner, pinned) in UNVERIFIED {
        let n = (FIXTURES.iter())
            .filter(|f| f.unverified & runner != 0)
            .count();
        assert_eq!(n, pinned, "runner mask {runner:#x}");
    }
    for f in FIXTURES {
        let (runners, why) = f.skipped;
        assert_eq!(
            runners == 0,
            why.is_empty(),
            "{}: a skip states its reason",
            f.name
        );
        assert_eq!(
            f.unverified & runners,
            0,
            "{}: unverified and skipped",
            f.name
        );
    }
}
