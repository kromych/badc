
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
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	leaq	-0x18(%rbp), %rdx
               	movl	%ecx, (%rdx)
               	movl	$0x68, %ecx
               	leaq	-0x18(%rbp), %rdx
               	movb	%cl, 0x4(%rdx)
               	movl	$0x6f, %ecx
               	leaq	-0x18(%rbp), %rdx
               	movb	%cl, 0x5(%rdx)
               	movl	$0x6c, %ecx
               	leaq	-0x18(%rbp), %rdx
               	movb	%cl, 0x6(%rdx)
               	movl	$0x61, %ecx
               	leaq	-0x18(%rbp), %rdx
               	movb	%cl, 0x7(%rdx)
               	xorq	%rcx, %rcx
               	leaq	-0x18(%rbp), %rdx
               	movb	%cl, 0x8(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movb	%cl, 0x9(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movb	%cl, 0xa(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movb	%cl, 0xb(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movb	%cl, 0xc(%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movb	%cl, 0xd(%rdx)
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, 0x10(%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x3, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rcx
               	movsbq	0x4(%rcx), %rcx
               	cmpq	$0x68, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %esi
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movsbq	0x5(%rcx), %rcx
               	cmpq	$0x6f, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%sil
               	movzbq	%sil, %rsi
               	movl	$0x1, %edx
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movsbq	0x6(%rcx), %rcx
               	cmpq	$0x6c, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movsbq	0x7(%rcx), %rcx
               	cmpq	$0x61, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rcx
               	movsbq	0x8(%rcx), %rcx
               	testq	%rcx, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movsbq	0xd(%rcx), %rcx
               	testq	%rcx, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rcx
               	movq	0x10(%rcx), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movzbq	0x8(%rdx), %rax
               	movb	%al, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rax
               	movb	%al, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rax
               	movb	%al, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rax
               	movb	%al, 0xb(%rcx)
               	popq	%rax
               	movslq	(%rax), %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	%eax, 0x4(%rcx)
               	movl	$0x5, %eax
               	leaq	-0x28(%rbp), %rcx
               	movl	%eax, 0x8(%rcx)
               	leaq	-0x28(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %edx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x5, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rcx
               	cmpq	$0x6f, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movsbq	0x1(%rax), %rax
               	cmpq	$0x6b, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
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
