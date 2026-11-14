
two_d_stride_no_leak_across_exprs.x64:	file format elf64-x86-64

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
               	subq	$0x100, %rsp            # imm = 0x100
               	xorl	%eax, %eax
               	leaq	-0x100(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	<rip>, %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, (%rcx)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	movss	-0xe0(%rbp), %xmm0
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movss	<rip>, %xmm0
               	movss	%xmm0, -0x100(%rbp)
               	movss	-0x100(%rbp), %xmm1
               	ucomiss	%xmm0, %xmm1
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
