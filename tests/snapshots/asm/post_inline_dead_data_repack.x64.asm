
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
               	leaq	<rip>, %rcx
               	addq	$0x18, %rcx
               	leaq	<rip>, %rdx
               	addq	$0x18, %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
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
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movq	$0x19, 0x10(%rcx)
               	cmpq	$0x0, (%rcx)
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movq	0x10(%rcx), %rcx
               	cmpq	$0x19, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	cmpq	$0x0, 0x18(%rcx)
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
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
