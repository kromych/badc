
hfa_param_interleave.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

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
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	leaq	-0x10(%rbp), %rax
               	movss	(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	leaq	-0x18(%rbp), %rax
               	movss	(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	leaq	-0x20(%rbp), %rax
               	movss	(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x4(%rax,%riz), %xmm2
               	addss	%xmm2, %xmm1
               	movapd	%xmm0, %xmm15
               	movapd	%xmm1, %xmm0
               	addss	%xmm15, %xmm0
               	leaq	-0x28(%rbp), %rax
               	movzbq	(%rax), %rcx
               	movzbq	0x1(%rax), %rdx
               	addq	%rdx, %rcx
               	movzbq	0x2(%rax), %rdx
               	addq	%rdx, %rcx
               	movzbq	0x3(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rax, %xmm1
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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	-0x28(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	leaq	-0x20(%rbp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x18(%rbp), %rdx
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0x8(%rbp), %rbx
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	leaq	-0x10(%rbp), %r9
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movzbq	(%rax), %rcx
               	movb	%cl, (%r9)
               	movzbq	0x1(%rax), %rcx
               	movb	%cl, 0x1(%r9)
               	movzbq	0x2(%rax), %rcx
               	movb	%cl, 0x2(%r9)
               	movzbq	0x3(%rax), %rcx
               	movb	%cl, 0x3(%r9)
               	popq	%rcx
               	movq	%r9, %rax
               	movl	$0x41180000, %r8d       # imm = 0x41180000
               	movq	%r8, %xmm4
               	movq	%rdi, %r10
               	movsd	(%r10,%riz), %xmm0
               	movq	%rsi, %r10
               	movsd	(%r10,%riz), %xmm1
               	movq	%rdx, %r10
               	movsd	(%r10,%riz), %xmm2
               	movq	%rbx, %r10
               	movsd	(%r10,%riz), %xmm3
               	movq	%r9, %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movl	$0x425e0000, %eax       # imm = 0x425E0000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, (%rbx)
               	leaq	-0x8(%rbp), %rdi
               	movl	$0x3e800000, %r8d       # imm = 0x3E800000
               	leaq	-0x10(%rbp), %r9
               	movq	%r8, %xmm4
               	movq	%rdi, %r10
               	movsd	(%r10,%riz), %xmm0
               	movq	%rdi, %r10
               	movsd	(%r10,%riz), %xmm1
               	movq	%rdi, %r10
               	movsd	(%r10,%riz), %xmm2
               	movq	%rdi, %r10
               	movsd	(%r10,%riz), %xmm3
               	movq	%r9, %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movl	$0x41240000, %eax       # imm = 0x41240000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	%r12, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
