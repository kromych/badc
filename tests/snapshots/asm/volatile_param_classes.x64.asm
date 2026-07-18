
volatile_param_classes.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<step>:
               	popq	%r10
               	subq	$0x20, %rsp
               	movq	%rdi, (%rsp)
               	movsd	%xmm0, 0x10(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, 0x10(%rbp)
               	movsd	%xmm0, 0x20(%rbp,%riz)
               	movq	0x10(%rbp), %rax
               	movsd	(%rax,%riz), %xmm0
               	movsd	%xmm0, -0x8(%rbp,%riz)
               	movq	0x10(%rbp), %rax
               	movsd	-0x8(%rbp,%riz), %xmm0
               	movsd	0x20(%rbp,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<half>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movss	%xmm0, -0x8(%rbp,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x10(%rbp), %rdi
               	movabsq	$0x3ff8000000000000, %rsi # imm = 0x3FF8000000000000
               	movq	0x8(%rdi), %rax
               	incq	%rax
               	movq	%rax, 0x8(%rdi)
               	movq	%rsi, %xmm0
               	callq	<addr>
               	leaq	-0x10(%rbp), %rdi
               	movabsq	$0x4004000000000000, %rsi # imm = 0x4004000000000000
               	movq	0x8(%rdi), %rax
               	incq	%rax
               	movq	%rax, 0x8(%rdi)
               	movq	%rsi, %xmm0
               	callq	<addr>
               	leaq	-0x10(%rbp), %rdi
               	movabsq	$0x400c000000000000, %rsi # imm = 0x400C000000000000
               	movq	0x8(%rdi), %rax
               	incq	%rax
               	movq	%rax, 0x8(%rdi)
               	movq	%rsi, %xmm0
               	callq	<addr>
               	leaq	-0x10(%rbp), %rax
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$0x401e000000000000, %rax # imm = 0x401E000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x40a00000, %edi       # imm = 0x40A00000
               	movq	%rdi, %xmm0
               	callq	<addr>
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
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
