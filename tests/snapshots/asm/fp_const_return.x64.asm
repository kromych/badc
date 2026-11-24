
fp_const_return.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x58, %rsp
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x10(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	xorl	%eax, %eax
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	incq	%rax
               	nop
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movl	$0x8, %eax
               	leaq	-0x1(%rax), %rdx
               	nopl	(%rax,%rax)
               	cmpq	$0x0, 0x10(%rsp,%rdx,8)
               	jne	<addr>
               	decq	%rax
               	testl	%eax, %eax
               	jg	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	xorps	%xmm0, %xmm0
               	xorps	%xmm1, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x58, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x58, %rsp
               	retq
               	decq	%rax
               	movq	0x10(%rsp,%rax,8), %rax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	jmp	<addr>
