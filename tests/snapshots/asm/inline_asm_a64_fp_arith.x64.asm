
inline_asm_a64_fp_arith.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	movabsq	$0x4018000000000000, %rax # imm = 0x4018000000000000
               	movabsq	$0x4020000000000000, %rcx # imm = 0x4020000000000000
               	movabsq	$-0x3fe8000000000000, %rdx # imm = 0xC018000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	movq	%rdx, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	cvttsd2si	%xmm0, %rax
               	movslq	%eax, %rax
               	retq
