
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

<func_1>:
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
               	xorl	%eax, %eax
               	leave
               	retq

<func_10>:
               	movl	$0x5, %esi
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
               	orq	%rsi, %rax
               	movq	%rax, %rdx
               	shrq	$0x2, %rdx
               	shlq	$0x2, %rdx
               	subq	%rdx, %rax
               	movq	(%rcx), %rcx
               	movzwq	(%rcx), %rcx
               	movswq	%ax, %rax
               	movswq	%cx, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	cmpl	$0xffff8000, %eax       # imm = 0xFFFF8000
               	jne	<addr>
               	cmpl	$-0x1, %ecx
               	jne	<addr>
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rcx
               	movslq	(%rsi), %rax
               	cmpl	$0x5, %eax
               	jg	<addr>
               	movslq	(%rdi), %rax
               	movl	%eax, (%rdi)
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	(%rsi), %rax
               	incq	%rax
               	movl	%eax, (%rsi)
               	movslq	(%rsi), %rax
               	cmpl	$0x5, %eax
               	jle	<addr>
               	leaq	<rip>, %rax
               	movzwq	(%rax), %rax
               	retq
               	cqto
               	idivq	%rcx
               	jmp	<addr>
               	shlq	$0x6, %rax
               	jmp	<addr>

<func_17>:
               	leaq	<rip>, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movl	$0x5, %esi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rdi
               	leaq	<rip>, %rdx
               	movq	%rsi, %rcx
               	movq	%rsi, %r8
               	callq	<addr>
               	movq	%rax, -0x50(%rbp)
               	leaq	<rip>, %rax
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
