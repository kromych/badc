
fp_param_float_before_double.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<pick_first>:
               	retq

<pick_second>:
               	cvtss2sd	%xmm1, %xmm0
               	retq

<sum4>:
               	cvtss2sd	%xmm0, %xmm0
               	addsd	%xmm1, %xmm0
               	cvtss2sd	%xmm2, %xmm1
               	addsd	%xmm1, %xmm0
               	addsd	%xmm3, %xmm0
               	retq

<dbl_then_float>:
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	cvtss2sd	%xmm1, %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	retq

<main>:
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x40d00000, %eax       # imm = 0x40D00000
               	movq	%rax, %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movq	%rax, %xmm14
               	cvtss2sd	%xmm14, %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0x3f800000, %eax       # imm = 0x3F800000
               	movabsq	$0x4000000000000000, %rcx # imm = 0x4000000000000000
               	movl	$0x40400000, %edx       # imm = 0x40400000
               	movabsq	$0x4010000000000000, %rsi # imm = 0x4010000000000000
               	movq	%rax, %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	movq	%rdx, %xmm14
               	cvtss2sd	%xmm14, %xmm1
               	addsd	%xmm1, %xmm0
               	movq	%rsi, %xmm15
               	addsd	%xmm15, %xmm0
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movabsq	$0x4014000000000000, %rax # imm = 0x4014000000000000
               	movl	$0x40c00000, %edx       # imm = 0x40C00000
               	movabsq	$0x4024000000000000, %rcx # imm = 0x4024000000000000
               	movq	%rdx, %xmm14
               	cvtss2sd	%xmm14, %xmm0
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movabsq	$0x404c000000000000, %rax # imm = 0x404C000000000000
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
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
