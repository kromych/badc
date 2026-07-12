
anon_struct_designated_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<check_runtime>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movzbq	0x10(%rcx), %rdx
               	movb	%dl, 0x10(%rax)
               	movzbq	0x11(%rcx), %rdx
               	movb	%dl, 0x11(%rax)
               	movzbq	0x12(%rcx), %rdx
               	movb	%dl, 0x12(%rax)
               	movzbq	0x13(%rcx), %rdx
               	movb	%dl, 0x13(%rax)
               	popq	%rdx
               	movl	$0x1, %eax
               	leaq	-0x18(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x18(%rbp), %rax
               	movl	%esi, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	%edi, 0x4(%rax)
               	movl	$0x4, %ecx
               	leaq	-0x18(%rbp), %rax
               	movl	%ecx, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	%rdi, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	%rsi, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0x10(%rax), %rax
               	cmpq	$0x4, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movzbq	0x10(%rcx), %rdx
               	movb	%dl, 0x10(%rax)
               	movzbq	0x11(%rcx), %rdx
               	movb	%dl, 0x11(%rax)
               	movzbq	0x12(%rcx), %rdx
               	movb	%dl, 0x12(%rax)
               	movzbq	0x13(%rcx), %rdx
               	movb	%dl, 0x13(%rax)
               	popq	%rdx
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0xa, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x14, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0x10(%rax), %rax
               	cmpq	$0x4, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x20(%rbp)
               	leaq	-0x38(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	movq	0x10(%rdx), %rax
               	movq	%rax, 0x10(%rcx)
               	popq	%rax
               	movl	$0x7, %ecx
               	leaq	-0x38(%rbp), %rdx
               	movl	%ecx, (%rdx)
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x38(%rbp), %rcx
               	movq	%rdx, 0x8(%rcx)
               	movl	$0x8, %edx
               	leaq	-0x38(%rbp), %rcx
               	movq	%rdx, 0x10(%rcx)
               	leaq	-0x38(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x7, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	0x8(%rax), %rax
               	leaq	-0x20(%rbp), %rcx
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	0x10(%rax), %rax
               	cmpq	$0x8, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x3, %eax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0xb, %edi
               	movl	$0x16, %esi
               	callq	<addr>
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
