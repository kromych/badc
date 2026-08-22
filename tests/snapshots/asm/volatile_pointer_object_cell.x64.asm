
volatile_pointer_object_cell.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	leaq	<rip>, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	movq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x3, %ecx
               	movq	%rcx, (%rax)
               	movq	%rax, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movq	-0x8(%rbp), %rcx
               	movl	$0x5, %edx
               	movq	%rdx, (%rcx)
               	movq	-0x8(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
