
nested_designator_string_member.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<str_eq>:
               	movsbq	(%rdi), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	(%rdi), %rax
               	movsbq	(%rsi), %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
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
               	movq	%rdi, %r12
               	leaq	<rip>, %rbx
               	leaq	0x4(%rbx), %rdi
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
               	movsbq	0x7(%rbx), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsbq	0xb(%rbx), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	0xc(%rbx), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	(%rbx), %rax
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
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
               	leaq	0x6(%r12), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, 0xc(%rcx)
               	leaq	0x4(%r12), %rax
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movslq	0xc(%rax), %rcx
               	leaq	0x6(%r12), %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	0x4(%r12), %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
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
               	addb	%al, (%rax)
