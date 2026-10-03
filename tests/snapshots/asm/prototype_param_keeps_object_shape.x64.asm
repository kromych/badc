
prototype_param_keeps_object_shape.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax      # <addr>
               	leaq	0x10(%rax), %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	shrq	$0x3e, %rax
               	addq	%rcx, %rax
               	sarq	$0x2, %rax
               	cmpq	$0x4, %rax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	leaq	0x30(%rax), %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	shrq	$0x3e, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x2, %rcx
               	cmpq	$0xc, %rcx
               	jne	<addr>
               	leaq	0x10(%rax), %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %rax
               	sarq	$0x3f, %rax
               	shrq	$0x3e, %rax
               	addq	%rcx, %rax
               	sarq	$0x2, %rax
               	cmpq	$0x4, %rax
               	jne	<addr>
               	leaq	<rip>, %rax       # <addr>
               	leaq	0x6(%rax), %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %rax
               	shrq	$0x3f, %rax
               	addq	%rcx, %rax
               	sarq	%rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movl	$0x9, -0x8(%rbp)
               	leaq	<rip>, %rax      # <addr>
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x5, %eax
               	leave
               	retq
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	leave
               	retq
