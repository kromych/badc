
empty_declaration.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x10(%rbp), %rax
               	movl	$0x7, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x9, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x9, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	$0x3, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	$0x4, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	movl	$0x7a, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x28(%rbp), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x7a, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0xb, %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rdx
               	movl	$0xc, %ecx
               	movl	%ecx, (%rdx)
               	movslq	(%rax), %rax
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
