
hfa_param_interleave.x64:	file format elf64-x86-64

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
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movss	<rip>, %xmm0
               	movss	-0x20(%rbp), %xmm1
               	movss	-0x1c(%rbp), %xmm2
               	addss	%xmm2, %xmm1
               	movss	-0x18(%rbp), %xmm2
               	addss	%xmm2, %xmm1
               	movss	-0x14(%rbp), %xmm2
               	addss	%xmm2, %xmm1
               	movss	-0x10(%rbp), %xmm2
               	addss	%xmm2, %xmm1
               	movss	-0xc(%rbp), %xmm2
               	addss	%xmm2, %xmm1
               	movss	-0x8(%rbp), %xmm2
               	addss	%xmm2, %xmm1
               	movss	-0x4(%rbp), %xmm2
               	addss	%xmm2, %xmm1
               	vaddss	%xmm0, %xmm1, %xmm0
               	movss	<rip>, %xmm1
               	addss	%xmm1, %xmm0
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
