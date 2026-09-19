
float_arithmetic.x64:	file format elf64-x86-64

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
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movabsq	$0x4004000000000000, %rcx # imm = 0x4004000000000000
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	addsd	%xmm15, %xmm0
               	movabsq	$0x4010000000000000, %rdx # imm = 0x4010000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	%rax, %xmm15
               	movq	%rcx, %xmm0
               	subsd	%xmm15, %xmm0
               	movabsq	$0x3ff0000000000000, %rdx # imm = 0x3FF0000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	%rcx, %xmm15
               	movq	%rax, %xmm0
               	mulsd	%xmm15, %xmm0
               	movabsq	$0x400e000000000000, %rdx # imm = 0x400E000000000000
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	%rax, %xmm15
               	movq	%rcx, %xmm0
               	divsd	%xmm15, %xmm0
               	movabsq	$0x3ff999999999999a, %rdx # imm = 0x3FF999999999999A
               	movq	%rdx, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jb	<addr>
               	movl	$0x4, %eax
               	retq
               	movabsq	$0x3ffb333333333333, %rdx # imm = 0x3FFB333333333333
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jb	<addr>
               	movl	$0x5, %eax
               	retq
               	movabsq	$-0x4008000000000000, %rdx # imm = 0xBFF8000000000000
               	movq	%rdx, %xmm14
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%dl
               	movzbq	%dl, %rdx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rdx
               	cmpq	$0x1, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jbe	<addr>
               	movl	$0x9, %eax
               	retq
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%dl
               	movzbq	%dl, %rdx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rdx
               	cmpq	$0x1, %rdx
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%dl
               	movzbq	%dl, %rdx
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rdx
               	cmpq	$0x1, %rdx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setbe	%dl
               	movzbq	%dl, %rdx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rdx
               	cmpq	$0x1, %rdx
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jb	<addr>
               	movl	$0xd, %eax
               	retq
               	movl	$0x7, %eax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x401c000000000000, %rax # imm = 0x401C000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rcx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	cvttsd2si	%xmm0, %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	movabsq	$-0x4004cccccccccccd, %rax # imm = 0xBFFB333333333333
               	movq	%rax, %xmm14
               	cvttsd2si	%xmm14, %rax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	xorl	%eax, %eax
               	retq
