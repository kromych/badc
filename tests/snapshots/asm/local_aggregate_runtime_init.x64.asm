
local_aggregate_runtime_init.x64:	file format elf64-x86-64

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
               	subq	$0x70, %rsp
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	popq	%rdx
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	leaq	-0x18(%rbp), %rdx
               	movl	%eax, (%rdx)
               	movl	$0x68, %edx
               	leaq	-0x18(%rbp), %rax
               	movb	%dl, 0x4(%rax)
               	movl	$0x6f, %edx
               	leaq	-0x18(%rbp), %rax
               	movb	%dl, 0x5(%rax)
               	movl	$0x6c, %edx
               	leaq	-0x18(%rbp), %rax
               	movb	%dl, 0x6(%rax)
               	movl	$0x61, %edx
               	leaq	-0x18(%rbp), %rax
               	movb	%dl, 0x7(%rax)
               	xorq	%rax, %rax
               	leaq	-0x18(%rbp), %rdx
               	movb	%al, 0x8(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movb	%al, 0x9(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movb	%al, 0xa(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movb	%al, 0xb(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movb	%al, 0xc(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movb	%al, 0xd(%rdx)
               	leaq	-0x18(%rbp), %rax
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movsbq	0x4(%rax), %rax
               	cmpq	$0x68, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %edx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movsbq	0x5(%rax), %rax
               	cmpq	$0x6f, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %eax
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movsbq	0x6(%rax), %rax
               	cmpq	$0x6c, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movsbq	0x7(%rax), %rax
               	cmpq	$0x61, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movsbq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movsbq	0xd(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movq	0x10(%rax), %rax
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movzbq	0x8(%rdx), %rcx
               	movb	%cl, 0x8(%rax)
               	movzbq	0x9(%rdx), %rcx
               	movb	%cl, 0x9(%rax)
               	movzbq	0xa(%rdx), %rcx
               	movb	%cl, 0xa(%rax)
               	movzbq	0xb(%rdx), %rcx
               	movb	%cl, 0xb(%rax)
               	popq	%rcx
               	movslq	(%rcx), %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	leaq	-0x28(%rbp), %rax
               	movl	%ecx, 0x4(%rax)
               	movl	$0x5, %ecx
               	leaq	-0x28(%rbp), %rax
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x28(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x3, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rax
               	cmpq	$0x6f, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsbq	0x1(%rcx), %rax
               	cmpq	$0x6b, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
