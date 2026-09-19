
float_increment_decrement.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0x3fc00000, %eax       # imm = 0x3FC00000
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rax, %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movabsq	$0x400a000000000000, %rax # imm = 0x400A000000000000
               	movabsq	$-0x4010000000000000, %rdx # imm = 0xBFF0000000000000
               	movq	%rdx, %xmm15
               	movq	%rax, %xmm0
               	addsd	%xmm15, %xmm0
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movabsq	$0x4002000000000000, %rax # imm = 0x4002000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x3f800000, -0x8(%rbp) # imm = 0x3F800000
               	leaq	-0x8(%rbp), %rax
               	movss	(%rax,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movss	(%rax,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movss	-0x8(%rbp,%riz), %xmm0
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movss	(%rax,%riz), %xmm0
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movss	%xmm0, (%rax,%riz)
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$-0x4010000000000000, %rdx # imm = 0xBFF0000000000000
               	movq	%rdx, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rax,%riz)
               	movss	(%rax,%riz), %xmm0
               	movl	$0x40200000, %ecx       # imm = 0x40200000
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$0x3ff0000000000000, %rcx # imm = 0x3FF0000000000000
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movsd	(%rax,%riz), %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movsd	(%rax,%riz), %xmm0
               	movabsq	$0x401c000000000000, %rax # imm = 0x401C000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%rsi), %rcx
               	movq	%rcx, 0x10(%rax)
               	popq	%rcx
               	movsd	0x8(%rax,%riz), %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rax,%riz)
               	movsd	0x10(%rax,%riz), %xmm0
               	movq	%rdx, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, 0x10(%rax,%riz)
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	0x10(%rax,%riz), %xmm0
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	movl	$0x4b800000, %ecx       # imm = 0x4B800000
               	movq	%rcx, %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movq	%rcx, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
