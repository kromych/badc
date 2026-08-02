
static_init_logical_and.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<dispatch>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, 0x10(%rbp)
               	leaq	<rip>, %rax
               	movsbq	0x10(%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, -0x8(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rcx        # <addr>
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rcx        # <addr>
               	movq	%rcx, 0x8(%rax)
               	movl	$0x1, %ecx
               	movb	%cl, 0x10(%rax)
               	movq	%rcx, -0x8(%rbp)
               	leaq	<rip>, %rcx
               	movsbq	0x10(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	movl	$0xa, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movl	$0x14, %eax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, -0x8(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	leaq	-<rip>, %rdx       # <addr>
               	movq	%rdx, (%rcx)
               	leaq	-<rip>, %rdx       # <addr>
               	movq	%rdx, 0x8(%rcx)
               	movl	$0x1, %edx
               	movb	%dl, 0x10(%rcx)
               	movq	%rdx, -0x8(%rbp)
               	leaq	<rip>, %rdx
               	movslq	0x10(%rbp), %rcx
               	andq	$0x1, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rdx
               	movq	(%rdx), %rdx
               	addq	%rax, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movabsq	$-0x1, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
               	movslq	0x10(%rbp), %rcx
               	andq	$0x1, %rcx
               	movq	(%rax,%rcx,8), %rax
               	jmpq	*%rax
               	movslq	-0x8(%rbp), %rcx
               	incq	%rcx
               	addq	$0x0, %rcx
               	incq	%rcx
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0xd, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x17, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	popq	%rbp
               	retq
               	jmp	<addr>
