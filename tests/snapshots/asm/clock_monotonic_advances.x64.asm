
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
               	leaq	-0x10(%rbp), %rcx
               	movabsq	$-0x1, %rax
               	movq	%rax, (%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movq	%rax, 0x8(%rcx)
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
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$-0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
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
               	setl	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	setge	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, -0x28(%rbp)
               	jmp	<addr>
               	movslq	-0x28(%rbp), %rcx
               	incq	%rcx
               	movl	%ecx, -0x28(%rbp)
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0xf4240, %rdx          # imm = 0xF4240
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
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x20(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rcx
               	setl	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
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
