
hfa_param_interleave.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sum>:
               	popq	%r10
               	subq	$0x60, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movsd	%xmm0, -0x8(%rbp,%riz)
               	movsd	%xmm1, -0x10(%rbp,%riz)
               	movsd	%xmm2, -0x18(%rbp,%riz)
               	movsd	%xmm3, -0x20(%rbp,%riz)
               	movq	%rdi, -0x28(%rbp)
               	movapd	%xmm4, %xmm0
               	leaq	-0x8(%rbp), %rax
               	movss	(%rax,%riz), %xmm1
               	leaq	-0x8(%rbp), %rax
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	leaq	-0x10(%rbp), %rax
               	movss	(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	leaq	-0x10(%rbp), %rax
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	leaq	-0x18(%rbp), %rax
               	movss	(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	leaq	-0x18(%rbp), %rax
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	leaq	-0x20(%rbp), %rax
               	movss	(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	leaq	-0x20(%rbp), %rax
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	addss	%xmm15, %xmm0
               	leaq	-0x28(%rbp), %rax
               	movzbq	(%rax), %rax
               	leaq	-0x28(%rbp), %rcx
               	movzbq	0x1(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x28(%rbp), %rcx
               	movzbq	0x2(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	-0x28(%rbp), %rcx
               	movzbq	0x3(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cvtsi2sd	%rax, %xmm1
               	cvtsd2ss	%xmm1, %xmm1
               	addss	%xmm1, %xmm0
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x60, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movzbq	(%rcx), %rdx
               	movb	%dl, (%rax)
               	movzbq	0x1(%rcx), %rdx
               	movb	%dl, 0x1(%rax)
               	movzbq	0x2(%rcx), %rdx
               	movb	%dl, 0x2(%rax)
               	movzbq	0x3(%rcx), %rdx
               	movb	%dl, 0x3(%rax)
               	popq	%rdx
               	leaq	-0x8(%rbp), %rdi
               	leaq	-0x10(%rbp), %rsi
               	leaq	-0x18(%rbp), %rdx
               	leaq	-0x20(%rbp), %rcx
               	movabsq	$0x4023000000000000, %rax # imm = 0x4023000000000000
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	leaq	-0x28(%rbp), %r8
               	movapd	%xmm0, %xmm4
               	movq	%rdi, %r10
               	movsd	(%r10,%riz), %xmm0
               	movq	%rsi, %r10
               	movsd	(%r10,%riz), %xmm1
               	movq	%rdx, %r10
               	movsd	(%r10,%riz), %xmm2
               	movq	%rcx, %r10
               	movsd	(%r10,%riz), %xmm3
               	movq	%r8, %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movabsq	$0x404bc00000000000, %rax # imm = 0x404BC00000000000
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
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
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x30(%rbp), %rdi
               	leaq	-0x30(%rbp), %rsi
               	leaq	-0x30(%rbp), %rdx
               	leaq	-0x30(%rbp), %rcx
               	movabsq	$0x3fd0000000000000, %rax # imm = 0x3FD0000000000000
               	movq	%rax, %xmm14
               	cvtsd2ss	%xmm14, %xmm0
               	leaq	-0x28(%rbp), %r8
               	movapd	%xmm0, %xmm4
               	movq	%rdi, %r10
               	movsd	(%r10,%riz), %xmm0
               	movq	%rsi, %r10
               	movsd	(%r10,%riz), %xmm1
               	movq	%rdx, %r10
               	movsd	(%r10,%riz), %xmm2
               	movq	%rcx, %r10
               	movsd	(%r10,%riz), %xmm3
               	movq	%r8, %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movabsq	$0x4024800000000000, %rax # imm = 0x4024800000000000
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
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
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
