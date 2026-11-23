
compound_literal_of_pointer_type_is_an_object.x64:	file format elf64-x86-64

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

<h>:
               	movl	$0x2a, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x60(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	movq	%rax, -0x58(%rbp)
               	leaq	-0x58(%rbp), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	addq	$0x2, %rax
               	movq	%rax, -0x58(%rbp)
               	movsbq	(%rax), %rax
               	cmpl	$0x74, %eax
               	jne	<addr>
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, -0x58(%rbp)
               	cmpq	%rax, %rcx
               	je	<addr>
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	jne	<addr>
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	jne	<addr>
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	jne	<addr>
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	leave
               	retq
