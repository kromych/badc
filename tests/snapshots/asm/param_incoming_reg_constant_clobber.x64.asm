
param_incoming_reg_constant_clobber.x64:	file format elf64-x86-64

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

<func_10>:
               	movq	%rdx, %rdi
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rax
               	movzwq	(%rax), %rax
               	movsbq	%al, %rax
               	testl	%eax, %eax
               	jl	<addr>
               	cmpl	$0x1, %eax
               	jle	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	orq	$0x5, %rax
               	movl	%eax, %eax
               	movq	%rax, %rdx
               	shrq	$0x2, %rdx
               	shlq	$0x2, %rdx
               	subq	%rdx, %rax
               	movswq	%ax, %rax
               	movq	(%rcx), %rcx
               	movzwq	(%rcx), %rcx
               	movswq	%cx, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	cmpl	$0xffff8000, %eax       # imm = 0xFFFF8000
               	jne	<addr>
               	cmpl	$-0x1, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rsi
               	movl	(%rsi), %eax
               	cmpl	$0x5, %eax
               	ja	<addr>
               	movslq	(%rdi), %rax
               	movl	%eax, (%rdi)
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movl	(%rsi), %eax
               	incq	%rax
               	movl	%eax, (%rsi)
               	movl	(%rsi), %eax
               	cmpl	$0x5, %eax
               	jbe	<addr>
               	leaq	<rip>, %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	retq
               	cqto
               	idivq	%rcx
               	movswq	%ax, %rax
               	jmp	<addr>
               	shlq	$0x6, %rax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x5, %esi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rdi
               	leaq	<rip>, %rdx
               	movq	%rsi, %rcx
               	movq	%rsi, %r8
               	callq	<addr>
               	movq	%rax, -0x8(%rbp)
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	xorq	$0x6, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
