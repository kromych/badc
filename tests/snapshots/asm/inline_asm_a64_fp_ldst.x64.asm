
inline_asm_a64_fp_ldst.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movabsq	$0x4045000000000000, %rcx # imm = 0x4045000000000000
               	xorq	%rax, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rbp,%riz)
               	movq	-0x8(%rbp), %rdx
               	movabsq	$0x4045000000000000, %r11 # imm = 0x4045000000000000
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movl	$0x2a, %eax
               	movslq	%eax, %rax
               	leave
               	retq
