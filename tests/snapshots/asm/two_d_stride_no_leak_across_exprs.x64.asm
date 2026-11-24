
two_d_stride_no_leak_across_exprs.x64:	file format elf64-x86-64

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
               	subq	$0x108, %rsp            # imm = 0x108
               	xorl	%eax, %eax
               	leaq	(%rsp), %rcx
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	vmulss	<rip>, %xmm0, %xmm0
               	movss	%xmm0, (%rsp,%rax,4)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	movss	0x20(%rsp), %xmm0
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x108, %rsp            # imm = 0x108
               	retq
               	movss	<rip>, %xmm0
               	movss	%xmm0, (%rsp)
               	movss	(%rsp), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x108, %rsp            # imm = 0x108
               	retq
               	xorl	%eax, %eax
               	addq	$0x108, %rsp            # imm = 0x108
               	retq
