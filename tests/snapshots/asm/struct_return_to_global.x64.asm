
struct_return_to_global.x64:	file format elf64-x86-64

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
               	xorq	%rax, %rax
               	leaq	<rip>, %r8
               	movl	$0x6, %ecx
               	movl	$0x1, %esi
               	movq	%rcx, (%r8)
               	movq	%rsi, 0x8(%r8)
               	leaq	<rip>, %rdi
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movslq	%eax, %rcx
               	movq	%rcx, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	imulq	$0xa, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, (%rdx)
               	movq	%rsi, 0x8(%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	leaq	0x7(%rax), %rcx
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	leaq	<rip>, %rax
               	addq	$0x20, %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	addq	%rax, %rcx
               	leaq	<rip>, %rax
               	addq	$0x30, %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	movl	$0x3, %ecx
               	movl	$0x4, %edx
               	movq	%rcx, (%r8)
               	movq	%rdx, 0x8(%r8)
               	movq	(%r8), %rcx
               	movq	0x8(%r8), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	cmpq	$0x4e, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
