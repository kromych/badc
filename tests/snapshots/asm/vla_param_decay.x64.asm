
vla_param_decay.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	leaq	-0x20(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	leaq	-0x10(%rbp), %r8
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r8)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r8)
               	popq	%rcx
               	movq	%r8, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	movslq	%eax, %rsi
               	movq	%rsi, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rdi,%rdx), %r9
               	movslq	(%r9), %r9
               	addq	%r8, %rdx
               	movslq	(%rdx), %rdx
               	imulq	%r9, %rdx
               	addq	%rdx, %rcx
               	leaq	0x1(%rsi), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movslq	%ecx, %rax
               	cmpl	$0x46, %eax
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
