
ssa_c5_internal_fp_arg.x64:	file format elf64-x86-64

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
               	leaq	0x64(%rdi), %rax
               	subq	%rdi, %rax
               	movslq	%eax, %rax
               	movabsq	$0x4049400000000000, %rcx # imm = 0x4049400000000000
               	movq	%rdi, %rdx
               	subq	%rdi, %rdx
               	movslq	%edx, %rdx
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rdx, %xmm0
               	movq	%rcx, %xmm1
               	addsd	%xmm0, %xmm1
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	ucomisd	%xmm0, %xmm1
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x4062d00000000000, %rax # imm = 0x4062D00000000000
               	movq	%rax, %xmm14
               	ucomisd	%xmm14, %xmm0
               	jbe	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	ucomisd	%xmm0, %xmm0
               	setbe	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	movapd	%xmm0, %xmm1
               	addsd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jb	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
