
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
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	leaq	-0x10(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movslq	%eax, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rsi,%rdx), %r8
               	movslq	(%r8), %r8
               	addq	%rdi, %rdx
               	movslq	(%rdx), %rdx
               	imulq	%r8, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	cmpl	$0x46, %ecx
               	jne	<addr>
               	xorl	%eax, %eax
               	movslq	%eax, %rax
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
