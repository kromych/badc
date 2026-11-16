
inline_indirect_call_region_share.x64:	file format elf64-x86-64

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

<twice>:
               	movq	(%rdi), %rax
               	shlq	%rax
               	movq	%rax, (%rdi)
               	retq

<negate>:
               	movq	(%rdi), %rax
               	negq	%rax
               	movq	%rax, (%rdi)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x20(%rbp), %rcx
               	movq	$0x3, -0x20(%rbp)
               	movq	$0x4, -0x18(%rbp)
               	movq	$0x5, -0x10(%rbp)
               	movq	$0x6, -0x8(%rbp)
               	leaq	0x8(%rcx), %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	leaq	-0x20(%rbp), %rax
               	leaq	0x18(%rax), %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movq	-0x20(%rbp), %rax
               	movq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x8(%rbp), %rcx
               	leaq	(%rax,%rcx), %r10
               	movq	%r10, 0x8(%rsp)
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	$0xa, -0x20(%rbp)
               	movq	$0xb, -0x18(%rbp)
               	movq	$0xc, -0x10(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	$0xd, -0x8(%rbp)
               	leaq	0x8(%rax), %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	leaq	-0x20(%rbp), %rax
               	leaq	0x18(%rax), %rdi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	movq	-0x20(%rbp), %rax
               	movq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	0x8(%rsp), %rcx
               	cmpq	$0x1c, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	cmpq	$-0x2, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
