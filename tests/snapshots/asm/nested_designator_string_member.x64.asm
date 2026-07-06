
nested_designator_string_member.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<str_eq>:
               	movsbq	(%rdi), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movsbq	(%rdi), %rax
               	movsbq	(%rsi), %rcx
               	cmpq	%rcx, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	incq	%rdi
               	incq	%rsi
               	jmp	<addr>
               	jmp	<addr>
               	movsbq	(%rdi), %rax
               	movsbq	(%rsi), %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	leaq	<rip>, %r12
               	leaq	0x4(%r12), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movsbq	0x7(%r12), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movsbq	0xb(%r12), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	0xc(%r12), %rax
               	cmpq	$0x7, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movslq	(%r12), %rax
               	cmpq	$0x5, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
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
               	movl	$0x77, %eax
               	leaq	-0x10(%rbp), %rcx
               	movb	%al, 0x4(%rcx)
               	movl	$0x78, %eax
               	leaq	-0x10(%rbp), %rcx
               	movb	%al, 0x5(%rcx)
               	movl	$0x79, %eax
               	leaq	-0x10(%rbp), %rcx
               	movb	%al, 0x6(%rcx)
               	movl	$0x7a, %eax
               	leaq	-0x10(%rbp), %rcx
               	movb	%al, 0x7(%rcx)
               	xorq	%rax, %rax
               	leaq	-0x10(%rbp), %rcx
               	movb	%al, 0x8(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movb	%al, 0x9(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movb	%al, 0xa(%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movb	%al, 0xb(%rcx)
               	leaq	0x6(%rbx), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, 0xc(%rcx)
               	leaq	0x4(%rbx), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x10(%rbp), %rax
               	leaq	0x4(%rax), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movsbq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movsbq	0xb(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	leaq	0x6(%rbx), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rax
               	leaq	0x4(%rbx), %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
