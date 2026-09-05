use super::*;

#[cfg(test)]
mod asm_scratch_tests {
    use super::super::super::ir::{AsmBlock, AsmConstraint, AsmOperand, AsmSeg};
    use super::*;

    fn asm_func(template: &str) -> FunctionSsa {
        let asm = AsmBlock {
            template: template.as_bytes().to_vec(),
            operands: alloc::vec![AsmOperand {
                constraint: AsmConstraint::Reg,
                is_output: false,
                is_rw: false,
                width: 8,
                seg: AsmSeg::None,
            }],
            clobber_regs: 0,
            clobber_fp_regs: 0,
            clobber_memory: true,
            volatile: true,
        };
        FunctionSsa {
            insts: alloc::vec![
                Inst::Imm(0),
                Inst::InlineAsm {
                    asm: alloc::boxed::Box::new(asm),
                    args: alloc::vec![0],
                },
            ],
            ..Default::default()
        }
    }

    /// A no-op template reserves no frame scratch; the same statement
    /// with one instruction reserves the operand's save + capture slots.
    #[test]
    fn noop_template_needs_no_scratch() {
        assert_eq!(
            asm_scratch_bytes(&asm_func(""), crate::c5::codegen::FixedRegs::NONE),
            0
        );
        assert_eq!(
            asm_scratch_bytes(
                &asm_func("/* note */ ;"),
                crate::c5::codegen::FixedRegs::NONE
            ),
            0
        );
        assert!(asm_scratch_bytes(&asm_func("nop"), crate::c5::codegen::FixedRegs::NONE) > 0);
    }
}

#[cfg(test)]
mod scratch_picker_tests {
    use super::*;

    #[test]
    fn pick_returns_some_when_no_operands() {
        // rd = rdi (outside the pool) and no operands: the helper
        // returns the first preference (rax) per the
        // CALLER_SAVED_INT_SCRATCHES ordering [0, 1, 2, 8, 9].
        assert_eq!(
            pick_caller_saved_scratch(Reg(7), &[], crate::c5::codegen::FixedRegs::NONE),
            Some(Reg(0))
        );
    }

    #[test]
    fn pick_skips_rd() {
        // rd = rax forces the helper past the first preference;
        // the next entry (rcx) wins.
        assert_eq!(
            pick_caller_saved_scratch(Reg(0), &[], crate::c5::codegen::FixedRegs::NONE),
            Some(Reg(1))
        );
    }

    #[test]
    fn pick_skips_operand_regs() {
        // rd = rax, operands hold rcx (1) -> rdx (2) wins.
        assert_eq!(
            pick_caller_saved_scratch(Reg(0), &[Reg(1)], crate::c5::codegen::FixedRegs::NONE),
            Some(Reg(2))
        );
    }

    #[test]
    fn pick_returns_none_when_pool_exhausted() {
        // The candidate pool is CALLER_SAVED_INT_SCRATCHES = [0, 1, 2,
        // 8, 9]. Excluding all five via rd + 4 operands forces the
        // fallthrough. The helper must return None so callers bail
        // rather than fall through to a callee-saved or reserved
        // scratch register.
        let rd = Reg(0);
        let operands = [Reg(1), Reg(2), Reg(8), Reg(9)];
        assert_eq!(
            pick_caller_saved_scratch(rd, &operands, crate::c5::codegen::FixedRegs::NONE),
            None
        );
    }

    #[test]
    fn pick_returns_none_when_every_candidate_in_operands() {
        // rd is outside the pool entirely (rdi = 7); every entry of
        // CALLER_SAVED_INT_SCRATCHES is in the operand list. Helper
        // must return None.
        let rd = Reg(7);
        let operands = [Reg(0), Reg(1), Reg(2), Reg(8), Reg(9)];
        assert_eq!(
            pick_caller_saved_scratch(rd, &operands, crate::c5::codegen::FixedRegs::NONE),
            None
        );
    }
}

#[cfg(test)]
mod mul_add_tests {
    use super::*;
    use alloc::vec::Vec;

    /// `(dst, src)` of the sole `imul r64, r/m64` (REX.W 0F AF /r).
    fn imul_regs(code: &[u8]) -> (u8, u8) {
        for i in 0..code.len().saturating_sub(3) {
            if code[i] & 0xF8 == 0x48 && code[i + 1] == 0x0f && code[i + 2] == 0xaf {
                return rex_modrm(code[i], code[i + 3]);
            }
        }
        panic!("no imul in {code:02x?}");
    }

    /// `(src, dst)` of an ALU `r/m64, r64` form (REX.W <op> /r), which
    /// is how the pair's `add` (01) and `sub` (29) encode.
    fn alu_regs(code: &[u8], opcode: u8) -> (u8, u8) {
        for i in 0..code.len().saturating_sub(2) {
            if code[i] & 0xF8 == 0x48 && code[i + 1] == opcode && code[i + 2] >= 0xc0 {
                return rex_modrm(code[i], code[i + 2]);
            }
        }
        panic!("no {opcode:02x} form in {code:02x?}");
    }

    /// ModR/M register-direct fields widened by the REX prefix, as
    /// `(reg, rm)`.
    fn rex_modrm(rex: u8, modrm: u8) -> (u8, u8) {
        (
            ((modrm >> 3) & 7) | ((rex >> 2) & 1) << 3,
            (modrm & 7) | ((rex & 1) << 3),
        )
    }

    /// Lower one `MulAdd` with the places the caller pins. `a_dies`
    /// makes this instruction the last reader of `a`; `b` always
    /// outlives it.
    fn lower(
        neg_product: bool,
        dst: Place,
        pa: Place,
        pb: Place,
        pc: Place,
        a_dies: bool,
    ) -> Vec<u8> {
        let target = Target::LinuxX64;
        let program = crate::Compiler::with_target(
            "long long f(long long a, long long b, long long c){ return c - a*b; } \
             int main(void){ return 0; }"
                .into(),
            target,
        )
        .compile()
        .expect("compile");
        let mut funcs =
            crate::c5::codegen::ssa::shadow::produce_ssa_funcs(&program, target, false, true)
                .expect("ssa");
        crate::c5::codegen::passes::mul_add::run(&mut funcs);
        let func = funcs
            .into_iter()
            .find(|f| {
                f.insts
                    .iter()
                    .any(|i| matches!(i, crate::c5::ir::Inst::MulAdd { .. }))
            })
            .expect("a function with a MulAdd");
        let (v, a, b, c) = func
            .insts
            .iter()
            .enumerate()
            .find_map(|(v, i)| match i {
                crate::c5::ir::Inst::MulAdd { a, b, c, .. } => {
                    Some((v as crate::c5::ir::ValueId, *a, *b, *c))
                }
                _ => None,
            })
            .expect("MulAdd operands");
        let mut alloc = super::super::ssa::reg_alloc::allocate(
            &func,
            target,
            crate::c5::codegen::FixedRegs::NONE,
        );
        alloc.places[a as usize] = pa;
        alloc.places[b as usize] = pb;
        alloc.places[c as usize] = pc;
        alloc.places[v as usize] = dst;
        alloc.last_use[a as usize] = if a_dies { v } else { v + 1 };
        alloc.last_use[b as usize] = v + 1;
        alloc.spill_count = alloc.spill_count.max(4);
        let frame = compute_frame(&func, &alloc, target.abi());
        let mut code = Vec::new();
        assert!(
            emit_mul_add(&mut code, dst, v, a, b, c, neg_product, &alloc, frame).is_ok(),
            "emit_mul_add bailed",
        );
        code
    }

    /// `c + a*b` with the addend outside the destination multiplies
    /// straight into the destination: no staging through the fixed
    /// scratch, and the add reads the addend's own register.
    #[test]
    fn add_form_multiplies_into_the_destination() {
        let code = lower(
            false,
            Place::IntReg(3),
            Place::IntReg(0),
            Place::IntReg(1),
            Place::IntReg(2),
            false,
        );
        assert_eq!(imul_regs(&code).0, 3, "product lands in rd: {code:02x?}");
        assert_eq!(alu_regs(&code, 0x01), (2, 3), "add rd, c: {code:02x?}");
    }

    /// `c - a*b` keeps the destination for the addend, so the product
    /// takes a multiplicand's own register when this instruction is
    /// that value's last reader.
    #[test]
    fn sub_form_reuses_a_dying_multiplicand() {
        let dst = Place::IntReg(3);
        let code = lower(
            true,
            dst,
            Place::IntReg(0),
            Place::IntReg(1),
            Place::IntReg(2),
            true,
        );
        let (product, _) = imul_regs(&code);
        assert_eq!(product, 0, "product reuses the dying operand: {code:02x?}");
        assert_eq!(
            alu_regs(&code, 0x29),
            (0, 3),
            "sub rd, product: {code:02x?}"
        );
    }

    /// With both multiplicands live past the instruction the product
    /// has to go to the fixed scratch, which no allocator value uses.
    #[test]
    fn sub_form_falls_back_to_the_fixed_scratch() {
        let code = lower(
            true,
            Place::IntReg(3),
            Place::IntReg(0),
            Place::IntReg(1),
            Place::IntReg(2),
            false,
        );
        let (product, _) = imul_regs(&code);
        assert_eq!(product, SCRATCH_R11.0, "product in r11: {code:02x?}");
        assert_eq!(alu_regs(&code, 0x29), (SCRATCH_R11.0, 3), "sub rd, r11");
    }

    /// The add form with a spilled destination multiplies into the
    /// scratch the destination borrows, so the spilled addend must
    /// reload somewhere else or the product is lost.
    #[test]
    fn add_form_spilled_destination_keeps_the_product() {
        let code = lower(
            false,
            Place::Spill(3),
            Place::Spill(0),
            Place::Spill(1),
            Place::Spill(2),
            false,
        );
        let (product, _) = imul_regs(&code);
        let (addend, dst) = alu_regs(&code, 0x01);
        assert_eq!(product, dst, "the product is the add's destination");
        assert_ne!(addend, product, "the addend reload spared the product");
    }

    /// A spilled destination routes through the other fixed scratch
    /// and stores; the product still avoids the addend's register.
    #[test]
    fn spilled_destination_stores_the_result() {
        let code = lower(
            true,
            Place::Spill(3),
            Place::Spill(0),
            Place::Spill(1),
            Place::Spill(2),
            false,
        );
        let (product, _) = imul_regs(&code);
        assert_eq!(product, SCRATCH_R11.0, "product in r11: {code:02x?}");
        assert_eq!(
            alu_regs(&code, 0x29),
            (SCRATCH_R11.0, SCRATCH_R10.0),
            "sub r10, r11: {code:02x?}",
        );
    }
}

#[cfg(test)]
mod relax_branches_tests {
    use super::*;

    // jmp form: long_size 5; jcc form: long_size 6. Short form is 2
    // bytes; displacement is measured from the byte after the 2-byte
    // short instruction to the target offset.

    #[test]
    fn near_forward_branch_shortens() {
        // Single jmp at offset 0 to a block 100 bytes ahead: short rel
        // = 100 - 2 = 98, within i8.
        let short = relax_branches(&[(0, 5, 1, false)], &[0, 100]);
        assert_eq!(short, vec![true]);
    }

    #[test]
    fn far_forward_branch_stays_long() {
        // Target 200 bytes ahead: short rel = 198, out of i8 range.
        let short = relax_branches(&[(0, 5, 1, false)], &[0, 200]);
        assert_eq!(short, vec![false]);
    }

    #[test]
    fn backward_branch_shortens() {
        // jmp at offset 50 back to offset 0: short rel = 0 - 52 = -52.
        let short = relax_branches(&[(50, 5, 0, false)], &[0, 50]);
        assert_eq!(short, vec![true]);
    }

    #[test]
    fn forward_boundary_127_shortens_128_does_not() {
        // Short instr ends at offset 2; target 129 -> rel 127 (fits),
        // target 130 -> rel 128 (does not).
        assert_eq!(relax_branches(&[(0, 5, 1, false)], &[0, 129]), vec![true]);
        assert_eq!(relax_branches(&[(0, 5, 1, false)], &[0, 130]), vec![false]);
    }

    #[test]
    fn cascade_inner_shortening_brings_outer_into_range() {
        // branch0 (offset 0) targets block 2 at 132; branch1 (offset 5)
        // targets block 1 at 10 and shortens first (rel 3), removing 3
        // bytes before branch0's target. branch0's short rel then
        // becomes 132 - 3 - 2 = 127 -> fits. A single all-long pass
        // (rel 130) would have missed branch0.
        let short = relax_branches(&[(0, 5, 2, false), (5, 5, 1, false)], &[0, 10, 132]);
        assert_eq!(short, vec![true, true]);
        // One more byte of distance defeats the cascade for branch0.
        let short = relax_branches(&[(0, 5, 2, false), (5, 5, 1, false)], &[0, 10, 133]);
        assert_eq!(short, vec![false, true]);
    }

    #[test]
    fn pinned_branch_keeps_the_long_form() {
        // An inline-asm template branch is emitted before relaxation runs, so
        // it stays long however close its target is.
        let short = relax_branches(&[(0, 5, 1, true)], &[0, 10]);
        assert_eq!(short, vec![false]);
        // Its bytes still count for the branches around it.
        let short = relax_branches(&[(0, 5, 1, true), (5, 5, 2, false)], &[0, 10, 20]);
        assert_eq!(short, vec![false, true]);
    }

    #[test]
    fn jcc_long_size_six_removes_four_bytes() {
        // A shortened jcc removes 4 bytes (6 -> 2). Two jccs whose
        // combined 8-byte saving brings a third into range.
        // block layout: b0@0, b1@4, b2@8, b3@140.
        // branch0@0 -> b3(140): all-long rel 138; after the two inner
        // jccs shorten (save 8), rel = 140 - 8 - 2 = 130 -> still out.
        let short = relax_branches(
            &[(0, 6, 3, false), (8, 6, 1, false), (16, 6, 2, false)],
            &[0, 4, 8, 140],
        );
        assert!(short[1]);
        assert!(short[2]);
        assert!(!short[0]);
        // Pull the target in by 3 so the saving is enough: 134 - 8 - 2 = 124.
        let short = relax_branches(
            &[(0, 6, 3, false), (8, 6, 1, false), (16, 6, 2, false)],
            &[0, 4, 8, 134],
        );
        assert!(short[0]);
    }
}

#[cfg(test)]
mod code_mode_tests {
    use alloc::vec::Vec;

    /// Bytes a file-scope asm stream assembles to, in section order.
    fn assemble(text: &str) -> Vec<u8> {
        assemble_relocs(text).0
    }

    /// One relocation as `(offset, width, signed, symbol, addend)`.
    type Reloc = (u32, u8, bool, alloc::string::String, i64);

    /// Bytes plus the relocations left after the sections materialize --
    /// what the object writer receives, so a reference the layout resolves
    /// is folded away here as GNU as folds it. Offsets are within the
    /// concatenated sections, in section order.
    fn assemble_relocs(text: &str) -> (Vec<u8>, Vec<Reloc>) {
        use crate::c5::asm::AsmComments;
        use crate::c5::asm::AsmSectionSink;
        use crate::c5::asm::AsmSectionTarget;
        use crate::c5::asm::{materialize_file_asm, prepare_file_asm_text};
        // The driver prepares the template (comment stripping, GNU as macro
        // and equate expansion) before the section parse reads it.
        let text = prepare_file_asm_text(text, AsmComments::X86).expect("prepares");
        let mut sink = AsmSectionSink::default();
        materialize_file_asm(
            &[text],
            false,
            AsmComments::X86,
            &|blocks| super::encode_x86_file_asm_section_code(blocks, crate::c5::ElfClass::Elf64),
            &mut sink,
        )
        .expect("assembles");
        let (mut out, mut rs) = (Vec::new(), Vec::new());
        for s in sink.sections().iter() {
            for r in &s.relocs {
                let name = match &r.target {
                    AsmSectionTarget::Symbol(n) => n.clone(),
                    t => alloc::format!("{t:?}"),
                };
                rs.push((
                    r.offset + out.len() as u32,
                    r.width,
                    r.signed,
                    name,
                    r.addend,
                ));
            }
            out.extend_from_slice(&s.bytes);
        }
        (out, rs)
    }

    /// The diagnostic a stream the assembler rejects produces, from encoding
    /// or from the layout the sections materialize against.
    fn assemble_err(text: &str) -> alloc::string::String {
        use crate::c5::asm::AsmComments;
        use crate::c5::asm::AsmSectionSink;
        use crate::c5::asm::{materialize_file_asm, prepare_file_asm_text};
        let text = prepare_file_asm_text(text, AsmComments::X86).expect("prepares");
        let mut sink = AsmSectionSink::default();
        materialize_file_asm(
            &[text],
            false,
            AsmComments::X86,
            &|blocks| super::encode_x86_file_asm_section_code(blocks, crate::c5::ElfClass::Elf64),
            &mut sink,
        )
        .expect_err("rejected")
    }

    /// A label difference is an absolute value in an immediate and in a
    /// memory displacement. GNU as fixes the field when the instruction is
    /// assembled, so a backward difference takes the narrow field and a
    /// forward one keeps the wide one. Bytes from GNU as 2.46.1.
    #[test]
    fn file_scope_x86_label_difference_operand_matches_gnu_as() {
        let (bytes, relocs) = assemble_relocs(
            ".pushsection .t,\"ax\"\n\
             1:\n\
             nop\n\
             2:\n\
             subl $(2b - 1b), %ebp\n\
             subl $(4f - 3f), %ebp\n\
             movl (2b - 1b)(%rax), %ebx\n\
             movl (4f - 3f)(%rax), %ecx\n\
             3:\n\
             nop\n\
             4:\n\
             nop\n\
             .popsection\n",
        );
        assert_eq!(
            bytes,
            alloc::vec![
                0x90, // nop
                0x83, 0xed, 0x01, // subl $1, %ebp        imm8, backward
                0x81, 0xed, 0x01, 0x00, 0x00, 0x00, // subl $1, %ebp  imm32, forward
                0x8b, 0x58, 0x01, // movl 1(%rax), %ebx   disp8, backward
                0x8b, 0x88, 0x01, 0x00, 0x00, 0x00, // movl 1(%rax), %ecx  disp32, forward
                0x90, 0x90,
            ]
        );
        assert!(
            relocs.is_empty(),
            "a folded difference relocates: {relocs:?}"
        );
    }

    /// A branch through a `.set` alias takes the location of the name the
    /// chain ends at and the binding of the name written: a local alias of a
    /// global resolves in place, a global or weak one keeps its relocation at
    /// the long form's width. A data field keeps the name written, which is
    /// what the kernel's `SYM_FUNC_ALIAS` + `EXPORT_SYMBOL` shape reads. Bytes
    /// from GNU as 2.46.1.
    #[test]
    fn file_scope_x86_branch_binds_as_the_alias_name_does() {
        let (bytes, relocs) = assemble_relocs(
            ".pushsection .t,\"ax\"\n\
             .globl gtgt\n\
             gtgt:\n\
             ret\n\
             .set la, gtgt\n\
             call la\n\
             jmp la\n\
             .globl ga\n\
             .set ga, gtgt\n\
             call ga\n\
             .weak wa\n\
             .set wa, gtgt\n\
             jmp wa\n\
             call gtgt\n\
             .popsection\n\
             .pushsection .d,\"a\"\n\
             .quad la\n\
             .popsection\n",
        );
        assert_eq!(
            bytes[..23],
            [
                0xc3, // ret
                0xe8, 0xfa, 0xff, 0xff, 0xff, // call la    local alias, in place
                0xeb, 0xf8, // jmp la     local alias, short in place
                0xe8, 0x00, 0x00, 0x00, 0x00, // call ga    global alias, relocated
                0xe9, 0x00, 0x00, 0x00, 0x00, // jmp wa     weak alias, long + relocated
                0xe8, 0x00, 0x00, 0x00, 0x00, // call gtgt
            ]
        );
        let sites: alloc::vec::Vec<(u32, &str, i64)> =
            relocs.iter().map(|r| (r.0, r.3.as_str(), r.4)).collect();
        assert_eq!(
            sites,
            [
                (9, "gtgt", -4),
                (14, "gtgt", -4),
                (19, "gtgt", -4),
                (23, "la", 0),
            ],
            "an instruction field names the chain end, a data field the name written"
        );
    }

    /// The two rules a `.set` alias answers to must agree: the binding the
    /// symbol table gives the name decides whether the link may rebind a
    /// reference to it, and a reference the link may rebind cannot reduce to a
    /// location of this unit. So where the chain ends at a name the link does
    /// not bind, a rebindable alias keeps its own relocation rather than the
    /// chain end, and a local one resolves in place. Relocations from GNU as
    /// 2.46.1 for the same source.
    #[test]
    fn a_rebindable_alias_of_a_local_target_keeps_its_relocation() {
        let (_, relocs) = assemble_relocs(
            ".pushsection .t,\"ax\"\n\
             base:\n\
             ret\n\
             t:\n\
             ret\n\
             .set la, t\n\
             call la\n\
             .globl ga\n\
             .set ga, t\n\
             call ga\n\
             .weak wa\n\
             .set wa, t\n\
             call wa\n\
             .popsection\n",
        );
        let sites: alloc::vec::Vec<(&str, i64)> =
            relocs.iter().map(|r| (r.3.as_str(), r.4)).collect();
        assert_eq!(
            sites,
            [("ga", -4), ("wa", -4)],
            "a local alias resolves in place; a rebindable one names itself"
        );
    }

    /// `.org` reads its target against the final layout, so operator order
    /// does not decide whether the target reduces. GNU as 2.46.1 accepts
    /// every spelling with the same padding.
    #[test]
    fn file_scope_x86_org_target_folds_regardless_of_association() {
        for expr in [". + 662b-661b", ". + (662b-661b)", ". + 662b - 661b"] {
            let bytes = assemble(&alloc::format!(
                ".pushsection .t,\"ax\"\n\
                 661:\n\
                 nop\n\
                 nop\n\
                 662:\n\
                 .org {expr}\n\
                 ret\n\
                 .popsection\n"
            ));
            assert_eq!(bytes, alloc::vec![0x90, 0x90, 0x00, 0x00, 0xc3], "{expr}");
        }
    }

    /// `crc32` encodes `r32, r/m8|r/m16|r/m32` and `r64, r/m8|r/m64`: REX.W is
    /// the accumulator width, a register source names the source width, and the
    /// size suffix supplies it only for a memory source. Bytes measured with
    /// GNU as 2.46.1.
    #[test]
    fn crc32_operand_widths_match_gnu_as() {
        for (src, want) in [
            ("crc32 %al, %edi\n", &[0xf2, 0x0f, 0x38, 0xf0, 0xf8][..]),
            (
                "crc32 %al, %rdi\n",
                &[0xf2, 0x48, 0x0f, 0x38, 0xf0, 0xf8][..],
            ),
            (
                "crc32 %ax, %edi\n",
                &[0x66, 0xf2, 0x0f, 0x38, 0xf1, 0xf8][..],
            ),
            ("crc32 %eax, %edi\n", &[0xf2, 0x0f, 0x38, 0xf1, 0xf8][..]),
            // The 3-way crc32c combine step: a 64-bit register source with a
            // 64-bit accumulator, which the unsuffixed spelling names.
            (
                "crc32 %rax, %rdi\n",
                &[0xf2, 0x48, 0x0f, 0x38, 0xf1, 0xf8][..],
            ),
            (
                "crc32q %rax, %rdi\n",
                &[0xf2, 0x48, 0x0f, 0x38, 0xf1, 0xf8][..],
            ),
            (
                "crc32 %r15, %r8\n",
                &[0xf2, 0x4d, 0x0f, 0x38, 0xf1, 0xc7][..],
            ),
            (
                "crc32 %r15b, %r8d\n",
                &[0xf2, 0x45, 0x0f, 0x38, 0xf0, 0xc7][..],
            ),
            // spl/bpl/sil/dil as the byte source take a bare REX.
            (
                "crc32 %sil, %edi\n",
                &[0xf2, 0x40, 0x0f, 0x38, 0xf0, 0xfe][..],
            ),
            // A memory source takes its width from the suffix, or from the
            // accumulator when unsuffixed.
            ("crc32b (%rsi), %edi\n", &[0xf2, 0x0f, 0x38, 0xf0, 0x3e][..]),
            (
                "crc32b (%rsi), %rdi\n",
                &[0xf2, 0x48, 0x0f, 0x38, 0xf0, 0x3e][..],
            ),
            (
                "crc32w (%rsi), %edi\n",
                &[0x66, 0xf2, 0x0f, 0x38, 0xf1, 0x3e][..],
            ),
            ("crc32 (%rsi), %edi\n", &[0xf2, 0x0f, 0x38, 0xf1, 0x3e][..]),
            (
                "crc32 (%rsi), %rdi\n",
                &[0xf2, 0x48, 0x0f, 0x38, 0xf1, 0x3e][..],
            ),
            (
                "crc32q (%rsi,%rcx,2), %r9\n",
                &[0xf2, 0x4c, 0x0f, 0x38, 0xf1, 0x0c, 0x4e][..],
            ),
        ] {
            assert_eq!(assemble(src), want, "{src}");
        }
        // Pairs the encoding has no room for, and a suffix contradicting the
        // source register: GNU as rejects each.
        for src in [
            "crc32 %rax, %edi\n",
            "crc32 %eax, %rdi\n",
            "crc32 %ax, %rdi\n",
            "crc32l %eax, %rdi\n",
            "crc32q (%rsi), %edi\n",
            "crc32w (%rsi), %rdi\n",
            "crc32 %al, %di\n",
            "crc32 %al, %dil\n",
            "crc32 (%rsi), %di\n",
            "crc32b %eax, %edi\n",
            "crc32l %al, %edi\n",
        ] {
            assert!(assemble_err(src).contains("crc32"), "{src}");
        }
    }

    /// `.code16` / `.code32` / `.code64` select the encoding mode of the
    /// instructions that follow, and the state carries across a section switch
    /// as it does in the assembler's input stream. Bytes measured with GNU as
    /// 2.46.1 for the same source.
    #[test]
    fn code_directives_select_the_encoding_mode() {
        assert_eq!(
            assemble(".code16\nmovl %eax, %ebx\nmov %ax, %bx\n"),
            [0x66, 0x89, 0xc3, 0x89, 0xc3]
        );
        assert_eq!(
            assemble(".code32\nmovl %eax, %ebx\nmov %ax, %bx\n"),
            [0x89, 0xc3, 0x66, 0x89, 0xc3]
        );
        assert_eq!(
            assemble("movl %eax, %ebx\nmov %ax, %bx\n"),
            [0x89, 0xc3, 0x66, 0x89, 0xc3]
        );
        // The mode switches mid-stream and carries into the next section.
        assert_eq!(
            assemble(".code16\npushw %si\n.code64\npush %rsi\n.code32\npush %esi\n"),
            [0x56, 0x56, 0x56]
        );
        assert_eq!(
            assemble(".code16\n.section \"a\",\"ax\"\nmovl %eax, %ebx\n"),
            [0x66, 0x89, 0xc3]
        );
    }

    /// The mode also selects the no-op forms alignment padding takes: a
    /// 32-bit no-op decodes to a shorter instruction under 16-bit addressing,
    /// leaving its tail bytes to run as whatever they decode to. GNU as bytes
    /// for the same source: a 7-byte gap in each mode.
    #[test]
    fn code_directives_select_the_alignment_nops() {
        assert_eq!(
            assemble(".code16\nnop\n.balign 8\nret\n.code64\n.balign 16\nret\n"),
            [
                0x90, 0x89, 0xf6, 0x2e, 0x8d, 0xb4, 0x00, 0x00, 0xc3, 0x0f, 0x1f, 0x80, 0x00, 0x00,
                0x00, 0x00, 0xc3
            ]
        );
    }

    /// A width class the instruction catalogue spells out member by member
    /// still takes the operand-size prefix. `and`'s ModRM immediate group is
    /// written `r/m16, imm16` / `r/m32, imm32` / `r/m64, imms32` rather than
    /// `rv/mv, immv`, and `lea` reaches the catalogue without its 16-bit
    /// destination row at all; a 32-bit member of either under `.code16` is
    /// what the x86 real-mode trampoline runs. A group with no 16-bit member
    /// is the `y` class, which REX.W alone selects and `66` does not reach.
    /// Bytes measured with GNU as 2.46.1 for the same source.
    #[test]
    fn spelled_out_width_class_takes_the_operand_size_prefix() {
        for (src, want) in [
            (
                ".code16\nandl $0x000f00f0, %ecx\n",
                &[0x66, 0x81, 0xe1, 0xf0, 0x00, 0x0f, 0x00][..],
            ),
            (
                ".code16\nandl $0x0700a169, %edx\n",
                &[0x66, 0x81, 0xe2, 0x69, 0xa1, 0x00, 0x07][..],
            ),
            (
                ".code16\nandl $0x12345678, 4(%bx)\n",
                &[0x66, 0x81, 0x67, 0x04, 0x78, 0x56, 0x34, 0x12][..],
            ),
            (
                ".code16\nandw $0x1234, %cx\n",
                &[0x81, 0xe1, 0x34, 0x12][..],
            ),
            (
                ".code16\nandw $0x1234, 4(%bx)\n",
                &[0x81, 0x67, 0x04, 0x34, 0x12][..],
            ),
            (".code16\nandl $0x7f, %ecx\n", &[0x66, 0x83, 0xe1, 0x7f][..]),
            (
                ".code16\nleal 4(%bx), %eax\n",
                &[0x66, 0x8d, 0x47, 0x04][..],
            ),
            (".code16\nleaw 4(%bx), %ax\n", &[0x8d, 0x47, 0x04][..]),
            (".code16\nptwrite %eax\n", &[0xf3, 0x0f, 0xae, 0xe0][..]),
            (
                ".code32\nandl $0x000f00f0, %ecx\n",
                &[0x81, 0xe1, 0xf0, 0x00, 0x0f, 0x00][..],
            ),
            (
                ".code32\nandw $0x1234, %cx\n",
                &[0x66, 0x81, 0xe1, 0x34, 0x12][..],
            ),
            (".code32\nleal 4(%ebx), %eax\n", &[0x8d, 0x43, 0x04][..]),
            (
                ".code32\nleaw 4(%ebx), %ax\n",
                &[0x66, 0x8d, 0x43, 0x04][..],
            ),
            (".code32\nptwrite %eax\n", &[0xf3, 0x0f, 0xae, 0xe0][..]),
            (
                "andq $0x000f00f0, %rcx\n",
                &[0x48, 0x81, 0xe1, 0xf0, 0x00, 0x0f, 0x00][..],
            ),
            (
                "andl $0x000f00f0, %ecx\n",
                &[0x81, 0xe1, 0xf0, 0x00, 0x0f, 0x00][..],
            ),
            ("leaw 4(%rbx), %ax\n", &[0x66, 0x8d, 0x43, 0x04][..]),
            ("leal 4(%rbx), %eax\n", &[0x8d, 0x43, 0x04][..]),
            ("leaq 4(%rbx), %rax\n", &[0x48, 0x8d, 0x43, 0x04][..]),
            ("ptwrite %eax\n", &[0xf3, 0x0f, 0xae, 0xe0][..]),
        ] {
            assert_eq!(assemble(src), want, "{src}");
        }
    }

    /// GNU as orders the prefixes segment, address size, operand size, then
    /// repeat / lock, whatever the mode.
    #[test]
    fn prefix_order_matches_gnu_as() {
        assert_eq!(assemble(".code16\nrep movsl\n"), [0x66, 0xf3, 0xa5]);
        assert_eq!(assemble(".code16\nrep movsw\n"), [0xf3, 0xa5]);
        assert_eq!(assemble(".code32\nrep movsw\n"), [0x66, 0xf3, 0xa5]);
        assert_eq!(assemble("rep movsw\n"), [0x66, 0xf3, 0xa5]);
        assert_eq!(assemble("rep movsq\n"), [0xf3, 0x48, 0xa5]);
        assert_eq!(
            assemble(".code16\nlock addl $1, (%bx)\n"),
            [0x66, 0xf0, 0x83, 0x07, 0x01]
        );
        assert_eq!(
            assemble("lock addw $1, (%rax)\n"),
            [0x66, 0xf0, 0x83, 0x00, 0x01]
        );
    }

    /// A near branch's displacement follows the operand size: 16-bit in a
    /// `.code16` stub unless the AT&T suffix names the other width.
    #[test]
    fn branch_displacement_width_follows_the_mode() {
        assert_eq!(assemble(".code16\ncall f\n"), [0xe8, 0, 0]);
        assert_eq!(assemble(".code16\ncalll f\n"), [0x66, 0xe8, 0, 0, 0, 0]);
        assert_eq!(assemble(".code16\njmp f\n"), [0xe9, 0, 0]);
        assert_eq!(assemble(".code16\njz f\n"), [0x0f, 0x84, 0, 0]);
        assert_eq!(assemble(".code32\ncall f\n"), [0xe8, 0, 0, 0, 0]);
        assert_eq!(assemble("call f\n"), [0xe8, 0, 0, 0, 0]);
    }

    /// The direct far branch `ljmp` / `lcall $seg, $off` is `ptr16:16` or
    /// `ptr16:32` (EA / 9A) with the offset first and the selector after it.
    /// The offset width is the mode default unless the AT&T suffix names the
    /// other one, which the 0x66 prefix then selects. Bytes measured with GNU
    /// as 2.46.1 for the same source.
    #[test]
    fn direct_far_branch_matches_gnu_as() {
        for (src, bytes) in [
            (
                ".code16\nljmp $0x1234, $0x5678\n",
                &[0xea, 0x78, 0x56, 0x34, 0x12][..],
            ),
            (
                ".code16\nljmpw $0x1234, $0x5678\n",
                &[0xea, 0x78, 0x56, 0x34, 0x12][..],
            ),
            (
                ".code16\nljmpl $0x1234, $0x12345678\n",
                &[0x66, 0xea, 0x78, 0x56, 0x34, 0x12, 0x34, 0x12][..],
            ),
            (
                ".code16\nlcall $0x1234, $0x5678\n",
                &[0x9a, 0x78, 0x56, 0x34, 0x12][..],
            ),
            (
                ".code16\nlcalll $0x1234, $0x12345678\n",
                &[0x66, 0x9a, 0x78, 0x56, 0x34, 0x12, 0x34, 0x12][..],
            ),
            (
                ".code32\nljmp $0x1234, $0x12345678\n",
                &[0xea, 0x78, 0x56, 0x34, 0x12, 0x34, 0x12][..],
            ),
            (
                ".code32\nljmpw $0x1234, $0x5678\n",
                &[0x66, 0xea, 0x78, 0x56, 0x34, 0x12][..],
            ),
            (
                ".code32\nljmpl $0x1234, $0x12345678\n",
                &[0xea, 0x78, 0x56, 0x34, 0x12, 0x34, 0x12][..],
            ),
            (
                ".code32\nlcall $0x1234, $0x12345678\n",
                &[0x9a, 0x78, 0x56, 0x34, 0x12, 0x34, 0x12][..],
            ),
            (
                ".code32\nlcallw $0x1234, $0x5678\n",
                &[0x66, 0x9a, 0x78, 0x56, 0x34, 0x12][..],
            ),
            // The offset fits the field signed or unsigned; the selector is
            // truncated to 16 bits.
            (
                ".code16\nljmpw $0xf000, $-1\n",
                &[0xea, 0xff, 0xff, 0x00, 0xf0][..],
            ),
            (
                ".code16\nljmpw $0x12345, $0x1234\n",
                &[0xea, 0x34, 0x12, 0x45, 0x23][..],
            ),
        ] {
            assert_eq!(assemble(src), bytes, "{src}");
        }
        // 64-bit mode has no direct far branch, as GNU as reports.
        for src in [
            "ljmp $1, $2\n",
            "ljmpl $1, $2\n",
            "lcall $1, $2\n",
            ".code64\nljmpw $1, $2\n",
        ] {
            assert!(assemble_err(src).contains("64-bit-mode"), "{src}");
        }
        // An offset wider than the field it would take has no encoding.
        assert!(
            assemble_err(".code16\nljmpw $0x1234, $0x12345\n").contains("does not fit"),
            "16-bit offset range"
        );
    }

    /// The indirect far branch's operand-size prefix follows the mode the
    /// same way: the AT&T suffix names the offset width, and 0x66 appears
    /// only where it differs from the mode default. Bytes measured with GNU
    /// as 2.46.1 for the same source. The operands stay at the mode's default
    /// address size; the bespoke encoder does not yet model the other one.
    /// TODO 16-bit addressing and the 0x67 prefix in the bespoke encoder.
    #[test]
    fn indirect_far_branch_operand_size_matches_gnu_as() {
        for (src, bytes) in [
            (".code32\nljmp *(%eax)\n", &[0xff, 0x28][..]),
            (".code32\nljmpw *(%eax)\n", &[0x66, 0xff, 0x28][..]),
            (".code32\nljmpl *(%eax)\n", &[0xff, 0x28][..]),
            (".code32\nlcall *(%eax)\n", &[0xff, 0x18][..]),
            (".code32\nlcallw *(%eax)\n", &[0x66, 0xff, 0x18][..]),
            ("ljmp *(%rax)\n", &[0xff, 0x28][..]),
            ("ljmpw *(%rax)\n", &[0x66, 0xff, 0x28][..]),
            ("ljmpl *(%rax)\n", &[0xff, 0x28][..]),
            ("lcall *(%rax)\n", &[0xff, 0x18][..]),
        ] {
            assert_eq!(assemble(src), bytes, "{src}");
        }
    }

    /// A near `jmp` / `call` through an absolute address: AT&T's `*` marks
    /// the operand as the memory holding the target, so a bare address after
    /// it is a displacement-only memory reference rather than the branch
    /// target itself. Long mode addresses it with a base-less SIB. Bytes
    /// measured with GNU as 2.46.1 and llvm-mc 21 for the same source:
    /// `jmp *0x1234` is `ff 24 25 34 12 00 00`, `call *0x1234`
    /// `ff 14 25 34 12 00 00`, and `jmp *sym` the same with a signed 32-bit
    /// relocation in the displacement.
    #[test]
    fn near_indirect_branch_through_an_absolute_address_matches_gnu_as() {
        for (src, bytes) in [
            ("jmp *0x1234\n", &[0xff, 0x24, 0x25, 0x34, 0x12, 0, 0][..]),
            ("call *0x1234\n", &[0xff, 0x14, 0x25, 0x34, 0x12, 0, 0][..]),
        ] {
            assert_eq!(assemble(src), bytes, "{src}");
        }
        // Without the marker the same name is the branch target itself.
        let (bytes, relocs) = assemble_relocs("jmp sym\n");
        assert_eq!(bytes, [0xe9, 0, 0, 0, 0]);
        assert_eq!(
            relocs,
            [(1, 4, false, alloc::string::String::from("sym"), -4)]
        );
        let (bytes, relocs) = assemble_relocs("jmp *sym\ncall *sym\n");
        assert_eq!(
            bytes,
            [0xff, 0x24, 0x25, 0, 0, 0, 0, 0xff, 0x14, 0x25, 0, 0, 0, 0]
        );
        assert_eq!(
            relocs,
            [
                (3, 4, true, alloc::string::String::from("sym"), 0),
                (10, 4, true, alloc::string::String::from("sym"), 0),
            ]
        );
    }

    /// A near indirect branch outside long mode: the reference carries no
    /// width of its own, so it takes the mode's default operand size, and the
    /// address size decides the r/m form and the `67` prefix. The same rule
    /// values a stack operand. Bytes measured with GNU as 2.46.1 and llvm-mc
    /// 21 for the same source.
    #[test]
    fn a_near_indirect_branch_follows_the_mode_outside_long_mode() {
        #[rustfmt::skip]
        let cases: &[(&str, &[u8])] = &[
            (".code16\njmp *(%bx)\n",        &[0xff, 0x27]),
            (".code16\ncall *(%bx)\n",       &[0xff, 0x17]),
            (".code16\njmp *2(%bp,%si)\n",   &[0xff, 0x62, 0x02]),
            (".code16\npush (%bx)\n",        &[0xff, 0x37]),
            (".code16\njmp *0x1234\n",       &[0xff, 0x26, 0x34, 0x12]),
            (".code16\ncall *0x1234\n",      &[0xff, 0x16, 0x34, 0x12]),
            (".code32\njmp *(%bx)\n",        &[0x67, 0xff, 0x27]),
            (".code32\ncall *(%bx)\n",       &[0x67, 0xff, 0x17]),
            (".code32\npush (%eax)\n",       &[0xff, 0x30]),
            (".code32\njmp *0x1234\n",       &[0xff, 0x25, 0x34, 0x12, 0x00, 0x00]),
            (".code32\ncall *0x1234\n",      &[0xff, 0x15, 0x34, 0x12, 0x00, 0x00]),
            ("jmp *(%rax)\n",                &[0xff, 0x20]),
            ("push (%rax)\n",                &[0xff, 0x30]),
        ];
        for (src, want) in cases {
            assert_eq!(assemble(src), *want, "{src}");
        }
        // Long mode has no 16-bit addressing, as GNU as also reports.
        assert!(assemble_err("jmp *(%bx)\n").contains("address size 2"));
    }

    /// A symbol in a direct far branch's offset relocates in that field,
    /// which the trailing selector keeps off the end of the encoding; a
    /// symbol in the selector relocates in its own 16-bit field. Bytes and
    /// relocations measured with GNU as 2.46.1 for the same source.
    #[test]
    fn far_branch_symbol_immediate_matches_gnu_as() {
        for (src, bytes, reloc) in [
            // ea <16 sym> 08 00
            (
                ".code16\nljmpw $8, $s\n",
                &[0xea, 0, 0, 0x08, 0][..],
                (1u32, 2u8, 0i64),
            ),
            // 66 ea <32 sym> 08 00
            (
                ".code16\nljmpl $8, $s\n",
                &[0x66, 0xea, 0, 0, 0, 0, 0x08, 0][..],
                (2, 4, 0),
            ),
            (
                ".code32\nljmpl $8, $s\n",
                &[0xea, 0, 0, 0, 0, 0x08, 0][..],
                (1, 4, 0),
            ),
            (
                ".code32\nljmpw $8, $s\n",
                &[0x66, 0xea, 0, 0, 0x08, 0][..],
                (2, 2, 0),
            ),
            (
                ".code32\nlcalll $8, $s\n",
                &[0x9a, 0, 0, 0, 0, 0x08, 0][..],
                (1, 4, 0),
            ),
            (
                ".code32\nljmpl $8, $s+4\n",
                &[0xea, 0, 0, 0, 0, 0x08, 0][..],
                (1, 4, 4),
            ),
            // A symbol selector takes the trailing 16-bit field instead.
            (
                ".code32\nljmpl $s, $0x1000\n",
                &[0xea, 0x00, 0x10, 0, 0, 0, 0][..],
                (5, 2, 0),
            ),
        ] {
            let (got, relocs) = assemble_relocs(src);
            assert_eq!(got, bytes, "{src}");
            let (off, width, addend) = reloc;
            assert_eq!(
                relocs,
                [(off, width, false, alloc::string::String::from("s"), addend)],
                "{src}"
            );
        }
    }

    /// A `$symbol` immediate relocates in whatever field the instruction's
    /// operand size gives it, not only `push`'s imm32. The field is
    /// sign-extended (`R_X86_64_32S`, `signed`) exactly when the form's
    /// immediate slot is the signed imm32 class. Bytes and relocations
    /// measured with GNU as 2.46.1 for the same source.
    #[test]
    fn symbol_immediate_field_matches_gnu_as() {
        for (src, bytes, reloc) in [
            // 48 c7 c0 <32S sym>
            (
                "movq $s, %rax\n",
                &[0x48, 0xc7, 0xc0, 0, 0, 0, 0][..],
                (3u32, 4u8, true, 0i64),
            ),
            // b8 <32 sym>: a 32-bit operand takes the zero-extended field.
            ("movl $s, %eax\n", &[0xb8, 0, 0, 0, 0][..], (1, 4, false, 0)),
            (
                "subq $s, %rsp\n",
                &[0x48, 0x81, 0xec, 0, 0, 0, 0][..],
                (3, 4, true, 0),
            ),
            (
                "addq $s+8, %rax\n",
                &[0x48, 0x05, 0, 0, 0, 0][..],
                (2, 4, true, 8),
            ),
            ("cmpl $s, %eax\n", &[0x3d, 0, 0, 0, 0][..], (1, 4, false, 0)),
            ("pushq $s\n", &[0x68, 0, 0, 0, 0][..], (1, 4, true, 0)),
            ("movb $s, %al\n", &[0xb0, 0][..], (1, 1, false, 0)),
            ("movw $s, %dx\n", &[0x66, 0xba, 0, 0][..], (2, 2, false, 0)),
            (
                "movabsq $s, %rcx\n",
                &[0x48, 0xb9, 0, 0, 0, 0, 0, 0, 0, 0][..],
                (2, 8, false, 0),
            ),
        ] {
            let (got, relocs) = assemble_relocs(src);
            assert_eq!(got, bytes, "{src}");
            let (off, width, signed, addend) = reloc;
            assert_eq!(
                relocs,
                [(off, width, signed, alloc::string::String::from("s"), addend)],
                "{src}"
            );
        }
    }

    /// The legacy high-byte registers are a distinct operand class: their
    /// ModRM field values 4..8 name `spl`/`bpl`/`sil`/`dil` under a REX
    /// prefix, so no encoding carrying one can reach them. Bytes measured
    /// with GNU as 2.46.1.
    #[test]
    fn high_byte_registers_match_gnu_as() {
        for (src, want) in [
            ("xchg %al, %ah\n", &[0x86u8, 0xc4][..]),
            ("xchg %ah, %al\n", &[0x86, 0xe0]),
            ("xchg %ah, %bh\n", &[0x86, 0xe7]),
            ("xchg %ah, %dl\n", &[0x86, 0xe2]),
            ("mov %ah, %bl\n", &[0x88, 0xe3]),
            ("mov %bl, %ah\n", &[0x88, 0xdc]),
            ("movb %ch, (%rax)\n", &[0x88, 0x28]),
            ("movb (%rax), %dh\n", &[0x8a, 0x30]),
            ("addb %bh, %ah\n", &[0x00, 0xfc]),
            ("cmpb $1, %ah\n", &[0x80, 0xfc, 0x01]),
            ("incb %ah\n", &[0xfe, 0xc4]),
            ("shrb $4, %ah\n", &[0xc0, 0xec, 0x04]),
            ("movzbl %ah, %ecx\n", &[0x0f, 0xb6, 0xcc]),
        ] {
            assert_eq!(assemble(src), want, "{src}");
        }
        // A REX prefix and a high-byte register cannot appear together, so
        // no form of these encodes.
        for src in ["xchg %ah, %r8b\n", "mov %ah, %sil\n", "movzbq %ah, %rcx\n"] {
            let e = assemble_err(src);
            assert!(e.contains("rh4:1"), "{src}: {e}");
        }
    }

    /// Undefined-opcode and descriptor-table forms the kernel entry code
    /// writes. `lsl` / `lar` take no REX.W: GNU as encodes a 64-bit
    /// destination as the 32-bit form. `ud2a` / `ud2b` are its spellings of
    /// `ud2` / `ud1`, and both `ud0` and `ud1` have an operandless form.
    #[test]
    fn undefined_opcode_and_descriptor_forms_match_gnu_as() {
        for (src, want) in [
            ("ud1 (%edx), %rdi\n", &[0x67u8, 0x48, 0x0f, 0xb9, 0x3a][..]),
            ("ud1 (%rdx), %rdi\n", &[0x48, 0x0f, 0xb9, 0x3a]),
            ("ud1 %eax, %ecx\n", &[0x0f, 0xb9, 0xc8]),
            ("ud1 %ax, %cx\n", &[0x66, 0x0f, 0xb9, 0xc8]),
            ("ud1\n", &[0x0f, 0xb9]),
            ("ud0\n", &[0x0f, 0xff]),
            ("ud0 %rax, %rcx\n", &[0x48, 0x0f, 0xff, 0xc8]),
            ("ud2\n", &[0x0f, 0x0b]),
            ("ud2a\n", &[0x0f, 0x0b]),
            ("ud2b\n", &[0x0f, 0xb9]),
            ("lsl %rax, %rax\n", &[0x0f, 0x03, 0xc0]),
            ("lsl %ax, %ax\n", &[0x66, 0x0f, 0x03, 0xc0]),
            ("lsl %r12, %r13\n", &[0x45, 0x0f, 0x03, 0xec]),
            ("lsl (%rbx), %rax\n", &[0x0f, 0x03, 0x03]),
            ("lar %rax, %rax\n", &[0x0f, 0x02, 0xc0]),
            ("verw %rax\n", &[0x0f, 0x00, 0xe8]),
            ("verw (%rax)\n", &[0x0f, 0x00, 0x28]),
            ("verw 8(%rbx)\n", &[0x0f, 0x00, 0x6b, 0x08]),
            ("verr (%rax)\n", &[0x0f, 0x00, 0x20]),
        ] {
            assert_eq!(assemble(src), want, "{src}");
        }
    }

    /// The descriptor-table and machine-status ops against memory. The
    /// operand names a 16-bit field, so the memory forms carry no
    /// operand-size prefix whatever width the source wrote; a 32-bit register
    /// destination is the 16-bit encoding without the 0x66.
    #[test]
    fn descriptor_table_memory_forms_match_gnu_as() {
        for (src, want) in [
            ("sldt (%rax)\n", &[0x0fu8, 0x00, 0x00][..]),
            ("sldt (%r12)\n", &[0x41, 0x0f, 0x00, 0x04, 0x24]),
            ("sldt 8(%rbx)\n", &[0x0f, 0x00, 0x43, 0x08]),
            ("sldt %ax\n", &[0x66, 0x0f, 0x00, 0xc0]),
            ("sldt %eax\n", &[0x0f, 0x00, 0xc0]),
            ("str (%rax)\n", &[0x0f, 0x00, 0x08]),
            ("str %ax\n", &[0x66, 0x0f, 0x00, 0xc8]),
            ("lldt (%rax)\n", &[0x0f, 0x00, 0x10]),
            ("lldt (%r13)\n", &[0x41, 0x0f, 0x00, 0x55, 0x00]),
            ("lldt %ax\n", &[0x0f, 0x00, 0xd0]),
            ("ltr (%rax)\n", &[0x0f, 0x00, 0x18]),
            ("ltr %ax\n", &[0x0f, 0x00, 0xd8]),
            ("smsw (%rax)\n", &[0x0f, 0x01, 0x20]),
            ("smsw %ax\n", &[0x66, 0x0f, 0x01, 0xe0]),
            ("smsw %eax\n", &[0x0f, 0x01, 0xe0]),
            ("lmsw (%rax)\n", &[0x0f, 0x01, 0x30]),
            ("lmsw %ax\n", &[0x0f, 0x01, 0xf0]),
        ] {
            assert_eq!(assemble(src), want, "{src}");
        }
    }

    /// Packed integer absolute value, VEX and legacy. VEX.L follows the
    /// destination; the source may be a register or memory.
    #[test]
    fn packed_absolute_value_matches_gnu_as() {
        for (src, want) in [
            (
                "vpabsb %xmm13, %xmm13\n",
                &[0xc4u8, 0x42, 0x79, 0x1c, 0xed][..],
            ),
            ("vpabsb %ymm13, %ymm13\n", &[0xc4, 0x42, 0x7d, 0x1c, 0xed]),
            ("vpabsb %xmm0, %xmm15\n", &[0xc4, 0x62, 0x79, 0x1c, 0xf8]),
            ("vpabsw %xmm1, %xmm2\n", &[0xc4, 0xe2, 0x79, 0x1d, 0xd1]),
            ("vpabsd %xmm1, %xmm2\n", &[0xc4, 0xe2, 0x79, 0x1e, 0xd1]),
            ("vpabsd %ymm1, %ymm2\n", &[0xc4, 0xe2, 0x7d, 0x1e, 0xd1]),
            ("vpabsb (%rax), %xmm1\n", &[0xc4, 0xe2, 0x79, 0x1c, 0x08]),
            (
                "vpabsd (%r12), %ymm9\n",
                &[0xc4, 0x42, 0x7d, 0x1e, 0x0c, 0x24],
            ),
            (
                "pabsb %xmm13, %xmm13\n",
                &[0x66, 0x45, 0x0f, 0x38, 0x1c, 0xed],
            ),
            ("pabsw %xmm1, %xmm2\n", &[0x66, 0x0f, 0x38, 0x1d, 0xd1]),
            ("pabsd %xmm1, %xmm2\n", &[0x66, 0x0f, 0x38, 0x1e, 0xd1]),
        ] {
            assert_eq!(assemble(src), want, "{src}");
        }
    }

    /// Packed shifts by a variable count. The count is `xmm/m128` at every
    /// destination width, so it takes ModRM.rm and VEX.L follows the
    /// destination and source; a ymm count has no encoding.
    #[test]
    fn variable_count_packed_shifts_match_gnu_as() {
        for (src, want) in [
            (
                "vpslld %xmm11, %xmm8, %xmm15\n",
                &[0xc4u8, 0x41, 0x39, 0xf2, 0xfb][..],
            ),
            ("vpsllw %xmm1, %xmm2, %xmm3\n", &[0xc5, 0xe9, 0xf1, 0xd9]),
            ("vpsllq %xmm1, %xmm2, %xmm3\n", &[0xc5, 0xe9, 0xf3, 0xd9]),
            ("vpsrlw %xmm1, %xmm2, %xmm3\n", &[0xc5, 0xe9, 0xd1, 0xd9]),
            ("vpsrld %xmm1, %xmm2, %xmm3\n", &[0xc5, 0xe9, 0xd2, 0xd9]),
            ("vpsrlq %xmm1, %xmm2, %xmm3\n", &[0xc5, 0xe9, 0xd3, 0xd9]),
            ("vpsraw %xmm1, %xmm2, %xmm3\n", &[0xc5, 0xe9, 0xe1, 0xd9]),
            ("vpsrad %xmm1, %xmm2, %xmm3\n", &[0xc5, 0xe9, 0xe2, 0xd9]),
            ("vpslld %xmm1, %ymm2, %ymm3\n", &[0xc5, 0xed, 0xf2, 0xd9]),
            ("vpsrld (%rax), %xmm2, %xmm3\n", &[0xc5, 0xe9, 0xd2, 0x18]),
            ("vpsrld (%rax), %ymm2, %ymm3\n", &[0xc5, 0xed, 0xd2, 0x18]),
            ("psrld %xmm1, %xmm2\n", &[0x66, 0x0f, 0xd2, 0xd1]),
            ("psllw %xmm1, %xmm9\n", &[0x66, 0x44, 0x0f, 0xf1, 0xc9]),
            ("psrlq %xmm9, %xmm10\n", &[0x66, 0x45, 0x0f, 0xd3, 0xd1]),
            ("psrld (%rax), %xmm2\n", &[0x66, 0x0f, 0xd2, 0x10]),
            // The immediate forms keep the destination in VEX.vvvv.
            ("vpslld $5, %xmm2, %xmm3\n", &[0xc5, 0xe1, 0x72, 0xf2, 0x05]),
            ("pslld $5, %xmm2\n", &[0x66, 0x0f, 0x72, 0xf2, 0x05]),
        ] {
            assert_eq!(assemble(src), want, "{src}");
        }
        // A ymm count is not encodable, and the shifts without a
        // variable-count member keep requiring an immediate.
        for (src, want) in [
            ("vpslld %ymm1, %ymm2, %ymm3\n", "count is xmm"),
            ("vpslldq %xmm1, %xmm2, %xmm3\n", "immediate expected"),
            ("pslldq %xmm1, %xmm2\n", "immediate expected"),
        ] {
            let e = assemble_err(src);
            assert!(e.contains(want), "{src}: {e}");
        }
    }

    /// `vmovd` / `vmovq` between an xmm lane and a general register or
    /// memory. VEX.W selects the width of a general-register transfer; the
    /// xmm and memory forms are W-ignored and take the two-byte VEX.
    #[test]
    fn vex_lane_moves_match_gnu_as() {
        for (src, want) in [
            ("vmovd %edi, %xmm0\n", &[0xc5u8, 0xf9, 0x6e, 0xc7][..]),
            ("vmovd %xmm0, %edi\n", &[0xc5, 0xf9, 0x7e, 0xc7]),
            ("vmovd (%rax), %xmm3\n", &[0xc5, 0xf9, 0x6e, 0x18]),
            ("vmovd %xmm5, (%rcx)\n", &[0xc5, 0xf9, 0x7e, 0x29]),
            ("vmovd %xmm11, %r9d\n", &[0xc4, 0x41, 0x79, 0x7e, 0xd9]),
            ("vmovd %r10d, %xmm12\n", &[0xc4, 0x41, 0x79, 0x6e, 0xe2]),
            ("vmovq %rdi, %xmm0\n", &[0xc4, 0xe1, 0xf9, 0x6e, 0xc7]),
            ("vmovq %xmm0, %rdi\n", &[0xc4, 0xe1, 0xf9, 0x7e, 0xc7]),
            ("vmovq %xmm0, %xmm1\n", &[0xc5, 0xfa, 0x7e, 0xc8]),
            ("vmovq (%rax), %xmm0\n", &[0xc5, 0xfa, 0x7e, 0x00]),
            ("vmovq %xmm0, (%rax)\n", &[0xc5, 0xf9, 0xd6, 0x00]),
            ("vmovq %r9, %xmm10\n", &[0xc4, 0x41, 0xf9, 0x6e, 0xd1]),
        ] {
            assert_eq!(assemble(src), want, "{src}");
        }
    }

    /// A character constant is an expression leaf wherever a number is, with
    /// the C escapes plus GNU as's octal and hex forms.
    #[test]
    fn character_constants_match_gnu_as() {
        for (src, want) in [
            ("addb $('a' - '0' - 10), %al\n", &[0x04u8, 0x27][..]),
            ("movl $'A', %eax\n", &[0xb8, 0x41, 0x00, 0x00, 0x00]),
            ("movb $'\\n', %al\n", &[0xb0, 0x0a]),
            ("movb $'\\'', %al\n", &[0xb0, 0x27]),
            ("movb $'\\\\', %al\n", &[0xb0, 0x5c]),
            ("movb $'\\x41', %al\n", &[0xb0, 0x41]),
            ("movb $'\\101', %al\n", &[0xb0, 0x41]),
            (".byte 'x'\n", &[0x78]),
            (".byte 'a', 'b'\n", &[0x61, 0x62]),
            (".long 'a' + 1\n", &[0x62, 0x00, 0x00, 0x00]),
        ] {
            assert_eq!(assemble(src), want, "{src}");
        }
    }

    /// The encoding mode is assembler state over the linear input, not a
    /// property of a section: a `.code64` written in one section is still in
    /// effect when the stream returns to an earlier one. GNU as encodes the
    /// `lea` below 64-bit (`48 8d 3d`), not 32-bit.
    #[test]
    fn code_mode_carries_across_section_switches_like_gnu_as() {
        let (bytes, relocs) = assemble_relocs(
            ".code32\n.text\nnop\n.section \".head.text\",\"ax\"\n.code32\nnop\n\
             .code64\nnop\n.text\nleaq _bss(%rip), %rdi\n",
        );
        assert_eq!(
            bytes,
            [0x90, 0x48, 0x8d, 0x3d, 0, 0, 0, 0, 0x90, 0x90],
            "{bytes:x?}"
        );
        assert_eq!(
            relocs,
            [(4, 4, false, alloc::string::String::from("_bss"), -4)]
        );
    }

    /// Which same-section references keep a relocation, measured against GNU
    /// as 2.46.1. A local name resolves in place; a global or weak one keeps
    /// the relocation so the link binds the definition that wins. The relaxed
    /// jump is the one exception: `jmp` / `jcc` to a same-section target
    /// resolves unless the symbol is weak.
    #[test]
    fn same_section_binding_decides_the_relocation_like_gnu_as() {
        let defs = ".text\n.Lloc:\nret\n.globl glob\nglob:\nret\n.weak wk\nwk:\nret\n";
        let relocs_of = |body: &str| assemble_relocs(&alloc::format!("{defs}{body}")).1;
        let names = |body: &str| -> alloc::vec::Vec<alloc::string::String> {
            relocs_of(body).into_iter().map(|r| r.3).collect()
        };
        // A local target resolves in place, whatever the form.
        assert!(names("call .Lloc\n").is_empty());
        assert!(names("jmp .Lloc\n").is_empty());
        assert!(names("lea .Lloc(%rip), %rax\n").is_empty());
        // A call or an address-of naming a global or weak symbol relocates.
        assert_eq!(names("call glob\n"), ["glob"]);
        assert_eq!(names("call wk\n"), ["wk"]);
        assert_eq!(names("lea glob(%rip), %rax\n"), ["glob"]);
        // A relaxed jump binds a same-section global in place: the branch
        // relaxes and no relocation survives. A weak target keeps both the
        // long form and its relocation.
        assert!(names("jmp glob\n").is_empty());
        assert!(names("je glob\n").is_empty());
        assert_eq!(names("jmp wk\n"), ["wk"]);
        assert_eq!(names("je wk\n"), ["wk"]);
        // A difference of two symbols folds whatever the binding, as GNU as
        // folds it: `.long glob - .` deposits a constant.
        assert!(names(".long glob - .\n").is_empty());
        assert!(names(".long wk - .\n").is_empty());
    }

    /// `. = expr` moves the location counter, as `.org` does; the kernel's
    /// kexec exception-vector table places its 6-byte entries that way.
    #[test]
    fn location_counter_assignment_places_like_org() {
        assert_eq!(
            assemble("base:\n.byte 1\n. = base + 4\n.byte 2\n"),
            [1, 0, 0, 0, 2]
        );
        assert_eq!(
            assemble("base:\n.byte 1\n.set ., base + 4\n.byte 2\n"),
            [1, 0, 0, 0, 2]
        );
        // Moving backwards is rejected, as GNU as rejects it.
        assert!(
            assemble_err("base:\n.byte 1, 2, 3\n. = base + 1\n").contains("backwards"),
            "a backward move must be diagnosed"
        );
    }

    /// The count- and rcx-conditional branches take a rel8 field only. A
    /// same-section target resolves to the byte displacement with no
    /// relocation, as GNU as emits it.
    #[test]
    fn short_branches_match_gnu_as() {
        assert_eq!(
            assemble("1:\nnop\nloop 1b\n"),
            [0x90, 0xe2, 0xfd],
            "loop backward"
        );
        assert_eq!(assemble(".Lx:\nnop\nloop .Lx\n"), [0x90, 0xe2, 0xfd]);
        assert_eq!(assemble(".Lx:\nnop\njrcxz .Lx\n"), [0x90, 0xe3, 0xfd]);
        assert_eq!(assemble(".Lx:\nnop\nloope .Lx\n"), [0x90, 0xe1, 0xfd]);
        assert_eq!(assemble(".Lx:\nnop\nloopne .Lx\n"), [0x90, 0xe0, 0xfd]);
        assert_eq!(assemble(".Lx:\nnop\nloopz .Lx\n"), [0x90, 0xe1, 0xfd]);
        assert_eq!(assemble(".Lx:\nnop\nloopnz .Lx\n"), [0x90, 0xe0, 0xfd]);
    }

    /// The counter an `E3` branch name spells is the address size, so the
    /// name off the mode's default takes the `67` prefix and a width the
    /// mode cannot address is rejected.
    #[test]
    fn e3_branch_takes_the_address_size_of_its_counter() {
        assert_eq!(assemble("x: jecxz x\n"), [0x67, 0xe3, 0xfd]);
        assert_eq!(assemble(".code32\nx: jecxz x\n"), [0xe3, 0xfe]);
        assert_eq!(assemble(".code32\nx: jcxz x\n"), [0x67, 0xe3, 0xfd]);
        assert_eq!(assemble(".code16\nx: jcxz x\n"), [0xe3, 0xfe]);
        assert_eq!(assemble(".code16\nx: jecxz x\n"), [0x67, 0xe3, 0xfd]);
        assert!(assemble_err("x: jcxz x\n").contains("64-bit mode"));
        assert!(assemble_err(".code32\nx: jrcxz x\n").contains("32-bit mode"));
        assert!(assemble_err(".code16\nx: jrcxz x\n").contains("16-bit mode"));
        // No wider form exists: a target out of rel8 range is an error, not
        // a relaxation.
        assert!(
            assemble_err("x: .skip 200, 0x90\njecxz x\n").contains("out of range"),
            "an out-of-range rel8 target must be diagnosed"
        );
    }

    /// A `.code16` stub's symbol immediate takes the 16-bit field, and the
    /// constant term folds into the relocation addend.
    #[test]
    fn symbol_immediate_in_code16_matches_gnu_as() {
        let (bytes, relocs) = assemble_relocs(".code16\nmovw $_end+3, %cx\n");
        assert_eq!(bytes, [0xb9, 0, 0]);
        assert_eq!(
            relocs,
            [(1, 2, false, alloc::string::String::from("_end"), 3)]
        );
    }

    /// A `.set` / `=` assignment to a register is the GNU as register equate:
    /// every later use of the name assembles as that register. `$name` splits
    /// at the AT&T immediate sigil, so a constant equate resolves there too.
    #[test]
    fn register_and_constant_equates_resolve_in_operands() {
        assert_eq!(
            assemble(".set IN_KEY, %rdx\nmovdqu (IN_KEY), %xmm0\n"),
            [0xf3, 0x0f, 0x6f, 0x02]
        );
        assert_eq!(
            assemble("CRC = %edi\nmovd CRC, %xmm0\n"),
            [0x66, 0x0f, 0x6e, 0xc7]
        );
        // An equate whose value is another equate takes its register.
        assert_eq!(
            assemble("A = %rdx\nB = A\nmov (%r9), B\n"),
            [0x49, 0x8b, 0x11]
        );
        // `_A`/`_B`/`K` fold to 32; `$K` is the sigil plus the name.
        assert_eq!(
            assemble("_A = 8\n_B = _A + 8\nK = _B + 16\nsubq $K, %rsp\n"),
            [0x48, 0x83, 0xec, 0x20]
        );
    }

    /// The SSSE3 / SSE4.1 / AES / SHA / carry-less families sit on the 0F38 and
    /// 0F3A maps, whose escape byte and operand direction the two-operand and
    /// immediate SSE shapes now carry. The extract forms write their r/m
    /// operand, so their vector operand is the ModRM.reg one. Bytes measured
    /// with GNU as 2.46.1 for the same source.
    #[test]
    fn sse_map38_and_map3a_forms_match_gnu_as() {
        for (src, want) in [
            ("pshufb %xmm7, %xmm2\n", &[0x66, 0x0f, 0x38, 0x00, 0xd7][..]),
            (
                "pshufb 16(%rdi), %xmm10\n",
                &[0x66, 0x44, 0x0f, 0x38, 0x00, 0x57, 0x10][..],
            ),
            ("punpcklqdq %xmm2, %xmm1\n", &[0x66, 0x0f, 0x6c, 0xca][..]),
            ("punpckhqdq %xmm2, %xmm1\n", &[0x66, 0x0f, 0x6d, 0xca][..]),
            (
                "pclmulqdq $0x00, %xmm1, %xmm0\n",
                &[0x66, 0x0f, 0x3a, 0x44, 0xc1, 0x00][..],
            ),
            (
                "pclmulqdq $0x11, %xmm9, %xmm10\n",
                &[0x66, 0x45, 0x0f, 0x3a, 0x44, 0xd1, 0x11][..],
            ),
            (
                "palignr $8, %xmm1, %xmm2\n",
                &[0x66, 0x0f, 0x3a, 0x0f, 0xd1, 0x08][..],
            ),
            (
                "pinsrd $3, 16(%rdi), %xmm1\n",
                &[0x66, 0x0f, 0x3a, 0x22, 0x4f, 0x10, 0x03][..],
            ),
            (
                "pinsrq $1, %rax, %xmm5\n",
                &[0x66, 0x48, 0x0f, 0x3a, 0x22, 0xe8, 0x01][..],
            ),
            // The extract's destination is the r/m: `%eax` sits there, `%xmm1`
            // in ModRM.reg.
            (
                "pextrd $3, %xmm1, %eax\n",
                &[0x66, 0x0f, 0x3a, 0x16, 0xc8, 0x03][..],
            ),
            (
                "pextrd $2, %xmm9, 8(%rsi)\n",
                &[0x66, 0x44, 0x0f, 0x3a, 0x16, 0x4e, 0x08, 0x02][..],
            ),
            (
                "pmovzxdq %xmm1, %xmm2\n",
                &[0x66, 0x0f, 0x38, 0x35, 0xd1][..],
            ),
            ("aesenc %xmm1, %xmm0\n", &[0x66, 0x0f, 0x38, 0xdc, 0xc1][..]),
            (
                "aesenclast %xmm9, %xmm10\n",
                &[0x66, 0x45, 0x0f, 0x38, 0xdd, 0xd1][..],
            ),
            // The SHA extensions take no mandatory prefix.
            ("sha1nexte %xmm1, %xmm0\n", &[0x0f, 0x38, 0xc8, 0xc1][..]),
            ("sha256rnds2 %xmm1, %xmm0\n", &[0x0f, 0x38, 0xcb, 0xc1][..]),
            (
                "sha1rnds4 $3, %xmm1, %xmm0\n",
                &[0x0f, 0x3a, 0xcc, 0xc1, 0x03][..],
            ),
        ] {
            assert_eq!(assemble(src), want, "{src}");
        }
    }

    /// The AVX counterparts: the 0F38 three-operand set, the packed shifts
    /// (destination in VEX.vvvv), the 0F3A lane ops, the lane extracts (whose
    /// `L` follows the wide ModRM.reg source), and the operandless upper-lane
    /// clears. Bytes measured with GNU as 2.46.1 for the same source.
    #[test]
    fn vex_map38_shift_and_lane_forms_match_gnu_as() {
        for (src, want) in [
            (
                "vpshufb %xmm13, %xmm4, %xmm4\n",
                &[0xc4, 0xc2, 0x59, 0x00, 0xe5][..],
            ),
            (
                "vpshufb %ymm13, %ymm0, %ymm0\n",
                &[0xc4, 0xc2, 0x7d, 0x00, 0xc5][..],
            ),
            (
                "vpslld $2, %xmm1, %xmm2\n",
                &[0xc5, 0xe9, 0x72, 0xf1, 0x02][..],
            ),
            (
                "vpsrld $30, %ymm1, %ymm2\n",
                &[0xc5, 0xed, 0x72, 0xd1, 0x1e][..],
            ),
            (
                "vpslldq $8, %xmm0, %xmm1\n",
                &[0xc5, 0xf1, 0x73, 0xf8, 0x08][..],
            ),
            (
                "vpsrldq $4, %xmm11, %xmm12\n",
                &[0xc4, 0xc1, 0x19, 0x73, 0xdb, 0x04][..],
            ),
            (
                "vpclmulqdq $0x01, %xmm0, %xmm1, %xmm14\n",
                &[0xc4, 0x63, 0x71, 0x44, 0xf0, 0x01][..],
            ),
            (
                "vperm2i128 $0x20, %ymm2, %ymm1, %ymm0\n",
                &[0xc4, 0xe3, 0x75, 0x46, 0xc2, 0x20][..],
            ),
            (
                "vinserti128 $1, %xmm2, %ymm1, %ymm0\n",
                &[0xc4, 0xe3, 0x75, 0x38, 0xc2, 0x01][..],
            ),
            (
                "vextracti128 $1, %ymm0, %xmm1\n",
                &[0xc4, 0xe3, 0x7d, 0x39, 0xc1, 0x01][..],
            ),
            (
                "vextracti128 $1, %ymm10, 16(%rdi)\n",
                &[0xc4, 0x63, 0x7d, 0x39, 0x57, 0x10, 0x01][..],
            ),
            ("vzeroupper\n", &[0xc5, 0xf8, 0x77][..]),
            ("vzeroall\n", &[0xc5, 0xfc, 0x77][..]),
            (
                "vaesenc %xmm1, %xmm2, %xmm3\n",
                &[0xc4, 0xe2, 0x69, 0xdc, 0xd9][..],
            ),
        ] {
            assert_eq!(assemble(src), want, "{src}");
        }
    }

    /// A label outside a branch is an operand like any other: `Nf(%%rip)` is
    /// the label's address, `$Nf` its address as an immediate, and a bare `Nf`
    /// the absolute address the boot stubs patch through. The whole stream's
    /// bytes and relocations, measured with GNU as 2.46.1.
    #[test]
    fn label_operands_match_gnu_as() {
        let (bytes, relocs) = assemble_relocs(concat!(
            ".code16\n",
            "cmpb %al, 3f\n",
            "movb %al, 3f\n",
            "addw %bx, 3f\n",
            "3:\n",
            "int $0x10\n",
            ".code32\n",
            "addl %ebx, 2f\n",
            "2:\n",
            ".code64\n",
            "leaq 1f(%rip), %rbp\n",
            "movl 1f(%rip), %eax\n",
            "pushq $1f\n",
            "1:\n",
        ));
        #[rustfmt::skip]
        let want: &[u8] = &[
            0x38, 0x06, 0, 0,                   // cmpb %al, 3f
            0xa2, 0, 0,                         // movb %al, 3f (the moffs form)
            0x01, 0x1e, 0, 0,                   // addw %bx, 3f
            0xcd, 0x10,                         // 3: int $0x10
            0x01, 0x1d, 0, 0, 0, 0,             // addl %ebx, 2f
            // The two RIP-relative references reach a label of this section,
            // so the distance is resolved in place and no relocation is left.
            0x48, 0x8d, 0x2d, 11, 0, 0, 0,      // leaq 1f(%rip), %rbp
            0x8b, 0x05, 5, 0, 0, 0,             // movl 1f(%rip), %eax
            0x68, 0, 0, 0, 0,                   // pushq $1f
        ];
        assert_eq!(bytes, want);
        // A numeric label's relocations name the per-instance symbol the
        // materializer gives its definition.
        let at = |name: &str| alloc::string::String::from(name);
        assert_eq!(
            relocs,
            [
                // The `.code16` address fields are 16 bits wide.
                (2, 2, false, at(".Lc5_asmsec_0_3"), 0),
                (5, 2, false, at(".Lc5_asmsec_0_3"), 0),
                (9, 2, false, at(".Lc5_asmsec_0_3"), 0),
                // A 32-bit address size takes the zero-extended flavour.
                (15, 4, false, at(".Lc5_asmsec_0_2"), 0),
                (33, 4, true, at(".Lc5_asmsec_0_1"), 0),
            ]
        );
    }

    /// AT&T spells an absolute memory reference without the `$` an immediate
    /// carries, so a bare symbol is an address. Its disp32 is sign-extended
    /// into a 64-bit address (`R_X86_64_32S`) and is the whole address under a
    /// narrower address size. Bytes measured with GNU as 2.46.1.
    #[test]
    fn absolute_symbol_memory_operands_match_gnu_as() {
        for (src, bytes, reloc) in [
            (
                "lock btsl $0, tr_lock\n",
                &[0xf0, 0x0f, 0xba, 0x2c, 0x25, 0, 0, 0, 0, 0][..],
                (5u32, 4u8, true, "tr_lock", 0i64),
            ),
            (
                "movl sym, %eax\n",
                &[0x8b, 0x04, 0x25, 0, 0, 0, 0][..],
                (3, 4, true, "sym", 0),
            ),
            // The immediate trails the displacement field.
            (
                "testb $0x80, loadflags\n",
                &[0xf6, 0x04, 0x25, 0, 0, 0, 0, 0x80][..],
                (3, 4, true, "loadflags", 0),
            ),
            (
                ".code16\nlgdtl %cs:wakeup_gdt\n",
                &[0x2e, 0x66, 0x0f, 0x01, 0x16, 0, 0][..],
                (5, 2, false, "wakeup_gdt", 0),
            ),
            (
                ".code16\nmovw sym, %dx\n",
                &[0x8b, 0x16, 0, 0][..],
                (2, 2, false, "sym", 0),
            ),
        ] {
            let (got, relocs) = assemble_relocs(src);
            assert_eq!(got, bytes, "{src}");
            let (off, width, signed, name, addend) = reloc;
            assert_eq!(
                relocs,
                [(
                    off,
                    width,
                    signed,
                    alloc::string::String::from(name),
                    addend
                )],
                "{src}"
            );
        }
    }

    /// An operand's displacement or immediate is an expression over symbols,
    /// not only a symbol name: a difference of two labels of the section folds
    /// into the field, what keeps a symbol relocates against it with the rest
    /// as the addend, and the addend is not confined to the field's width.
    /// The displacement and the immediate relocate independently, so one
    /// instruction may carry both. Bytes and relocations measured with GNU as
    /// 2.46.1 for the same source.
    #[test]
    fn operand_symbol_expressions_match_gnu_as() {
        let at = |name: &str| alloc::string::String::from(name);
        // A symbol less a constant wider than the field: the addend rides the
        // relocation, so it is not truncated to the imm32 it lands in.
        assert_eq!(
            assemble_relocs("addq $(init_top_pgt - 0xffffffff80000000), %rax\n"),
            (
                alloc::vec![0x48, 0x05, 0, 0, 0, 0],
                alloc::vec![(2, 4, true, at("init_top_pgt"), 0x8000_0000)]
            )
        );
        // Two labels of one section: the difference folds and no relocation
        // is left. The field stays the wide one the encoding picked, as GNU
        // as leaves it for a difference it cannot value while encoding.
        assert_eq!(
            assemble_relocs(
                "relocate_kernel:\naddq $(identity_mapped - relocate_kernel), %r8\nnop\n\
                 identity_mapped:\nnop\n"
            ),
            (
                alloc::vec![0x49, 0x81, 0xc0, 0x08, 0, 0, 0, 0x90, 0x90],
                alloc::vec![]
            )
        );
        // A far branch's offset is such a difference (`la57toggle.S`).
        assert_eq!(
            assemble_relocs(
                ".code32\ntrampoline_32bit_src:\nljmpl $(2*8), $(.Lret - trampoline_32bit_src)\n\
                 nop\n.Lret:\nnop\n"
            ),
            (
                alloc::vec![0xea, 0x08, 0, 0, 0, 0x10, 0, 0x90, 0x90],
                alloc::vec![]
            )
        );
        // A symbol displacement and a symbol immediate in one instruction
        // (`wakeup_64.S`): x86 relocates the two fields independently.
        assert_eq!(
            assemble_relocs("movq $.Lresume_point, saved_rip(%rip)\n.Lresume_point:\nnop\n"),
            (
                alloc::vec![0x48, 0xc7, 0x05, 0, 0, 0, 0, 0, 0, 0, 0, 0x90],
                alloc::vec![
                    (3, 4, false, at("saved_rip"), -8),
                    (7, 4, true, at(".Lresume_point"), 0),
                ]
            )
        );
        // A memory displacement over a symbol less a label of this section
        // (`efi-mixed.S`): the label folds into the addend and the symbol
        // keeps the relocation.
        assert_eq!(
            assemble_relocs(".code32\n1:\nleal (efi32_boot_args - 1b)(%ecx), %ebx\n"),
            (
                alloc::vec![0x8d, 0x99, 0, 0, 0, 0],
                alloc::vec![(2, 4, false, at("efi32_boot_args"), 2)]
            )
        );
        // An expression in each of the other displacement forms.
        for (src, bytes, reloc) in [
            (
                "movq (tab + 8)(,%rcx,4), %rbx\n",
                &[0x48, 0x8b, 0x1c, 0x8d, 0, 0, 0, 0][..],
                (4u32, 4u8, true, "tab", 8i64),
            ),
            (
                "movq (tab + 8)(%rbx), %rcx\n",
                &[0x48, 0x8b, 0x8b, 0, 0, 0, 0][..],
                (3, 4, true, "tab", 8),
            ),
            (
                ".code32\nmovl (tab + 4 * 3), %eax\n",
                &[0xa1, 0, 0, 0, 0][..],
                (1, 4, false, "tab", 12),
            ),
            // The AT&T indirect marker leaves the operand form unchanged.
            (
                "jmpq *tr_start(%rip)\n",
                &[0xff, 0x25, 0, 0, 0, 0][..],
                (2, 4, false, "tr_start", -4),
            ),
            // `_ASM_RIP(x)` expands with whitespace inside the reference.
            (
                "movl x86_pred_cmd (% rip), %eax\n",
                &[0x8b, 0x05, 0, 0, 0, 0][..],
                (2, 4, false, "x86_pred_cmd", -4),
            ),
        ] {
            let (got, relocs) = assemble_relocs(src);
            assert_eq!(got, bytes, "{src}");
            let (off, width, signed, name, addend) = reloc;
            assert_eq!(relocs, [(off, width, signed, at(name), addend)], "{src}");
        }
        // An expression the layout cannot value names itself in the
        // diagnostic rather than encoding a wrong field.
        assert!(
            assemble_err("addq $(a - b), %r8\n").contains("subtracts an undefined symbol"),
            "undefined difference"
        );
    }

    /// A `.fill` count is an expression over the layout, the location counter
    /// included (`head_64.S` pads each early IDT entry to a fixed stride).
    /// Bytes measured with GNU as 2.46.1 for the same source.
    #[test]
    fn fill_count_over_location_counter_matches_gnu_as() {
        assert_eq!(
            assemble("base:\nnop\n.fill base + 4 - ., 1, 0xcc\nnop\n"),
            [0x90, 0xcc, 0xcc, 0xcc, 0x90]
        );
    }

    /// A scaled index addresses memory in the hand-written SSE / VEX shapes as
    /// it does in the catalogue: the SIB byte with REX.X / VEX.X carrying the
    /// index's high bit. Bytes measured with GNU as 2.46.1.
    #[test]
    fn scaled_index_memory_operands_match_gnu_as() {
        for (src, want) in [
            (
                "crc32q (%rsi,%rcx), %r8\n",
                &[0xf2, 0x4c, 0x0f, 0x38, 0xf1, 0x04, 0x0e][..],
            ),
            (
                "movd (%rsi,%rax,4), %xmm4\n",
                &[0x66, 0x0f, 0x6e, 0x24, 0x86][..],
            ),
            (
                "movdqu -16(%rsi,%rdx), %xmm2\n",
                &[0xf3, 0x0f, 0x6f, 0x54, 0x16, 0xf0][..],
            ),
            (
                "movdqu %xmm7, 16(%rsp,%rbx,8)\n",
                &[0xf3, 0x0f, 0x7f, 0x7c, 0xdc, 0x10][..],
            ),
            // A high index sets VEX.X, which forces the 3-byte form.
            (
                "vpaddd (%rsi,%r13,4), %ymm4, %ymm9\n",
                &[0xc4, 0x21, 0x5d, 0xfe, 0x0c, 0xae][..],
            ),
            (
                "pshufb (%r8,%r9,2), %xmm3\n",
                &[0x66, 0x43, 0x0f, 0x38, 0x00, 0x1c, 0x48][..],
            ),
            // No base register: SIB.base = 101 with a disp32.
            (
                "movd (,%rax,4), %xmm4\n",
                &[0x66, 0x0f, 0x6e, 0x24, 0x85, 0, 0, 0, 0][..],
            ),
        ] {
            assert_eq!(assemble(src), want, "{src}");
        }
    }

    /// The BMI / BMI2 set encodes with VEX but names no vector register:
    /// VEX.W follows the operand width and VEX.L is zero. The shift-like ops
    /// hold their count in VEX.vvvv, so their AT&T sources are the other way
    /// round from `andn` and friends. Bytes measured with GNU as 2.46.1.
    #[test]
    fn vex_general_register_forms_match_gnu_as() {
        for (src, want) in [
            (
                "rorx $2, %esi, %esi\n",
                &[0xc4, 0xe3, 0x7b, 0xf0, 0xf6, 0x02][..],
            ),
            (
                "rorx $25, %edx, %r13d\n",
                &[0xc4, 0x63, 0x7b, 0xf0, 0xea, 0x19][..],
            ),
            // A quadword operand sets VEX.W.
            (
                "rorx $7, %rax, %rbx\n",
                &[0xc4, 0xe3, 0xfb, 0xf0, 0xd8, 0x07][..],
            ),
            (
                "rorx $3, 8(%rdi), %ecx\n",
                &[0xc4, 0xe3, 0x7b, 0xf0, 0x4f, 0x08, 0x03][..],
            ),
            (
                "andn %eax, %ebx, %ecx\n",
                &[0xc4, 0xe2, 0x60, 0xf2, 0xc8][..],
            ),
            (
                "andn %rax, %rbx, %rcx\n",
                &[0xc4, 0xe2, 0xe0, 0xf2, 0xc8][..],
            ),
            (
                "bzhi %eax, %ebx, %ecx\n",
                &[0xc4, 0xe2, 0x78, 0xf5, 0xcb][..],
            ),
            (
                "sarx %ecx, %eax, %edx\n",
                &[0xc4, 0xe2, 0x72, 0xf7, 0xd0][..],
            ),
            (
                "shlx %ecx, %eax, %edx\n",
                &[0xc4, 0xe2, 0x71, 0xf7, 0xd0][..],
            ),
            (
                "shrx %rcx, %rax, %rdx\n",
                &[0xc4, 0xe2, 0xf3, 0xf7, 0xd0][..],
            ),
            (
                "sarx %ecx, (%rdi,%rsi,4), %edx\n",
                &[0xc4, 0xe2, 0x72, 0xf7, 0x14, 0xb7][..],
            ),
        ] {
            assert_eq!(assemble(src), want, "{src}");
        }
    }

    /// Bespoke-path memory forms (x87, mxcsr, cmpxchg16b, the MMX / SSE
    /// quadword moves, segment moves, crc32, and the indirect far branches)
    /// follow the address size: a 16-bit address takes the 16-bit r/m
    /// numbering and a non-default one the `67` prefix, ahead of any
    /// operand-size or mandatory prefix. Bytes measured with GNU as 2.46.1
    /// and clang for the same source.
    #[test]
    fn bespoke_memory_forms_follow_the_address_size() {
        #[rustfmt::skip]
        let cases: &[(&str, &[u8])] = &[
            (".code16\nljmp *(%bx)\n",           &[0xff, 0x2f]),
            (".code16\nljmpw *(%bx)\n",          &[0xff, 0x2f]),
            (".code16\nlcall *8(%bp,%si)\n",     &[0xff, 0x5a, 0x08]),
            (".code16\nlcalll *(%bx)\n",         &[0x66, 0xff, 0x1f]),
            (".code16\nljmpl *(%eax)\n",         &[0x67, 0x66, 0xff, 0x28]),
            (".code16\nfnstsw (%bx)\n",          &[0xdd, 0x3f]),
            (".code16\nfnstsw 2(%bx,%si)\n",     &[0xdd, 0x78, 0x02]),
            (".code16\nfnstcw -2(%bp)\n",        &[0xd9, 0x7e, 0xfe]),
            (".code16\nfldl (%si)\n",            &[0xdd, 0x04]),
            (".code16\nfstpl 6(%di)\n",          &[0xdd, 0x5d, 0x06]),
            (".code16\nfistpl -4(%bp,%di)\n",    &[0xdb, 0x5b, 0xfc]),
            (".code16\nldmxcsr (%bx,%si)\n",     &[0x0f, 0xae, 0x10]),
            (".code16\nstmxcsr (%bp)\n",         &[0x0f, 0xae, 0x5e, 0x00]),
            (".code32\nfnstsw (%bx)\n",          &[0x67, 0xdd, 0x3f]),
            (".code32\nlcall *8(%bp,%si)\n",     &[0x67, 0xff, 0x5a, 0x08]),
            (".code32\nljmp *(%bx)\n",           &[0x67, 0xff, 0x2f]),
            ("fnstsw (%eax)\n",                  &[0x67, 0xdd, 0x38]),
            ("ldmxcsr (%ebx)\n",                 &[0x67, 0x0f, 0xae, 0x13]),
            ("cmpxchg16b (%ebx)\n",              &[0x67, 0x48, 0x0f, 0xc7, 0x0b]),
            ("movq (%ebx), %mm0\n",              &[0x67, 0x0f, 0x6f, 0x03]),
            ("movq %xmm3, (%edi)\n",             &[0x67, 0x66, 0x0f, 0xd6, 0x1f]),
            ("movq (%ecx), %xmm2\n",             &[0x67, 0xf3, 0x0f, 0x7e, 0x11]),
            ("mov %ds, (%eax)\n",                &[0x67, 0x8c, 0x18]),
            ("mov (%eax), %ds\n",                &[0x67, 0x8e, 0x18]),
            ("crc32w (%ebx), %ecx\n",            &[0x67, 0x66, 0xf2, 0x0f, 0x38, 0xf1, 0x0b]),
        ];
        for (src, want) in cases {
            assert_eq!(assemble(src), *want, "{src}");
        }
        // The 16-bit r/m forms carry no scale and only bx / bp with si / di.
        assert!(assemble_err(".code16\nfnstsw (%bx,%bp)\n").contains("bx / bp with si / di"));
        assert!(assemble_err(".code16\nfnstsw (%bx,%si,2)\n").contains("no scale"));
    }

    /// `mov` between a segment register and a GPR moves 16 bits: 8C writes
    /// and zero-extends, 8E reads. REX.W is unused in both directions, and
    /// 8E's operand size is the opcode's rather than the register's, so only
    /// an 8C with a 16-bit destination takes the `66` prefix. The GDT reload
    /// in `arch/x86/kernel/relocate_kernel_64.S` writes the 64-bit pair.
    /// Bytes measured with GNU as 2.46.1 for the same source.
    #[test]
    fn segment_register_moves_take_no_rex_w() {
        #[rustfmt::skip]
        let cases: &[(&str, &[u8])] = &[
            ("mov %ds, %rax\n",      &[0x8c, 0xd8]),
            ("mov %rax, %ds\n",      &[0x8e, 0xd8]),
            ("mov %ds, %eax\n",      &[0x8c, 0xd8]),
            ("mov %eax, %ds\n",      &[0x8e, 0xd8]),
            ("mov %ds, %ax\n",       &[0x66, 0x8c, 0xd8]),
            ("mov %ax, %ds\n",       &[0x8e, 0xd8]),
            ("mov %fs, %r8\n",       &[0x41, 0x8c, 0xe0]),
            ("mov %fs, %r8d\n",      &[0x41, 0x8c, 0xe0]),
            ("mov %fs, %r8w\n",      &[0x66, 0x41, 0x8c, 0xe0]),
            ("mov %r8, %fs\n",       &[0x41, 0x8e, 0xe0]),
            ("mov %r8w, %fs\n",      &[0x41, 0x8e, 0xe0]),
            ("mov %gs, %rbx\n",      &[0x8c, 0xeb]),
            ("mov %rbx, %gs\n",      &[0x8e, 0xeb]),
            ("mov %ds, (%rax)\n",    &[0x8c, 0x18]),
            ("mov (%rax), %ds\n",    &[0x8e, 0x18]),
            ("mov %ds, (%r9)\n",     &[0x41, 0x8c, 0x19]),
        ];
        for (src, want) in cases {
            assert_eq!(assemble(src), *want, "{src}");
        }
    }

    /// An explicit size suffix on `push` / `pop` selects the stack operand
    /// size in every mode: the `66` prefix when it is not the mode default,
    /// the immediate field width, and the shortest immediate form. Long mode
    /// has no 32-bit stack operand and the other modes no 64-bit one. Bytes
    /// measured with GNU as 2.46.1 and clang for the same source.
    #[test]
    fn push_pop_suffix_selects_the_stack_operand_size() {
        #[rustfmt::skip]
        let cases: &[(&str, &[u8])] = &[
            ("pushw (%rax)\n",           &[0x66, 0xff, 0x30]),
            ("popw (%rax)\n",            &[0x66, 0x8f, 0x00]),
            (".code16\npushl $0\n",      &[0x66, 0x6a, 0x00]),
            (".code16\npushw $0\n",      &[0x6a, 0x00]),
            (".code32\npushw $0\n",      &[0x66, 0x6a, 0x00]),
            ("pushw $0\n",               &[0x66, 0x6a, 0x00]),
            ("pushq $0\n",               &[0x6a, 0x00]),
            ("pushw $-129\n",            &[0x66, 0x68, 0x7f, 0xff]),
            (".code16\npushw $0x1234\n", &[0x68, 0x34, 0x12]),
            (".code16\npush $0x1234\n",  &[0x68, 0x34, 0x12]),
            (".code16\npushl $0x12345\n", &[0x66, 0x68, 0x45, 0x23, 0x01, 0x00]),
            (".code16\npushw (%bx)\n",   &[0xff, 0x37]),
            (".code16\npushl (%bx)\n",   &[0x66, 0xff, 0x37]),
            (".code16\npopl (%bx)\n",    &[0x66, 0x8f, 0x07]),
            (".code32\npushw (%eax)\n",  &[0x66, 0xff, 0x30]),
            (".code16\npushw %ax\n",     &[0x50]),
            (".code16\npushl %eax\n",    &[0x66, 0x50]),
            (".code16\npopl %eax\n",     &[0x66, 0x58]),
            ("pushw %ax\n",              &[0x66, 0x50]),
            ("popw %ax\n",               &[0x66, 0x58]),
        ];
        for (src, want) in cases {
            assert_eq!(assemble(src), *want, "{src}");
        }
        for src in [
            "pushl $0\n",
            ".code16\npushq $0\n",
            ".code32\npushq $0\n",
            ".code16\npushq %rax\n",
        ] {
            assert!(assemble_err(src).contains("not encodable"), "{src}");
        }
    }

    /// A `push` symbol immediate's field is the spelled operand size wide,
    /// so its relocation is too.
    #[test]
    fn push_symbol_immediate_field_follows_the_operand_size() {
        let s = alloc::string::String::from("s");
        let (bytes, relocs) = assemble_relocs(".code16\npushw $s\n");
        assert_eq!(bytes, [0x68, 0, 0]);
        assert_eq!(relocs, [(1, 2, false, s.clone(), 0)]);
        let (bytes, relocs) = assemble_relocs(".code16\npushl $s\n");
        assert_eq!(bytes, [0x66, 0x68, 0, 0, 0, 0]);
        assert_eq!(relocs, [(2, 4, false, s.clone(), 0)]);
        let (bytes, relocs) = assemble_relocs("pushw $s\n");
        assert_eq!(bytes, [0x66, 0x68, 0, 0]);
        assert_eq!(relocs, [(2, 2, false, s, 0)]);
    }
}
