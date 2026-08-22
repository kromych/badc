
volatile_param_classes.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x10(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movabsq	$0x3ff8000000000000, %rcx # imm = 0x3FF8000000000000
               	movl	$0x1, %edx
               	movq	%rdx, 0x8(%rax)
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x18(%rbp,%riz)
               	movsd	(%rax,%riz), %xmm0
               	movsd	%xmm0, -0x20(%rbp,%riz)
               	movsd	-0x20(%rbp,%riz), %xmm0
               	movsd	-0x18(%rbp,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movabsq	$0x4004000000000000, %rbx # imm = 0x4004000000000000
               	movq	0x8(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, 0x8(%rax)
               	movq	%rbx, %xmm14
               	movsd	%xmm14, -0x18(%rbp,%riz)
               	movsd	(%rax,%riz), %xmm0
               	movsd	%xmm0, -0x20(%rbp,%riz)
               	movsd	-0x20(%rbp,%riz), %xmm0
               	movsd	-0x18(%rbp,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movabsq	$0x400c000000000000, %rcx # imm = 0x400C000000000000
               	movq	0x8(%rax), %rsi
               	incq	%rsi
               	movq	%rsi, 0x8(%rax)
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x18(%rbp,%riz)
               	movsd	(%rax,%riz), %xmm0
               	movsd	%xmm0, -0x20(%rbp,%riz)
               	movsd	-0x20(%rbp,%riz), %xmm0
               	movsd	-0x18(%rbp,%riz), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$0x401e000000000000, %rcx # imm = 0x401E000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%cl
               	movzbq	%cl, %rcx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x3, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	(%rsp), %rbx
               	movq	%rdx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x40a00000, %edi       # imm = 0x40A00000
               	movq	%rdi, %xmm0
               	callq	<addr>
               	movq	%rbx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
