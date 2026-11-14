
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
               	movsd	<rip>, %xmm1
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	comisd	%xmm1, %xmm0
               	seta	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movsd	<rip>, %xmm1
               	comisd	%xmm1, %xmm0
               	jbe	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	comisd	%xmm0, %xmm0
               	setae	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movsd	<rip>, %xmm1
               	vaddsd	%xmm1, %xmm0, %xmm1
               	comisd	%xmm1, %xmm0
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
