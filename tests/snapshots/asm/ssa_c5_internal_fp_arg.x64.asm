
ssa_c5_internal_fp_arg.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<lt_float_int>:
               	cvtsi2sd	%rdi, %xmm1
               	ucomisd	%xmm1, %xmm0
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	retq

<le_float_int>:
               	cvtsi2sd	%rdi, %xmm1
               	ucomisd	%xmm1, %xmm0
               	setbe	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	0x64(%rdi), %rax
               	subq	%rdi, %rax
               	movslq	%eax, %rax
               	movabsq	$0x4049400000000000, %rdx # imm = 0x4049400000000000
               	movq	%rdi, %rcx
               	subq	%rdi, %rcx
               	movslq	%ecx, %rcx
               	cvtsi2sd	%rcx, %xmm0
               	movapd	%xmm0, %xmm15
               	movq	%rdx, %xmm0
               	addsd	%xmm15, %xmm0
               	cvtsi2sd	%rax, %xmm1
               	ucomisd	%xmm1, %xmm0
               	setb	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x4062d00000000000, %rcx # imm = 0x4062D00000000000
               	cvtsi2sd	%rax, %xmm0
               	movq	%rcx, %xmm14
               	ucomisd	%xmm0, %xmm14
               	setb	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	cvtsi2sd	%rax, %xmm0
               	cvtsi2sd	%rax, %xmm1
               	ucomisd	%xmm1, %xmm0
               	setbe	%cl
               	movzbq	%cl, %rcx
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	cvtsi2sd	%rax, %xmm0
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	cvtsi2sd	%rax, %xmm1
               	ucomisd	%xmm1, %xmm0
               	setbe	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
