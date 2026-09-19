
unroll_const_trip_copy.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movq	$0x1, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x4, 0x8(%rax)
               	leaq	<rip>, %rax
               	movq	$0x7, 0x10(%rax)
               	leaq	<rip>, %rax
               	movq	$0xa, 0x18(%rax)
               	leaq	<rip>, %rax
               	movq	$0xd, 0x20(%rax)
               	leaq	<rip>, %rax
               	movq	$0x10, 0x28(%rax)
               	leaq	<rip>, %rax
               	movq	$0x13, 0x30(%rax)
               	leaq	<rip>, %rax
               	movq	$0x16, 0x38(%rax)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x20(%rax)
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	movq	0x30(%rcx), %rdx
               	movq	%rdx, 0x30(%rax)
               	movq	0x38(%rcx), %rdx
               	movq	%rdx, 0x38(%rax)
               	popq	%rdx
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	shlq	$0x0, %rax
               	leaq	(%rax), %rcx
               	leaq	<rip>, %rax
               	movq	0x10(%rax), %rax
               	shlq	%rax
               	addq	%rax, %rcx
               	leaq	<rip>, %rax
               	movq	0x18(%rax), %rax
               	leaq	(%rax,%rax,2), %rax
               	addq	%rax, %rcx
               	leaq	<rip>, %rax
               	movq	0x20(%rax), %rax
               	shlq	$0x2, %rax
               	addq	%rax, %rcx
               	leaq	<rip>, %rax
               	movq	0x28(%rax), %rax
               	leaq	(%rax,%rax,4), %rax
               	addq	%rax, %rcx
               	leaq	<rip>, %rax
               	movq	0x30(%rax), %rax
               	imulq	$0x6, %rax, %rax
               	addq	%rax, %rcx
               	leaq	<rip>, %rax
               	movq	0x38(%rax), %rax
               	imulq	$0x7, %rax, %rax
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	addq	$0x0, %rcx
               	movq	(%rcx), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	cmpq	$0x1c8, %rax            # imm = 0x1C8
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorl	%eax, %eax
               	retq
