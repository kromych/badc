
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
               	subq	$0x20, %rsp
               	movl	$0xb, %ecx
               	movl	$0x16, %edx
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	movzbq	0x10(%rsi), %rcx
               	movb	%cl, 0x10(%rax)
               	movzbq	0x11(%rsi), %rcx
               	movb	%cl, 0x11(%rax)
               	movzbq	0x12(%rsi), %rcx
               	movb	%cl, 0x12(%rax)
               	movzbq	0x13(%rsi), %rcx
               	movb	%cl, 0x13(%rax)
               	popq	%rcx
               	movl	$0x1, %eax
               	leaq	-0x18(%rbp), %rsi
               	movl	%eax, (%rsi)
               	leaq	-0x18(%rbp), %rax
               	movl	%edx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	%ecx, 0x4(%rax)
               	movl	$0x4, %ecx
               	leaq	-0x18(%rbp), %rax
               	movl	%ecx, 0x10(%rax)
               	movl	$0x1, %eax
               	movl	$0x1, %eax
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
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x30(%rbp), %rax
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
               	leaq	-0x30(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x30(%rbp), %rax
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
               	leaq	-0x30(%rbp), %rax
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
               	leaq	-0x30(%rbp), %rax
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
               	leaq	-0x30(%rbp), %rax
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
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x38(%rbp)
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	movl	$0xb, %edi
               	movl	$0x16, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
