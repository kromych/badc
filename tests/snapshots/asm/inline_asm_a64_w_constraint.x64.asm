
inline_asm_a64_w_constraint.x64:	file format elf64-x86-64

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
               	movabsq	$0x4045000000000000, %rax # imm = 0x4045000000000000
               	leaq	-0x8(%rbp), %rcx
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rcx)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x8(%rbp), %rax
               	movsd	(%rax,%riz), %xmm0
               	leaq	-0x8(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movsd	%xmm0, (%rax,%riz)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movabsq	$0x4045000000000000, %r11 # imm = 0x4045000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movl	$0x2a, %eax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
