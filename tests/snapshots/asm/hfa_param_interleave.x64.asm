
hfa_param_interleave.x64:	file format elf64-x86-64

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
               	subq	$0x28, %rsp
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	0x8(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	0x10(%rsp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movss	(%rsp), %xmm0
               	movss	0x4(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x8(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0xc(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x10(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x14(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1
               	addss	%xmm1, %xmm0
               	vaddss	<rip>, %xmm0, %xmm0
               	vaddss	<rip>, %xmm0, %xmm0
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
