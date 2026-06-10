
fp_return_value.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<make_double>:
               	movslq	%edi, %rdi
               	cvtsi2sd	%rdi, %xmm0
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	retq

<make_float>:
               	movslq	%edi, %rdi
               	cvtsi2sd	%rdi, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0x7, %eax
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	movl	$0x2, %eax
               	cvtsi2sd	%rax, %xmm1
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm1
               	addsd	%xmm1, %xmm0
               	movabsq	$0x4024000000000000, %rax # imm = 0x4024000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	cvtsi2sd	%rax, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm0
               	cvtsd2ss	%xmm0, %xmm0
               	movl	$0x5, %eax
               	cvtsi2sd	%rax, %xmm1
               	cvtsd2ss	%xmm1, %xmm1
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm1
               	cvtsd2ss	%xmm1, %xmm1
               	addss	%xmm1, %xmm0
               	leaq	-0x10(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	movss	-0x10(%rbp,%riz), %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	cvtss2sd	%xmm0, %xmm0
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movl	$0x6, %ecx
               	cvtsi2sd	%rcx, %xmm1
               	cvtsd2ss	%xmm1, %xmm1
               	movabsq	$0x4010000000000000, %rcx # imm = 0x4010000000000000
               	cvtss2sd	%xmm1, %xmm1
               	movq	%rcx, %xmm15
               	divsd	%xmm15, %xmm1
               	cvtsd2ss	%xmm1, %xmm1
               	cvtss2sd	%xmm1, %xmm1
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm1, %xmm0
               	vfmadd231sd	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) + xmm0
               	movabsq	$0x4012000000000000, %rax # imm = 0x4012000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
