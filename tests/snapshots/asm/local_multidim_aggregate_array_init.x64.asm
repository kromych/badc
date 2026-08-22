
local_multidim_aggregate_array_init.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	leaq	-0x20(%rbp), %rcx
               	leaq	<rip>, %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	movq	0x18(%rax), %rdx
               	movq	%rdx, 0x18(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	movq	0x10(%rdx), %rax
               	movq	%rax, 0x10(%rcx)
               	movq	0x18(%rdx), %rax
               	movq	%rax, 0x18(%rcx)
               	popq	%rax
               	movq	%rax, %rcx
               	leaq	-0x40(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	movq	0x10(%rdx), %rax
               	movq	%rax, 0x10(%rcx)
               	movq	0x18(%rdx), %rax
               	movq	%rax, 0x18(%rcx)
               	movq	0x20(%rdx), %rax
               	movq	%rax, 0x20(%rcx)
               	movq	0x28(%rdx), %rax
               	movq	%rax, 0x28(%rcx)
               	movq	0x30(%rdx), %rax
               	movq	%rax, 0x30(%rcx)
               	movq	0x38(%rdx), %rax
               	movq	%rax, 0x38(%rcx)
               	popq	%rax
               	movq	%rax, %rcx
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
