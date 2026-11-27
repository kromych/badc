
volatile_pointer_object_cell.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x28, %rsp
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, 0x8(%rsp)
               	movq	0x8(%rsp), %rdx
               	movq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	leaq	<rip>, %rdx # <addr>
               	movq	%rdx, 0x8(%rsp)
               	movq	0x8(%rsp), %rdx
               	movq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	cmpq	$0x3c, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	movq	%rax, 0x10(%rsp)
               	movq	0x10(%rsp), %rax
               	movq	(%rax), %rax
               	movq	0x10(%rsp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movq	0x10(%rsp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x3, %eax
               	movq	%rax, <rip> # <addr>
               	movq	%rcx, 0x18(%rsp)
               	movq	0x18(%rsp), %rcx
               	movq	(%rcx), %rcx
               	movq	0x18(%rsp), %rdx
               	movq	$0x5, (%rdx)
               	movq	0x18(%rsp), %rdx
               	movq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	cmpq	$0x8, %rcx
               	je	<addr>
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
