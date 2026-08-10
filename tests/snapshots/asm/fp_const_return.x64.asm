
fp_const_return.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sum_zero>:
               	movl	$0x8, %eax
               	movslq	%eax, %rdx
               	testq	%rdx, %rdx
               	setg	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movq	(%rdi,%rcx,8), %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x1(%rdx), %rax
               	jmp	<addr>
               	jmp	<addr>
               	testq	%rdx, %rdx
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %xmm14
               	movapd	%xmm14, %xmm0
               	retq
               	decq	%rax
               	movslq	%eax, %rax
               	movq	(%rdi,%rax,8), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x50(%rbp), %rax
               	xorq	%rdi, %rdi
               	movq	%rdi, (%rax)
               	movq	%rdi, 0x8(%rax)
               	movq	%rdi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	movq	%rdi, 0x20(%rax)
               	movq	%rdi, 0x28(%rax)
               	movq	%rdi, 0x30(%rax)
               	movq	%rdi, 0x38(%rax)
               	leaq	-0x10(%rbp), %rdx
               	xorq	%rax, %rax
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x58(%rbp,%riz)
               	jmp	<addr>
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rdx, %rsi
               	movsd	(%rsi,%riz), %xmm0
               	movsd	%xmm0, -0x58(%rbp,%riz)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %xmm14
               	movq	%rdi, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rdx
               	xorq	%rax, %rax
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x58(%rbp,%riz)
               	jmp	<addr>
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rdx, %rsi
               	movsd	(%rsi,%riz), %xmm0
               	movsd	%xmm0, -0x58(%rbp,%riz)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rdx
               	xorq	%rax, %rax
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x58(%rbp,%riz)
               	jmp	<addr>
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rdx, %rsi
               	movsd	(%rsi,%riz), %xmm0
               	movsd	%xmm0, -0x58(%rbp,%riz)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rdx
               	xorq	%rax, %rax
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x58(%rbp,%riz)
               	jmp	<addr>
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rdx, %rsi
               	movsd	(%rsi,%riz), %xmm0
               	movsd	%xmm0, -0x58(%rbp,%riz)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	movl	$0x3e800000, %eax       # imm = 0x3E800000
               	movq	%rax, %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movabsq	$0x3fd0000000000000, %rax # imm = 0x3FD0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rdx
               	xorq	%rax, %rax
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x58(%rbp,%riz)
               	jmp	<addr>
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rdx, %rsi
               	movsd	(%rsi,%riz), %xmm0
               	movsd	%xmm0, -0x58(%rbp,%riz)
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	-0x50(%rbp), %rdi
               	movl	$0x8, %esi
               	callq	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
