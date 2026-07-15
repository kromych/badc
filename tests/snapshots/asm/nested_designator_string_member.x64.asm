
nested_designator_string_member.x64:	file format elf64-x86-64

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
               	subq	$0x50, %rsp
               	movq	%rdi, %r8
               	leaq	<rip>, %rsi
               	leaq	0x4(%rsi), %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rdi
               	cmpq	%rdi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movsbq	0x7(%rsi), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsbq	0xb(%rsi), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	0xc(%rsi), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	(%rsi), %rax
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movl	$0x77, %ecx
               	leaq	-0x10(%rbp), %rax
               	movb	%cl, 0x4(%rax)
               	movl	$0x78, %ecx
               	leaq	-0x10(%rbp), %rax
               	movb	%cl, 0x5(%rax)
               	movl	$0x79, %ecx
               	leaq	-0x10(%rbp), %rax
               	movb	%cl, 0x6(%rax)
               	movl	$0x7a, %ecx
               	leaq	-0x10(%rbp), %rax
               	movb	%cl, 0x7(%rax)
               	xorq	%rax, %rax
               	leaq	-0x10(%rbp), %rcx
               	movb	%al, 0x8(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movb	%al, 0x9(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movb	%al, 0xa(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movb	%al, 0xb(%rcx)
               	leaq	0x6(%r8), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, 0xc(%rcx)
               	leaq	0x4(%r8), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x10(%rbp), %rax
               	addq	$0x4, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rax), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movsbq	(%rax), %rdx
               	movsbq	(%rcx), %rsi
               	cmpq	%rsi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	incq	%rax
               	incq	%rcx
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rax), %rax
               	movsbq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movsbq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movsbq	0xb(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movslq	0xc(%rax), %rcx
               	leaq	0x6(%r8), %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	0x4(%r8), %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
