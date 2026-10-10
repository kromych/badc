
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
               	movss	%xmm0, -0x8(%rbp)
               	movss	-0x8(%rbp), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	mulsd	%xmm15, %xmm0
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movabsq	$0x3ff8000000000000, %rcx # imm = 0x3FF8000000000000
               	movl	$0x1, %eax
               	movq	%rax, -0x8(%rbp)
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x18(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	movsd	%xmm0, -0x20(%rbp)
               	movsd	-0x20(%rbp), %xmm0
               	movsd	-0x18(%rbp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	movabsq	$0x4004000000000000, %rdx # imm = 0x4004000000000000
               	leaq	0x1(%rax), %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x18(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	movsd	%xmm0, -0x20(%rbp)
               	movsd	-0x20(%rbp), %xmm0
               	movsd	-0x18(%rbp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	movabsq	$0x400c000000000000, %rdx # imm = 0x400C000000000000
               	incq	%rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x18(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	movsd	%xmm0, -0x20(%rbp)
               	movsd	-0x20(%rbp), %xmm0
               	movsd	-0x18(%rbp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	-0x10(%rbp), %xmm0
               	movabsq	$0x401e000000000000, %rcx # imm = 0x401E000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	-0x8(%rbp), %rcx
               	cmpq	$0x3, %rcx
               	je	<addr>
               	leave
               	retq
               	movl	$0x40a00000, %eax       # imm = 0x40A00000
               	movq	%rax, %xmm0
               	callq	<addr>
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
