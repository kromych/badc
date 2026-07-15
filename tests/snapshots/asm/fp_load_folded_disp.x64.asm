
fp_load_folded_disp.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	leaq	-0x28(%rbp), %rax
               	movabsq	$-0x1, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x28(%rbp), %rax
               	movl	$0x3fa00000, %ecx       # imm = 0x3FA00000
               	movq	%rcx, %xmm14
               	movss	%xmm14, 0x8(%rax,%riz)
               	leaq	-0x28(%rbp), %rax
               	movabsq	$0x4004000000000000, %rdx # imm = 0x4004000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, 0x10(%rax,%riz)
               	leaq	-0x28(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, %xmm14
               	movss	%xmm14, 0x18(%rax,%riz)
               	leaq	-0x28(%rbp), %rax
               	movq	%rdx, %xmm14
               	movss	%xmm14, 0x1c(%rax,%riz)
               	leaq	-0x28(%rbp), %rax
               	movl	$0x40980000, %edx       # imm = 0x40980000
               	movq	%rdx, %xmm14
               	movss	%xmm14, 0x20(%rax,%riz)
               	leaq	-0x28(%rbp), %rax
               	movss	0x8(%rax,%riz), %xmm0
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	movsd	0x10(%rax,%riz), %xmm0
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
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
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	movss	0x20(%rax,%riz), %xmm0
               	movl	$0x40980000, %eax       # imm = 0x40980000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	movsd	0x10(%rax,%riz), %xmm0
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, 0x10(%rax,%riz)
               	leaq	-0x28(%rbp), %rax
               	movsd	0x10(%rax,%riz), %xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
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
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
