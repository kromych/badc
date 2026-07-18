
unroll_const_trip_copy.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x4, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	<rip>, %rax
               	movl	$0x7, %ecx
               	movq	%rcx, 0x10(%rax)
               	leaq	<rip>, %rax
               	movl	$0xa, %ecx
               	movq	%rcx, 0x18(%rax)
               	leaq	<rip>, %rax
               	movl	$0xd, %ecx
               	movq	%rcx, 0x20(%rax)
               	leaq	<rip>, %rax
               	movl	$0x10, %ecx
               	movq	%rcx, 0x28(%rax)
               	leaq	<rip>, %rax
               	movl	$0x13, %ecx
               	movq	%rcx, 0x30(%rax)
               	leaq	<rip>, %rax
               	movl	$0x16, %ecx
               	movq	%rcx, 0x38(%rax)
               	leaq	<rip>, %rax
               	addq	$0x0, %rax
               	leaq	<rip>, %rcx
               	addq	$0x0, %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	0x8(%rcx), %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	0x10(%rcx), %rcx
               	movq	%rcx, 0x10(%rax)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	0x18(%rcx), %rcx
               	movq	%rcx, 0x18(%rax)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	0x20(%rcx), %rcx
               	movq	%rcx, 0x20(%rax)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	0x28(%rcx), %rcx
               	movq	%rcx, 0x28(%rax)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	0x30(%rcx), %rcx
               	movq	%rcx, 0x30(%rax)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	0x38(%rcx), %rcx
               	movq	%rcx, 0x38(%rax)
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
               	xorq	%rax, %rax
               	retq
