
fp_const_return.x64:	file format elf64-x86-64

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

<sum_zero>:
               	movl	$0x8, %eax
               	jmp	<addr>
               	leaq	-0x1(%rax), %rcx
               	movslq	%ecx, %rcx
               	movq	(%rdi,%rcx,8), %rcx
               	testq	%rcx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%eax, %rax
               	decq	%rax
               	testl	%eax, %eax
               	jg	<addr>
               	testq	%rax, %rax
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
               	leaq	-0x50(%rbp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	-0x40(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movq	%rcx, 0x20(%rax)
               	movq	%rcx, 0x28(%rax)
               	movq	%rcx, 0x30(%rax)
               	movq	%rcx, 0x38(%rax)
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x58(%rbp,%riz)
               	movq	%rcx, %rax
               	jmp	<addr>
               	movslq	%eax, %rdx
               	movq	%rdx, %rdi
               	shlq	$0x3, %rdi
               	addq	%rsi, %rdi
               	movsd	(%rdi,%riz), %xmm0
               	movsd	%xmm0, -0x58(%rbp,%riz)
               	leaq	0x1(%rdx), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdx
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x58(%rbp,%riz)
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rdx, %rsi
               	movsd	(%rsi,%riz), %xmm0
               	movsd	%xmm0, -0x58(%rbp,%riz)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdx
               	xorq	%rax, %rax
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x58(%rbp,%riz)
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rdx, %rsi
               	movsd	(%rsi,%riz), %xmm0
               	movsd	%xmm0, -0x58(%rbp,%riz)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdx
               	xorq	%rax, %rax
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x58(%rbp,%riz)
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rdx, %rsi
               	movsd	(%rsi,%riz), %xmm0
               	movsd	%xmm0, -0x58(%rbp,%riz)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movl	$0x3e800000, %eax       # imm = 0x3E800000
               	movq	%rax, %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movabsq	$0x3fd0000000000000, %rax # imm = 0x3FD0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	-0x50(%rbp), %rdx
               	xorq	%rax, %rax
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x58(%rbp,%riz)
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rdx, %rsi
               	movsd	(%rsi,%riz), %xmm0
               	movsd	%xmm0, -0x58(%rbp,%riz)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rdi
               	movl	$0x8, %esi
               	callq	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leave
               	retq
