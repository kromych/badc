
post_inline_dead_data_repack.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	leaq	0x18(%rax), %rcx
               	cmpq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdx
               	movq	%rcx, %rdx
               	movq	%rcx, %rdx
               	leaq	<rip>, %rcx
               	andq	$0x3f, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x7, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	0x8(%rcx), %rcx
               	cmpq	$0x9, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movl	$0x19, %edx
               	movq	%rdx, 0x10(%rcx)
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	0x10(%rcx), %rcx
               	cmpq	$0x19, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	0x18(%rcx), %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x28, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rcx
               	leaq	<rip>, %rax
               	movq	0x10(%rax), %r8
               	movb	$0x0, %al
               	callq	<addr>
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
