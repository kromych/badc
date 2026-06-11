
nested_compound_literal.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<make>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	0x10(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x10(%rbp), %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	popq	%r11
               	movq	%rax, %rcx
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movzbq	0x8(%rcx), %r11
               	movb	%r11b, 0x8(%rax)
               	movzbq	0x9(%rcx), %r11
               	movb	%r11b, 0x9(%rax)
               	movzbq	0xa(%rcx), %r11
               	movb	%r11b, 0xa(%rax)
               	movzbq	0xb(%rcx), %r11
               	movb	%r11b, 0xb(%rax)
               	popq	%r11
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	movzbq	0x8(%rax), %r11
               	movb	%r11b, 0x8(%rcx)
               	movzbq	0x9(%rax), %r11
               	movb	%r11b, 0x9(%rcx)
               	movzbq	0xa(%rax), %r11
               	movb	%r11b, 0xa(%rcx)
               	movzbq	0xb(%rax), %r11
               	movb	%r11b, 0xb(%rcx)
               	popq	%r11
               	movq	%rcx, %rax
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ebx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x4, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x5, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movzbq	0x8(%rcx), %r11
               	movb	%r11b, 0x8(%rax)
               	movzbq	0x9(%rcx), %r11
               	movb	%r11b, 0x9(%rax)
               	movzbq	0xa(%rcx), %r11
               	movb	%r11b, 0xa(%rax)
               	movzbq	0xb(%rcx), %r11
               	movb	%r11b, 0xb(%rax)
               	popq	%r11
               	leaq	-0x30(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x6, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ebx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x8, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ebx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x9, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	popq	%r11
               	leaq	-0x50(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	movq	0x8(%rax), %r11
               	movq	%r11, 0x8(%rcx)
               	popq	%r11
               	movq	%rcx, %rax
               	leaq	-0x40(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x3, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x5, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xc0(%rbp), %rdi
               	callq	<addr>
               	leaq	-0xc0(%rbp), %rax
               	leaq	-0x60(%rbp), %rcx
               	pushq	%r11
               	movq	(%rax), %r11
               	movq	%r11, (%rcx)
               	movq	0x8(%rax), %r11
               	movq	%r11, 0x8(%rcx)
               	popq	%r11
               	movq	%rcx, %rax
               	leaq	-0x60(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x60(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0xb, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
