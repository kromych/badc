
clock_monotonic_advances.x64:	file format elf64-x86-64

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
               	subq	$0x60, %rsp
               	leaq	-0x10(%rbp), %rax
               	movabsq	$-0x1, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%rcx, 0x8(%rax)
               	movl	$0x1, %edi
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$-0x1, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$-0x1, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setl	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	setge	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movl	%ecx, -0x28(%rbp)
               	jmp	<addr>
               	movslq	-0x28(%rbp), %rax
               	incq	%rax
               	movl	%eax, -0x28(%rbp)
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0xf4240, %rax          # imm = 0xF4240
               	jl	<addr>
               	movl	$0x1, %edi
               	leaq	-0x20(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movl	$0x6, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x20(%rbp), %rax
               	movq	0x8(%rax), %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	0x8(%rcx), %rcx
               	cmpq	%rcx, %rax
               	setl	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
