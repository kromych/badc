
code_slot_read_by_a_later_initializer.x64:	file format elf64-x86-64

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

<fe>:
               	movl	$0x5, %eax
               	retq

<fb>:
               	movl	$0x2, %eax
               	retq

<fc>:
               	movl	$0x3, %eax
               	retq

<fd>:
               	movl	$0x4, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	leaq	-<rip>, %rdx       # <addr>
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	leaq	-<rip>, %rdx       # <addr>
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	leaq	-<rip>, %rax       # <addr>
               	subq	%rax, %rcx
               	cmpq	$0x8, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx       # <addr>
               	movq	(%rcx), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x8, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	leaq	-<rip>, %rax       # <addr>
               	subq	%rax, %rcx
               	cmpq	$0xc, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rdx
               	cmpq	%rax, %rdx
               	jne	<addr>
               	movq	(%rcx), %rax
               	callq	*%rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	leaq	-<rip>, %rax       # <addr>
               	subq	%rax, %rcx
               	cmpq	$0x2, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx       # <addr>
               	movq	0x8(%rcx), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x2, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
