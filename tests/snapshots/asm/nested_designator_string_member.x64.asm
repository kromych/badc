
nested_designator_string_member.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax # <addr>
               	addq	$0x4, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	cmpb	$0x0, <rip> # <addr>
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movb	$0x77, -0xc(%rbp)
               	movb	$0x78, -0xb(%rbp)
               	movb	$0x79, -0xa(%rbp)
               	movb	$0x7a, -0x9(%rbp)
               	movb	$0x0, -0x8(%rbp)
               	movb	$0x0, -0x7(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	movb	$0x0, -0x6(%rbp)
               	movb	$0x0, -0x5(%rbp)
               	leaq	0x6(%rdi), %rax
               	movl	%eax, -0x4(%rbp)
               	leaq	0x4(%rdi), %rax
               	movl	%eax, -0x10(%rbp)
               	leaq	0x4(%rcx), %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rcx), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	-0x4(%rbp), %eax
               	leaq	0x6(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	-0x10(%rbp), %eax
               	leaq	0x4(%rdi), %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
