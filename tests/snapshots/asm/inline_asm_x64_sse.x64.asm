
inline_asm_x64_sse.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sse_add>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	leaq	-0x8(%rbp), %rax
               	subq	$0x20, %rsp
               	movups	%xmm0, (%rsp)
               	movups	%xmm1, 0x10(%rsp)
               	pushq	%rax
               	pushq	%rcx
               	pushq	%rbx
               	movq	%rax, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	pushq	%r10
               	movq	0x8(%rsp), %rbx
               	movq	(%rsp), %rcx
               	movd	%ebx, %xmm0
               	movd	%ecx, %xmm1
               	paddd	%xmm1, %xmm0
               	movd	%xmm0, %eax
               	movq	0x10(%rsp), %r11
               	movl	%eax, (%r11)
               	addq	$0x18, %rsp
               	popq	%rbx
               	popq	%rcx
               	popq	%rax
               	movups	(%rsp), %xmm0
               	movups	0x10(%rsp), %xmm1
               	addq	$0x20, %rsp
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<sse_mem_add>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	subq	$0x10, %rsp
               	movups	%xmm0, (%rsp)
               	pushq	%rax
               	pushq	%rcx
               	pushq	%rbx
               	movq	%rax, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%rcx, %r10
               	pushq	%r10
               	movq	0x8(%rsp), %rbx
               	movq	(%rsp), %rcx
               	movd	%ebx, %xmm0
               	paddd	(%rcx), %xmm0
               	movd	%xmm0, %eax
               	movq	0x10(%rsp), %r11
               	movl	%eax, (%r11)
               	addq	$0x18, %rsp
               	popq	%rbx
               	popq	%rcx
               	popq	%rax
               	movups	(%rsp), %xmm0
               	addq	$0x10, %rsp
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<sse_movdqu>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x18(%rbp), %rax
               	movl	%edi, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	%edi, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	%edi, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	%edi, 0xc(%rax)
               	leaq	-0x28(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	subq	$0x10, %rsp
               	movups	%xmm0, (%rsp)
               	pushq	%rax
               	pushq	%rbx
               	movq	%rax, %r10
               	pushq	%r10
               	movq	%rcx, %r10
               	pushq	%r10
               	movq	0x8(%rsp), %rax
               	movq	(%rsp), %rbx
               	movdqu	(%rbx), %xmm0
               	movdqu	%xmm0, (%rax)
               	addq	$0x10, %rsp
               	popq	%rbx
               	popq	%rax
               	movups	(%rsp), %xmm0
               	addq	$0x10, %rsp
               	leaq	-0x28(%rbp), %rax
               	movslq	(%rax), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq

<sse_shift>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	leaq	-0x8(%rbp), %rax
               	subq	$0x10, %rsp
               	movups	%xmm0, (%rsp)
               	pushq	%rax
               	pushq	%rbx
               	movq	%rax, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	(%rsp), %rbx
               	movd	%ebx, %xmm0
               	pslld	$0x1, %xmm0
               	movd	%xmm0, %eax
               	movq	0x8(%rsp), %r11
               	movl	%eax, (%r11)
               	addq	$0x10, %rsp
               	popq	%rbx
               	popq	%rax
               	movups	(%rsp), %xmm0
               	addq	$0x10, %rsp
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<sse_shuffle>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	leaq	-0x8(%rbp), %rax
               	subq	$0x20, %rsp
               	movups	%xmm0, (%rsp)
               	movups	%xmm1, 0x10(%rsp)
               	pushq	%rax
               	pushq	%rcx
               	pushq	%rbx
               	movq	%rax, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	pushq	%r10
               	movq	0x8(%rsp), %rbx
               	movq	(%rsp), %rcx
               	movd	%ebx, %xmm0
               	movd	%ecx, %xmm1
               	punpckldq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
               	pshufd	$0x1, %xmm0, %xmm0      # xmm0 = xmm0[1,0,0,0]
               	movd	%xmm0, %eax
               	movq	0x10(%rsp), %r11
               	movl	%eax, (%r11)
               	addq	$0x18, %rsp
               	popq	%rbx
               	popq	%rcx
               	popq	%rax
               	movups	(%rsp), %xmm0
               	movups	0x10(%rsp), %xmm1
               	addq	$0x20, %rsp
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<movq_roundtrip>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	subq	$0x10, %rsp
               	movups	%xmm0, (%rsp)
               	pushq	%rax
               	pushq	%rbx
               	movq	%rax, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	(%rsp), %rbx
               	movq	%rbx, %xmm0
               	movq	%xmm0, %rax
               	movq	0x8(%rsp), %r11
               	movq	%rax, (%r11)
               	addq	$0x10, %rsp
               	popq	%rbx
               	popq	%rax
               	movups	(%rsp), %xmm0
               	addq	$0x10, %rsp
               	movq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<sse_float_roundtrip>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	subq	$0x10, %rsp
               	movups	%xmm0, (%rsp)
               	pushq	%rax
               	pushq	%rbx
               	movq	%rax, %r10
               	pushq	%r10
               	movq	%rcx, %r10
               	pushq	%r10
               	movq	0x8(%rsp), %rax
               	movq	(%rsp), %rbx
               	movdqu	(%rbx), %xmm0
               	cvtdq2ps	%xmm0, %xmm0
               	cvtps2dq	%xmm0, %xmm0
               	shufps	$0x1b, %xmm0, %xmm0     # xmm0 = xmm0[3,2,1,0]
               	movdqu	%xmm0, (%rax)
               	addq	$0x10, %rsp
               	popq	%rbx
               	popq	%rax
               	movups	(%rsp), %xmm0
               	addq	$0x10, %rsp
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<sse_x_constraint>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x38(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x28(%rbp), %rdx
               	subq	$0x40, %rsp
               	movups	%xmm0, (%rsp)
               	movups	%xmm1, 0x10(%rsp)
               	movups	%xmm2, 0x20(%rsp)
               	movups	%xmm7, 0x30(%rsp)
               	movq	%rax, %r10
               	pushq	%r10
               	movq	%rcx, %r10
               	pushq	%r10
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	0x8(%rsp), %r11
               	movups	(%r11,%riz), %xmm1
               	movq	(%rsp), %r11
               	movups	(%r11,%riz), %xmm2
               	movdqa	%xmm1, %xmm7
               	paddd	%xmm2, %xmm7
               	movdqa	%xmm7, %xmm0
               	movq	0x10(%rsp), %r11
               	movups	%xmm0, (%r11,%riz)
               	addq	$0x18, %rsp
               	movups	(%rsp), %xmm0
               	movups	0x10(%rsp), %xmm1
               	movups	0x20(%rsp), %xmm2
               	movups	0x30(%rsp), %xmm7
               	addq	$0x40, %rsp
               	leaq	-0x38(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x13, %edi
               	movl	$0x17, %esi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x17, %edi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x2a, %edi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x15, %edi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x7, %edi
               	movl	$0x2a, %esi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movl	$0x2a, %edi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	popq	%rbp
               	retq
