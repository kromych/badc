
inline_asm_x64_sse.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x280, %rsp            # imm = 0x280
               	movq	%rbx, (%rsp)
               	movl	$0x13, %eax
               	movl	$0x17, %ecx
               	leaq	-0x160(%rbp), %rdx
               	movups	%xmm0, -0x270(%rbp,%riz)
               	movups	%xmm1, -0x260(%rbp,%riz)
               	movq	%rax, -0x250(%rbp)
               	movq	%rcx, -0x248(%rbp)
               	movq	%rbx, -0x240(%rbp)
               	movq	%rdx, -0x238(%rbp)
               	movq	%rax, -0x230(%rbp)
               	movq	%rcx, -0x228(%rbp)
               	movq	-0x230(%rbp), %rbx
               	movq	-0x228(%rbp), %rcx
               	movd	%ebx, %xmm0
               	movd	%ecx, %xmm1
               	paddd	%xmm1, %xmm0
               	movd	%xmm0, %eax
               	movq	-0x238(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x250(%rbp), %rax
               	movq	-0x248(%rbp), %rcx
               	movq	-0x240(%rbp), %rbx
               	movups	-0x270(%rbp,%riz), %xmm0
               	movups	-0x260(%rbp,%riz), %xmm1
               	movslq	-0x160(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x280, %rsp            # imm = 0x280
               	popq	%rbp
               	retq
               	movl	$0x17, %eax
               	leaq	-0x160(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	%xmm0, -0x270(%rbp,%riz)
               	movq	%rax, -0x260(%rbp)
               	movq	%rcx, -0x258(%rbp)
               	movq	%rbx, -0x250(%rbp)
               	movq	%rcx, -0x248(%rbp)
               	movq	%rax, -0x240(%rbp)
               	movq	%rdx, -0x238(%rbp)
               	movq	-0x240(%rbp), %rbx
               	movq	-0x238(%rbp), %rcx
               	movd	%ebx, %xmm0
               	paddd	<rip>, %xmm0
               	movd	%xmm0, %eax
               	movq	-0x248(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x260(%rbp), %rax
               	movq	-0x258(%rbp), %rcx
               	movq	-0x250(%rbp), %rbx
               	movups	-0x270(%rbp,%riz), %xmm0
               	movslq	-0x160(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x280, %rsp            # imm = 0x280
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	leaq	-0x170(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	-0x170(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x170(%rbp), %rcx
               	movl	%eax, 0x4(%rcx)
               	leaq	-0x170(%rbp), %rcx
               	movl	%eax, 0x8(%rcx)
               	leaq	-0x170(%rbp), %rcx
               	movl	%eax, 0xc(%rcx)
               	leaq	-0x180(%rbp), %rax
               	leaq	-0x170(%rbp), %rcx
               	movups	%xmm0, -0x270(%rbp,%riz)
               	movq	%rax, -0x260(%rbp)
               	movq	%rbx, -0x258(%rbp)
               	movq	%rax, -0x250(%rbp)
               	movq	%rcx, -0x248(%rbp)
               	movq	-0x250(%rbp), %rax
               	movq	-0x248(%rbp), %rbx
               	movdqu	(%rbx), %xmm0
               	movdqu	%xmm0, (%rax)
               	movq	-0x260(%rbp), %rax
               	movq	-0x258(%rbp), %rbx
               	movups	-0x270(%rbp,%riz), %xmm0
               	leaq	-0x180(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x280, %rsp            # imm = 0x280
               	popq	%rbp
               	retq
               	movl	$0x15, %eax
               	leaq	-0x160(%rbp), %rcx
               	movups	%xmm0, -0x270(%rbp,%riz)
               	movq	%rax, -0x260(%rbp)
               	movq	%rbx, -0x258(%rbp)
               	movq	%rcx, -0x250(%rbp)
               	movq	%rax, -0x248(%rbp)
               	movq	-0x248(%rbp), %rbx
               	movd	%ebx, %xmm0
               	pslld	$0x1, %xmm0
               	movd	%xmm0, %eax
               	movq	-0x250(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x260(%rbp), %rax
               	movq	-0x258(%rbp), %rbx
               	movups	-0x270(%rbp,%riz), %xmm0
               	movslq	-0x160(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x280, %rsp            # imm = 0x280
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	movl	$0x2a, %ecx
               	leaq	-0x160(%rbp), %rdx
               	movups	%xmm0, -0x270(%rbp,%riz)
               	movups	%xmm1, -0x260(%rbp,%riz)
               	movq	%rax, -0x250(%rbp)
               	movq	%rcx, -0x248(%rbp)
               	movq	%rbx, -0x240(%rbp)
               	movq	%rdx, -0x238(%rbp)
               	movq	%rax, -0x230(%rbp)
               	movq	%rcx, -0x228(%rbp)
               	movq	-0x230(%rbp), %rbx
               	movq	-0x228(%rbp), %rcx
               	movd	%ebx, %xmm0
               	movd	%ecx, %xmm1
               	punpckldq	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
               	pshufd	$0x1, %xmm0, %xmm0      # xmm0 = xmm0[1,0,0,0]
               	movd	%xmm0, %eax
               	movq	-0x238(%rbp), %r10
               	movl	%eax, (%r10)
               	movq	-0x250(%rbp), %rax
               	movq	-0x248(%rbp), %rcx
               	movq	-0x240(%rbp), %rbx
               	movups	-0x270(%rbp,%riz), %xmm0
               	movups	-0x260(%rbp,%riz), %xmm1
               	movslq	-0x160(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x280, %rsp            # imm = 0x280
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	leaq	-0x160(%rbp), %rcx
               	movups	%xmm0, -0x270(%rbp,%riz)
               	movq	%rax, -0x260(%rbp)
               	movq	%rbx, -0x258(%rbp)
               	movq	%rcx, -0x250(%rbp)
               	movq	%rax, -0x248(%rbp)
               	movq	-0x248(%rbp), %rbx
               	movq	%rbx, %xmm0
               	movq	%xmm0, %rax
               	movq	-0x250(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x260(%rbp), %rax
               	movq	-0x258(%rbp), %rbx
               	movups	-0x270(%rbp,%riz), %xmm0
               	movq	-0x160(%rbp), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	addq	$0x280, %rsp            # imm = 0x280
               	popq	%rbp
               	retq
               	leaq	-0x170(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	%xmm0, -0x270(%rbp,%riz)
               	movq	%rax, -0x260(%rbp)
               	movq	%rbx, -0x258(%rbp)
               	movq	%rax, -0x250(%rbp)
               	movq	%rcx, -0x248(%rbp)
               	movq	-0x250(%rbp), %rax
               	movq	-0x248(%rbp), %rbx
               	movdqu	<rip>, %xmm0
               	cvtdq2ps	%xmm0, %xmm0
               	cvtps2dq	%xmm0, %xmm0
               	shufps	$0x1b, %xmm0, %xmm0     # xmm0 = xmm0[3,2,1,0]
               	movdqu	%xmm0, (%rax)
               	movq	-0x260(%rbp), %rax
               	movq	-0x258(%rbp), %rbx
               	movups	-0x270(%rbp,%riz), %xmm0
               	leaq	-0x170(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	addq	$0x280, %rsp            # imm = 0x280
               	popq	%rbp
               	retq
               	leaq	-0x170(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x180(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x190(%rbp), %rax
               	leaq	-0x170(%rbp), %rcx
               	leaq	-0x180(%rbp), %rdx
               	movups	%xmm0, -0x270(%rbp,%riz)
               	movups	%xmm1, -0x260(%rbp,%riz)
               	movups	%xmm2, -0x250(%rbp,%riz)
               	movups	%xmm7, -0x240(%rbp,%riz)
               	movq	%rax, -0x230(%rbp)
               	movq	%rcx, -0x228(%rbp)
               	movq	%rdx, -0x220(%rbp)
               	movq	-0x228(%rbp), %r10
               	movups	(%r10,%riz), %xmm1
               	movq	-0x220(%rbp), %r10
               	movups	(%r10,%riz), %xmm2
               	movdqa	%xmm1, %xmm7
               	paddd	%xmm2, %xmm7
               	movdqa	%xmm7, %xmm0
               	movq	-0x230(%rbp), %r10
               	movups	%xmm0, (%r10,%riz)
               	movups	-0x270(%rbp,%riz), %xmm0
               	movups	-0x260(%rbp,%riz), %xmm1
               	movups	-0x250(%rbp,%riz), %xmm2
               	movups	-0x240(%rbp,%riz), %xmm7
               	leaq	-0x190(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	addq	$0x280, %rsp            # imm = 0x280
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	leaq	-0x160(%rbp), %rcx
               	leaq	-0x168(%rbp), %rdx
               	leaq	-0x170(%rbp), %rsi
               	leaq	-0x178(%rbp), %rdi
               	movl	$0x1, %r8d
               	xorq	%r9, %r9
               	pushq	%rax
               	pushq	%rbx
               	pushq	%rcx
               	pushq	%rdx
               	movq	%rcx, %r10
               	pushq	%r10
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%r8, %r10
               	movq	%r9, %r11
               	movq	%r10, %rax
               	movq	%r11, %rcx
               	cpuid
               	popq	%r10
               	movl	%edx, (%r10)
               	popq	%r10
               	movl	%ecx, (%r10)
               	popq	%r10
               	movl	%ebx, (%r10)
               	popq	%r10
               	movl	%eax, (%r10)
               	popq	%rdx
               	popq	%rcx
               	popq	%rbx
               	popq	%rax
               	movl	-0x170(%rbp), %ecx
               	shrq	$0x1c, %rcx
               	andq	$0x1, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x100(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x110(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x120(%rbp), %rax
               	leaq	-0x100(%rbp), %rcx
               	leaq	-0x110(%rbp), %rdx
               	movups	%xmm0, -0x270(%rbp,%riz)
               	movups	%xmm1, -0x260(%rbp,%riz)
               	movups	%xmm2, -0x250(%rbp,%riz)
               	movq	%rax, -0x240(%rbp)
               	movq	%rcx, -0x238(%rbp)
               	movq	%rdx, -0x230(%rbp)
               	movq	-0x238(%rbp), %r10
               	movups	(%r10,%riz), %xmm1
               	movq	-0x230(%rbp), %r10
               	movups	(%r10,%riz), %xmm2
               	vpaddd	%xmm2, %xmm1, %xmm0
               	movq	-0x240(%rbp), %r10
               	movups	%xmm0, (%r10,%riz)
               	movups	-0x270(%rbp,%riz), %xmm0
               	movups	-0x260(%rbp,%riz), %xmm1
               	movups	-0x250(%rbp,%riz), %xmm2
               	leaq	-0x120(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	movslq	%eax, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	addq	$0x280, %rsp            # imm = 0x280
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	leaq	-0x160(%rbp), %rcx
               	leaq	-0x168(%rbp), %rdx
               	leaq	-0x170(%rbp), %rsi
               	leaq	-0x178(%rbp), %rdi
               	movl	$0x1, %r8d
               	xorq	%r9, %r9
               	pushq	%rax
               	pushq	%rbx
               	pushq	%rcx
               	pushq	%rdx
               	movq	%rcx, %r10
               	pushq	%r10
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%r8, %r10
               	movq	%r9, %r11
               	movq	%r10, %rax
               	movq	%r11, %rcx
               	cpuid
               	popq	%r10
               	movl	%edx, (%r10)
               	popq	%r10
               	movl	%ecx, (%r10)
               	popq	%r10
               	movl	%ebx, (%r10)
               	popq	%r10
               	movl	%eax, (%r10)
               	popq	%rdx
               	popq	%rcx
               	popq	%rbx
               	popq	%rax
               	movl	-0x170(%rbp), %ecx
               	shrq	$0x1c, %rcx
               	andq	$0x1, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x138(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	%xmm0, -0x270(%rbp,%riz)
               	movq	%rax, -0x260(%rbp)
               	movq	%rbx, -0x258(%rbp)
               	movq	%rax, -0x250(%rbp)
               	movq	%rcx, -0x248(%rbp)
               	movq	-0x250(%rbp), %rax
               	movq	-0x248(%rbp), %rbx
               	vmovdqu	<rip>, %xmm0
               	vmovdqu	%xmm0, (%rax)
               	movq	-0x260(%rbp), %rax
               	movq	-0x258(%rbp), %rbx
               	movups	-0x270(%rbp,%riz), %xmm0
               	leaq	-0x148(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x158(%rbp), %rax
               	leaq	-0x148(%rbp), %rcx
               	leaq	<rip>, %rdx
               	movups	%xmm0, -0x270(%rbp,%riz)
               	movups	%xmm1, -0x260(%rbp,%riz)
               	movq	%rax, -0x250(%rbp)
               	movq	%rax, -0x248(%rbp)
               	movq	%rcx, -0x240(%rbp)
               	movq	%rdx, -0x238(%rbp)
               	movq	-0x240(%rbp), %r10
               	movups	(%r10,%riz), %xmm1
               	movq	-0x238(%rbp), %rax
               	vpaddd	<rip>, %xmm1, %xmm0
               	movq	-0x248(%rbp), %r10
               	movups	%xmm0, (%r10,%riz)
               	movq	-0x250(%rbp), %rax
               	movups	-0x270(%rbp,%riz), %xmm0
               	movups	-0x260(%rbp,%riz), %xmm1
               	leaq	-0x138(%rbp), %rax
               	movslq	(%rax), %rcx
               	leaq	-0x138(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	addq	%rcx, %rax
               	subq	$0x2a, %rax
               	leaq	-0x158(%rbp), %rcx
               	movslq	0xc(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	addq	$0x280, %rsp            # imm = 0x280
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	leaq	-0x160(%rbp), %rcx
               	leaq	-0x168(%rbp), %rdx
               	leaq	-0x170(%rbp), %rsi
               	leaq	-0x178(%rbp), %rdi
               	movl	$0x1, %r8d
               	xorq	%r9, %r9
               	pushq	%rax
               	pushq	%rbx
               	pushq	%rcx
               	pushq	%rdx
               	movq	%rcx, %r10
               	pushq	%r10
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%r8, %r10
               	movq	%r9, %r11
               	movq	%r10, %rax
               	movq	%r11, %rcx
               	cpuid
               	popq	%r10
               	movl	%edx, (%r10)
               	popq	%r10
               	movl	%ecx, (%r10)
               	popq	%r10
               	movl	%ebx, (%r10)
               	popq	%r10
               	movl	%eax, (%r10)
               	popq	%rdx
               	popq	%rcx
               	popq	%rbx
               	popq	%rax
               	movl	-0x170(%rbp), %ecx
               	shrq	$0x1c, %rcx
               	andq	$0x1, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0xc0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xd0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xe0(%rbp), %rax
               	leaq	-0xc0(%rbp), %rcx
               	leaq	-0xd0(%rbp), %rdx
               	movups	%xmm0, -0x270(%rbp,%riz)
               	movups	%xmm1, -0x260(%rbp,%riz)
               	movups	%xmm2, -0x250(%rbp,%riz)
               	movq	%rax, -0x240(%rbp)
               	movq	%rcx, -0x238(%rbp)
               	movq	%rdx, -0x230(%rbp)
               	movq	-0x238(%rbp), %r10
               	movups	(%r10,%riz), %xmm1
               	movq	-0x230(%rbp), %r10
               	movups	(%r10,%riz), %xmm2
               	vpmulld	%xmm2, %xmm1, %xmm0
               	movq	-0x240(%rbp), %r10
               	movups	%xmm0, (%r10,%riz)
               	movups	-0x270(%rbp,%riz), %xmm0
               	movups	-0x260(%rbp,%riz), %xmm1
               	movups	-0x250(%rbp,%riz), %xmm2
               	leaq	-0xf0(%rbp), %rax
               	leaq	-0xe0(%rbp), %rcx
               	movups	%xmm0, -0x270(%rbp,%riz)
               	movups	%xmm1, -0x260(%rbp,%riz)
               	movq	%rax, -0x250(%rbp)
               	movq	%rcx, -0x248(%rbp)
               	movq	-0x248(%rbp), %r10
               	movups	(%r10,%riz), %xmm1
               	vpshufd	$0x1b, %xmm1, %xmm0     # xmm0 = xmm1[3,2,1,0]
               	movq	-0x250(%rbp), %r10
               	movups	%xmm0, (%r10,%riz)
               	movups	-0x270(%rbp,%riz), %xmm0
               	movups	-0x260(%rbp,%riz), %xmm1
               	leaq	-0xf0(%rbp), %rax
               	movslq	(%rax), %rax
               	movslq	%eax, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	addq	$0x280, %rsp            # imm = 0x280
               	popq	%rbp
               	retq
               	movl	$0x2a, %ecx
               	leaq	-0x1d0(%rbp), %rdx
               	leaq	-0x1c8(%rbp), %rsi
               	leaq	-0x1c0(%rbp), %rdi
               	leaq	-0x1b8(%rbp), %r8
               	movl	$0x1, %r9d
               	xorq	%rax, %rax
               	pushq	%rax
               	pushq	%rbx
               	pushq	%rcx
               	pushq	%rdx
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%r8, %r10
               	pushq	%r10
               	movq	%r9, %r10
               	movq	%rax, %r11
               	movq	%r10, %rax
               	movq	%r11, %rcx
               	cpuid
               	popq	%r10
               	movl	%edx, (%r10)
               	popq	%r10
               	movl	%ecx, (%r10)
               	popq	%r10
               	movl	%ebx, (%r10)
               	popq	%r10
               	movl	%eax, (%r10)
               	popq	%rdx
               	popq	%rcx
               	popq	%rbx
               	popq	%rax
               	leaq	-0x160(%rbp), %rdx
               	leaq	-0x168(%rbp), %rsi
               	leaq	-0x170(%rbp), %rdi
               	leaq	-0x178(%rbp), %r8
               	movl	$0x1, %r9d
               	xorq	%rbx, %rbx
               	pushq	%rax
               	pushq	%rbx
               	pushq	%rcx
               	pushq	%rdx
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%r8, %r10
               	pushq	%r10
               	movq	%r9, %r10
               	movq	%rbx, %r11
               	movq	%r10, %rax
               	movq	%r11, %rcx
               	cpuid
               	popq	%r10
               	movl	%edx, (%r10)
               	popq	%r10
               	movl	%ecx, (%r10)
               	popq	%r10
               	movl	%ebx, (%r10)
               	popq	%r10
               	movl	%eax, (%r10)
               	popq	%rdx
               	popq	%rcx
               	popq	%rbx
               	popq	%rax
               	movl	-0x170(%rbp), %edx
               	shrq	$0x1c, %rdx
               	andq	$0x1, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	-0x1c0(%rbp), %eax
               	shrq	$0xc, %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x80(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x90(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xa0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xb0(%rbp), %rax
               	leaq	-0x80(%rbp), %rcx
               	leaq	-0x90(%rbp), %rdx
               	leaq	-0xa0(%rbp), %rsi
               	movups	%xmm0, -0x270(%rbp,%riz)
               	movups	%xmm1, -0x260(%rbp,%riz)
               	movups	%xmm2, -0x250(%rbp,%riz)
               	movups	%xmm3, -0x240(%rbp,%riz)
               	movups	%xmm4, -0x230(%rbp,%riz)
               	movups	%xmm5, -0x220(%rbp,%riz)
               	movups	%xmm6, -0x210(%rbp,%riz)
               	movq	%rax, -0x200(%rbp)
               	movq	%rcx, -0x1f8(%rbp)
               	movq	%rdx, -0x1f0(%rbp)
               	movq	%rsi, -0x1e8(%rbp)
               	movq	-0x1f8(%rbp), %r10
               	movups	(%r10,%riz), %xmm4
               	movq	-0x1f0(%rbp), %r10
               	movups	(%r10,%riz), %xmm5
               	movq	-0x1e8(%rbp), %r10
               	movups	(%r10,%riz), %xmm6
               	cvtdq2ps	%xmm4, %xmm0
               	cvtdq2ps	%xmm5, %xmm1
               	cvtdq2ps	%xmm6, %xmm2
               	vfmadd231ps	%xmm0, %xmm1, %xmm2 # xmm2 = (xmm1 * xmm0) + xmm2
               	cvtps2dq	%xmm2, %xmm3
               	movq	-0x200(%rbp), %r10
               	movups	%xmm3, (%r10,%riz)
               	movups	-0x270(%rbp,%riz), %xmm0
               	movups	-0x260(%rbp,%riz), %xmm1
               	movups	-0x250(%rbp,%riz), %xmm2
               	movups	-0x240(%rbp,%riz), %xmm3
               	movups	-0x230(%rbp,%riz), %xmm4
               	movups	-0x220(%rbp,%riz), %xmm5
               	movups	-0x210(%rbp,%riz), %xmm6
               	leaq	-0xb0(%rbp), %rax
               	movslq	0xc(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	addq	$0x280, %rsp            # imm = 0x280
               	popq	%rbp
               	retq
               	movl	$0x2a, %ecx
               	leaq	-0x1b0(%rbp), %rdx
               	leaq	-0x1a8(%rbp), %rsi
               	leaq	-0x1a0(%rbp), %rdi
               	leaq	-0x198(%rbp), %r8
               	movl	$0x7, %r9d
               	xorq	%rax, %rax
               	pushq	%rax
               	pushq	%rbx
               	pushq	%rcx
               	pushq	%rdx
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%r8, %r10
               	pushq	%r10
               	movq	%r9, %r10
               	movq	%rax, %r11
               	movq	%r10, %rax
               	movq	%r11, %rcx
               	cpuid
               	popq	%r10
               	movl	%edx, (%r10)
               	popq	%r10
               	movl	%ecx, (%r10)
               	popq	%r10
               	movl	%ebx, (%r10)
               	popq	%r10
               	movl	%eax, (%r10)
               	popq	%rdx
               	popq	%rcx
               	popq	%rbx
               	popq	%rax
               	leaq	-0x160(%rbp), %rdx
               	leaq	-0x168(%rbp), %rsi
               	leaq	-0x170(%rbp), %rdi
               	leaq	-0x178(%rbp), %r8
               	movl	$0x1, %r9d
               	xorq	%rbx, %rbx
               	pushq	%rax
               	pushq	%rbx
               	pushq	%rcx
               	pushq	%rdx
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%r8, %r10
               	pushq	%r10
               	movq	%r9, %r10
               	movq	%rbx, %r11
               	movq	%r10, %rax
               	movq	%r11, %rcx
               	cpuid
               	popq	%r10
               	movl	%edx, (%r10)
               	popq	%r10
               	movl	%ecx, (%r10)
               	popq	%r10
               	movl	%ebx, (%r10)
               	popq	%r10
               	movl	%eax, (%r10)
               	popq	%rdx
               	popq	%rcx
               	popq	%rbx
               	popq	%rax
               	movl	-0x170(%rbp), %edx
               	shrq	$0x1c, %rdx
               	andq	$0x1, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	-0x1a8(%rbp), %eax
               	shrq	$0x5, %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x70(%rbp), %rax
               	movl	$0x15, %ecx
               	movups	%xmm0, -0x270(%rbp,%riz)
               	movups	%xmm1, -0x260(%rbp,%riz)
               	movups	%xmm2, -0x250(%rbp,%riz)
               	movq	%rax, -0x240(%rbp)
               	movq	%rax, -0x238(%rbp)
               	movq	%rcx, -0x230(%rbp)
               	movq	-0x230(%rbp), %rax
               	movd	%eax, %xmm0
               	vpbroadcastd	%xmm0, %xmm1
               	vpaddd	%xmm1, %xmm1, %xmm2
               	movq	-0x238(%rbp), %r10
               	movups	%xmm2, (%r10,%riz)
               	movq	-0x240(%rbp), %rax
               	movups	-0x270(%rbp,%riz), %xmm0
               	movups	-0x260(%rbp,%riz), %xmm1
               	movups	-0x250(%rbp,%riz), %xmm2
               	leaq	-0x70(%rbp), %rax
               	movslq	0x8(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	addq	$0x280, %rsp            # imm = 0x280
               	popq	%rbp
               	retq
               	movl	$0x2a, %ecx
               	leaq	-0x1b0(%rbp), %rdx
               	leaq	-0x1a8(%rbp), %rsi
               	leaq	-0x1a0(%rbp), %rdi
               	leaq	-0x198(%rbp), %r8
               	movl	$0x7, %r9d
               	xorq	%rax, %rax
               	pushq	%rax
               	pushq	%rbx
               	pushq	%rcx
               	pushq	%rdx
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%r8, %r10
               	pushq	%r10
               	movq	%r9, %r10
               	movq	%rax, %r11
               	movq	%r10, %rax
               	movq	%r11, %rcx
               	cpuid
               	popq	%r10
               	movl	%edx, (%r10)
               	popq	%r10
               	movl	%ecx, (%r10)
               	popq	%r10
               	movl	%ebx, (%r10)
               	popq	%r10
               	movl	%eax, (%r10)
               	popq	%rdx
               	popq	%rcx
               	popq	%rbx
               	popq	%rax
               	leaq	-0x160(%rbp), %rdx
               	leaq	-0x168(%rbp), %rsi
               	leaq	-0x170(%rbp), %rdi
               	leaq	-0x178(%rbp), %r8
               	movl	$0x1, %r9d
               	xorq	%rbx, %rbx
               	pushq	%rax
               	pushq	%rbx
               	pushq	%rcx
               	pushq	%rdx
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%r8, %r10
               	pushq	%r10
               	movq	%r9, %r10
               	movq	%rbx, %r11
               	movq	%r10, %rax
               	movq	%r11, %rcx
               	cpuid
               	popq	%r10
               	movl	%edx, (%r10)
               	popq	%r10
               	movl	%ecx, (%r10)
               	popq	%r10
               	movl	%ebx, (%r10)
               	popq	%r10
               	movl	%eax, (%r10)
               	popq	%rdx
               	popq	%rcx
               	popq	%rbx
               	popq	%rax
               	movl	-0x170(%rbp), %edx
               	shrq	$0x1c, %rdx
               	andq	$0x1, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	-0x1a8(%rbp), %eax
               	shrq	$0x5, %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x50(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x60(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x50(%rbp), %rdx
               	movups	%xmm0, -0x270(%rbp,%riz)
               	movups	%xmm1, -0x260(%rbp,%riz)
               	movups	%xmm2, -0x250(%rbp,%riz)
               	movq	%rax, -0x240(%rbp)
               	movq	%rcx, -0x238(%rbp)
               	movq	%rdx, -0x230(%rbp)
               	movq	-0x238(%rbp), %r10
               	movups	(%r10,%riz), %xmm1
               	movq	-0x230(%rbp), %r10
               	movups	(%r10,%riz), %xmm2
               	vpsllvd	%xmm2, %xmm1, %xmm0
               	movq	-0x240(%rbp), %r10
               	movups	%xmm0, (%r10,%riz)
               	movups	-0x270(%rbp,%riz), %xmm0
               	movups	-0x260(%rbp,%riz), %xmm1
               	movups	-0x250(%rbp,%riz), %xmm2
               	leaq	-0x60(%rbp), %rax
               	movslq	0xc(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	addq	$0x280, %rsp            # imm = 0x280
               	popq	%rbp
               	retq
               	movl	$0x2a, %ecx
               	leaq	-0x1b0(%rbp), %rdx
               	leaq	-0x1a8(%rbp), %rsi
               	leaq	-0x1a0(%rbp), %rdi
               	leaq	-0x198(%rbp), %r8
               	movl	$0x7, %r9d
               	xorq	%rax, %rax
               	pushq	%rax
               	pushq	%rbx
               	pushq	%rcx
               	pushq	%rdx
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%r8, %r10
               	pushq	%r10
               	movq	%r9, %r10
               	movq	%rax, %r11
               	movq	%r10, %rax
               	movq	%r11, %rcx
               	cpuid
               	popq	%r10
               	movl	%edx, (%r10)
               	popq	%r10
               	movl	%ecx, (%r10)
               	popq	%r10
               	movl	%ebx, (%r10)
               	popq	%r10
               	movl	%eax, (%r10)
               	popq	%rdx
               	popq	%rcx
               	popq	%rbx
               	popq	%rax
               	leaq	-0x160(%rbp), %rdx
               	leaq	-0x168(%rbp), %rsi
               	leaq	-0x170(%rbp), %rdi
               	leaq	-0x178(%rbp), %r8
               	movl	$0x1, %r9d
               	xorq	%rbx, %rbx
               	pushq	%rax
               	pushq	%rbx
               	pushq	%rcx
               	pushq	%rdx
               	movq	%rdx, %r10
               	pushq	%r10
               	movq	%rsi, %r10
               	pushq	%r10
               	movq	%rdi, %r10
               	pushq	%r10
               	movq	%r8, %r10
               	pushq	%r10
               	movq	%r9, %r10
               	movq	%rbx, %r11
               	movq	%r10, %rax
               	movq	%r11, %rcx
               	cpuid
               	popq	%r10
               	movl	%edx, (%r10)
               	popq	%r10
               	movl	%ecx, (%r10)
               	popq	%r10
               	movl	%ebx, (%r10)
               	popq	%r10
               	movl	%eax, (%r10)
               	popq	%rdx
               	popq	%rcx
               	popq	%rbx
               	popq	%rax
               	movl	-0x170(%rbp), %edx
               	shrq	$0x1c, %rdx
               	andq	$0x1, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	-0x1a8(%rbp), %eax
               	shrq	$0x5, %rax
               	andq	$0x1, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	movups	%xmm0, -0x270(%rbp,%riz)
               	movups	%xmm1, -0x260(%rbp,%riz)
               	movups	%xmm2, -0x250(%rbp,%riz)
               	movq	%rax, -0x240(%rbp)
               	movq	%rcx, -0x238(%rbp)
               	movq	%rdx, -0x230(%rbp)
               	movq	-0x238(%rbp), %r10
               	movups	(%r10,%riz), %xmm1
               	movq	-0x230(%rbp), %r10
               	movups	(%r10,%riz), %xmm2
               	vpblendd	$0x8, %xmm2, %xmm1, %xmm0 # xmm0 = xmm1[0,1,2],xmm2[3]
               	movq	-0x240(%rbp), %r10
               	movups	%xmm0, (%r10,%riz)
               	movups	-0x270(%rbp,%riz), %xmm0
               	movups	-0x260(%rbp,%riz), %xmm1
               	movups	-0x250(%rbp,%riz), %xmm2
               	leaq	-0x30(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	leaq	-0x30(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rax
               	decq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	addq	$0x280, %rsp            # imm = 0x280
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	movq	(%rsp), %rbx
               	addq	$0x280, %rsp            # imm = 0x280
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
